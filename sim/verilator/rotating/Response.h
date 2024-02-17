#pragma once

#include <verilated.h>
#include "VmkCORDIC_r_16.h"

class Response {
  VmkCORDIC_r_16 *dut;
  size_t  n;
  size_t  i;
  int32_t *x;
  int32_t *y;
  int16_t *z;

 public:
  double xerr, yerr, zerr;
  double xenob, yenob; 

  Response(VmkCORDIC_r_16 *dut, size_t n);
  ~Response();
  void get();
  void calc_err();
  void enob(size_t bin);
};
