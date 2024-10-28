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

module GenericDeserializer_TLBeatw67_f32(	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7]
  input         clock,	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7]
  input         reset,	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7]
  output        io_in_ready,	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:39:14]
  input         io_in_valid,	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:39:14]
  input  [31:0] io_in_bits_flit,	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:39:14]
  input         io_out_ready,	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:39:14]
  output        io_out_valid,	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:39:14]
  output [64:0] io_out_bits_payload,	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:39:14]
  output        io_out_bits_head,	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:39:14]
  output        io_out_bits_tail	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:39:14]
);

  reg  [31:0] data_0;	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:48:17]
  reg  [31:0] data_1;	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:48:17]
  reg  [1:0]  beat;	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:49:21]
  wire        _io_in_ready_output = io_out_ready | beat != 2'h2;	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7, :49:21, :51:{31,39}]
  wire        _beat_T = beat == 2'h2;	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7, :49:21, :52:39]
  wire        _GEN = _io_in_ready_output & io_in_valid;	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:51:31, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  wire        _GEN_0 = beat == 2'h2;	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7, :48:17, :49:21, :51:39, :62:39, :63:47]
  always @(posedge clock) begin	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7]
    if (~_GEN | _GEN_0 | beat[0]) begin	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:48:17, :49:21, :51:39, :59:21, :62:39, :63:{18,47}, src/main/scala/chisel3/util/Decoupled.scala:51:35]
    end
    else	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:48:17, :59:21, :62:39]
      data_0 <= io_in_bits_flit;	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:48:17]
    if (~_GEN | _GEN_0 | ~(beat[0])) begin	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:48:17, :49:21, :51:39, :59:21, :62:39, :63:{18,47}, src/main/scala/chisel3/util/Decoupled.scala:51:35]
    end
    else	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:48:17, :59:21, :62:39]
      data_1 <= io_in_bits_flit;	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:48:17]
    if (reset)	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7]
      beat <= 2'h0;	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7, :49:21]
    else if (_GEN) begin	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
      if (_beat_T)	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:52:39]
        beat <= 2'h0;	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7, :49:21]
      else	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:52:39]
        beat <= beat + 2'h1;	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7, :49:21, :60:53]
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7]
      `FIRRTL_BEFORE_INITIAL	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:2];	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7]
    initial begin	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7]
        `INIT_RANDOM_PROLOG_	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7]
        for (logic [1:0] i = 2'h0; i < 2'h3; i += 2'h1) begin
          _RANDOM[i] = `RANDOM;	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7]
        end	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7]
        data_0 = _RANDOM[2'h0];	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7, :48:17]
        data_1 = _RANDOM[2'h1];	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7, :48:17]
        beat = _RANDOM[2'h2][1:0];	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7, :49:21]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7]
      `FIRRTL_AFTER_INITIAL	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_in_ready = _io_in_ready_output;	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7, :51:31]
  assign io_out_valid = io_in_valid & _beat_T;	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7, :52:{31,39}]
  assign io_out_bits_payload = {io_in_bits_flit[2:0], data_1, data_0[31:2]};	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7, :48:17, :56:47]
  assign io_out_bits_head = data_0[1];	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7, :48:17, :56:47]
  assign io_out_bits_tail = data_0[0];	// @[generators/testchipip/src/main/scala/serdes/Serdes.scala:37:7, :48:17, :56:47]
endmodule

