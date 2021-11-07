#ifndef VERILATED_REQUEST_H
#define VERILATED_REQUEST_H

#include <verilated.h>
#include "VmkCORDIC_16_wrapper.h"

class Request {
 public:
  VmkCORDIC_16_wrapper *dut;
  size_t n;
  size_t i;

  Request(VmkCORDIC_16_wrapper *dut, size_t n);
  void put();
};

#endif
