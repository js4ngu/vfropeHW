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

module Queue12_ShuttleDMemResp(	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
  input         clock,	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
  input         reset,	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
  input         io_enq_valid,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  input  [6:0]  io_enq_bits_tag,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  input  [1:0]  io_enq_bits_size,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  input         io_deq_ready,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  output        io_deq_valid,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  output        io_deq_bits_has_data,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  output [6:0]  io_deq_bits_tag,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  output [63:0] io_deq_bits_data,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  output [1:0]  io_deq_bits_size,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  output [3:0]  io_count	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
);

  wire        _io_enq_ready_T;	// @[src/main/scala/chisel3/util/Decoupled.scala:286:19]
  wire [73:0] _ram_ext_R0_data;	// @[src/main/scala/chisel3/util/Decoupled.scala:256:91]
  reg  [3:0]  enq_ptr_value;	// @[src/main/scala/chisel3/util/Counter.scala:61:40]
  reg  [3:0]  deq_ptr_value;	// @[src/main/scala/chisel3/util/Counter.scala:61:40]
  reg         maybe_full;	// @[src/main/scala/chisel3/util/Decoupled.scala:259:27]
  wire        ptr_match = enq_ptr_value == deq_ptr_value;	// @[src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:260:33]
  wire        empty = ptr_match & ~maybe_full;	// @[src/main/scala/chisel3/util/Decoupled.scala:259:27, :260:33, :261:{25,28}]
  wire        do_enq = _io_enq_ready_T & io_enq_valid;	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35, :286:19]
  assign _io_enq_ready_T = ~(ptr_match & maybe_full);	// @[src/main/scala/chisel3/util/Decoupled.scala:259:27, :260:33, :262:24, :286:19]
  wire [3:0]  _ptr_diff_T = enq_ptr_value - deq_ptr_value;	// @[src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:309:32]
  wire        do_deq = io_deq_ready & ~empty;	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35, :261:25, :285:19]
  always @(posedge clock) begin	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
    if (reset) begin	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
      enq_ptr_value <= 4'h0;	// @[src/main/scala/chisel3/util/Counter.scala:61:40]
      deq_ptr_value <= 4'h0;	// @[src/main/scala/chisel3/util/Counter.scala:61:40]
      maybe_full <= 1'h0;	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :259:27]
    end
    else begin	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
      if (do_enq) begin	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
        if (enq_ptr_value == 4'hB)	// @[src/main/scala/chisel3/util/Counter.scala:61:40, :73:24]
          enq_ptr_value <= 4'h0;	// @[src/main/scala/chisel3/util/Counter.scala:61:40]
        else	// @[src/main/scala/chisel3/util/Counter.scala:73:24]
          enq_ptr_value <= enq_ptr_value + 4'h1;	// @[src/main/scala/chisel3/util/Counter.scala:61:40, :77:24]
      end
      if (do_deq) begin	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
        if (deq_ptr_value == 4'hB)	// @[src/main/scala/chisel3/util/Counter.scala:61:40, :73:24]
          deq_ptr_value <= 4'h0;	// @[src/main/scala/chisel3/util/Counter.scala:61:40]
        else	// @[src/main/scala/chisel3/util/Counter.scala:73:24]
          deq_ptr_value <= deq_ptr_value + 4'h1;	// @[src/main/scala/chisel3/util/Counter.scala:61:40, :77:24]
      end
      if (do_enq != do_deq)	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35, :259:27, :276:{15,27}, :277:16]
        maybe_full <= do_enq;	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35, :259:27]
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
      `FIRRTL_BEFORE_INITIAL	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:0];	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
    initial begin	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
        `INIT_RANDOM_PROLOG_	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
        enq_ptr_value = _RANDOM[/*Zero width*/ 1'b0][3:0];	// @[src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:243:7]
        deq_ptr_value = _RANDOM[/*Zero width*/ 1'b0][7:4];	// @[src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:243:7]
        maybe_full = _RANDOM[/*Zero width*/ 1'b0][8];	// @[src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:243:7, :259:27]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
      `FIRRTL_AFTER_INITIAL	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  ram_12x74 ram_ext (	// @[src/main/scala/chisel3/util/Decoupled.scala:256:91]
    .R0_addr (deq_ptr_value),	// @[src/main/scala/chisel3/util/Counter.scala:61:40]
    .R0_en   (1'h1),	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
    .R0_clk  (clock),
    .R0_data (_ram_ext_R0_data),
    .W0_addr (enq_ptr_value),	// @[src/main/scala/chisel3/util/Counter.scala:61:40]
    .W0_en   (do_enq),	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
    .W0_clk  (clock),
    .W0_data ({io_enq_bits_size, 64'h0, io_enq_bits_tag, 1'h0})	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :255:14, :256:91]
  );
  assign io_deq_valid = ~empty;	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :261:25, :285:19]
  assign io_deq_bits_has_data = _ram_ext_R0_data[0];	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :256:91]
  assign io_deq_bits_tag = _ram_ext_R0_data[7:1];	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :256:91]
  assign io_deq_bits_data = _ram_ext_R0_data[71:8];	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :256:91]
  assign io_deq_bits_size = _ram_ext_R0_data[73:72];	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :256:91]
  assign io_count = ptr_match ? (maybe_full ? 4'hC : 4'h0) : deq_ptr_value > enq_ptr_value ? _ptr_diff_T - 4'h4 : _ptr_diff_T;	// @[src/main/scala/chisel3/util/Counter.scala:61:40, src/main/scala/chisel3/util/Decoupled.scala:243:7, :259:27, :260:33, :309:32, :314:20, :316:10, :317:{10,25,57}]
endmodule

