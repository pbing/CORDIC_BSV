#pragma once

#include <verilated.h>
#include "VmkCORDIC_v_16.h"

class Response {
  VmkCORDIC_v_16 *dut;
  size_t  n;
  size_t  i;
  std::unique_ptr<int32_t[]> x;
  std::unique_ptr<int32_t[]> y;
  std::unique_ptr<int32_t[]> z; 

 public:
  double xerr, yerr, zerr;

  Response(VmkCORDIC_v_16 *dut, size_t n);
  ~Response();
  void get();
  void calc_err();
};
