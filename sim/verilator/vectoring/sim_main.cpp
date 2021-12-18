/* https://www.itsembedded.com/dhd/verilator_4/ */

#include <verilated.h>
#include <verilated_fst_c.h>
#include "VmkCORDIC_v_16.h"
#include "Request.h"
#include "Response.h"

// Current simulation time
// This is a 64-bit integer to reduce wrap over issues and
// allow modulus.  This is in units of the timeprecision
// used in Verilog (or from --timescale-override)
vluint64_t main_time = 0;

// Called by $time in Verilog
// converts to double, to match what SystemC does
double sc_time_stamp() {
  return main_time;
}

int main(int argc, char** argv) {
  Verilated::commandArgs(argc, argv);

  VmkCORDIC_v_16 *dut = new VmkCORDIC_v_16;
  Request  *req       = new Request(dut, 0x10000);
  Response *rsp       = new Response(dut, 0x10000);

  Verilated::traceEverOn(true);
  VerilatedFstC *tfp = new VerilatedFstC;
  dut->trace(tfp, 99);
  tfp->open("dump.fst");

  dut->CLK   = 0;
  dut->RST_N = 0;
  dut->eval();

  while (main_time < 2 * 0x11000 && !Verilated::gotFinish()) {
    dut->CLK ^= 1;
    dut->eval();

    tfp->dump(main_time);

    if (dut->CLK == 1 && main_time > 3) {
      dut->RST_N = 1;
    }

    if (dut->CLK == 1) {
      req->put(main_time);
      rsp->get();
    }

    main_time++;
  }

  dut->final();
  tfp->close();

  rsp->calc_err();
  printf("xerr=%f yerr=%f zerr=%f\n", rsp->xerr, rsp->yerr, rsp->zerr);

  delete req;
  delete rsp;
  delete tfp;
  delete dut;
  return 0;
}
