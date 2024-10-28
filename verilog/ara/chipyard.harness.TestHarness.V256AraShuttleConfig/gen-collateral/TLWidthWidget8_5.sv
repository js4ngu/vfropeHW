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

module TLWidthWidget8_5(	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
  input          clock,	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
  input          reset,	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
  output         auto_anon_in_a_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_anon_in_a_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [31:0]  auto_anon_in_a_bits_address,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_anon_in_d_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [2:0]   auto_anon_in_d_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [3:0]   auto_anon_in_d_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [63:0]  auto_anon_in_d_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_anon_out_a_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_anon_out_a_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [31:0]  auto_anon_out_a_bits_address,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_anon_out_d_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_anon_out_d_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]   auto_anon_out_d_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [1:0]   auto_anon_out_d_bits_param,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [3:0]   auto_anon_out_d_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_anon_out_d_bits_source,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [3:0]   auto_anon_out_d_bits_sink,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_anon_out_d_bits_denied,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [127:0] auto_anon_out_d_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_anon_out_d_bits_corrupt	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
);

  wire         _repeated_repeater_io_deq_valid;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
  wire [2:0]   _repeated_repeater_io_deq_bits_opcode;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
  wire [1:0]   _repeated_repeater_io_deq_bits_param;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
  wire [3:0]   _repeated_repeater_io_deq_bits_size;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
  wire         _repeated_repeater_io_deq_bits_source;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
  wire [3:0]   _repeated_repeater_io_deq_bits_sink;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
  wire         _repeated_repeater_io_deq_bits_denied;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
  wire [127:0] _repeated_repeater_io_deq_bits_data;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
  wire         _repeated_repeater_io_deq_bits_corrupt;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
  wire [18:0]  _repeat_limit_T = 19'hF << _repeated_repeater_io_deq_bits_size;	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26, generators/rocket-chip/src/main/scala/util/package.scala:243:71]
  reg          repeat_count;	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:105:26]
  wire         repeat_last = repeat_count == ~(_repeat_limit_T[3]) | ~(_repeated_repeater_io_deq_bits_opcode[0]);	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:106:36, generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:105:26, :107:{25,35,38}, generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26, generators/rocket-chip/src/main/scala/util/package.scala:243:{46,71,76}]
  reg          repeat_sel_sel_sources_0;	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:187:27]
  reg          repeat_sel_hold_r;	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:121:47]
  always @(posedge clock) begin	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
    if (reset)	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
      repeat_count <= 1'h0;	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25, generators/rocket-chip/src/main/scala/tilelink/Nodes.scala:27:25, generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:50:15, :51:21, :52:21, :53:17, :54:23, :66:24, :68:88, :69:{23,33}, :71:56, :76:32, :105:26]
    else if (_repeated_repeater_io_deq_valid)	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
      repeat_count <= ~repeat_last & repeat_count - 1'h1;	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:105:26, :107:35, :110:{15,24}, :111:{21,29}]
    if (auto_anon_out_a_ready & auto_anon_in_a_valid)	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
      repeat_sel_sel_sources_0 <= auto_anon_in_a_bits_address[3];	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:187:27, :188:38]
    if (repeat_count) begin	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:105:26]
    end
    else	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:105:26]
      repeat_sel_hold_r <= repeat_sel_sel_sources_0;	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:121:47, :187:27]
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
      `FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:2];	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
    initial begin	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
        `INIT_RANDOM_PROLOG_	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
        for (logic [1:0] i = 2'h0; i < 2'h3; i += 2'h1) begin
          _RANDOM[i] = `RANDOM;	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
        end	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
        repeat_count = _RANDOM[2'h2][12];	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9, :105:26]
        repeat_sel_sel_sources_0 = _RANDOM[2'h2][13];	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9, :105:26, :187:27]
        repeat_sel_hold_r = _RANDOM[2'h2][14];	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9, :105:26, :121:47]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
      `FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_44 monitor (	// @[generators/rocket-chip/src/main/scala/tilelink/Nodes.scala:27:25]
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (auto_anon_out_a_ready),
    .io_in_a_valid        (auto_anon_in_a_valid),
    .io_in_a_bits_address (auto_anon_in_a_bits_address),
    .io_in_d_valid        (_repeated_repeater_io_deq_valid),	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
    .io_in_d_bits_opcode  (_repeated_repeater_io_deq_bits_opcode),	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
    .io_in_d_bits_param   (_repeated_repeater_io_deq_bits_param),	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
    .io_in_d_bits_size    (_repeated_repeater_io_deq_bits_size),	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
    .io_in_d_bits_source  (_repeated_repeater_io_deq_bits_source),	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
    .io_in_d_bits_sink    (_repeated_repeater_io_deq_bits_sink),	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
    .io_in_d_bits_denied  (_repeated_repeater_io_deq_bits_denied),	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
    .io_in_d_bits_corrupt (_repeated_repeater_io_deq_bits_corrupt)	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
  );
  Repeater_TLBundleD_a32d128s1k4z4u repeated_repeater (	// @[generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
    .clock               (clock),
    .reset               (reset),
    .io_repeat           (~repeat_last),	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:107:35, :148:7]
    .io_enq_ready        (auto_anon_out_d_ready),
    .io_enq_valid        (auto_anon_out_d_valid),
    .io_enq_bits_opcode  (auto_anon_out_d_bits_opcode),
    .io_enq_bits_param   (auto_anon_out_d_bits_param),
    .io_enq_bits_size    (auto_anon_out_d_bits_size),
    .io_enq_bits_source  (auto_anon_out_d_bits_source),
    .io_enq_bits_sink    (auto_anon_out_d_bits_sink),
    .io_enq_bits_denied  (auto_anon_out_d_bits_denied),
    .io_enq_bits_data    (auto_anon_out_d_bits_data),
    .io_enq_bits_corrupt (auto_anon_out_d_bits_corrupt),
    .io_deq_valid        (_repeated_repeater_io_deq_valid),
    .io_deq_bits_opcode  (_repeated_repeater_io_deq_bits_opcode),
    .io_deq_bits_param   (_repeated_repeater_io_deq_bits_param),
    .io_deq_bits_size    (_repeated_repeater_io_deq_bits_size),
    .io_deq_bits_source  (_repeated_repeater_io_deq_bits_source),
    .io_deq_bits_sink    (_repeated_repeater_io_deq_bits_sink),
    .io_deq_bits_denied  (_repeated_repeater_io_deq_bits_denied),
    .io_deq_bits_data    (_repeated_repeater_io_deq_bits_data),
    .io_deq_bits_corrupt (_repeated_repeater_io_deq_bits_corrupt)
  );
  assign auto_anon_in_a_ready = auto_anon_out_a_ready;	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
  assign auto_anon_in_d_valid = _repeated_repeater_io_deq_valid;	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9, generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
  assign auto_anon_in_d_bits_opcode = _repeated_repeater_io_deq_bits_opcode;	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9, generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
  assign auto_anon_in_d_bits_size = _repeated_repeater_io_deq_bits_size;	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9, generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26]
  assign auto_anon_in_d_bits_data = (repeat_count ? repeat_sel_hold_r : repeat_sel_sel_sources_0) & _repeat_limit_T[3] | repeat_count ? _repeated_repeater_io_deq_bits_data[127:64] : auto_anon_out_d_bits_data[63:0];	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9, :105:26, :121:{25,47}, :122:16, :126:24, :137:30, :164:37, :165:31, :187:27, generators/rocket-chip/src/main/scala/util/Repeater.scala:36:26, generators/rocket-chip/src/main/scala/util/package.scala:243:{71,76}]
  assign auto_anon_out_a_valid = auto_anon_in_a_valid;	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
  assign auto_anon_out_a_bits_address = auto_anon_in_a_bits_address;	// @[generators/rocket-chip/src/main/scala/tilelink/WidthWidget.scala:27:9]
endmodule
