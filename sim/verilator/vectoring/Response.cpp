#include "Response.h"

Response::Response(VmkCORDIC_v_16 *dut, size_t n) {
  this->dut = dut;
  this->n = n;
  i = 0;
  x = new int32_t[n];
  y = new int32_t[n];
  z = new int16_t[n];
}

Response::~Response() {
  delete x;
  delete y;
  delete z;
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

      //VL_PRINTF("get(): i=%zu rsp=0x%013" PRIx64 " x=%" PRId32" y=%" PRId32 " z=%" PRId16"\n", i, rsp, x[i], y[i], z[i]);
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

  /* standard deviation */
  for (int i = 0; i < n; ++i) {
    double xr = A * (double)0x7fff;
    double yr = 0.0;
    double zr = (i < 0x8000) ? i : (i - 0x10000);
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
