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

module ReorderBuffer(	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7]
  input        clock,	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7]
  input        reset,	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7]
  input        io_reserve_ready,	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:19:14]
  output       io_reserve_valid,	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:19:14]
  output [3:0] io_reserve_bits,	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:19:14]
  input        io_push_valid,	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:19:14]
  input  [3:0] io_push_bits_tag,	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:19:14]
  input        io_deq_ready,	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:19:14]
  output       io_deq_valid	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:19:14]
);

  reg         valids_0;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23]
  reg         valids_1;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23]
  reg         valids_2;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23]
  reg         valids_3;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23]
  reg         valids_4;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23]
  reg         valids_5;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23]
  reg         valids_6;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23]
  reg         valids_7;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23]
  reg         valids_8;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23]
  reg         valids_9;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23]
  reg         valids_10;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23]
  reg         valids_11;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23]
  reg         valids_12;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23]
  reg         valids_13;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23]
  reg         valids_14;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23]
  reg         valids_15;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23]
  reg  [3:0]  enq_ptr_value;	// @[src/main/scala/chisel3/util/Counter.scala:61:40]
  reg  [3:0]  deq_ptr_value;	// @[src/main/scala/chisel3/util/Counter.scala:61:40]
  reg         maybe_full;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:33:27]
  wire        ptr_match = enq_ptr_value == deq_ptr_value;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:34:33, src/main/scala/chisel3/util/Counter.scala:61:40]
  wire        full = ptr_match & maybe_full;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:33:27, :34:33, :36:24]
  wire [15:0] _GEN = {{valids_15}, {valids_14}, {valids_13}, {valids_12}, {valids_11}, {valids_10}, {valids_9}, {valids_8}, {valids_7}, {valids_6}, {valids_5}, {valids_4}, {valids_3}, {valids_2}, {valids_1}, {valids_0}};	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23, :46:12]
  `ifndef SYNTHESIS	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:46:11]
    always @(posedge clock) begin	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:46:11]
      if (io_push_valid & ~reset & _GEN[io_push_bits_tag]) begin	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:46:{11,12}]
        if (`ASSERT_VERBOSE_COND_)	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:46:11]
          $error("Assertion failed\n    at ReorderBuffer.scala:46 assert(!valids(io.push.bits.tag))\n");	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:46:11]
        if (`STOP_COND_)	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:46:11]
          $fatal;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:46:11]
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire        _io_deq_valid_output = ~(ptr_match & ~maybe_full) & (_GEN[deq_ptr_value] | io_push_valid & io_push_bits_tag == deq_ptr_value);	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:33:27, :34:33, :35:{25,28}, :38:14, :46:12, :51:{26,52,69,89}, src/main/scala/chisel3/util/Counter.scala:61:40]
  wire        _maybe_full_T = io_reserve_ready & ~full;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:36:24, :39:23, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  wire        _valids_T_1 = io_deq_ready & deq_ptr_value == io_push_bits_tag;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:47:{48,65}, src/main/scala/chisel3/util/Counter.scala:61:40]
  wire        _GEN_0 = io_deq_ready & _io_deq_valid_output;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:51:26, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  always @(posedge clock) begin	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7]
    if (reset) begin	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7]
      valids_0 <= 1'h0;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
      valids_1 <= 1'h0;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
      valids_2 <= 1'h0;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
      valids_3 <= 1'h0;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
      valids_4 <= 1'h0;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
      valids_5 <= 1'h0;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
      valids_6 <= 1'h0;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
      valids_7 <= 1'h0;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
      valids_8 <= 1'h0;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
      valids_9 <= 1'h0;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
      valids_10 <= 1'h0;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
      valids_11 <= 1'h0;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
      valids_12 <= 1'h0;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
      valids_13 <= 1'h0;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
      valids_14 <= 1'h0;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
      valids_15 <= 1'h0;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
      enq_ptr_value <= 4'h0;	// @[src/main/scala/chisel3/util/Counter.scala:61:40]
      deq_ptr_value <= 4'h0;	// @[src/main/scala/chisel3/util/Counter.scala:61:40]
      maybe_full <= 1'h0;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :33:27]
    end
    else begin	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7]
      valids_0 <= ~(_GEN_0 & deq_ptr_value == 4'h0) & (io_push_valid & io_push_bits_tag == 4'h0 ? ~_valids_T_1 : valids_0);	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23, :45:23, :47:{30,33,48}, :54:22, :56:27, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      valids_1 <= ~(_GEN_0 & deq_ptr_value == 4'h1) & (io_push_valid & io_push_bits_tag == 4'h1 ? ~_valids_T_1 : valids_1);	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23, :45:23, :47:{30,33,48}, :54:22, :56:27, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      valids_2 <= ~(_GEN_0 & deq_ptr_value == 4'h2) & (io_push_valid & io_push_bits_tag == 4'h2 ? ~_valids_T_1 : valids_2);	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23, :45:23, :47:{30,33,48}, :54:22, :56:27, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      valids_3 <= ~(_GEN_0 & deq_ptr_value == 4'h3) & (io_push_valid & io_push_bits_tag == 4'h3 ? ~_valids_T_1 : valids_3);	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23, :45:23, :47:{30,33,48}, :54:22, :56:27, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      valids_4 <= ~(_GEN_0 & deq_ptr_value == 4'h4) & (io_push_valid & io_push_bits_tag == 4'h4 ? ~_valids_T_1 : valids_4);	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23, :45:23, :47:{30,33,48}, :54:22, :56:27, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      valids_5 <= ~(_GEN_0 & deq_ptr_value == 4'h5) & (io_push_valid & io_push_bits_tag == 4'h5 ? ~_valids_T_1 : valids_5);	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23, :45:23, :47:{30,33,48}, :54:22, :56:27, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      valids_6 <= ~(_GEN_0 & deq_ptr_value == 4'h6) & (io_push_valid & io_push_bits_tag == 4'h6 ? ~_valids_T_1 : valids_6);	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23, :45:23, :47:{30,33,48}, :54:22, :56:27, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      valids_7 <= ~(_GEN_0 & deq_ptr_value == 4'h7) & (io_push_valid & io_push_bits_tag == 4'h7 ? ~_valids_T_1 : valids_7);	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23, :45:23, :47:{30,33,48}, :54:22, :56:27, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      valids_8 <= ~(_GEN_0 & deq_ptr_value == 4'h8) & (io_push_valid & io_push_bits_tag == 4'h8 ? ~_valids_T_1 : valids_8);	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23, :45:23, :47:{30,33,48}, :54:22, :56:27, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      valids_9 <= ~(_GEN_0 & deq_ptr_value == 4'h9) & (io_push_valid & io_push_bits_tag == 4'h9 ? ~_valids_T_1 : valids_9);	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23, :45:23, :47:{30,33,48}, :54:22, :56:27, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      valids_10 <= ~(_GEN_0 & deq_ptr_value == 4'hA) & (io_push_valid & io_push_bits_tag == 4'hA ? ~_valids_T_1 : valids_10);	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23, :45:23, :47:{30,33,48}, :54:22, :56:27, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      valids_11 <= ~(_GEN_0 & deq_ptr_value == 4'hB) & (io_push_valid & io_push_bits_tag == 4'hB ? ~_valids_T_1 : valids_11);	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23, :45:23, :47:{30,33,48}, :54:22, :56:27, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      valids_12 <= ~(_GEN_0 & deq_ptr_value == 4'hC) & (io_push_valid & io_push_bits_tag == 4'hC ? ~_valids_T_1 : valids_12);	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23, :45:23, :47:{30,33,48}, :54:22, :56:27, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      valids_13 <= ~(_GEN_0 & deq_ptr_value == 4'hD) & (io_push_valid & io_push_bits_tag == 4'hD ? ~_valids_T_1 : valids_13);	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23, :45:23, :47:{30,33,48}, :54:22, :56:27, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      valids_14 <= ~(_GEN_0 & deq_ptr_value == 4'hE) & (io_push_valid & io_push_bits_tag == 4'hE ? ~_valids_T_1 : valids_14);	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23, :45:23, :47:{30,33,48}, :54:22, :56:27, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      valids_15 <= ~(_GEN_0 & (&deq_ptr_value)) & (io_push_valid & (&io_push_bits_tag) ? ~_valids_T_1 : valids_15);	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:29:23, :45:23, :47:{30,33,48}, :54:22, :56:27, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      if (_maybe_full_T)	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
        enq_ptr_value <= enq_ptr_value + 4'h1;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:47:30, src/main/scala/chisel3/util/Counter.scala:61:40, :77:24]
      if (_GEN_0)	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
        deq_ptr_value <= deq_ptr_value + 4'h1;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:47:30, src/main/scala/chisel3/util/Counter.scala:61:40, :77:24]
      if (_maybe_full_T != _GEN_0)	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:33:27, :59:{25,42}, :60:16, src/main/scala/chisel3/util/Decoupled.scala:51:35]
        maybe_full <= _maybe_full_T;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:33:27, src/main/scala/chisel3/util/Decoupled.scala:51:35]
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7]
      `FIRRTL_BEFORE_INITIAL	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:1];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7]
    initial begin	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7]
        `INIT_RANDOM_PROLOG_	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7]
        for (logic [1:0] i = 2'h0; i < 2'h2; i += 2'h1) begin
          _RANDOM[i[0]] = `RANDOM;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7]
        end	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7]
        valids_0 = _RANDOM[1'h0][0];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
        valids_1 = _RANDOM[1'h0][1];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
        valids_2 = _RANDOM[1'h0][2];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
        valids_3 = _RANDOM[1'h0][3];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
        valids_4 = _RANDOM[1'h0][4];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
        valids_5 = _RANDOM[1'h0][5];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
        valids_6 = _RANDOM[1'h0][6];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
        valids_7 = _RANDOM[1'h0][7];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
        valids_8 = _RANDOM[1'h0][8];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
        valids_9 = _RANDOM[1'h0][9];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
        valids_10 = _RANDOM[1'h0][10];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
        valids_11 = _RANDOM[1'h0][11];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
        valids_12 = _RANDOM[1'h0][12];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
        valids_13 = _RANDOM[1'h0][13];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
        valids_14 = _RANDOM[1'h0][14];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
        valids_15 = _RANDOM[1'h0][15];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :29:23]
        enq_ptr_value = _RANDOM[1'h1][3:0];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, src/main/scala/chisel3/util/Counter.scala:61:40]
        deq_ptr_value = _RANDOM[1'h1][7:4];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, src/main/scala/chisel3/util/Counter.scala:61:40]
        maybe_full = _RANDOM[1'h1][8];	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :33:27, src/main/scala/chisel3/util/Counter.scala:61:40]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7]
      `FIRRTL_AFTER_INITIAL	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_reserve_valid = ~full;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :36:24, :39:23]
  assign io_reserve_bits = enq_ptr_value;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, src/main/scala/chisel3/util/Counter.scala:61:40]
  assign io_deq_valid = _io_deq_valid_output;	// @[generators/saturn/src/main/scala/common/ReorderBuffer.scala:12:7, :51:26]
endmodule

