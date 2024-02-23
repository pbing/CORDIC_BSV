#pragma once

#include <verilated.h>
#include "VmkCORDIC_r_16.h"

class Request {
  VmkCORDIC_r_16 *dut;
  size_t n;
  size_t i;

 public:
  Request(VmkCORDIC_r_16 *dut, size_t n);
  void put(uint64_t t);
};
