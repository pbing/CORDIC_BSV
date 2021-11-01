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

module mkCORDIC #(parameter Bool mode) (CORDICServer#(n));
   /* n+3 stages for n+2 iterations with log2(n) guard bits */
   Vector#(TAdd#(n, 3), FIFO#(Int#(TAdd#(TAdd#(n, 1), TLog#(n))))) xr <- replicateM(mkPipelineFIFO);
   Vector#(TAdd#(n, 3), FIFO#(Int#(TAdd#(TAdd#(n, 1), TLog#(n))))) yr <- replicateM(mkPipelineFIFO);
   Vector#(TAdd#(n, 3), FIFO#(Int#(TAdd#(n, TLog#(n)))))           zr <- replicateM(mkPipelineFIFO);

   Integer m = valueof(n);
   Integer g = log2(m);

   function Int#(TAdd#(n, TLog#(n))) theta(Integer i);
      return fromInteger(round(atan(2**(fromInteger(-i))) * 2**(fromInteger(m + g - 1)) / pi));
   endfunction

   for (Integer i = 0; i < m + 3 - 1; i = i + 1)
      rule iterate;
         let x = xr[i].first;
         let y = yr[i].first;
         let z = zr[i].first;
         xr[i].deq;
         yr[i].deq;
         zr[i].deq;

         if ((mode == vectoring && y >= 0) || (mode == rotating && z < 0)) begin
            xr[i+1].enq(x + (y >> i));
            yr[i+1].enq(y - (x >> i));
            zr[i+1].enq(z + theta(i));
         end
         else begin
            xr[i+1].enq(x - (y >> i));
            yr[i+1].enq(y + (x >> i));
            zr[i+1].enq(z - theta(i));
         end
         //$display("%t i=%3d x=%d y=%d z=%d theta=%d", $time, i, x, y, z, theta(i));
      endrule

   interface Put request;
      method Action put(req);
         Integer m = valueof(n);
         Integer g = log2(m);
         Int#(TAdd#(TAdd#(n, 1), TLog#(n))) x    = extend(req.x) << g;
         Int#(TAdd#(TAdd#(n, 1), TLog#(n))) y    = extend(req.y) << g;
         Int#(TAdd#(n, TLog#(n)))           z    = extend(req.z) << g;
         Int#(TAdd#(n, TLog#(n)))           pi_2 = fromInteger(2**(m + g - 2)); // π/2

         /* map argument -π...π to -π/2...π/2 */
         if ((mode == vectoring && x < 0 && y >= 0) || (mode == rotating && z < (-pi_2))) begin
            head(xr).enq(y);
            head(yr).enq(-x);
            head(zr).enq(z + pi_2);
         end
         else if ((mode == vectoring && x < 0 && y < 0) || (mode == rotating && z >= pi_2)) begin
            head(xr).enq(-y);
            head(yr).enq(x);
            head(zr).enq(z - pi_2);
         end
         else begin
            head(xr).enq(x);
            head(yr).enq(y);
            head(zr).enq(z);
         end
      endmethod
   endinterface

   interface Get response;
      method ActionValue#(CORDICResponse#(n)) get();
         let x = last(xr).first;
         let y = last(yr).first;
         let z = last(zr).first;
         last(xr).deq;
         last(yr).deq;
         last(zr).deq;

         Integer m = valueof(n);
         Integer g = log2(m);
         return CORDICResponse {x: truncate(x >> g),
                                y: truncate(y >> g),
                                z: truncate(z >> g)};
      endmethod
   endinterface
endmodule

endpackage
