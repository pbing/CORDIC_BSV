package TestUtils;

import Real::*;

/* scale factor K */
function Real k(Integer n);
   function Real f(Integer i) = 1.0 / sqrt(1.0 + 2**(fromInteger(-2 * i)));

   if (n == 0)
      return f(n);
   else
      return k(n - 1) * f(n);
endfunction

/* scale with factor K */
function Int#(n) scale(Integer x) = fromInteger(round(fromInteger(x) * fromReal(k(valueof(n) - 1))));

/* transform degrees to binary */
function Int#(n) degrees(Real x) = fromInteger(round(x * 2**(fromInteger(valueof(n) - 1)) / 180.0));

endpackage
