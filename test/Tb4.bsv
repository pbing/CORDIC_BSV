/* Dynamic, rotating mode
 *
 * Input (polar coordinates): x = magnitude, y = 0 , z = phase
 * 
 * Output (cartesian coordinates): x,y = I/Q signals, z = 0
 */

package Tb4;

import ClientServer::*;
import GetPut::*;

import CORDIC::*;
import TestUtils::*;

(* synthesize *)
module mkCORDIC_16 #(parameter Bool mode) (CORDICServer#(16));
   let m <- mkCORDIC(mode);
   return m;
endmodule

module mkTb(Empty);
   Reg#(UInt#(32))   cycles <- mkReg(0);
   Reg#(Int#(16))    phase  <- mkReg(0);
   CORDICServer#(16) dut    <- mkCORDIC_16(rotating);

   rule run;
      CORDICRequest#(16) req = CORDICRequest {x: scale(10000),//fromInteger(2**(16-1) - 1),
                                             y: 0,
                                             z: phase};
      //$display("%t req=", $time, fshow(req));
      dut.request.put(req);
      cycles <= cycles + 1;
      phase <= phase + 1;
      if (cycles == fromInteger(16 + 2**16 + 4)) $finish;
   endrule

   rule monitor;
      let rsp <- dut.response.get();
      $display("%t rsp=", $time, fshow(rsp));
   endrule
endmodule

endpackage
