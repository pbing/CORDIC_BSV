#pragma once

#include <verilated.h>
#include "VmkCORDIC_r_16.h"

class Response {
  std::shared_ptr<VmkCORDIC_r_16> dut;
  size_t  n;
  size_t  i;
  std::unique_ptr<int32_t[]> x;
  std::unique_ptr<int32_t[]> y;
  std::unique_ptr<int32_t[]> z; 

 public:
  double xerr, yerr, zerr;
  double xenob, yenob; 

  Response(std::shared_ptr<VmkCORDIC_r_16> dut, size_t n);
  ~Response();
  void get();
  void calc_err();
  void enob(size_t bin);
};
