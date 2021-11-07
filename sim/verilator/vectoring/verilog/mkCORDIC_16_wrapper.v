/* Testbench wrapper for combinational feedbacks */

`default_nettype none

module mkCORDIC_16_wrapper
  (input  wire          CLK,
   input  wire          RST_N,
   input  wire [47 : 0] request_put,
   output wire          RDY_request_put,
   output wire [49 : 0] response_get,
   output wire          RDY_response_get);

   wire EN_request_put;
   wire EN_response_get;

   assign EN_request_put  = RST_N & RDY_request_put;
   assign EN_response_get = RST_N & RDY_response_get;

   mkCORDIC_16 #(1) u_mkCORDIC_16(.*); 

  endmodule
`default_nettype wire
