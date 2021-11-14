//
// Generated by Bluespec Compiler, version 2021.07 (build 4cac6eb)
//
// On Sun Nov 14 11:36:19 CET 2021
//
//
// Ports:
// Name                         I/O  size props
// RDY_request_put                O     1
// response_get                   O    14
// RDY_response_get               O     1
// CLK                            I     1 clock
// RST_N                          I     1 reset
// request_put                    I    12
// EN_request_put                 I     1
// EN_response_get                I     1
//
// Combinational paths from inputs to outputs:
//   EN_response_get -> RDY_request_put
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkCORDIC_4(CLK,
		  RST_N,

		  request_put,
		  EN_request_put,
		  RDY_request_put,

		  EN_response_get,
		  response_get,
		  RDY_response_get);
  parameter [0 : 0] mode = 1'b0;
  input  CLK;
  input  RST_N;

  // action method request_put
  input  [11 : 0] request_put;
  input  EN_request_put;
  output RDY_request_put;

  // actionvalue method response_get
  input  EN_response_get;
  output [13 : 0] response_get;
  output RDY_response_get;

  // signals for module outputs
  wire [13 : 0] response_get;
  wire RDY_request_put, RDY_response_get;

  // inlined wires
  wire [20 : 0] m_stg_0_rv$port0__write_1,
		m_stg_0_rv$port1__read,
		m_stg_0_rv$port1__write_1,
		m_stg_0_rv$port2__read,
		m_stg_1_rv$port1__read,
		m_stg_1_rv$port1__write_1,
		m_stg_1_rv$port2__read,
		m_stg_2_rv$port1__read,
		m_stg_2_rv$port1__write_1,
		m_stg_2_rv$port2__read,
		m_stg_3_rv$port1__read,
		m_stg_3_rv$port1__write_1,
		m_stg_3_rv$port2__read,
		m_stg_4_rv$port1__read,
		m_stg_4_rv$port1__write_1,
		m_stg_4_rv$port2__read,
		m_stg_5_rv$port1__read,
		m_stg_5_rv$port1__write_1,
		m_stg_5_rv$port2__read,
		m_stg_6_rv$port1__read,
		m_stg_6_rv$port1__write_1,
		m_stg_6_rv$port2__read,
		m_stg_7_rv$port1__read,
		m_stg_7_rv$port1__write_1,
		m_stg_7_rv$port2__read;
  wire m_stg_0_rv$EN_port0__write,
       m_stg_1_rv$EN_port0__write,
       m_stg_1_rv$EN_port1__write,
       m_stg_2_rv$EN_port0__write,
       m_stg_2_rv$EN_port1__write,
       m_stg_3_rv$EN_port0__write,
       m_stg_3_rv$EN_port1__write,
       m_stg_4_rv$EN_port0__write,
       m_stg_4_rv$EN_port1__write,
       m_stg_5_rv$EN_port0__write,
       m_stg_5_rv$EN_port1__write,
       m_stg_6_rv$EN_port0__write,
       m_stg_6_rv$EN_port1__write,
       m_stg_7_rv$EN_port1__write;

  // register m_stg_0_rv
  reg [20 : 0] m_stg_0_rv;
  wire [20 : 0] m_stg_0_rv$D_IN;
  wire m_stg_0_rv$EN;

  // register m_stg_1_rv
  reg [20 : 0] m_stg_1_rv;
  wire [20 : 0] m_stg_1_rv$D_IN;
  wire m_stg_1_rv$EN;

  // register m_stg_2_rv
  reg [20 : 0] m_stg_2_rv;
  wire [20 : 0] m_stg_2_rv$D_IN;
  wire m_stg_2_rv$EN;

  // register m_stg_3_rv
  reg [20 : 0] m_stg_3_rv;
  wire [20 : 0] m_stg_3_rv$D_IN;
  wire m_stg_3_rv$EN;

  // register m_stg_4_rv
  reg [20 : 0] m_stg_4_rv;
  wire [20 : 0] m_stg_4_rv$D_IN;
  wire m_stg_4_rv$EN;

  // register m_stg_5_rv
  reg [20 : 0] m_stg_5_rv;
  wire [20 : 0] m_stg_5_rv$D_IN;
  wire m_stg_5_rv$EN;

  // register m_stg_6_rv
  reg [20 : 0] m_stg_6_rv;
  wire [20 : 0] m_stg_6_rv$D_IN;
  wire m_stg_6_rv$EN;

  // register m_stg_7_rv
  reg [20 : 0] m_stg_7_rv;
  wire [20 : 0] m_stg_7_rv$D_IN;
  wire m_stg_7_rv$EN;

  // remaining internal signals
  wire [19 : 0] IF_mode_AND_NOT_m_stg_0_rv_port0__read_BIT_12__ETC___d28,
		IF_mode_AND_NOT_m_stg_1_rv_port0__read__0_BIT__ETC___d55,
		IF_mode_AND_NOT_m_stg_2_rv_port0__read__7_BIT__ETC___d82,
		IF_mode_AND_NOT_m_stg_3_rv_port0__read__4_BIT__ETC___d109,
		IF_mode_AND_NOT_m_stg_4_rv_port0__read__11_BIT_ETC___d136,
		IF_mode_AND_SEXT_request_put_BITS_11_TO_8_83_8_ETC___d217,
		IF_mode_AND_SEXT_request_put_BITS_11_TO_8_83_8_ETC___d218;
  wire [6 : 0] IF_mode_AND_NOT_m_stg_5_rv_port0__read__38_BIT_ETC___d155,
	       IF_mode_AND_NOT_m_stg_5_rv_port0__read__38_BIT_ETC___d159,
	       IF_mode_AND_SEXT_request_put_BITS_11_TO_8_83_8_ETC___d212,
	       SEXT_m_stg_7_rv_BITS_12_TO_6_BITS_6_TO_2__q6,
	       SEXT_m_stg_7_rv_BITS_19_TO_13_BITS_6_TO_2__q3,
	       SEXT_request_put_BITS_11_TO_8_83___d184,
	       SEXT_request_put_BITS_7_TO_4_87___d188,
	       m_stg_0_rv_BITS_12_TO_6__q10,
	       m_stg_0_rv_BITS_19_TO_13__q15,
	       m_stg_0_rv_port0__read_BITS_12_TO_6_6_SRA_0___d17,
	       m_stg_0_rv_port0__read_BITS_19_TO_13_5_SRA_0___d19,
	       m_stg_1_rv_BITS_12_TO_6__q13,
	       m_stg_1_rv_BITS_19_TO_13__q11,
	       m_stg_1_rv_port0__read__0_BITS_12_TO_6_3_SRA_1___d44,
	       m_stg_1_rv_port0__read__0_BITS_19_TO_13_2_SRA_1___d46,
	       m_stg_2_rv_BITS_12_TO_6__q16,
	       m_stg_2_rv_BITS_19_TO_13__q18,
	       m_stg_2_rv_port0__read__7_BITS_12_TO_6_0_SRA_2___d71,
	       m_stg_2_rv_port0__read__7_BITS_19_TO_13_9_SRA_2___d73,
	       m_stg_3_rv_BITS_12_TO_6__q20,
	       m_stg_3_rv_BITS_19_TO_13__q22,
	       m_stg_3_rv_port0__read__4_BITS_12_TO_6_7_SRA_3___d98,
	       m_stg_3_rv_port0__read__4_BITS_19_TO_13_6_SRA_3___d100,
	       m_stg_4_rv_BITS_12_TO_6__q24,
	       m_stg_4_rv_BITS_19_TO_13__q26,
	       m_stg_4_rv_port0__read__11_BITS_12_TO_6_24_SRA_4___d125,
	       m_stg_4_rv_port0__read__11_BITS_19_TO_13_23_SRA_4___d127,
	       m_stg_5_rv_BITS_12_TO_6__q28,
	       m_stg_5_rv_BITS_19_TO_13__q30,
	       m_stg_5_rv_port0__read__38_BITS_12_TO_6_51_SRA_5___d152,
	       m_stg_5_rv_port0__read__38_BITS_19_TO_13_50_SRA_5___d156,
	       m_stg_7_rv_BITS_12_TO_6__q4,
	       m_stg_7_rv_BITS_19_TO_13__q1;
  wire [5 : 0] SEXT_m_stg_7_rv_BITS_5_TO_0_BITS_5_TO_2__q9,
	       SEXT_request_put_BITS_3_TO_04__q35,
	       SEXT_request_put_BITS_3_TO_0_92_93_BITS_3_TO_0_ETC___d195,
	       m_stg_1_rv_BITS_12_TO_63_BITS_6_TO_1__q14,
	       m_stg_1_rv_BITS_19_TO_131_BITS_6_TO_1__q12,
	       m_stg_7_rv_BITS_5_TO_0__q7;
  wire [4 : 0] m_stg_2_rv_BITS_12_TO_66_BITS_6_TO_2__q17,
	       m_stg_2_rv_BITS_19_TO_138_BITS_6_TO_2__q19,
	       m_stg_7_rv_BITS_12_TO_6_BITS_6_TO_2__q5,
	       m_stg_7_rv_BITS_19_TO_13_BITS_6_TO_2__q2;
  wire [3 : 0] m_stg_3_rv_BITS_12_TO_60_BITS_6_TO_3__q21,
	       m_stg_3_rv_BITS_19_TO_132_BITS_6_TO_3__q23,
	       m_stg_7_rv_BITS_5_TO_0_BITS_5_TO_2__q8,
	       request_put_BITS_11_TO_8__q32,
	       request_put_BITS_3_TO_0__q34,
	       request_put_BITS_7_TO_4__q33;
  wire [2 : 0] m_stg_4_rv_BITS_12_TO_64_BITS_6_TO_4__q25,
	       m_stg_4_rv_BITS_19_TO_136_BITS_6_TO_4__q27;
  wire [1 : 0] m_stg_5_rv_BITS_12_TO_68_BITS_6_TO_5__q29,
	       m_stg_5_rv_BITS_19_TO_130_BITS_6_TO_5__q31;
  wire mode_AND_SEXT_request_put_BITS_11_TO_8_83_84_B_ETC___d198,
       mode_AND_SEXT_request_put_BITS_11_TO_8_83_84_B_ETC___d210;

  // action method request_put
  assign RDY_request_put = !m_stg_0_rv$port1__read[20] ;

  // actionvalue method response_get
  assign response_get =
	     { SEXT_m_stg_7_rv_BITS_19_TO_13_BITS_6_TO_2__q3[4:0],
	       SEXT_m_stg_7_rv_BITS_12_TO_6_BITS_6_TO_2__q6[4:0],
	       SEXT_m_stg_7_rv_BITS_5_TO_0_BITS_5_TO_2__q9[3:0] } ;
  assign RDY_response_get = m_stg_7_rv[20] ;

  // inlined wires
  assign m_stg_0_rv$EN_port0__write =
	     m_stg_0_rv[20] && !m_stg_1_rv$port1__read[20] ;
  assign m_stg_0_rv$port0__write_1 =
	     { 1'd0, 20'bxxxxxxxxxxxxxxxxxxxx /* unspecified value */  } ;
  assign m_stg_0_rv$port1__read =
	     m_stg_0_rv$EN_port0__write ?
	       m_stg_0_rv$port0__write_1 :
	       m_stg_0_rv ;
  assign m_stg_0_rv$port1__write_1 =
	     { 1'd1,
	       IF_mode_AND_SEXT_request_put_BITS_11_TO_8_83_8_ETC___d218 } ;
  assign m_stg_0_rv$port2__read =
	     EN_request_put ?
	       m_stg_0_rv$port1__write_1 :
	       m_stg_0_rv$port1__read ;
  assign m_stg_1_rv$EN_port0__write =
	     m_stg_1_rv[20] && !m_stg_2_rv$port1__read[20] ;
  assign m_stg_1_rv$port1__read =
	     m_stg_1_rv$EN_port0__write ?
	       m_stg_0_rv$port0__write_1 :
	       m_stg_1_rv ;
  assign m_stg_1_rv$EN_port1__write =
	     m_stg_0_rv[20] && !m_stg_1_rv$port1__read[20] ;
  assign m_stg_1_rv$port1__write_1 =
	     { 1'd1,
	       IF_mode_AND_NOT_m_stg_0_rv_port0__read_BIT_12__ETC___d28 } ;
  assign m_stg_1_rv$port2__read =
	     m_stg_1_rv$EN_port1__write ?
	       m_stg_1_rv$port1__write_1 :
	       m_stg_1_rv$port1__read ;
  assign m_stg_2_rv$EN_port0__write =
	     m_stg_2_rv[20] && !m_stg_3_rv$port1__read[20] ;
  assign m_stg_2_rv$port1__read =
	     m_stg_2_rv$EN_port0__write ?
	       m_stg_0_rv$port0__write_1 :
	       m_stg_2_rv ;
  assign m_stg_2_rv$EN_port1__write =
	     m_stg_1_rv[20] && !m_stg_2_rv$port1__read[20] ;
  assign m_stg_2_rv$port1__write_1 =
	     { 1'd1,
	       IF_mode_AND_NOT_m_stg_1_rv_port0__read__0_BIT__ETC___d55 } ;
  assign m_stg_2_rv$port2__read =
	     m_stg_2_rv$EN_port1__write ?
	       m_stg_2_rv$port1__write_1 :
	       m_stg_2_rv$port1__read ;
  assign m_stg_3_rv$EN_port0__write =
	     m_stg_3_rv[20] && !m_stg_4_rv$port1__read[20] ;
  assign m_stg_3_rv$port1__read =
	     m_stg_3_rv$EN_port0__write ?
	       m_stg_0_rv$port0__write_1 :
	       m_stg_3_rv ;
  assign m_stg_3_rv$EN_port1__write =
	     m_stg_2_rv[20] && !m_stg_3_rv$port1__read[20] ;
  assign m_stg_3_rv$port1__write_1 =
	     { 1'd1,
	       IF_mode_AND_NOT_m_stg_2_rv_port0__read__7_BIT__ETC___d82 } ;
  assign m_stg_3_rv$port2__read =
	     m_stg_3_rv$EN_port1__write ?
	       m_stg_3_rv$port1__write_1 :
	       m_stg_3_rv$port1__read ;
  assign m_stg_4_rv$EN_port0__write =
	     m_stg_4_rv[20] && !m_stg_5_rv$port1__read[20] ;
  assign m_stg_4_rv$port1__read =
	     m_stg_4_rv$EN_port0__write ?
	       m_stg_0_rv$port0__write_1 :
	       m_stg_4_rv ;
  assign m_stg_4_rv$EN_port1__write =
	     m_stg_3_rv[20] && !m_stg_4_rv$port1__read[20] ;
  assign m_stg_4_rv$port1__write_1 =
	     { 1'd1,
	       IF_mode_AND_NOT_m_stg_3_rv_port0__read__4_BIT__ETC___d109 } ;
  assign m_stg_4_rv$port2__read =
	     m_stg_4_rv$EN_port1__write ?
	       m_stg_4_rv$port1__write_1 :
	       m_stg_4_rv$port1__read ;
  assign m_stg_5_rv$EN_port0__write =
	     m_stg_5_rv[20] && !m_stg_6_rv$port1__read[20] ;
  assign m_stg_5_rv$port1__read =
	     m_stg_5_rv$EN_port0__write ?
	       m_stg_0_rv$port0__write_1 :
	       m_stg_5_rv ;
  assign m_stg_5_rv$EN_port1__write =
	     m_stg_4_rv[20] && !m_stg_5_rv$port1__read[20] ;
  assign m_stg_5_rv$port1__write_1 =
	     { 1'd1,
	       IF_mode_AND_NOT_m_stg_4_rv_port0__read__11_BIT_ETC___d136 } ;
  assign m_stg_5_rv$port2__read =
	     m_stg_5_rv$EN_port1__write ?
	       m_stg_5_rv$port1__write_1 :
	       m_stg_5_rv$port1__read ;
  assign m_stg_6_rv$EN_port0__write =
	     m_stg_6_rv[20] && !m_stg_7_rv$port1__read[20] ;
  assign m_stg_6_rv$port1__read =
	     m_stg_6_rv$EN_port0__write ?
	       m_stg_0_rv$port0__write_1 :
	       m_stg_6_rv ;
  assign m_stg_6_rv$EN_port1__write =
	     m_stg_5_rv[20] && !m_stg_6_rv$port1__read[20] ;
  assign m_stg_6_rv$port1__write_1 =
	     { 1'd1,
	       IF_mode_AND_NOT_m_stg_5_rv_port0__read__38_BIT_ETC___d155,
	       IF_mode_AND_NOT_m_stg_5_rv_port0__read__38_BIT_ETC___d159,
	       m_stg_5_rv[5:0] } ;
  assign m_stg_6_rv$port2__read =
	     m_stg_6_rv$EN_port1__write ?
	       m_stg_6_rv$port1__write_1 :
	       m_stg_6_rv$port1__read ;
  assign m_stg_7_rv$port1__read =
	     EN_response_get ? m_stg_0_rv$port0__write_1 : m_stg_7_rv ;
  assign m_stg_7_rv$EN_port1__write =
	     m_stg_6_rv[20] && !m_stg_7_rv$port1__read[20] ;
  assign m_stg_7_rv$port1__write_1 =
	     { 1'd1,
	       m_stg_6_rv[19:13] + (m_stg_6_rv[15] ? 7'd2 : 7'd1),
	       m_stg_6_rv[12:6] + (m_stg_6_rv[8] ? 7'd2 : 7'd1),
	       m_stg_6_rv[5:0] + (m_stg_6_rv[2] ? 6'd2 : 6'd1) } ;
  assign m_stg_7_rv$port2__read =
	     m_stg_7_rv$EN_port1__write ?
	       m_stg_7_rv$port1__write_1 :
	       m_stg_7_rv$port1__read ;

  // register m_stg_0_rv
  assign m_stg_0_rv$D_IN = m_stg_0_rv$port2__read ;
  assign m_stg_0_rv$EN = 1'b1 ;

  // register m_stg_1_rv
  assign m_stg_1_rv$D_IN = m_stg_1_rv$port2__read ;
  assign m_stg_1_rv$EN = 1'b1 ;

  // register m_stg_2_rv
  assign m_stg_2_rv$D_IN = m_stg_2_rv$port2__read ;
  assign m_stg_2_rv$EN = 1'b1 ;

  // register m_stg_3_rv
  assign m_stg_3_rv$D_IN = m_stg_3_rv$port2__read ;
  assign m_stg_3_rv$EN = 1'b1 ;

  // register m_stg_4_rv
  assign m_stg_4_rv$D_IN = m_stg_4_rv$port2__read ;
  assign m_stg_4_rv$EN = 1'b1 ;

  // register m_stg_5_rv
  assign m_stg_5_rv$D_IN = m_stg_5_rv$port2__read ;
  assign m_stg_5_rv$EN = 1'b1 ;

  // register m_stg_6_rv
  assign m_stg_6_rv$D_IN = m_stg_6_rv$port2__read ;
  assign m_stg_6_rv$EN = 1'b1 ;

  // register m_stg_7_rv
  assign m_stg_7_rv$D_IN = m_stg_7_rv$port2__read ;
  assign m_stg_7_rv$EN = 1'b1 ;

  // remaining internal signals
  assign IF_mode_AND_NOT_m_stg_0_rv_port0__read_BIT_12__ETC___d28 =
	     (mode && !m_stg_0_rv[12] || !mode && m_stg_0_rv[5]) ?
	       { m_stg_0_rv[19:13] +
		 m_stg_0_rv_port0__read_BITS_12_TO_6_6_SRA_0___d17,
		 m_stg_0_rv[12:6] -
		 m_stg_0_rv_port0__read_BITS_19_TO_13_5_SRA_0___d19,
		 m_stg_0_rv[5:0] + 6'd8 } :
	       { m_stg_0_rv[19:13] -
		 m_stg_0_rv_port0__read_BITS_12_TO_6_6_SRA_0___d17,
		 m_stg_0_rv[12:6] +
		 m_stg_0_rv_port0__read_BITS_19_TO_13_5_SRA_0___d19,
		 m_stg_0_rv[5:0] - 6'd8 } ;
  assign IF_mode_AND_NOT_m_stg_1_rv_port0__read__0_BIT__ETC___d55 =
	     (mode && !m_stg_1_rv[12] || !mode && m_stg_1_rv[5]) ?
	       { m_stg_1_rv[19:13] +
		 m_stg_1_rv_port0__read__0_BITS_12_TO_6_3_SRA_1___d44,
		 m_stg_1_rv[12:6] -
		 m_stg_1_rv_port0__read__0_BITS_19_TO_13_2_SRA_1___d46,
		 m_stg_1_rv[5:0] + 6'd5 } :
	       { m_stg_1_rv[19:13] -
		 m_stg_1_rv_port0__read__0_BITS_12_TO_6_3_SRA_1___d44,
		 m_stg_1_rv[12:6] +
		 m_stg_1_rv_port0__read__0_BITS_19_TO_13_2_SRA_1___d46,
		 m_stg_1_rv[5:0] - 6'd5 } ;
  assign IF_mode_AND_NOT_m_stg_2_rv_port0__read__7_BIT__ETC___d82 =
	     (mode && !m_stg_2_rv[12] || !mode && m_stg_2_rv[5]) ?
	       { m_stg_2_rv[19:13] +
		 m_stg_2_rv_port0__read__7_BITS_12_TO_6_0_SRA_2___d71,
		 m_stg_2_rv[12:6] -
		 m_stg_2_rv_port0__read__7_BITS_19_TO_13_9_SRA_2___d73,
		 m_stg_2_rv[5:0] + 6'd2 } :
	       { m_stg_2_rv[19:13] -
		 m_stg_2_rv_port0__read__7_BITS_12_TO_6_0_SRA_2___d71,
		 m_stg_2_rv[12:6] +
		 m_stg_2_rv_port0__read__7_BITS_19_TO_13_9_SRA_2___d73,
		 m_stg_2_rv[5:0] - 6'd2 } ;
  assign IF_mode_AND_NOT_m_stg_3_rv_port0__read__4_BIT__ETC___d109 =
	     (mode && !m_stg_3_rv[12] || !mode && m_stg_3_rv[5]) ?
	       { m_stg_3_rv[19:13] +
		 m_stg_3_rv_port0__read__4_BITS_12_TO_6_7_SRA_3___d98,
		 m_stg_3_rv[12:6] -
		 m_stg_3_rv_port0__read__4_BITS_19_TO_13_6_SRA_3___d100,
		 m_stg_3_rv[5:0] + 6'd1 } :
	       { m_stg_3_rv[19:13] -
		 m_stg_3_rv_port0__read__4_BITS_12_TO_6_7_SRA_3___d98,
		 m_stg_3_rv[12:6] +
		 m_stg_3_rv_port0__read__4_BITS_19_TO_13_6_SRA_3___d100,
		 m_stg_3_rv[5:0] - 6'd1 } ;
  assign IF_mode_AND_NOT_m_stg_4_rv_port0__read__11_BIT_ETC___d136 =
	     (mode && !m_stg_4_rv[12] || !mode && m_stg_4_rv[5]) ?
	       { m_stg_4_rv[19:13] +
		 m_stg_4_rv_port0__read__11_BITS_12_TO_6_24_SRA_4___d125,
		 m_stg_4_rv[12:6] -
		 m_stg_4_rv_port0__read__11_BITS_19_TO_13_23_SRA_4___d127,
		 m_stg_4_rv[5:0] + 6'd1 } :
	       { m_stg_4_rv[19:13] -
		 m_stg_4_rv_port0__read__11_BITS_12_TO_6_24_SRA_4___d125,
		 m_stg_4_rv[12:6] +
		 m_stg_4_rv_port0__read__11_BITS_19_TO_13_23_SRA_4___d127,
		 m_stg_4_rv[5:0] - 6'd1 } ;
  assign IF_mode_AND_NOT_m_stg_5_rv_port0__read__38_BIT_ETC___d155 =
	     (mode && !m_stg_5_rv[12] || !mode && m_stg_5_rv[5]) ?
	       m_stg_5_rv[19:13] +
	       m_stg_5_rv_port0__read__38_BITS_12_TO_6_51_SRA_5___d152 :
	       m_stg_5_rv[19:13] -
	       m_stg_5_rv_port0__read__38_BITS_12_TO_6_51_SRA_5___d152 ;
  assign IF_mode_AND_NOT_m_stg_5_rv_port0__read__38_BIT_ETC___d159 =
	     (mode && !m_stg_5_rv[12] || !mode && m_stg_5_rv[5]) ?
	       m_stg_5_rv[12:6] -
	       m_stg_5_rv_port0__read__38_BITS_19_TO_13_50_SRA_5___d156 :
	       m_stg_5_rv[12:6] +
	       m_stg_5_rv_port0__read__38_BITS_19_TO_13_50_SRA_5___d156 ;
  assign IF_mode_AND_SEXT_request_put_BITS_11_TO_8_83_8_ETC___d212 =
	     mode_AND_SEXT_request_put_BITS_11_TO_8_83_84_B_ETC___d210 ?
	       -{ SEXT_request_put_BITS_7_TO_4_87___d188[4:0], 2'd0 } :
	       { SEXT_request_put_BITS_11_TO_8_83___d184[4:0], 2'd0 } ;
  assign IF_mode_AND_SEXT_request_put_BITS_11_TO_8_83_8_ETC___d217 =
	     { IF_mode_AND_SEXT_request_put_BITS_11_TO_8_83_8_ETC___d212,
	       mode_AND_SEXT_request_put_BITS_11_TO_8_83_84_B_ETC___d210 ?
		 SEXT_request_put_BITS_11_TO_8_83___d184[4:0] :
		 SEXT_request_put_BITS_7_TO_4_87___d188[4:0],
	       2'd0,
	       mode_AND_SEXT_request_put_BITS_11_TO_8_83_84_B_ETC___d210 ?
		 SEXT_request_put_BITS_3_TO_0_92_93_BITS_3_TO_0_ETC___d195 -
		 6'd16 :
		 SEXT_request_put_BITS_3_TO_0_92_93_BITS_3_TO_0_ETC___d195 } ;
  assign IF_mode_AND_SEXT_request_put_BITS_11_TO_8_83_8_ETC___d218 =
	     mode_AND_SEXT_request_put_BITS_11_TO_8_83_84_B_ETC___d198 ?
	       { SEXT_request_put_BITS_7_TO_4_87___d188[4:0],
		 2'd0,
		 -{ SEXT_request_put_BITS_11_TO_8_83___d184[4:0], 2'd0 },
		 SEXT_request_put_BITS_3_TO_0_92_93_BITS_3_TO_0_ETC___d195 +
		 6'd16 } :
	       IF_mode_AND_SEXT_request_put_BITS_11_TO_8_83_8_ETC___d217 ;
  assign SEXT_m_stg_7_rv_BITS_12_TO_6_BITS_6_TO_2__q6 =
	     { {2{m_stg_7_rv_BITS_12_TO_6_BITS_6_TO_2__q5[4]}},
	       m_stg_7_rv_BITS_12_TO_6_BITS_6_TO_2__q5 } ;
  assign SEXT_m_stg_7_rv_BITS_19_TO_13_BITS_6_TO_2__q3 =
	     { {2{m_stg_7_rv_BITS_19_TO_13_BITS_6_TO_2__q2[4]}},
	       m_stg_7_rv_BITS_19_TO_13_BITS_6_TO_2__q2 } ;
  assign SEXT_m_stg_7_rv_BITS_5_TO_0_BITS_5_TO_2__q9 =
	     { {2{m_stg_7_rv_BITS_5_TO_0_BITS_5_TO_2__q8[3]}},
	       m_stg_7_rv_BITS_5_TO_0_BITS_5_TO_2__q8 } ;
  assign SEXT_request_put_BITS_11_TO_8_83___d184 =
	     { {3{request_put_BITS_11_TO_8__q32[3]}},
	       request_put_BITS_11_TO_8__q32 } ;
  assign SEXT_request_put_BITS_3_TO_04__q35 =
	     { {2{request_put_BITS_3_TO_0__q34[3]}},
	       request_put_BITS_3_TO_0__q34 } ;
  assign SEXT_request_put_BITS_3_TO_0_92_93_BITS_3_TO_0_ETC___d195 =
	     { SEXT_request_put_BITS_3_TO_04__q35[3:0], 2'd0 } ;
  assign SEXT_request_put_BITS_7_TO_4_87___d188 =
	     { {3{request_put_BITS_7_TO_4__q33[3]}},
	       request_put_BITS_7_TO_4__q33 } ;
  assign m_stg_0_rv_BITS_12_TO_6__q10 = m_stg_0_rv[12:6] ;
  assign m_stg_0_rv_BITS_19_TO_13__q15 = m_stg_0_rv[19:13] ;
  assign m_stg_0_rv_port0__read_BITS_12_TO_6_6_SRA_0___d17 =
	     m_stg_0_rv_BITS_12_TO_6__q10 ;
  assign m_stg_0_rv_port0__read_BITS_19_TO_13_5_SRA_0___d19 =
	     m_stg_0_rv_BITS_19_TO_13__q15 ;
  assign m_stg_1_rv_BITS_12_TO_63_BITS_6_TO_1__q14 =
	     m_stg_1_rv_BITS_12_TO_6__q13[6:1] ;
  assign m_stg_1_rv_BITS_12_TO_6__q13 = m_stg_1_rv[12:6] ;
  assign m_stg_1_rv_BITS_19_TO_131_BITS_6_TO_1__q12 =
	     m_stg_1_rv_BITS_19_TO_13__q11[6:1] ;
  assign m_stg_1_rv_BITS_19_TO_13__q11 = m_stg_1_rv[19:13] ;
  assign m_stg_1_rv_port0__read__0_BITS_12_TO_6_3_SRA_1___d44 =
	     { m_stg_1_rv_BITS_12_TO_63_BITS_6_TO_1__q14[5],
	       m_stg_1_rv_BITS_12_TO_63_BITS_6_TO_1__q14 } ;
  assign m_stg_1_rv_port0__read__0_BITS_19_TO_13_2_SRA_1___d46 =
	     { m_stg_1_rv_BITS_19_TO_131_BITS_6_TO_1__q12[5],
	       m_stg_1_rv_BITS_19_TO_131_BITS_6_TO_1__q12 } ;
  assign m_stg_2_rv_BITS_12_TO_66_BITS_6_TO_2__q17 =
	     m_stg_2_rv_BITS_12_TO_6__q16[6:2] ;
  assign m_stg_2_rv_BITS_12_TO_6__q16 = m_stg_2_rv[12:6] ;
  assign m_stg_2_rv_BITS_19_TO_138_BITS_6_TO_2__q19 =
	     m_stg_2_rv_BITS_19_TO_13__q18[6:2] ;
  assign m_stg_2_rv_BITS_19_TO_13__q18 = m_stg_2_rv[19:13] ;
  assign m_stg_2_rv_port0__read__7_BITS_12_TO_6_0_SRA_2___d71 =
	     { {2{m_stg_2_rv_BITS_12_TO_66_BITS_6_TO_2__q17[4]}},
	       m_stg_2_rv_BITS_12_TO_66_BITS_6_TO_2__q17 } ;
  assign m_stg_2_rv_port0__read__7_BITS_19_TO_13_9_SRA_2___d73 =
	     { {2{m_stg_2_rv_BITS_19_TO_138_BITS_6_TO_2__q19[4]}},
	       m_stg_2_rv_BITS_19_TO_138_BITS_6_TO_2__q19 } ;
  assign m_stg_3_rv_BITS_12_TO_60_BITS_6_TO_3__q21 =
	     m_stg_3_rv_BITS_12_TO_6__q20[6:3] ;
  assign m_stg_3_rv_BITS_12_TO_6__q20 = m_stg_3_rv[12:6] ;
  assign m_stg_3_rv_BITS_19_TO_132_BITS_6_TO_3__q23 =
	     m_stg_3_rv_BITS_19_TO_13__q22[6:3] ;
  assign m_stg_3_rv_BITS_19_TO_13__q22 = m_stg_3_rv[19:13] ;
  assign m_stg_3_rv_port0__read__4_BITS_12_TO_6_7_SRA_3___d98 =
	     { {3{m_stg_3_rv_BITS_12_TO_60_BITS_6_TO_3__q21[3]}},
	       m_stg_3_rv_BITS_12_TO_60_BITS_6_TO_3__q21 } ;
  assign m_stg_3_rv_port0__read__4_BITS_19_TO_13_6_SRA_3___d100 =
	     { {3{m_stg_3_rv_BITS_19_TO_132_BITS_6_TO_3__q23[3]}},
	       m_stg_3_rv_BITS_19_TO_132_BITS_6_TO_3__q23 } ;
  assign m_stg_4_rv_BITS_12_TO_64_BITS_6_TO_4__q25 =
	     m_stg_4_rv_BITS_12_TO_6__q24[6:4] ;
  assign m_stg_4_rv_BITS_12_TO_6__q24 = m_stg_4_rv[12:6] ;
  assign m_stg_4_rv_BITS_19_TO_136_BITS_6_TO_4__q27 =
	     m_stg_4_rv_BITS_19_TO_13__q26[6:4] ;
  assign m_stg_4_rv_BITS_19_TO_13__q26 = m_stg_4_rv[19:13] ;
  assign m_stg_4_rv_port0__read__11_BITS_12_TO_6_24_SRA_4___d125 =
	     { {4{m_stg_4_rv_BITS_12_TO_64_BITS_6_TO_4__q25[2]}},
	       m_stg_4_rv_BITS_12_TO_64_BITS_6_TO_4__q25 } ;
  assign m_stg_4_rv_port0__read__11_BITS_19_TO_13_23_SRA_4___d127 =
	     { {4{m_stg_4_rv_BITS_19_TO_136_BITS_6_TO_4__q27[2]}},
	       m_stg_4_rv_BITS_19_TO_136_BITS_6_TO_4__q27 } ;
  assign m_stg_5_rv_BITS_12_TO_68_BITS_6_TO_5__q29 =
	     m_stg_5_rv_BITS_12_TO_6__q28[6:5] ;
  assign m_stg_5_rv_BITS_12_TO_6__q28 = m_stg_5_rv[12:6] ;
  assign m_stg_5_rv_BITS_19_TO_130_BITS_6_TO_5__q31 =
	     m_stg_5_rv_BITS_19_TO_13__q30[6:5] ;
  assign m_stg_5_rv_BITS_19_TO_13__q30 = m_stg_5_rv[19:13] ;
  assign m_stg_5_rv_port0__read__38_BITS_12_TO_6_51_SRA_5___d152 =
	     { {5{m_stg_5_rv_BITS_12_TO_68_BITS_6_TO_5__q29[1]}},
	       m_stg_5_rv_BITS_12_TO_68_BITS_6_TO_5__q29 } ;
  assign m_stg_5_rv_port0__read__38_BITS_19_TO_13_50_SRA_5___d156 =
	     { {5{m_stg_5_rv_BITS_19_TO_130_BITS_6_TO_5__q31[1]}},
	       m_stg_5_rv_BITS_19_TO_130_BITS_6_TO_5__q31 } ;
  assign m_stg_7_rv_BITS_12_TO_6_BITS_6_TO_2__q5 =
	     m_stg_7_rv_BITS_12_TO_6__q4[6:2] ;
  assign m_stg_7_rv_BITS_12_TO_6__q4 = m_stg_7_rv[12:6] ;
  assign m_stg_7_rv_BITS_19_TO_13_BITS_6_TO_2__q2 =
	     m_stg_7_rv_BITS_19_TO_13__q1[6:2] ;
  assign m_stg_7_rv_BITS_19_TO_13__q1 = m_stg_7_rv[19:13] ;
  assign m_stg_7_rv_BITS_5_TO_0_BITS_5_TO_2__q8 =
	     m_stg_7_rv_BITS_5_TO_0__q7[5:2] ;
  assign m_stg_7_rv_BITS_5_TO_0__q7 = m_stg_7_rv[5:0] ;
  assign mode_AND_SEXT_request_put_BITS_11_TO_8_83_84_B_ETC___d198 =
	     mode && SEXT_request_put_BITS_11_TO_8_83___d184[4] &&
	     !SEXT_request_put_BITS_7_TO_4_87___d188[4] ||
	     !mode &&
	     (SEXT_request_put_BITS_3_TO_0_92_93_BITS_3_TO_0_ETC___d195 ^
	      6'h20) <
	     6'd16 ;
  assign mode_AND_SEXT_request_put_BITS_11_TO_8_83_84_B_ETC___d210 =
	     mode && SEXT_request_put_BITS_11_TO_8_83___d184[4] &&
	     SEXT_request_put_BITS_7_TO_4_87___d188[4] ||
	     !mode &&
	     (SEXT_request_put_BITS_3_TO_0_92_93_BITS_3_TO_0_ETC___d195 ^
	      6'h20) >=
	     6'd48 ;
  assign request_put_BITS_11_TO_8__q32 = request_put[11:8] ;
  assign request_put_BITS_3_TO_0__q34 = request_put[3:0] ;
  assign request_put_BITS_7_TO_4__q33 = request_put[7:4] ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        m_stg_0_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 20'bxxxxxxxxxxxxxxxxxxxx /* unspecified value */  };
	m_stg_1_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 20'bxxxxxxxxxxxxxxxxxxxx /* unspecified value */  };
	m_stg_2_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 20'bxxxxxxxxxxxxxxxxxxxx /* unspecified value */  };
	m_stg_3_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 20'bxxxxxxxxxxxxxxxxxxxx /* unspecified value */  };
	m_stg_4_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 20'bxxxxxxxxxxxxxxxxxxxx /* unspecified value */  };
	m_stg_5_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 20'bxxxxxxxxxxxxxxxxxxxx /* unspecified value */  };
	m_stg_6_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 20'bxxxxxxxxxxxxxxxxxxxx /* unspecified value */  };
	m_stg_7_rv <= `BSV_ASSIGNMENT_DELAY
	    { 1'd0, 20'bxxxxxxxxxxxxxxxxxxxx /* unspecified value */  };
      end
    else
      begin
        if (m_stg_0_rv$EN)
	  m_stg_0_rv <= `BSV_ASSIGNMENT_DELAY m_stg_0_rv$D_IN;
	if (m_stg_1_rv$EN)
	  m_stg_1_rv <= `BSV_ASSIGNMENT_DELAY m_stg_1_rv$D_IN;
	if (m_stg_2_rv$EN)
	  m_stg_2_rv <= `BSV_ASSIGNMENT_DELAY m_stg_2_rv$D_IN;
	if (m_stg_3_rv$EN)
	  m_stg_3_rv <= `BSV_ASSIGNMENT_DELAY m_stg_3_rv$D_IN;
	if (m_stg_4_rv$EN)
	  m_stg_4_rv <= `BSV_ASSIGNMENT_DELAY m_stg_4_rv$D_IN;
	if (m_stg_5_rv$EN)
	  m_stg_5_rv <= `BSV_ASSIGNMENT_DELAY m_stg_5_rv$D_IN;
	if (m_stg_6_rv$EN)
	  m_stg_6_rv <= `BSV_ASSIGNMENT_DELAY m_stg_6_rv$D_IN;
	if (m_stg_7_rv$EN)
	  m_stg_7_rv <= `BSV_ASSIGNMENT_DELAY m_stg_7_rv$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    m_stg_0_rv = 21'h0AAAAA;
    m_stg_1_rv = 21'h0AAAAA;
    m_stg_2_rv = 21'h0AAAAA;
    m_stg_3_rv = 21'h0AAAAA;
    m_stg_4_rv = 21'h0AAAAA;
    m_stg_5_rv = 21'h0AAAAA;
    m_stg_6_rv = 21'h0AAAAA;
    m_stg_7_rv = 21'h0AAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkCORDIC_4

