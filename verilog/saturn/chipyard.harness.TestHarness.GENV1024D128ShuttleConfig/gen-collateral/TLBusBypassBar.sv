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

module TLBusBypassBar(	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
  input          clock,	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
  input          reset,	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
  output         auto_in_a_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_in_a_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]   auto_in_a_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [8:0]   auto_in_a_bits_address,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [31:0]  auto_in_a_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_in_d_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_in_d_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [2:0]   auto_in_d_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [1:0]   auto_in_d_bits_param,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [1:0]   auto_in_d_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_in_d_bits_sink,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_in_d_bits_denied,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [31:0]  auto_in_d_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_in_d_bits_corrupt,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_out_1_a_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_out_1_a_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [2:0]   auto_out_1_a_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [8:0]   auto_out_1_a_bits_address,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [31:0]  auto_out_1_a_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_out_1_d_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_out_1_d_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]   auto_out_1_d_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [1:0]   auto_out_1_d_bits_param,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [1:0]   auto_out_1_d_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_out_1_d_bits_source,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_out_1_d_bits_sink,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_out_1_d_bits_denied,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [31:0]  auto_out_1_d_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_out_1_d_bits_corrupt,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_out_0_a_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_out_0_a_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [2:0]   auto_out_0_a_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [127:0] auto_out_0_a_bits_address,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_out_0_d_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_out_0_d_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]   auto_out_0_d_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [1:0]   auto_out_0_d_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_out_0_d_bits_denied,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_out_0_d_bits_corrupt,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          io_bypass	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:67:16]
);

  reg        in_reset;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:79:27]
  reg        bypass_reg;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:80:25]
  wire       bypass = in_reset ? io_bypass : bypass_reg;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:79:27, :80:25, :81:21]
  reg  [1:0] flight;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:295:25]
  reg        r_counter;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
  reg        r_counter_3;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
  reg        stall_counter;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
  wire       stall = bypass != io_bypass & ~stall_counter;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:81:21, :86:{25,40}, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, :231:25]
  wire       nodeIn_a_ready = ~stall & (bypass ? auto_out_0_a_ready : auto_out_1_a_ready);	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:81:21, :86:40, :88:21, :90:{28,34}]
  wire       nodeIn_d_valid = bypass ? auto_out_0_d_valid : auto_out_1_d_valid;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:81:21, :96:24]
  wire [2:0] nodeIn_d_bits_opcode = bypass ? auto_out_0_d_bits_opcode : auto_out_1_d_bits_opcode;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:81:21, :98:21]
  wire [1:0] nodeIn_d_bits_param = bypass ? 2'h0 : auto_out_1_d_bits_param;	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25, generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:81:21, :98:21]
  wire [1:0] nodeIn_d_bits_size = bypass ? auto_out_0_d_bits_size : auto_out_1_d_bits_size;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:81:21, :98:21]
  wire       nodeIn_d_bits_sink = ~bypass & auto_out_1_d_bits_sink;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:81:21, :98:21]
  wire       nodeIn_d_bits_denied = bypass ? auto_out_0_d_bits_denied : auto_out_1_d_bits_denied;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:81:21, :98:21]
  wire       nodeIn_d_bits_corrupt = bypass ? auto_out_0_d_bits_corrupt : auto_out_1_d_bits_corrupt;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:81:21, :98:21]
  wire       r_3 = nodeIn_a_ready & auto_in_a_valid;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:90:28, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  wire       d_dec = auto_in_d_ready & nodeIn_d_valid;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:96:24, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  wire [1:0] _next_flight_T_10 = flight + {1'h0, d_dec & ~r_counter_3 & nodeIn_d_bits_opcode[2] & ~(nodeIn_d_bits_opcode[1])} + {1'h0, r_3 & ~r_counter} - {1'h0, d_dec};	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :98:21, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:71:{36,43,52}, :229:27, :231:25, :295:25, :310:26, :313:37, :324:{30,40,46}, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  always @(posedge clock) begin	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
    if (reset) begin	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
      in_reset <= 1'h1;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :79:27]
      flight <= 2'h0;	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:295:25]
      r_counter <= 1'h0;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
      r_counter_3 <= 1'h0;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
      stall_counter <= 1'h0;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
    end
    else begin	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
      in_reset <= 1'h0;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :79:27]
      flight <= _next_flight_T_10;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:295:25, :324:46]
      r_counter <= (~r_3 | r_counter - 1'h1) & r_counter;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, :230:28, :235:17, :236:15, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      r_counter_3 <= (~d_dec | r_counter_3 - 1'h1) & r_counter_3;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, :230:28, :235:17, :236:15, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      stall_counter <= (~r_3 | stall_counter - 1'h1) & stall_counter;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, :230:28, :235:17, :236:15, src/main/scala/chisel3/util/Decoupled.scala:51:35]
    end
    if (in_reset | _next_flight_T_10 == 2'h0)	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25, generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:79:27, :85:{20,36}, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:324:46]
      bypass_reg <= io_bypass;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:80:25]
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
      `FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:0];	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
    initial begin	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
        `INIT_RANDOM_PROLOG_	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
        in_reset = _RANDOM[/*Zero width*/ 1'b0][0];	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :79:27]
        bypass_reg = _RANDOM[/*Zero width*/ 1'b0][1];	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :79:27, :80:25]
        flight = _RANDOM[/*Zero width*/ 1'b0][3:2];	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :79:27, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:295:25]
        r_counter = _RANDOM[/*Zero width*/ 1'b0][4];	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :79:27, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
        r_counter_3 = _RANDOM[/*Zero width*/ 1'b0][7];	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :79:27, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
        stall_counter = _RANDOM[/*Zero width*/ 1'b0][9];	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :79:27, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
      `FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_56 monitor (	// @[generators/rocket-chip/src/main/scala/tilelink/Nodes.scala:27:25]
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (nodeIn_a_ready),	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:90:28]
    .io_in_a_valid        (auto_in_a_valid),
    .io_in_a_bits_opcode  (auto_in_a_bits_opcode),
    .io_in_a_bits_address (auto_in_a_bits_address),
    .io_in_d_ready        (auto_in_d_ready),
    .io_in_d_valid        (nodeIn_d_valid),	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:96:24]
    .io_in_d_bits_opcode  (nodeIn_d_bits_opcode),	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:98:21]
    .io_in_d_bits_param   (nodeIn_d_bits_param),	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:98:21]
    .io_in_d_bits_size    (nodeIn_d_bits_size),	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:98:21]
    .io_in_d_bits_source  (~bypass & auto_out_1_d_bits_source),	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:81:21, :98:21]
    .io_in_d_bits_sink    (nodeIn_d_bits_sink),	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:98:21]
    .io_in_d_bits_denied  (nodeIn_d_bits_denied),	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:98:21]
    .io_in_d_bits_corrupt (nodeIn_d_bits_corrupt)	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:98:21]
  );
  assign auto_in_a_ready = nodeIn_a_ready;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :90:28]
  assign auto_in_d_valid = nodeIn_d_valid;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :96:24]
  assign auto_in_d_bits_opcode = nodeIn_d_bits_opcode;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :98:21]
  assign auto_in_d_bits_param = nodeIn_d_bits_param;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :98:21]
  assign auto_in_d_bits_size = nodeIn_d_bits_size;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :98:21]
  assign auto_in_d_bits_sink = nodeIn_d_bits_sink;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :98:21]
  assign auto_in_d_bits_denied = nodeIn_d_bits_denied;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :98:21]
  assign auto_in_d_bits_data = bypass ? 32'h0 : auto_out_1_d_bits_data;	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25, generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :81:21, :98:21]
  assign auto_in_d_bits_corrupt = nodeIn_d_bits_corrupt;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :98:21]
  assign auto_out_1_a_valid = ~stall & auto_in_a_valid & ~bypass;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :81:21, :86:40, :88:21, :89:{42,45}]
  assign auto_out_1_a_bits_opcode = auto_in_a_bits_opcode;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
  assign auto_out_1_a_bits_address = auto_in_a_bits_address;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
  assign auto_out_1_a_bits_data = auto_in_a_bits_data;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
  assign auto_out_1_d_ready = auto_in_d_ready & ~bypass;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :81:21, :89:45, :95:32]
  assign auto_out_0_a_valid = ~stall & auto_in_a_valid & bypass;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :81:21, :86:40, :88:{21,42}]
  assign auto_out_0_a_bits_opcode = auto_in_a_bits_opcode;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9]
  assign auto_out_0_a_bits_address = {119'h0, auto_in_a_bits_address};	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :91:18]
  assign auto_out_0_d_ready = auto_in_d_ready & bypass;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BusBypass.scala:66:9, :81:21, :94:32]
endmodule
