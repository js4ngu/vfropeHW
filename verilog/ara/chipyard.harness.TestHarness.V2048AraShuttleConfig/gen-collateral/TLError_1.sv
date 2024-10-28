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

module TLError_1(	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9]
  input          clock,	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9]
  input          reset,	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9]
  output         auto_in_a_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_in_a_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]   auto_in_a_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [127:0] auto_in_a_bits_address,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_in_d_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_in_d_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [2:0]   auto_in_d_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [1:0]   auto_in_d_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_in_d_bits_denied,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_in_d_bits_corrupt	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
);

  wire            da_ready;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:94:31]
  wire [2:0]      da_bits_opcode;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:38:21]
  wire [7:0][2:0] _GEN = {3'h4, 3'h4, 3'h2, 3'h1, 3'h1, 3'h1, 3'h0, 3'h0};	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:38:21]
  reg             idle;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:29:23]
  reg             r_counter;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
  wire            nodeIn_a_ready = da_ready & idle;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:29:23, :35:37, generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:94:31]
  wire            winner_1 = auto_in_a_valid & idle;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:29:23, :36:35]
  assign da_bits_opcode = _GEN[auto_in_a_bits_opcode];	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:38:21]
  reg             beatsLeft;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30]
  `ifndef SYNTHESIS	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:34:12]
    always @(posedge clock) begin	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:34:12]
      if (~reset & ~(idle | ~r_counter)) begin	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:29:23, :34:{12,18}, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, :231:25]
        if (`ASSERT_VERBOSE_COND_)	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:34:12]
          $error("Assertion failed\n    at Error.scala:34 assert (idle || da_first) // we only send Grant, never GrantData => simplified flow control below\n");	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:34:12]
        if (`STOP_COND_)	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:34:12]
          $fatal;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:34:12]
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  reg             state_1;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:88:26]
  wire            _nodeIn_d_bits_WIRE_5 = beatsLeft ? state_1 : winner_1;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:36:35, generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30, :88:26, :89:25]
  assign da_ready = auto_in_d_ready & (~beatsLeft | state_1);	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30, :61:28, :88:26, :92:24, :94:31]
  wire            nodeIn_d_valid = (~beatsLeft | state_1) & winner_1;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:36:35, generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30, :88:26, :96:24]
  wire            _nodeIn_d_bits_WIRE_1 = _nodeIn_d_bits_WIRE_5 & da_bits_opcode[0];	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:38:21, generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:89:25, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:106:36, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire [1:0]      _nodeIn_d_bits_WIRE_8 = {_nodeIn_d_bits_WIRE_5, 1'h0};	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9, generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:89:25, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire [2:0]      _nodeIn_d_bits_WIRE_10 = _nodeIn_d_bits_WIRE_5 ? da_bits_opcode : 3'h0;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:38:21, generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:89:25, generators/rocket-chip/src/main/scala/tilelink/Bundles.scala:265:74, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire            r_3 = da_ready & winner_1;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:36:35, generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:94:31, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  always @(posedge clock) begin	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9]
    if (reset) begin	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9]
      idle <= 1'h1;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9, :29:23]
      r_counter <= 1'h0;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
      beatsLeft <= 1'h0;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9, generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30]
      state_1 <= 1'h0;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9, generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:88:26]
    end
    else begin	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9]
      idle <= ~(r_3 & da_bits_opcode == 3'h4) & idle;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:29:23, :38:21, :55:{21,39,50,57}, generators/rocket-chip/src/main/scala/tilelink/Bundles.scala:47:27, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      r_counter <= (~r_3 | r_counter - 1'h1) & r_counter;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, :230:28, :235:17, :236:15, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      beatsLeft <= ~(~beatsLeft & auto_in_d_ready) & beatsLeft - (auto_in_d_ready & nodeIn_d_valid);	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30, :61:28, :62:24, :85:{23,52}, :96:24, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      if (beatsLeft) begin	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30]
      end
      else	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30]
        state_1 <= winner_1;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:36:35, generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:88:26]
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9]
      `FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:0];	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9]
    initial begin	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9]
        `INIT_RANDOM_PROLOG_	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9]
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9]
        idle = _RANDOM[/*Zero width*/ 1'b0][0];	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9, :29:23]
        r_counter = _RANDOM[/*Zero width*/ 1'b0][2];	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9, :29:23, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
        beatsLeft = _RANDOM[/*Zero width*/ 1'b0][5];	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9, :29:23, generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30]
        state_1 = _RANDOM[/*Zero width*/ 1'b0][7];	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9, :29:23, generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:88:26]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9]
      `FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_55 monitor (	// @[generators/rocket-chip/src/main/scala/tilelink/Nodes.scala:27:25]
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (nodeIn_a_ready),	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:35:37]
    .io_in_a_valid        (auto_in_a_valid),
    .io_in_a_bits_opcode  (auto_in_a_bits_opcode),
    .io_in_a_bits_address (auto_in_a_bits_address),
    .io_in_d_ready        (auto_in_d_ready),
    .io_in_d_valid        (nodeIn_d_valid),	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:96:24]
    .io_in_d_bits_opcode  (_nodeIn_d_bits_WIRE_10),	// @[src/main/scala/chisel3/util/Mux.scala:30:73]
    .io_in_d_bits_size    (_nodeIn_d_bits_WIRE_8),	// @[src/main/scala/chisel3/util/Mux.scala:30:73]
    .io_in_d_bits_denied  (_nodeIn_d_bits_WIRE_5),	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:89:25]
    .io_in_d_bits_corrupt (_nodeIn_d_bits_WIRE_1)	// @[src/main/scala/chisel3/util/Mux.scala:30:73]
  );
  assign auto_in_a_ready = nodeIn_a_ready;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9, :35:37]
  assign auto_in_d_valid = nodeIn_d_valid;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9, generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:96:24]
  assign auto_in_d_bits_opcode = _nodeIn_d_bits_WIRE_10;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign auto_in_d_bits_size = _nodeIn_d_bits_WIRE_8;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign auto_in_d_bits_denied = _nodeIn_d_bits_WIRE_5;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9, generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:89:25]
  assign auto_in_d_bits_corrupt = _nodeIn_d_bits_WIRE_1;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/Error.scala:21:9, src/main/scala/chisel3/util/Mux.scala:30:73]
endmodule

