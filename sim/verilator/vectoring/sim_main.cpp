/* https://www.itsembedded.com/dhd/verilator_4/ */

#include <verilated.h>
#include <verilated_fst_c.h>
#include "VmkCORDIC_v_16.h"
#include "Request.h"
#include "Response.h"

// Legacy function required only so linking works
double sc_time_stamp() { return 0; }

int main(int argc, char** argv) {
  const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};
  contextp->commandArgs(argc, argv);

  auto dut = std::make_shared<VmkCORDIC_v_16>();
  auto req = std::make_unique<Request>(dut, 0x10000);
  auto rsp = std::make_unique<Response>(dut, 0x10000);

  contextp->traceEverOn(true);
  auto tfp = std::make_unique<VerilatedFstC>();
  dut->trace(tfp.get(), 99);
  tfp->open("dump.fst");

  dut->CLK   = 0;
  dut->RST_N = 0;
  dut->eval();

  while (contextp->time() < 2 * 0x11000 && !contextp->gotFinish()) {
    dut->CLK ^= 1;
    dut->eval();

    if (dut->CLK == 1 && contextp->time() > 3) {
      dut->RST_N = 1;
    }
    req->put(contextp->time());
    rsp->get();

    tfp->dump(contextp->time());
    contextp->timeInc(1);
  }

  dut->final();
  tfp->close();

  rsp->calc_err();
  printf("xerr=%f yerr=%f zerr=%f\n", rsp->xerr, rsp->yerr, rsp->zerr);

  return 0;
}
