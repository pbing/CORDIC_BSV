/* Dynamic, rotating mode
 *
 * Input (polar coordinates): x = magnitude, y = 0 , z = phase
 * 
 * Output (cartesian coordinates): x,y = I/Q signals, z = 0
 */

package Tb2;

import ClientServer::*;
import GetPut::*;

import CORDIC::*;
import TestUtils::*;

(* synthesize *)
module mkCORDIC_4 #(parameter Bool mode) (CORDICServer#(4));
   let m <- mkCORDIC(mode);
   return m;
endmodule

module mkTb(Empty);
   Reg#(UInt#(32))  cycles <- mkReg(0);
   Reg#(Int#(4))    phase  <- mkReg(0);
   CORDICServer#(4) dut    <- mkCORDIC_4(rotating);

   rule run;
      CORDICRequest#(4) req = CORDICRequest {x: fromInteger(2**(4-1) - 1),
                                             y: 0,
                                             z: phase};
      //$display("%t req=", $time, fshow(req));
      dut.request.put(req);
      cycles <= cycles + 1;
      phase <= phase + 1;
      if (cycles == fromInteger(4 + 2**4 + 3)) $finish;
   endrule

   rule monitor;
      let rsp <- dut.response.get();
      $display("%t rsp=", $time, fshow(rsp));
   endrule
endmodule

endpackage
