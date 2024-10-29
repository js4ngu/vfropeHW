// Generated by CIRCT unknown git version
// Standard header to adapt well known macros to our needs.
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_REG_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_REG_INIT
`endif // not def RANDOMIZE
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_MEM_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_MEM_INIT
`endif // not def RANDOMIZE

// RANDOM may be set to an expression that produces a 32-bit random unsigned value.
`ifndef RANDOM
  `define RANDOM $random
`endif // not def RANDOM

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

// Users can define 'ASSERT_VERBOSE_COND' to add an extra gate to assert error printing.
`ifndef ASSERT_VERBOSE_COND_
  `ifdef ASSERT_VERBOSE_COND
    `define ASSERT_VERBOSE_COND_ (`ASSERT_VERBOSE_COND)
  `else  // ASSERT_VERBOSE_COND
    `define ASSERT_VERBOSE_COND_ 1
  `endif // ASSERT_VERBOSE_COND
`endif // not def ASSERT_VERBOSE_COND_

// Users can define 'STOP_COND' to add an extra gate to stop conditions.
`ifndef STOP_COND_
  `ifdef STOP_COND
    `define STOP_COND_ (`STOP_COND)
  `else  // STOP_COND
    `define STOP_COND_ 1
  `endif // STOP_COND
`endif // not def STOP_COND_

// Users can define INIT_RANDOM as general code that gets injected into the
// initializer block for modules with registers.
`ifndef INIT_RANDOM
  `define INIT_RANDOM
`endif // not def INIT_RANDOM

// If using random initialization, you can also define RANDOMIZE_DELAY to
// customize the delay used, otherwise 0.002 is used.
`ifndef RANDOMIZE_DELAY
  `define RANDOMIZE_DELAY 0.002
`endif // not def RANDOMIZE_DELAY

// Define INIT_RANDOM_PROLOG_ for use in our modules below.
`ifndef INIT_RANDOM_PROLOG_
  `ifdef RANDOMIZE
    `ifdef VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM
    `else  // VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM #`RANDOMIZE_DELAY begin end
    `endif // VERILATOR
  `else  // RANDOMIZE
    `define INIT_RANDOM_PROLOG_
  `endif // RANDOMIZE
`endif // not def INIT_RANDOM_PROLOG_

// Include register initializers in init blocks unless synthesis is set
`ifndef SYNTHESIS
  `ifndef ENABLE_INITIAL_REG_
    `define ENABLE_INITIAL_REG_
  `endif // not def ENABLE_INITIAL_REG_
`endif // not def SYNTHESIS

// Include rmemory initializers in init blocks unless synthesis is set
`ifndef SYNTHESIS
  `ifndef ENABLE_INITIAL_MEM_
    `define ENABLE_INITIAL_MEM_
  `endif // not def ENABLE_INITIAL_MEM_
`endif // not def SYNTHESIS

module RecFNToIN_e8_s24_i32(	// @[generators/hardfloat/hardfloat/src/main/scala/RecFNToIN.scala:46:7]
  input  [32:0] io_in,	// @[generators/hardfloat/hardfloat/src/main/scala/RecFNToIN.scala:49:16]
  input  [2:0]  io_roundingMode,	// @[generators/hardfloat/hardfloat/src/main/scala/RecFNToIN.scala:49:16]
  input         io_signedOut,	// @[generators/hardfloat/hardfloat/src/main/scala/RecFNToIN.scala:49:16]
  output [31:0] io_out	// @[generators/hardfloat/hardfloat/src/main/scala/RecFNToIN.scala:49:16]
);

  wire        rawIn_isNaN = (&(io_in[31:30])) & io_in[29];	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :53:{28,53}, :56:{33,41}]
  wire        magJustBelowOne = ~(io_in[31]) & (&(io_in[30:23]));	// @[generators/hardfloat/hardfloat/src/main/scala/RecFNToIN.scala:61:30, :62:28, :63:{27,37,47}]
  wire        roundingMode_odd = io_roundingMode == 3'h6;	// @[generators/hardfloat/hardfloat/src/main/scala/RecFNToIN.scala:72:53]
  wire [54:0] shiftedSig = {31'h0, io_in[31], io_in[22:0]} << (io_in[31] ? io_in[27:23] : 5'h0);	// @[generators/hardfloat/hardfloat/src/main/scala/RecFNToIN.scala:61:30, :83:49, :84:16, :85:27, :143:12, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:61:49]
  wire [1:0]  _roundIncr_near_even_T_6 = {shiftedSig[22], |(shiftedSig[21:0])};	// @[generators/hardfloat/hardfloat/src/main/scala/RecFNToIN.scala:83:49, :89:{51,69}, :92:50]
  wire        common_inexact = io_in[31] ? (|_roundIncr_near_even_T_6) : (|(io_in[31:29]));	// @[generators/hardfloat/hardfloat/src/main/scala/RecFNToIN.scala:61:30, :92:{29,50,57}, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :52:{28,53}]
  wire        roundIncr = io_roundingMode == 3'h0 & (io_in[31] & ((&(shiftedSig[23:22])) | (&_roundIncr_near_even_T_6)) | magJustBelowOne & (|_roundIncr_near_even_T_6)) | io_roundingMode == 3'h4 & (io_in[31] & shiftedSig[22] | magJustBelowOne) | (io_roundingMode == 3'h2 | roundingMode_odd) & io_in[32] & common_inexact | io_roundingMode == 3'h3 & ~(io_in[32]) & common_inexact;	// @[generators/hardfloat/hardfloat/src/main/scala/RecFNToIN.scala:61:30, :63:37, :67:53, :69:53, :70:53, :71:53, :72:53, :83:49, :92:{29,50}, :94:{25,39,46,51,71,78}, :95:{26,46}, :96:{43,56,61}, :98:35, :99:35, :100:{28,49}, :101:46, :102:{27,31}, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:52:53, :59:25]
  wire [31:0] complUnroundedInt = {32{io_in[32]}} ^ shiftedSig[54:23];	// @[generators/hardfloat/hardfloat/src/main/scala/RecFNToIN.scala:83:49, :90:52, :103:32, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:59:25]
  wire [31:0] _roundedInt_T_3 = roundIncr ^ io_in[32] ? complUnroundedInt + 32'h1 : complUnroundedInt;	// @[generators/hardfloat/hardfloat/src/main/scala/RecFNToIN.scala:101:46, :103:32, :105:{12,23}, :106:31, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:59:25]
  wire        magGeOne_atOverflowEdge = io_in[30:23] == 8'h1F;	// @[generators/hardfloat/hardfloat/src/main/scala/RecFNToIN.scala:62:28, :110:43]
  wire        roundCarryBut2 = (&(shiftedSig[52:23])) & roundIncr;	// @[generators/hardfloat/hardfloat/src/main/scala/RecFNToIN.scala:83:49, :90:52, :101:46, :113:{38,56,61}]
  wire        excSign = ~rawIn_isNaN & io_in[32];	// @[generators/hardfloat/hardfloat/src/main/scala/RecFNToIN.scala:137:{19,32}, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:56:33, :59:25]
  assign io_out = rawIn_isNaN | (&(io_in[31:30])) & ~(io_in[29]) | (io_in[31] ? (|(io_in[30:28])) | (io_signedOut ? (io_in[32] ? magGeOne_atOverflowEdge & ((|(shiftedSig[53:23])) | roundIncr) : magGeOne_atOverflowEdge | io_in[30:23] == 8'h1E & roundCarryBut2) : io_in[32] | magGeOne_atOverflowEdge & shiftedSig[53] & roundCarryBut2) : ~io_signedOut & io_in[32] & roundIncr) ? {io_signedOut == excSign, {31{~excSign}}} : {_roundedInt_T_3[31:1], _roundedInt_T_3[0] | roundingMode_odd & common_inexact};	// @[generators/hardfloat/hardfloat/src/main/scala/RecFNToIN.scala:46:7, :61:30, :62:28, :72:53, :83:49, :90:52, :92:29, :101:46, :105:12, :108:{11,31}, :110:43, :113:61, :115:12, :116:{21,36}, :117:20, :118:24, :119:49, :120:{42,60,64}, :121:49, :122:{38,60}, :124:32, :126:{42,57}, :128:{13,41}, :137:32, :139:27, :142:11, :143:{12,13}, :145:{18,30}, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :53:{28,53}, :56:{33,41}, :57:{33,36}, :59:25]
endmodule

