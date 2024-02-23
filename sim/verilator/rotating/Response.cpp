#include <complex>
#include <gsl/gsl_complex_math.h>
#include <gsl/gsl_errno.h>
#include <gsl/gsl_fft_halfcomplex.h>
#include <gsl/gsl_fft_real.h>

#include "Response.h"

Response::Response(std::shared_ptr<VmkCORDIC_r_16> dut, size_t n) : dut(dut), n(n), i(0) {
  x = std::make_unique<int32_t[]>(n);
  y = std::make_unique<int32_t[]>(n);
  z = std::make_unique<int32_t[]>(n);
}

// https://graphics.stanford.edu/~seander/bithacks.html#FixedSignExtend
template <typename T, unsigned B>
inline T signextend(const T x)
{
  struct {T x:B;} s;
  return s.x = x;
}

void Response::get() {
  if (dut->CLK == 1) {
    if (i < n && dut->RDY_response_get == 1) {
      dut->EN_response_get = 1;
      int64_t rsp = dut->response_get;

      int64_t rx = (rsp & ((int64_t)0x1ffff << 33));
      int64_t ry = (rsp & ((int64_t)0x1ffff << 16));
      int64_t rz = (rsp & 0xffff);
      x[i] = signextend<int32_t, 17>(rx >> 33);
      y[i] = signextend<int32_t, 17>(ry >> 16);
      z[i] = signextend<int32_t, 16>(rz);

      //VL_PRINTF("get(): i=%zu rsp=0x%013" PRIx64 " x=%" PRId32 " y=%" PRId32 " z=%" PRId16 "\n", i, rsp, x[i], y[i], z[i]);
      ++i;
    } else {
      dut->EN_response_get = 0;
    }
  }
}

void Response::calc_err() {
  double A   = 1.0;
  double ssx = 0.0;
  double ssy = 0.0;
  double ssz = 0.0;

  /* scale factor */
  for (int i = 0; i < 18; ++i) {
    A *= sqrt(1.0 + exp2(-2 * i));
  }
  //printf("A=%f\n", A);

#if 0
  /* DEBUG: Ideal 16-bit response */
  for (int i = 0; i < n; ++i) {
    double phi = M_PI * ((double)i / (double)0x8000u);
    x[i] = lround(A * 0x7fff * cos(phi));
    y[i] = lround(A * 0x7fff * sin(phi));
  }
#endif

  /* standard deviation */
  for (int i = 0; i < n; ++i) {
    double phi = M_PI * ((double)i / (double)0x8000u);
    double xr = A * 0x7fff * cos(phi);
    double yr = A * 0x7fff * sin(phi);
    double zr = 0.0;
    double xd = x[i] - xr;
    double yd = y[i] - yr;
    double zd = z[i] - zr;
    ssx += xd * xd;
    ssy += yd * yd;
    ssz += zd * zd;
#if 0
    printf("x[%0d]=%0d xr=%f sxx=%f    y[%0d]=%0d yr=%f syy=%f    z[%0d]=%0d zr=%0f szz=%f  \n",
           i, x[i], xr, ssx,
           i, y[i], yr, ssy,
           i, z[i], zr, ssz);
#endif
  }
  xerr = sqrt(ssx / (n - 1));
  yerr = sqrt(ssy / (n - 1));
  zerr = sqrt(ssz / (n - 1));
}

void Response::enob(size_t bin) {
  // FFT of x and y
  int err;
  auto xh = std::make_unique<double[]>(n);
  auto yh = std::make_unique<double[]>(n);

  for (size_t i = 0; i < n; ++i) {
    xh[i] = static_cast<double>(x[i]);
    yh[i] = static_cast<double>(y[i]);
  }

  err = gsl_fft_real_radix2_transform(xh.get(), 1, n);
  if (err) fprintf(stderr, "gsl_fft_real_radix2_transform(xh, 1, %zu): %s\n", n, gsl_strerror(err));

  err = gsl_fft_real_radix2_transform(yh.get(), 1, n);
  if (err) fprintf(stderr, "gsl_fft_real_radix2_transform(yh, 1, %zu): %s\n", n, gsl_strerror(err));

  // convert half complex array to complex array
  auto xc = std::make_unique<double[]>(2*n);
  auto yc = std::make_unique<double[]>(2*n);

  err = gsl_fft_halfcomplex_radix2_unpack(xh.get(), xc.get(), 1, n);
  if (err) fprintf(stderr, "gsl_fft_halfcomplex_radix2_unpack(xh, xc, 1, %zu): %s\n", n, gsl_strerror(err));

  err = gsl_fft_halfcomplex_radix2_unpack(yh.get(), yc.get(), 1, n);
  if (err) fprintf(stderr, "gsl_fft_halfcomplex_radix2_unpack(yh, yc, 1, %zu): %s\n", n, gsl_strerror(err));

  // calculate power
  auto x2 = std::make_unique<double[]>(n);
  auto y2 = std::make_unique<double[]>(n);

  for (size_t i = 0; i < n; ++i) {
    gsl_complex zx, zy;
    GSL_SET_COMPLEX(&zx, xc[2*i], xc[2*i+1]);
    GSL_SET_COMPLEX(&zy, yc[2*i], yc[2*i+1]);
    x2[i] = gsl_complex_abs2(zx);
    y2[i] = gsl_complex_abs2(zy);
  }

  // noise and distortions
  // omit DC component and fundamental frequency
  double sxx = 0.0;
  double syy = 0.0;
  for (size_t i = 1; i < n / 2; ++i)
    if (i != bin) {
      sxx += x2[i] + x2[n-i];
      syy += y2[i] + y2[n-i];
    }
  // add bin at Nyquist frequency
  if (bin != n/2) {
    sxx += x2[n/2];
    syy += y2[n/2];
  }
  // adjust bias for the two missing bins
  // (n - 1) -> (n - 3)
  sxx /= n * (n - 3);
  syy /= n * (n - 3);

  double sdx = sqrt(sxx);
  double sdy = sqrt(syy);
  //printf("sdx=%f sdy=%f\n", sdx, sdy); // should be the same like xerr, yerr

  // fundamental frequency
  double xf = (x2[bin] + x2[n-bin]) / (n * (n - 1));
  double yf = (y2[bin] + y2[n-bin]) / (n * (n - 1));
  //printf("peak(xf)=%f peak(yf)=%f\n", sqrt(2 * xf), sqrt(2 * yf)); // amplitude = sqrt(2) * RMS

  // ENOB
  // https://scdn.rohde-schwarz.com/ur/pws/dl_downloads/dl_application/application_notes/1er03/ENOB_Technical_Paper_1ER03_1e.pdf
  xenob = 0.5 * (log2(xf / sxx) - log2(1.5));
  yenob = 0.5 * (log2(yf / syy) - log2(1.5));
}
