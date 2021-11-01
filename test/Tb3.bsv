/* Static, vectoring mode
 *
 * Input (cartesian coordinates): x,y = I/Q signals, z = 0
 *
 * Output (polar coordinates): x = magnitude, y = 0, z = phase
 */

package Tb3;

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
   CORDICServer#(16) dut    <- mkCORDIC_16(vectoring);

//   CORDICRequest#(16) req = CORDICRequest {x: scale(10000),
//                                           y: 0,
//                                           z: 0};
//   CORDICRequest#(16) req = CORDICRequest {x: 0,
//                                           y: scale(10000),
//                                           z: 0};
//   CORDICRequest#(16) req = CORDICRequest {x: scale(-10000),
//                                           y: 0,
//                                           z: 0};
   CORDICRequest#(16) req = CORDICRequest {x: 0,
                                           y: scale(-10000),
                                           z: 0};

   rule run;
      dut.request.put(req);
      cycles <= cycles + 1;
      if (cycles == 16 + 3) $finish;
   endrule

   rule monitor;
      let rsp <- dut.response.get();
      $display("%t rsp=", $time, fshow(rsp));
   endrule
endmodule

endpackage
