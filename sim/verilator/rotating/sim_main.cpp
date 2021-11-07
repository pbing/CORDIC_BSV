/* https://www.itsembedded.com/dhd/verilator_4/ */

#include <verilated.h>
#include <verilated_vcd_c.h>
#include "VmkCORDIC_16_wrapper.h"
#include "Request.h"
#include "Response.h"

VmkCORDIC_16_wrapper *dut;      // Instantiation of model

vluint64_t main_time = 0;       // Current simulation time
// This is a 64-bit integer to reduce wrap over issues and
// allow modulus.  This is in units of the timeprecision
// used in Verilog (or from --timescale-override)

double sc_time_stamp() {        // Called by $time in Verilog
  return main_time;             // converts to double, to match what SystemC does
}

int main(int argc, char** argv) {
  Verilated::commandArgs(argc, argv);

  VmkCORDIC_16_wrapper *dut = new VmkCORDIC_16_wrapper;
  Request  *req             = new Request(dut, 0x10000);
  Response *rsp             = new Response(dut, 0x10000);

  Verilated::traceEverOn(true);
  VerilatedVcdC *tfp = new VerilatedVcdC;
  dut->trace(tfp, 99);
  tfp->open("dump.vcd");

  dut->CLK   = 0;
  dut->RST_N = 0;
  dut->eval();

  while (main_time < 2 * 0x11000 && !Verilated::gotFinish()) {
    if (main_time > 3) {
      dut->RST_N = 1;
    }

    dut->CLK ^= 1;
    dut->eval();

    if (dut->CLK == 1) {
      req->put();
      rsp->get();
    }

    tfp->dump(main_time);
    main_time++;
  }

  dut->final();
  tfp->close();

  delete req;
  delete rsp;
  delete dut;
  return 0;
}
