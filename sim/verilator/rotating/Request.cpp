#include "Request.h"

Request::Request(std::shared_ptr<VmkCORDIC_r_16> dut, size_t n) : dut(dut), n(n), i(0) {}

void Request::put(uint64_t t) {
  if (dut->CLK == 1) {
    if (t > 20 && i < n && dut->RDY_request_put == 1) {
      int16_t x = 0x7fff;
      int16_t y = 0;
      int16_t z = i;
      int64_t req = (((int64_t)x << 32) & 0xffff00000000) | (((int64_t)y << 16) & 0x0000ffff0000) | ((int64_t)z & 0x00000000ffff);
      dut->request_put = req;
      dut->EN_request_put = 1;

      //VL_PRINTF("put(): i=%zu x=%" PRId16 " y=%" PRId16 " z=%" PRId16 " req=0x%012" PRIx64 "\n", i, x, y, z, req);
      ++i;
    } else {
      dut->request_put = 0xaaaaaaaaaaaaaaaa;
      dut->EN_request_put = 0;
    }
  }
}
