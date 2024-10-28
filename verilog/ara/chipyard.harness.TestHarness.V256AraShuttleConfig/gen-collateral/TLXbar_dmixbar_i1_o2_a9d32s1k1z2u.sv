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

module TLXbar_dmixbar_i1_o2_a9d32s1k1z2u(	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
  input         clock,	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
  input         reset,	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
  output        auto_anon_in_a_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_anon_in_a_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]  auto_anon_in_a_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [8:0]  auto_anon_in_a_bits_address,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [31:0] auto_anon_in_a_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_anon_in_d_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output        auto_anon_in_d_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output        auto_anon_in_d_bits_denied,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [31:0] auto_anon_in_d_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output        auto_anon_in_d_bits_corrupt,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_anon_out_1_a_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output        auto_anon_out_1_a_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [2:0]  auto_anon_out_1_a_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [6:0]  auto_anon_out_1_a_bits_address,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [31:0] auto_anon_out_1_a_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output        auto_anon_out_1_d_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_anon_out_1_d_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]  auto_anon_out_1_d_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [31:0] auto_anon_out_1_d_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_anon_out_0_a_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output        auto_anon_out_0_a_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [2:0]  auto_anon_out_0_a_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [8:0]  auto_anon_out_0_a_bits_address,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [31:0] auto_anon_out_0_a_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output        auto_anon_out_0_d_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_anon_out_0_d_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]  auto_anon_out_0_d_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [1:0]  auto_anon_out_0_d_bits_param,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [1:0]  auto_anon_out_0_d_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_anon_out_0_d_bits_sink,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_anon_out_0_d_bits_denied,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [31:0] auto_anon_out_0_d_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_anon_out_0_d_bits_corrupt	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
);

  wire [4:0] _GEN = auto_anon_in_a_bits_address[6:2] ^ 5'h11;	// @[generators/rocket-chip/src/main/scala/diplomacy/Parameters.scala:137:31, generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:222:41]
  wire       requestAIO_0_0 = auto_anon_in_a_bits_address[8:6] == 3'h0 | {auto_anon_in_a_bits_address[8:7], _GEN[4:2], _GEN[0]} == 6'h0 | {auto_anon_in_a_bits_address[8:7], auto_anon_in_a_bits_address[6:3] ^ 4'hB} == 6'h0 | {auto_anon_in_a_bits_address[8:7], ~(auto_anon_in_a_bits_address[6:5])} == 4'h0 | {auto_anon_in_a_bits_address[8], ~(auto_anon_in_a_bits_address[7])} == 2'h0 | auto_anon_in_a_bits_address[8];	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25, generators/rocket-chip/src/main/scala/diplomacy/Parameters.scala:137:{31,41,46,59}, generators/rocket-chip/src/main/scala/tilelink/Bundles.scala:264:74, generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:222:41, :291:92, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire       requestAIO_0_1 = {auto_anon_in_a_bits_address[8:7], auto_anon_in_a_bits_address[6:4] ^ 3'h4, auto_anon_in_a_bits_address[2]} == 6'h0 | {auto_anon_in_a_bits_address[8:7], auto_anon_in_a_bits_address[6:3] ^ 4'hA} == 6'h0;	// @[generators/rocket-chip/src/main/scala/diplomacy/Parameters.scala:137:{31,41,46,59}, generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:222:41, :291:92]
  wire       _portsAOI_in_0_a_ready_WIRE = requestAIO_0_0 & auto_anon_out_0_a_ready | requestAIO_0_1 & auto_anon_out_1_a_ready;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:291:92, src/main/scala/chisel3/util/Mux.scala:30:73]
  reg        beatsLeft;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30]
  wire [1:0] readys_valid = {auto_anon_out_1_d_valid, auto_anon_out_0_d_valid};	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:68:51]
  reg  [1:0] readys_mask;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:23:23]
  wire [1:0] _readys_filter_T_1 = readys_valid & ~readys_mask;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:23:23, :24:{28,30}, :68:51]
  wire [1:0] readys_readys = ~({readys_mask[1], _readys_filter_T_1[1] | readys_mask[0]} & ({_readys_filter_T_1[0], auto_anon_out_1_d_valid} | _readys_filter_T_1));	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:23:23, :24:28, :25:58, :26:{18,29,39}, generators/rocket-chip/src/main/scala/util/package.scala:262:43]
  wire       winner_0 = readys_readys[0] & auto_anon_out_0_d_valid;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:26:18, :68:76, :71:69]
  wire       winner_1 = readys_readys[1] & auto_anon_out_1_d_valid;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:26:18, :68:76, :71:69]
  wire       _in_0_d_valid_T = auto_anon_out_0_d_valid | auto_anon_out_1_d_valid;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:79:31]
  `ifndef SYNTHESIS	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:77:13]
    always @(posedge clock) begin	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:77:13]
      if (~reset & ~(~winner_0 | ~winner_1)) begin	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:71:69, :77:{13,56,59,62}]
        if (`ASSERT_VERBOSE_COND_)	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:77:13]
          $error("Assertion failed\n    at Arbiter.scala:77 assert((prefixOR zip winner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:77:13]
        if (`STOP_COND_)	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:77:13]
          $fatal;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:77:13]
      end
      if (~reset & ~(~_in_0_d_valid_T | winner_0 | winner_1)) begin	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:71:69, :77:13, :79:{14,15,31,36}]
        if (`ASSERT_VERBOSE_COND_)	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:79:14]
          $error("Assertion failed\n    at Arbiter.scala:79 assert (!valids.reduce(_||_) || winner.reduce(_||_))\n");	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:79:14]
        if (`STOP_COND_)	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:79:14]
          $fatal;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:79:14]
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  reg        state_0;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:88:26]
  reg        state_1;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:88:26]
  wire       muxState_0 = beatsLeft ? state_0 : winner_0;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30, :71:69, :88:26, :89:25]
  wire       muxState_1 = beatsLeft ? state_1 : winner_1;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30, :71:69, :88:26, :89:25]
  wire       in_0_d_valid = beatsLeft ? state_0 & auto_anon_out_0_d_valid | state_1 & auto_anon_out_1_d_valid : _in_0_d_valid_T;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30, :79:31, :88:26, :96:24, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire       _in_0_d_bits_WIRE_1 = muxState_0 & auto_anon_out_0_d_bits_corrupt;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:89:25, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire       _in_0_d_bits_WIRE_5 = muxState_0 & auto_anon_out_0_d_bits_denied;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:89:25, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire [1:0] _readys_mask_T = readys_readys & readys_valid;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:26:18, :28:29, :68:51]
  wire       latch = ~beatsLeft & auto_anon_in_d_ready;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30, :61:28, :62:24]
  always @(posedge clock) begin	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
    if (reset) begin	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
      beatsLeft <= 1'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30, generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
      readys_mask <= 2'h3;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:23:23, generators/rocket-chip/src/main/scala/util/package.scala:243:71]
      state_0 <= 1'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:88:26, generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
      state_1 <= 1'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:88:26, generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
    end
    else begin	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
      beatsLeft <= ~latch & beatsLeft - (auto_anon_in_d_ready & in_0_d_valid);	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30, :62:24, :85:{23,52}, :96:24, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      if (latch & (|readys_valid))	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:27:{18,27}, :62:24, :68:51]
        readys_mask <= _readys_mask_T | {_readys_mask_T[0], 1'h0};	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:23:23, :28:29, generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9, generators/rocket-chip/src/main/scala/util/package.scala:253:{43,53}]
      if (beatsLeft) begin	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30]
      end
      else begin	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30]
        state_0 <= winner_0;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:71:69, :88:26]
        state_1 <= winner_1;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:71:69, :88:26]
      end
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
      `FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:0];	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
    initial begin	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
        `INIT_RANDOM_PROLOG_	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
        beatsLeft = _RANDOM[/*Zero width*/ 1'b0][0];	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30, generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
        readys_mask = _RANDOM[/*Zero width*/ 1'b0][2:1];	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:23:23, :60:30, generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
        state_0 = _RANDOM[/*Zero width*/ 1'b0][3];	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30, :88:26, generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
        state_1 = _RANDOM[/*Zero width*/ 1'b0][4];	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:60:30, :88:26, generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
      `FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_52 monitor (	// @[generators/rocket-chip/src/main/scala/tilelink/Nodes.scala:27:25]
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (_portsAOI_in_0_a_ready_WIRE),	// @[src/main/scala/chisel3/util/Mux.scala:30:73]
    .io_in_a_valid        (auto_anon_in_a_valid),
    .io_in_a_bits_opcode  (auto_anon_in_a_bits_opcode),
    .io_in_a_bits_address (auto_anon_in_a_bits_address),
    .io_in_d_ready        (auto_anon_in_d_ready),
    .io_in_d_valid        (in_0_d_valid),	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:96:24]
    .io_in_d_bits_opcode  ((muxState_0 ? auto_anon_out_0_d_bits_opcode : 3'h0) | (muxState_1 ? auto_anon_out_1_d_bits_opcode : 3'h0)),	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:89:25, generators/rocket-chip/src/main/scala/tilelink/Bundles.scala:264:74, src/main/scala/chisel3/util/Mux.scala:30:73]
    .io_in_d_bits_param   (muxState_0 ? auto_anon_out_0_d_bits_param : 2'h0),	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25, generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:89:25, src/main/scala/chisel3/util/Mux.scala:30:73]
    .io_in_d_bits_size    ((muxState_0 ? auto_anon_out_0_d_bits_size : 2'h0) | {muxState_1, 1'h0}),	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25, generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:89:25, generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9, src/main/scala/chisel3/util/Mux.scala:30:73]
    .io_in_d_bits_sink    (muxState_0 & auto_anon_out_0_d_bits_sink),	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:89:25, src/main/scala/chisel3/util/Mux.scala:30:73]
    .io_in_d_bits_denied  (_in_0_d_bits_WIRE_5),	// @[src/main/scala/chisel3/util/Mux.scala:30:73]
    .io_in_d_bits_corrupt (_in_0_d_bits_WIRE_1)	// @[src/main/scala/chisel3/util/Mux.scala:30:73]
  );
  assign auto_anon_in_a_ready = _portsAOI_in_0_a_ready_WIRE;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign auto_anon_in_d_valid = in_0_d_valid;	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:96:24, generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
  assign auto_anon_in_d_bits_denied = _in_0_d_bits_WIRE_5;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign auto_anon_in_d_bits_data = (muxState_0 ? auto_anon_out_0_d_bits_data : 32'h0) | (muxState_1 ? auto_anon_out_1_d_bits_data : 32'h0);	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:89:25, generators/rocket-chip/src/main/scala/tilelink/Bundles.scala:264:74, generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign auto_anon_in_d_bits_corrupt = _in_0_d_bits_WIRE_1;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign auto_anon_out_1_a_valid = auto_anon_in_a_valid & requestAIO_0_1;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9, :291:92, :355:40]
  assign auto_anon_out_1_a_bits_opcode = auto_anon_in_a_bits_opcode;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
  assign auto_anon_out_1_a_bits_address = auto_anon_in_a_bits_address[6:0];	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9, :222:41]
  assign auto_anon_out_1_a_bits_data = auto_anon_in_a_bits_data;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
  assign auto_anon_out_1_d_ready = auto_anon_in_d_ready & (beatsLeft ? state_1 : readys_readys[1]);	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:26:18, :60:30, :68:76, :88:26, :92:24, :94:31, generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
  assign auto_anon_out_0_a_valid = auto_anon_in_a_valid & requestAIO_0_0;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9, :291:92, :355:40]
  assign auto_anon_out_0_a_bits_opcode = auto_anon_in_a_bits_opcode;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
  assign auto_anon_out_0_a_bits_address = auto_anon_in_a_bits_address;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
  assign auto_anon_out_0_a_bits_data = auto_anon_in_a_bits_data;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
  assign auto_anon_out_0_d_ready = auto_anon_in_d_ready & (beatsLeft ? state_0 : readys_readys[0]);	// @[generators/rocket-chip/src/main/scala/tilelink/Arbiter.scala:26:18, :60:30, :68:76, :88:26, :92:24, :94:31, generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:74:9]
endmodule

