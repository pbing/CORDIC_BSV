package CORDIC;

import ClientServer::*;
import FIFO::*;
import GetPut::*;
import Real::*;
import SpecialFIFOs::*;
import Vector::*;

Bool rotating  = False;
Bool vectoring = True;

typedef struct {
   Int#(n) x;
   Int#(n) y;
   Int#(n) z; // π = 2**(n - 1)
   } CORDICRequest#(numeric type n) deriving(Bits, Eq, FShow);

typedef struct {
   Int#(TAdd#(n, 1)) x; // scaled by K
   Int#(TAdd#(n, 1)) y; // scaled by K
   Int#(n)           z; // π = 2**(n - 1)
   } CORDICResponse#(numeric type n) deriving(Bits, Eq, FShow);

typedef Server#(CORDICRequest#(n), CORDICResponse#(n)) CORDICServer#(numeric type n);
typedef Client#(CORDICRequest#(n), CORDICResponse#(n)) CORDICClient#(numeric type n);

module mkCORDIC #(parameter Bool mode) (CORDICServer#(n))
   provisos (Log#(n, g),
             Add#(n, 1, n1),
             Add#(n, g, m),
             Add#(TAdd#(n, 1), g, m1),
             Add#(a__, n, m1),
             Add#(n, 4, stages),
             Add#(b__, 1, stages));
   /* n+4 stages for n+2 iterations with log2(n) guard bits */
   Vector#(stages, FIFO#(CORDICResponse#(m))) stg <- replicateM(mkPipelineFIFO);

   function Int#(m) theta(Integer i);
      return fromInteger(round(atan(2**(fromInteger(-i))) * 2**(fromInteger(valueof(m) - 1)) / pi));
   endfunction

   function Int#(k) roundConvergent(Int#(k) x);
      Integer h = 2**(valueof(g) - 1); // half LSB for rounding
      let xp = pack(x);
      let r  = xp[valueof(g)] == 1'b1 ? h : h - 1 ; // either 'b1000... or 'b0111...
      return x + fromInteger(r);
   endfunction

   for (Integer i = 0; i < valueof(stages) - 1; i = i + 1)
      rule iterate;
         let s = stg[i].first;
         stg[i].deq;

         let x = s.x;
         let y = s.y;
         let z = s.z;
         CORDICResponse#(m) s1;

         if (i < valueof(stages) - 2)
            /* iterating */
            if ((mode == vectoring && y >= 0) || (mode == rotating && z < 0)) begin
               s1.x = x + (y >> i);
               s1.y = y - (x >> i);
               s1.z = z + theta(i);
            end
            else begin
               s1.x = x - (y >> i);
               s1.y = y + (x >> i);
               s1.z = z - theta(i);
            end
         else begin
            /* convergent rounding */
            s1.x = roundConvergent(x);
            s1.y = roundConvergent(y);
            s1.z = roundConvergent(z);
         end

         stg[i+1].enq(s1);
         //$display("%t i=%3d x=%d y=%d z=%d theta=%d", $time, i, x, y, z, theta(i));
      endrule

   interface Put request;
      method Action put(req);
         Int#(m1) x    = extend(req.x) << valueof(g);
         Int#(m1) y    = extend(req.y) << valueof(g);
         Int#(m)  z    = extend(req.z) << valueof(g);
         Int#(m)  pi_2 = fromInteger(2**(valueof(m) - 2)); // π/2
         CORDICResponse#(m) s;

         /* map argument -π...π to -π/2...π/2 */
         if ((mode == vectoring && x < 0 && y >= 0) || (mode == rotating && z < (-pi_2))) begin
            s.x = y;
            s.y = -x;
            s.z = z + pi_2;
         end
         else if ((mode == vectoring && x < 0 && y < 0) || (mode == rotating && z >= pi_2)) begin
            s.x = -y;
            s.y = x;
            s.z = z - pi_2;
         end
         else begin
            s.x = x;
            s.y = y;
            s.z = z;
         end

         head(stg).enq(s);
      endmethod
   endinterface

   interface Get response;
      method ActionValue#(CORDICResponse#(n)) get();
         let s = last(stg).first;
         last(stg).deq;

         let x = s.x;
         let y = s.y;
         let z = s.z;

         return CORDICResponse {x: truncate(x >> valueof(g)),
                                y: truncate(y >> valueof(g)),
                                z: truncate(z >> valueof(g))};
      endmethod
   endinterface
endmodule

endpackage
