package CORDIC;

import ClientServer::*;
import FIFO::*;
import GetPut::*;
import Real::*;
import SpecialFIFOs::*;
import Vector::*;

export rotating, vectoring,
       CORDICRequest(..), CORDICResponse(..),
       CORDICServer, CORDICClient,
       mkCORDIC, fnCORDIC;

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

typedef struct {
   Int#(nxy) x;
   Int#(nxy) y;
   Int#(nz)  z;
   } DataPath#(numeric type nxy, numeric type nz) deriving(Bits, Eq, FShow);

typedef Server#(CORDICRequest#(n), CORDICResponse#(n)) CORDICServer#(numeric type n);
typedef Client#(CORDICRequest#(n), CORDICResponse#(n)) CORDICClient#(numeric type n);

function Int#(n) theta(Integer i);
   return fromInteger(round(atan(2**(fromInteger(-i))) * 2**(fromInteger(valueOf(n) - 1)) / pi));
endfunction

function Int#(n) roundConvergent(Int#(n) x, Integer g);
   Integer h = 2**(g - 1);              // half LSB for rounding
   let xp = pack(x);
   let r  = xp[g] == 1'b1 ? h : h - 1 ; // either 'b1000... or 'b0111...
   //return x;
   //return x + fromInteger(h);
   return x + fromInteger(r);
endfunction

module mkCORDIC #(parameter Bool mode) (CORDICServer#(n))
   provisos (Add#(n, 1, n1),
             Add#(n, 3, stages),
             Log#(n, g),
             Add#(g, 2, g2),
             Add#(n1, g2, nxy),
             Add#(n, g, nz),
             Add#(a__, TAdd#(n, 1), nxy),
             Add#(b__, n, nxy),
             Add#(1, c__, stages));
   /*
   (n+1) iterations with 2+log2(n) guard bits for xy and log2(n) guard bits for z
   stage[0]     : mapped inputs
   stage[1..n+1]: iterations
   stage[n+2]   : last interation, rounded
   */
   Vector#(stages, FIFO#(DataPath#(nxy, nz))) stg <- replicateM(mkPipelineFIFO);

   for (Integer i = 0; i < valueOf(stages) - 1; i = i + 1)
      rule iterate;
         let s = stg[i].first;
         stg[i].deq;

         let x = s.x;
         let y = s.y;
         let z = s.z;
         DataPath#(nxy, nz) s1;

         if (i < valueOf(stages) - 2)
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
            s1.x = roundConvergent(x, valueOf(g2));
            s1.y = roundConvergent(y, valueOf(g2));
            s1.z = roundConvergent(z, valueOf(g));
         end

         stg[i+1].enq(s1);
      endrule

   interface Put request;
      method Action put(req);
         Int#(nxy) x    = extend(req.x) << valueOf(g2);
         Int#(nxy) y    = extend(req.y) << valueOf(g2);
         Int#(nz)  z    = extend(req.z) << valueOf(g);
         Int#(nz)  pi_2 = fromInteger(2**(valueOf(nz) - 2)); // π/2
         DataPath#(nxy, nz) s;

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
         let sl = last(stg).first;
         last(stg).deq;

         return CORDICResponse {x: truncate(sl.x >> valueOf(g2)),
                                y: truncate(sl.y >> valueOf(g2)),
                                z: truncate(sl.z >> valueOf(g))};
      endmethod
   endinterface
endmodule

function CORDICResponse#(n) fnCORDIC(Bool mode, CORDICRequest#(n) req)
   provisos (Add#(n, 1, n1),
             Add#(n, 3, stages),
             Log#(n, g),
             Add#(g, 2, g2),
             Add#(n1, g2, nxy),
             Add#(n, g, nz),
             Add#(a__, TAdd#(n, 1), nxy),
             Add#(b__, n, nxy),
             Add#(1, c__, stages));
   /*
   (n+1) iterations with 2+log2(n) guard bits for xy and log2(n) guard bits for z
   stage[0]     : mapped inputs
   stage[1..n+1]: iterations
   stage[n+2]   : last interation, rounded
   */
 Vector#(stages, DataPath#(nxy, nz)) stg;

   for (Integer i = -1; i < valueOf(stages) - 1; i = i + 1) begin
      DataPath#(nxy, nz) s1;

      if (i == -1) begin
         Int#(nxy) x    = extend(req.x) << valueOf(g2);
         Int#(nxy) y    = extend(req.y) << valueOf(g2);
         Int#(nz)  z    = extend(req.z) << valueOf(g);
         Int#(nz)  pi_2 = fromInteger(2**(valueOf(nz) - 2)); // π/2

         /* map argument -π...π to -π/2...π/2 */
         if ((mode == vectoring && x < 0 && y >= 0) || (mode == rotating && z < (-pi_2))) begin
            s1.x = y;
            s1.y = -x;
            s1.z = z + pi_2;
         end
         else if ((mode == vectoring && x < 0 && y < 0) || (mode == rotating && z >= pi_2)) begin
            s1.x = -y;
            s1.y = x;
            s1.z = z - pi_2;
         end
         else begin
            s1.x = x;
            s1.y = y;
            s1.z = z;
         end
      end
      else begin
         let s = stg[i];
         let x = s.x;
         let y = s.y;
         let z = s.z;

         if (i < valueOf(stages) - 2)
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
            s1.x = roundConvergent(x, valueOf(g2));
            s1.y = roundConvergent(y, valueOf(g2));
            s1.z = roundConvergent(z, valueOf(g));
         end
      end

      stg[i+1] = s1;
   end

   let sl = last(stg);
   return CORDICResponse {x: truncate(sl.x >> valueOf(g2)),
                          y: truncate(sl.y >> valueOf(g2)),
                          z: truncate(sl.z >> valueOf(g))};
endfunction
endpackage
