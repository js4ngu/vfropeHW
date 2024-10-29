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

module CompareRecFN(	// @[generators/hardfloat/hardfloat/src/main/scala/CompareRecFN.scala:42:7]
  input  [16:0] io_a,	// @[generators/hardfloat/hardfloat/src/main/scala/CompareRecFN.scala:44:16]
  input  [16:0] io_b,	// @[generators/hardfloat/hardfloat/src/main/scala/CompareRecFN.scala:44:16]
  output        io_lt,	// @[generators/hardfloat/hardfloat/src/main/scala/CompareRecFN.scala:44:16]
  output        io_eq,	// @[generators/hardfloat/hardfloat/src/main/scala/CompareRecFN.scala:44:16]
  output        io_gt,	// @[generators/hardfloat/hardfloat/src/main/scala/CompareRecFN.scala:44:16]
  output [4:0]  io_exceptionFlags	// @[generators/hardfloat/hardfloat/src/main/scala/CompareRecFN.scala:44:16]
);

  wire        rawA_isNaN = (&(io_a[15:14])) & io_a[13];	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :53:{28,53}, :56:{33,41}]
  wire        rawB_isNaN = (&(io_b[15:14])) & io_b[13];	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :53:{28,53}, :56:{33,41}]
  wire        ordered = ~rawA_isNaN & ~rawB_isNaN;	// @[generators/hardfloat/hardfloat/src/main/scala/CompareRecFN.scala:57:{19,32,35}, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:56:33]
  wire        bothInfs = (&(io_a[15:14])) & ~(io_a[13]) & (&(io_b[15:14])) & ~(io_b[13]);	// @[generators/hardfloat/hardfloat/src/main/scala/CompareRecFN.scala:58:33, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :53:{28,53}, :56:41, :57:36]
  wire        bothZeros = ~(|(io_a[15:13])) & ~(|(io_b[15:13]));	// @[generators/hardfloat/hardfloat/src/main/scala/CompareRecFN.scala:59:33, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :52:{28,53}]
  wire        eqExps = io_a[15:10] == io_b[15:10];	// @[generators/hardfloat/hardfloat/src/main/scala/CompareRecFN.scala:60:29, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21]
  wire [10:0] _GEN = {|(io_a[15:13]), io_a[9:0]};	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :52:{28,53}, :61:{44,49}]
  wire [10:0] _GEN_0 = {|(io_b[15:13]), io_b[9:0]};	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :52:{28,53}, :61:{44,49}]
  wire        common_ltMags = $signed({1'h0, io_a[15:10]}) < $signed({1'h0, io_b[15:10]}) | eqExps & _GEN < _GEN_0;	// @[generators/hardfloat/hardfloat/src/main/scala/CompareRecFN.scala:60:29, :62:{20,33,44,57}, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :52:53, :60:27, :61:44]
  wire        common_eqMags = eqExps & _GEN == _GEN_0;	// @[generators/hardfloat/hardfloat/src/main/scala/CompareRecFN.scala:60:29, :63:{32,45}, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:61:44]
  wire        ordered_lt = ~bothZeros & (io_a[16] & ~(io_b[16]) | ~bothInfs & (io_a[16] & ~common_ltMags & ~common_eqMags | ~(io_b[16]) & common_ltMags));	// @[generators/hardfloat/hardfloat/src/main/scala/CompareRecFN.scala:58:33, :59:33, :62:33, :63:32, :66:{9,21}, :67:{25,28,41}, :68:{19,30}, :69:{38,54,57,74}, :70:41, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:59:25]
  wire        ordered_eq = bothZeros | io_a[16] == io_b[16] & (bothInfs | common_eqMags);	// @[generators/hardfloat/hardfloat/src/main/scala/CompareRecFN.scala:58:33, :59:33, :63:32, :72:{19,34,49,62}, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:59:25]
  assign io_lt = ordered & ordered_lt;	// @[generators/hardfloat/hardfloat/src/main/scala/CompareRecFN.scala:42:7, :57:32, :66:21, :78:22]
  assign io_eq = ordered & ordered_eq;	// @[generators/hardfloat/hardfloat/src/main/scala/CompareRecFN.scala:42:7, :57:32, :72:19, :79:22]
  assign io_gt = ordered & ~ordered_lt & ~ordered_eq;	// @[generators/hardfloat/hardfloat/src/main/scala/CompareRecFN.scala:42:7, :57:32, :66:21, :72:19, :80:{25,38,41}]
  assign io_exceptionFlags = {rawA_isNaN & ~(io_a[9]) | rawB_isNaN & ~(io_b[9]) | ~ordered, 4'h0};	// @[generators/hardfloat/hardfloat/src/main/scala/CompareRecFN.scala:42:7, :57:32, :75:58, :76:30, :81:34, generators/hardfloat/hardfloat/src/main/scala/common.scala:82:{46,49,56}, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:56:33]
endmodule

