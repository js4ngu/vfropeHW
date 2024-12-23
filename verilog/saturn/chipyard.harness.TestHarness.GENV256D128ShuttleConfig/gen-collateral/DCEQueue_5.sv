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

module DCEQueue_5(	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7]
  input          clock,	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7]
  input          reset,	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7]
  output         io_enq_ready,	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:20:14]
  input          io_enq_valid,	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:20:14]
  input  [127:0] io_enq_bits_rvs2_data,	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:20:14]
  input  [7:0]   io_enq_bits_eidx,	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:20:14]
  input  [1:0]   io_enq_bits_rvs2_eew,	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:20:14]
  input  [8:0]   io_enq_bits_vl,	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:20:14]
  input          io_enq_bits_tail,	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:20:14]
  input          io_deq_ready,	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:20:14]
  output         io_deq_valid,	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:20:14]
  output [127:0] io_deq_bits_rvs2_data,	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:20:14]
  output [7:0]   io_deq_bits_eidx,	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:20:14]
  output [1:0]   io_deq_bits_rvs2_eew,	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:20:14]
  output [8:0]   io_deq_bits_vl,	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:20:14]
  output         io_deq_bits_tail	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:20:14]
);

  reg  [127:0] ram_0_rvs2_data;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
  reg  [7:0]   ram_0_eidx;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
  reg  [1:0]   ram_0_rvs2_eew;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
  reg  [8:0]   ram_0_vl;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
  reg          ram_0_tail;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
  reg  [127:0] ram_1_rvs2_data;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
  reg  [7:0]   ram_1_eidx;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
  reg  [1:0]   ram_1_rvs2_eew;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
  reg  [8:0]   ram_1_vl;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
  reg          ram_1_tail;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
  reg          wrap_1;	// @[src/main/scala/chisel3/util/Counter.scala:61:40]
  reg          wrap;	// @[src/main/scala/chisel3/util/Counter.scala:61:40]
  reg          maybe_full;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:27:27]
  wire         ptr_match = wrap_1 == wrap;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:28:33, src/main/scala/chisel3/util/Counter.scala:61:40]
  wire         empty = ptr_match & ~maybe_full;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:27:27, :28:33, :29:{25,28}]
  wire         full = ptr_match & maybe_full;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:27:27, :28:33, :30:24]
  wire         do_deq = io_deq_ready & ~empty;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:29:25, :54:19, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  wire         do_enq = ~full & io_enq_valid;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:30:24, :55:19, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  always @(posedge clock) begin	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7]
    if (do_enq & ~wrap_1) begin	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16, :44:16, :45:24, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      ram_0_rvs2_data <= io_enq_bits_rvs2_data;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
      ram_0_eidx <= io_enq_bits_eidx;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
      ram_0_rvs2_eew <= io_enq_bits_rvs2_eew;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
      ram_0_vl <= io_enq_bits_vl;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
      ram_0_tail <= io_enq_bits_tail;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
    end
    if (do_enq & wrap_1) begin	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16, :44:16, :45:24, src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      ram_1_rvs2_data <= io_enq_bits_rvs2_data;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
      ram_1_eidx <= io_enq_bits_eidx;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
      ram_1_rvs2_eew <= io_enq_bits_rvs2_eew;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
      ram_1_vl <= io_enq_bits_vl;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
      ram_1_tail <= io_enq_bits_tail;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:24:16]
    end
    if (reset) begin	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7]
      wrap_1 <= 1'h0;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:23:45, src/main/scala/chisel3/util/Counter.scala:61:40]
      wrap <= 1'h0;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:23:45, src/main/scala/chisel3/util/Counter.scala:61:40]
      maybe_full <= 1'h0;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:23:45, :27:27]
    end
    else begin	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7]
      if (do_enq)	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
        wrap_1 <= wrap_1 - 1'h1;	// @[src/main/scala/chisel3/util/Counter.scala:61:40, :77:24]
      if (do_deq)	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
        wrap <= wrap - 1'h1;	// @[src/main/scala/chisel3/util/Counter.scala:61:40, :77:24]
      if (do_enq != do_deq)	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:27:27, :50:{15,27}, :51:16, src/main/scala/chisel3/util/Decoupled.scala:51:35]
        maybe_full <= do_enq;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:27:27, src/main/scala/chisel3/util/Decoupled.scala:51:35]
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7]
      `FIRRTL_BEFORE_INITIAL	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:17];	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7]
    initial begin	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7]
        `INIT_RANDOM_PROLOG_	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7]
        for (logic [4:0] i = 5'h0; i < 5'h12; i += 5'h1) begin
          _RANDOM[i] = `RANDOM;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7]
        end	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7]
        ram_0_rvs2_data = {_RANDOM[5'h0][31:4], _RANDOM[5'h1], _RANDOM[5'h2], _RANDOM[5'h3], _RANDOM[5'h4][3:0]};	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :24:16]
        ram_0_eidx = _RANDOM[5'h4][11:4];	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :24:16]
        ram_0_rvs2_eew = _RANDOM[5'h4][13:12];	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :24:16]
        ram_0_vl = _RANDOM[5'h8][23:15];	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :24:16]
        ram_0_tail = _RANDOM[5'h8][24];	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :24:16]
        ram_1_rvs2_data = {_RANDOM[5'h8][31:27], _RANDOM[5'h9], _RANDOM[5'hA], _RANDOM[5'hB], _RANDOM[5'hC][26:0]};	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :24:16]
        ram_1_eidx = {_RANDOM[5'hC][31:27], _RANDOM[5'hD][2:0]};	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :24:16]
        ram_1_rvs2_eew = _RANDOM[5'hD][4:3];	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :24:16]
        ram_1_vl = _RANDOM[5'h11][14:6];	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :24:16]
        ram_1_tail = _RANDOM[5'h11][15];	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :24:16]
        wrap_1 = _RANDOM[5'h11][16];	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :24:16, src/main/scala/chisel3/util/Counter.scala:61:40]
        wrap = _RANDOM[5'h11][17];	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :24:16, src/main/scala/chisel3/util/Counter.scala:61:40]
        maybe_full = _RANDOM[5'h11][18];	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :24:16, :27:27]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7]
      `FIRRTL_AFTER_INITIAL	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_enq_ready = ~full;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :30:24, :55:19]
  assign io_deq_valid = ~empty;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :29:25, :54:19]
  assign io_deq_bits_rvs2_data = wrap ? ram_1_rvs2_data : ram_0_rvs2_data;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :24:16, :57:15, src/main/scala/chisel3/util/Counter.scala:61:40]
  assign io_deq_bits_eidx = wrap ? ram_1_eidx : ram_0_eidx;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :24:16, :57:15, src/main/scala/chisel3/util/Counter.scala:61:40]
  assign io_deq_bits_rvs2_eew = wrap ? ram_1_rvs2_eew : ram_0_rvs2_eew;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :24:16, :57:15, src/main/scala/chisel3/util/Counter.scala:61:40]
  assign io_deq_bits_vl = wrap ? ram_1_vl : ram_0_vl;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :24:16, :57:15, src/main/scala/chisel3/util/Counter.scala:61:40]
  assign io_deq_bits_tail = wrap ? ram_1_tail : ram_0_tail;	// @[generators/saturn/src/main/scala/common/DCEQueue.scala:12:7, :24:16, :57:15, src/main/scala/chisel3/util/Counter.scala:61:40]
endmodule

