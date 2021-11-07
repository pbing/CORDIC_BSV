#include "math.h"
#include "Request.h"

Request::Request(VmkCORDIC_16_wrapper *dut, size_t n) {
  this->dut = dut;
  this->n = n;
  i = 0;
}

void Request::put() {
  if (i < n) {
    if (dut->RST_N == 1 && dut->RDY_request_put == 1) {
      double phi = M_PI * ((double)i / (double)0x8000u);
      int16_t x = 0x7fff * cos(phi);
      int16_t y = 0x7fff * sin(phi);
      int16_t z = 0;
      int64_t req = (((int64_t)x << 32) & 0xffff00000000) | (((int64_t)y << 16) & 0x0000ffff0000) | ((int64_t)z & 0x00000000ffff);
      dut->request_put = req;
      //printf("put(): i=%zu x=%d, y=%d, z=%d req=0x%012llx\n", i, x, y, z, req);
      ++i;
    }
  }
}
