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

module OldestRRArbiter_8(	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:10:7]
  input        clock,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:10:7]
  output       io_in_0_ready,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:11:14]
  input        io_in_0_valid,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:11:14]
  input  [5:0] io_in_0_bits_eg,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:11:14]
  input        io_in_0_bits_oldest,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:11:14]
  output       io_in_1_ready,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:11:14]
  input        io_in_1_valid,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:11:14]
  input  [5:0] io_in_1_bits_eg,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:11:14]
  input        io_in_1_bits_oldest,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:11:14]
  output       io_in_2_ready,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:11:14]
  input        io_in_2_valid,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:11:14]
  input  [5:0] io_in_2_bits_eg,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:11:14]
  input        io_in_2_bits_oldest,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:11:14]
  input        io_out_ready,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:11:14]
  output       io_out_valid,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:11:14]
  output [5:0] io_out_bits_eg	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:11:14]
);

  wire       _arb_io_in_0_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:13:19]
  wire       _arb_io_in_1_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:13:19]
  wire       _arb_io_in_2_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:13:19]
  wire       _arb_io_out_valid;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:13:19]
  wire [5:0] _arb_io_out_bits_eg;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:13:19]
  wire       oldest_oh_0 = io_in_0_valid & io_in_0_bits_oldest;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:15:42]
  wire       oldest_oh_1 = io_in_1_valid & io_in_1_bits_oldest;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:15:42]
  wire       oldest_oh_2 = io_in_2_valid & io_in_2_bits_oldest;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:15:42]
  wire       _GEN = oldest_oh_0 | oldest_oh_1 | oldest_oh_2;	// @[generators/rocket-chip/src/main/scala/util/package.scala:81:59, generators/saturn/src/main/scala/backend/RegisterFile.scala:15:42]
  RRArbiter_8 arb (	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:13:19]
    .clock           (clock),
    .io_in_0_ready   (_arb_io_in_0_ready),
    .io_in_0_valid   (io_in_0_valid),
    .io_in_0_bits_eg (io_in_0_bits_eg),
    .io_in_1_ready   (_arb_io_in_1_ready),
    .io_in_1_valid   (io_in_1_valid),
    .io_in_1_bits_eg (io_in_1_bits_eg),
    .io_in_2_ready   (_arb_io_in_2_ready),
    .io_in_2_valid   (io_in_2_valid),
    .io_in_2_bits_eg (io_in_2_bits_eg),
    .io_out_ready    (io_out_ready),
    .io_out_valid    (_arb_io_out_valid),
    .io_out_bits_eg  (_arb_io_out_bits_eg)
  );
  assign io_in_0_ready = _GEN ? oldest_oh_0 & io_out_ready : _arb_io_in_0_ready;	// @[generators/rocket-chip/src/main/scala/util/package.scala:81:59, generators/saturn/src/main/scala/backend/RegisterFile.scala:10:7, :13:19, :14:6, :15:42, :17:24, :22:{22,38}]
  assign io_in_1_ready = _GEN ? oldest_oh_1 & io_out_ready : _arb_io_in_1_ready;	// @[generators/rocket-chip/src/main/scala/util/package.scala:81:59, generators/saturn/src/main/scala/backend/RegisterFile.scala:10:7, :13:19, :14:6, :15:42, :17:24, :22:{22,38}]
  assign io_in_2_ready = _GEN ? oldest_oh_2 & io_out_ready : _arb_io_in_2_ready;	// @[generators/rocket-chip/src/main/scala/util/package.scala:81:59, generators/saturn/src/main/scala/backend/RegisterFile.scala:10:7, :13:19, :14:6, :15:42, :17:24, :22:{22,38}]
  assign io_out_valid = _GEN | _arb_io_out_valid;	// @[generators/rocket-chip/src/main/scala/util/package.scala:81:59, generators/saturn/src/main/scala/backend/RegisterFile.scala:10:7, :13:19, :14:6, :17:24, :19:18]
  assign io_out_bits_eg = _GEN ? (oldest_oh_0 ? io_in_0_bits_eg : 6'h0) | (oldest_oh_1 ? io_in_1_bits_eg : 6'h0) | (oldest_oh_2 ? io_in_2_bits_eg : 6'h0) : _arb_io_out_bits_eg;	// @[generators/rocket-chip/src/main/scala/util/package.scala:81:59, generators/saturn/src/main/scala/backend/RegisterFile.scala:10:7, :13:19, :14:6, :15:42, :17:24, :20:17, src/main/scala/chisel3/util/Mux.scala:30:73]
endmodule
