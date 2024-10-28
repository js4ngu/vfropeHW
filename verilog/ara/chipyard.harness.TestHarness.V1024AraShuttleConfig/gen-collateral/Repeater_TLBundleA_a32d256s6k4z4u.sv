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

module Repeater_TLBundleA_a32d256s6k4z4u(	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7]
  input          clock,	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7]
  input          reset,	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7]
  input          io_repeat,	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:13:14]
  output         io_enq_ready,	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:13:14]
  input          io_enq_valid,	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:13:14]
  input  [2:0]   io_enq_bits_opcode,	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:13:14]
  input  [3:0]   io_enq_bits_size,	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:13:14]
  input  [5:0]   io_enq_bits_source,	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:13:14]
  input  [31:0]  io_enq_bits_address,	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:13:14]
  input  [31:0]  io_enq_bits_mask,	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:13:14]
  input  [255:0] io_enq_bits_data,	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:13:14]
  input          io_deq_ready,	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:13:14]
  output         io_deq_valid,	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:13:14]
  output [2:0]   io_deq_bits_opcode,	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:13:14]
  output [3:0]   io_deq_bits_size,	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:13:14]
  output [5:0]   io_deq_bits_source,	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:13:14]
  output [31:0]  io_deq_bits_address,	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:13:14]
  output [31:0]  io_deq_bits_mask,	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:13:14]
  output [255:0] io_deq_bits_data	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:13:14]
);

  reg          full;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:20:21]
  reg  [2:0]   saved_opcode;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:21:18]
  reg  [3:0]   saved_size;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:21:18]
  reg  [5:0]   saved_source;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:21:18]
  reg  [31:0]  saved_address;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:21:18]
  reg  [31:0]  saved_mask;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:21:18]
  reg  [255:0] saved_data;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:21:18]
  wire         _io_deq_valid_output = io_enq_valid | full;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:20:21, :24:32]
  wire         _io_enq_ready_output = io_deq_ready & ~full;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:20:21, :25:{32,35}]
  wire         _GEN = _io_enq_ready_output & io_enq_valid & io_repeat;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:25:32, :29:21]
  always @(posedge clock) begin	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7]
    if (reset)	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7]
      full <= 1'h0;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:13:14, :20:21]
    else	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7]
      full <= ~(io_deq_ready & _io_deq_valid_output & ~io_repeat) & (_GEN | full);	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:20:21, :24:32, :29:{21,36,43}, :30:{21,24,36,43}]
    if (_GEN) begin	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:29:21]
      saved_opcode <= io_enq_bits_opcode;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:21:18]
      saved_size <= io_enq_bits_size;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:21:18]
      saved_source <= io_enq_bits_source;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:21:18]
      saved_address <= io_enq_bits_address;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:21:18]
      saved_mask <= io_enq_bits_mask;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:21:18]
      saved_data <= io_enq_bits_data;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:21:18]
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7]
      `FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:10];	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7]
    initial begin	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7]
        `INIT_RANDOM_PROLOG_	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7]
        for (logic [3:0] i = 4'h0; i < 4'hB; i += 4'h1) begin
          _RANDOM[i] = `RANDOM;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7]
        end	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7]
        full = _RANDOM[4'h0][0];	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7, :20:21]
        saved_opcode = _RANDOM[4'h0][3:1];	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7, :20:21, :21:18]
        saved_size = _RANDOM[4'h0][10:7];	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7, :20:21, :21:18]
        saved_source = _RANDOM[4'h0][16:11];	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7, :20:21, :21:18]
        saved_address = {_RANDOM[4'h0][31:17], _RANDOM[4'h1][16:0]};	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7, :20:21, :21:18]
        saved_mask = {_RANDOM[4'h1][31:17], _RANDOM[4'h2][16:0]};	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7, :21:18]
        saved_data = {_RANDOM[4'h2][31:17], _RANDOM[4'h3], _RANDOM[4'h4], _RANDOM[4'h5], _RANDOM[4'h6], _RANDOM[4'h7], _RANDOM[4'h8], _RANDOM[4'h9], _RANDOM[4'hA][16:0]};	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7, :21:18]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7]
      `FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_enq_ready = _io_enq_ready_output;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7, :25:32]
  assign io_deq_valid = _io_deq_valid_output;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7, :24:32]
  assign io_deq_bits_opcode = full ? saved_opcode : io_enq_bits_opcode;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7, :20:21, :21:18, :26:21]
  assign io_deq_bits_size = full ? saved_size : io_enq_bits_size;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7, :20:21, :21:18, :26:21]
  assign io_deq_bits_source = full ? saved_source : io_enq_bits_source;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7, :20:21, :21:18, :26:21]
  assign io_deq_bits_address = full ? saved_address : io_enq_bits_address;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7, :20:21, :21:18, :26:21]
  assign io_deq_bits_mask = full ? saved_mask : io_enq_bits_mask;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7, :20:21, :21:18, :26:21]
  assign io_deq_bits_data = full ? saved_data : io_enq_bits_data;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:10:7, :20:21, :21:18, :26:21]
endmodule

