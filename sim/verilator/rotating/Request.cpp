#include "Request.h"

Request::Request(VmkCORDIC_r_16 *dut, size_t n) {
  this->dut = dut;
  this->n = n;
  i = 0;
}

void Request::put(vluint64_t t) {
  if (i < n) {
    if (t > 20 && dut->RDY_request_put == 1) {
      int16_t x = 0x7fff;
      int16_t y = 0;
      int16_t z = i;
      int64_t req = (((int64_t)x << 32) & 0xffff00000000) | (((int64_t)y << 16) & 0x0000ffff0000) | ((int64_t)z & 0x00000000ffff);
      dut->request_put = req;
      dut->EN_request_put = 1;

      //printf("put(): i=%zu x=%d, y=%d, z=%d req=0x%012llx\n", i, x, y, z, req);
      ++i;
    } else {
      dut->request_put = 0xaaaaaaaaaaaaaaaa;
      dut->EN_request_put = 0;
    }
  } else {
    dut->request_put = 0xaaaaaaaaaaaaaaaa;
    dut->EN_request_put = 0;
  } 
}
