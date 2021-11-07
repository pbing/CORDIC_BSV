#include "Response.h"

Response::Response(VmkCORDIC_16_wrapper *dut, size_t n) {
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
  if (i < n) {
    if (dut->RDY_response_get == 1) {
      int64_t rsp = dut->response_get;

      int64_t rx = (rsp & ((int64_t)0x1ffff << 33));
      int64_t ry = (rsp & ((int64_t)0x1ffff << 16));
      int64_t rz = (rsp & 0xffff);
      x[i] = signextend<int32_t, 17>(rx >> 33);
      y[i] = signextend<int32_t, 17>(ry >> 16);
      z[i] = signextend<int32_t, 17>(rz);
      //printf("get(): i=%zu rsp=0x%013llx x=%d, y=%d, z=%d\n", i, rsp, x[i], y[i], z[i]);
      ++i;
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

  /* standard deviation */
  for (int i = 0; i < n; ++i) {
    double xr = A * (double)0x7fff;
    double yr = 0.0;
    double zr = (i < 0x8000) ? i : (i - 0x10000);
    ssx += (x[i] - xr) * (x[i] - xr);
    ssy += (y[i] - yr) * (y[i] - yr);
    ssz += (z[i] - zr) * (z[i] - zr);
  }
  xerr = sqrt(ssx / n);
  yerr = sqrt(ssy / n);
  zerr = sqrt(ssz / n);
}
