#ifndef VERILATED_RESPONSE_H
#define VERILATED_RESPONSE_H

#include <verilated.h>
#include "VmkCORDIC_16_wrapper.h"

class Response {
 public:
  VmkCORDIC_16_wrapper *dut;
  size_t  n;
  size_t  i;
  int32_t *x;
  int32_t *y;
  int16_t *z;

  Response(VmkCORDIC_16_wrapper *dut, size_t n);
  ~Response();
  void get();
};

#endif
