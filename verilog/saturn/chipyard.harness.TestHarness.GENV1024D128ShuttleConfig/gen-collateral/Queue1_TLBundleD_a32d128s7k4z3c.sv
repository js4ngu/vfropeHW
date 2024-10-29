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

module Queue1_TLBundleD_a32d128s7k4z3c(	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
  input          clock,	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
  input          reset,	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
  output         io_enq_ready,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  input          io_enq_valid,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  input  [2:0]   io_enq_bits_opcode,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  input  [1:0]   io_enq_bits_param,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  input  [2:0]   io_enq_bits_size,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  input  [6:0]   io_enq_bits_source,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  input  [3:0]   io_enq_bits_sink,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  input          io_enq_bits_denied,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  input  [127:0] io_enq_bits_data,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  input          io_enq_bits_corrupt,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  input          io_deq_ready,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  output         io_deq_valid,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  output [2:0]   io_deq_bits_opcode,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  output [1:0]   io_deq_bits_param,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  output [2:0]   io_deq_bits_size,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  output [6:0]   io_deq_bits_source,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  output [3:0]   io_deq_bits_sink,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  output         io_deq_bits_denied,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  output [127:0] io_deq_bits_data,	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
  output         io_deq_bits_corrupt	// @[src/main/scala/chisel3/util/Decoupled.scala:255:14]
);

  reg  [148:0] ram;	// @[src/main/scala/chisel3/util/Decoupled.scala:256:91]
  reg          full;	// @[src/main/scala/chisel3/util/Decoupled.scala:259:27]
  wire         _io_deq_valid_output = io_enq_valid | full;	// @[src/main/scala/chisel3/util/Decoupled.scala:259:27, :285:16, :297:{24,39}]
  wire         do_enq = ~(~full & io_deq_ready) & ~full & io_enq_valid;	// @[src/main/scala/chisel3/util/Decoupled.scala:259:27, :261:28, :263:27, :286:19, :298:17, :301:{26,35}]
  always @(posedge clock) begin	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
    if (do_enq)	// @[src/main/scala/chisel3/util/Decoupled.scala:263:27, :298:17, :301:{26,35}]
      ram <= {io_enq_bits_corrupt, io_enq_bits_data, io_enq_bits_denied, io_enq_bits_sink, io_enq_bits_source, io_enq_bits_size, io_enq_bits_param, io_enq_bits_opcode};	// @[src/main/scala/chisel3/util/Decoupled.scala:256:91]
    if (reset)	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
      full <= 1'h0;	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :259:27]
    else if (do_enq != (full & io_deq_ready & _io_deq_valid_output))	// @[src/main/scala/chisel3/util/Decoupled.scala:259:27, :263:27, :264:27, :276:{15,27}, :277:16, :285:16, :297:{24,39}, :298:17, :300:14, :301:{26,35}]
      full <= do_enq;	// @[src/main/scala/chisel3/util/Decoupled.scala:259:27, :263:27, :298:17, :301:{26,35}]
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
      `FIRRTL_BEFORE_INITIAL	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:4];	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
    initial begin	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
        `INIT_RANDOM_PROLOG_	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
        for (logic [2:0] i = 3'h0; i < 3'h5; i += 3'h1) begin
          _RANDOM[i] = `RANDOM;	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
        end	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
        ram = {_RANDOM[3'h0][31:1], _RANDOM[3'h1], _RANDOM[3'h2], _RANDOM[3'h3], _RANDOM[3'h4][21:0]};	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :256:91]
        full = _RANDOM[3'h0][0];	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :256:91, :259:27]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
      `FIRRTL_AFTER_INITIAL	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_enq_ready = ~full;	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :259:27, :286:19]
  assign io_deq_valid = _io_deq_valid_output;	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :285:16, :297:{24,39}]
  assign io_deq_bits_opcode = full ? ram[2:0] : io_enq_bits_opcode;	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :256:91, :259:27, :293:17, :298:17, :299:19]
  assign io_deq_bits_param = full ? ram[4:3] : io_enq_bits_param;	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :256:91, :259:27, :293:17, :298:17, :299:19]
  assign io_deq_bits_size = full ? ram[7:5] : io_enq_bits_size;	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :256:91, :259:27, :293:17, :298:17, :299:19]
  assign io_deq_bits_source = full ? ram[14:8] : io_enq_bits_source;	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :256:91, :259:27, :293:17, :298:17, :299:19]
  assign io_deq_bits_sink = full ? ram[18:15] : io_enq_bits_sink;	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :256:91, :259:27, :293:17, :298:17, :299:19]
  assign io_deq_bits_denied = full ? ram[19] : io_enq_bits_denied;	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :256:91, :259:27, :293:17, :298:17, :299:19]
  assign io_deq_bits_data = full ? ram[147:20] : io_enq_bits_data;	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :256:91, :259:27, :293:17, :298:17, :299:19]
  assign io_deq_bits_corrupt = full ? ram[148] : io_enq_bits_corrupt;	// @[src/main/scala/chisel3/util/Decoupled.scala:243:7, :256:91, :259:27, :293:17, :298:17, :299:19]
endmodule

