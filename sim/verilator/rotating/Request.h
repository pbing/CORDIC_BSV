#ifndef VERILATED_REQUEST_H
#define VERILATED_REQUEST_H

#include <verilated.h>
#include "VmkCORDIC_16_wrapper.h"

class Request {
  VmkCORDIC_16_wrapper *dut;
  size_t n;
  size_t i;

 public:
  Request(VmkCORDIC_16_wrapper *dut, size_t n);
  void put();
};

#endif
