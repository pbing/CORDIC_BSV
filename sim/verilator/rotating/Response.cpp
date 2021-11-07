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
      printf("get(): i=%zu rsp=0x%013llx x=%d, y=%d, z=%d\n", i, rsp, x[i], y[i], z[i]);
      ++i;
    }
  }
}
