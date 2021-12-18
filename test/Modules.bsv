/* Generate Verilog simulation modules */

package Modules;

import CORDIC::*;

(* synthesize *)
module mkCORDIC_r_16 (CORDICServer#(16));
   let m <- mkCORDIC(rotating);
   return m;
endmodule

(* synthesize *)
module mkCORDIC_v_16 (CORDICServer#(16));
   let m <- mkCORDIC(vectoring);
   return m;
endmodule

(* noinline *)
function CORDICResponse#(16) fnCORDIC_r_16(CORDICRequest#(16) req) = fnCORDIC(rotating, req);

(* noinline *)
function CORDICResponse#(16) fnCORDIC_v_16(CORDICRequest#(16) req) = fnCORDIC(vectoring, req);

endpackage
