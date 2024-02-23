#pragma once

#include <verilated.h>
#include "VmkCORDIC_v_16.h"

class Request {
  VmkCORDIC_v_16 *dut;
  size_t n;
  size_t i;

 public:
  Request(VmkCORDIC_v_16 *dut, size_t n);
  void put(uint64_t t);
};
