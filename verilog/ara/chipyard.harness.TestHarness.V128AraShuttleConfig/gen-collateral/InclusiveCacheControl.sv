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

module InclusiveCacheControl(	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9]
  input         clock,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9]
  input         reset,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9]
  output        auto_ctrl_in_a_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_ctrl_in_a_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]  auto_ctrl_in_a_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]  auto_ctrl_in_a_bits_param,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [1:0]  auto_ctrl_in_a_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [12:0] auto_ctrl_in_a_bits_source,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [25:0] auto_ctrl_in_a_bits_address,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [7:0]  auto_ctrl_in_a_bits_mask,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [63:0] auto_ctrl_in_a_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_ctrl_in_a_bits_corrupt,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_ctrl_in_d_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output        auto_ctrl_in_d_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [2:0]  auto_ctrl_in_d_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [1:0]  auto_ctrl_in_d_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [12:0] auto_ctrl_in_d_bits_source,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [63:0] auto_ctrl_in_d_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         io_flush_match,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:39:16]
  input         io_flush_req_ready,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:39:16]
  output        io_flush_req_valid,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:39:16]
  output [63:0] io_flush_req_bits,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:39:16]
  input         io_flush_resp	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:39:16]
);

  wire             _out_wofireMux_T_2;	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire             out_backSel_3;	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire             out_backSel_2;	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire             _out_back_front_q_io_enq_ready;	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire             _out_back_front_q_io_deq_valid;	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire             _out_back_front_q_io_deq_bits_read;	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [8:0]       _out_back_front_q_io_deq_bits_index;	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [7:0]       _out_back_front_q_io_deq_bits_mask;	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [12:0]      _out_back_front_q_io_deq_bits_extra_tlrr_extra_source;	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [1:0]       _out_back_front_q_io_deq_bits_extra_tlrr_extra_size;	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [3:0][63:0] _GEN = {64'h0, 64'h0, 64'h0, 64'h60A0801};	// @[generators/rocket-chip/src/main/scala/util/MuxLiteral.scala:49:10]
  reg              flushInValid;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:45:33]
  reg  [63:0]      flushInAddress;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:46:29]
  reg              flushOutValid;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:47:33]
  wire             out_front_bits_read = auto_ctrl_in_a_bits_opcode == 3'h4;	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:74:36]
  wire [6:0]       _GEN_0 = {auto_ctrl_in_a_bits_address[11:10], auto_ctrl_in_a_bits_address[8:7], auto_ctrl_in_a_bits_address[5:3]};	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [6:0]       _GEN_1 = {_out_back_front_q_io_deq_bits_index[8:7], _out_back_front_q_io_deq_bits_index[5:4], _out_back_front_q_io_deq_bits_index[2:0]};	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [7:0]       _out_frontMask_T_8 = {8{auto_ctrl_in_a_bits_mask[0]}};	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [7:0]       _out_frontMask_T_9 = {8{auto_ctrl_in_a_bits_mask[1]}};	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [7:0]       _out_frontMask_T_10 = {8{auto_ctrl_in_a_bits_mask[2]}};	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [7:0]       _out_frontMask_T_11 = {8{auto_ctrl_in_a_bits_mask[3]}};	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [63:0]      out_frontMask = {{8{auto_ctrl_in_a_bits_mask[7]}}, {8{auto_ctrl_in_a_bits_mask[6]}}, {8{auto_ctrl_in_a_bits_mask[5]}}, {8{auto_ctrl_in_a_bits_mask[4]}}, _out_frontMask_T_11, _out_frontMask_T_10, _out_frontMask_T_9, _out_frontMask_T_8};	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [7:0]       _out_backMask_T_8 = {8{_out_back_front_q_io_deq_bits_mask[0]}};	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [7:0]       _out_backMask_T_9 = {8{_out_back_front_q_io_deq_bits_mask[1]}};	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [7:0]       _out_backMask_T_10 = {8{_out_back_front_q_io_deq_bits_mask[2]}};	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [7:0]       _out_backMask_T_11 = {8{_out_back_front_q_io_deq_bits_mask[3]}};	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [63:0]      out_backMask = {{8{_out_back_front_q_io_deq_bits_mask[7]}}, {8{_out_back_front_q_io_deq_bits_mask[6]}}, {8{_out_back_front_q_io_deq_bits_mask[5]}}, {8{_out_back_front_q_io_deq_bits_mask[4]}}, _out_backMask_T_11, _out_backMask_T_10, _out_backMask_T_9, _out_backMask_T_8};	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [31:0]      _out_wimask_T_5 = {_out_frontMask_T_11, _out_frontMask_T_10, _out_frontMask_T_9, _out_frontMask_T_8};	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [31:0]      _out_womask_T_5 = {_out_backMask_T_11, _out_backMask_T_10, _out_backMask_T_9, _out_backMask_T_8};	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [1:0]       out_oindex = {_out_back_front_q_io_deq_bits_index[6], _out_back_front_q_io_deq_bits_index[3]};	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [1:0]       _GEN_2 = {auto_ctrl_in_a_bits_address[9], auto_ctrl_in_a_bits_address[6]};	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire [1:0]       _GEN_3 = {_out_back_front_q_io_deq_bits_index[6], _out_back_front_q_io_deq_bits_index[3]};	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24, src/main/scala/chisel3/util/OneHot.scala:58:35]
  assign out_backSel_2 = _GEN_3 == 2'h2;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9, generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24, src/main/scala/chisel3/util/OneHot.scala:58:35]
  assign out_backSel_3 = &_GEN_3;	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire             _out_wifireMux_T_2 = auto_ctrl_in_a_valid & _out_back_front_q_io_enq_ready & ~out_front_bits_read;	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:74:36, :87:24]
  wire [3:0]       _GEN_4 = {{~flushInValid | ~(&_out_wimask_T_5) | (|_GEN_0)}, {~flushInValid | ~(&out_frontMask) | (|_GEN_0)}, {1'h1}, {1'h1}};	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:45:33, :51:42, :71:23, generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24, generators/rocket-chip/src/main/scala/util/MuxLiteral.scala:49:10]
  assign _out_wofireMux_T_2 = _out_back_front_q_io_deq_valid & auto_ctrl_in_d_ready & ~_out_back_front_q_io_deq_bits_read;	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [3:0]       _GEN_5 = {{flushOutValid | ~(&_out_womask_T_5) | (|_GEN_1)}, {flushOutValid | ~(&out_backMask) | (|_GEN_1)}, {1'h1}, {1'h1}};	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:47:33, :51:42, generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24, generators/rocket-chip/src/main/scala/util/MuxLiteral.scala:49:10]
  wire             out_iready = out_front_bits_read | _GEN_4[{auto_ctrl_in_a_bits_address[9], auto_ctrl_in_a_bits_address[6]}];	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:74:36, :87:24, generators/rocket-chip/src/main/scala/util/MuxLiteral.scala:49:10]
  wire             out_oready = _out_back_front_q_io_deq_bits_read | _GEN_5[out_oindex];	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24, generators/rocket-chip/src/main/scala/util/MuxLiteral.scala:49:10]
  wire             in_ready = _out_back_front_q_io_enq_ready & out_iready;	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire             out_valid = _out_back_front_q_io_deq_valid & out_oready;	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  wire [3:0]       _GEN_6 = {{~(|_GEN_1)}, {~(|_GEN_1)}, {1'h1}, {~(|_GEN_1)}};	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:51:42, generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24, generators/rocket-chip/src/main/scala/util/MuxLiteral.scala:49:10]
  wire [2:0]       ctrlnodeIn_d_bits_opcode = {2'h0, _out_back_front_q_io_deq_bits_read};	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9, generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24, :105:19]
  wire             _GEN_7 = ~io_flush_match & flushInValid;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:45:33, :56:{11,27}]
  wire             out_f_wivalid_4 = _out_wifireMux_T_2 & _GEN_2 == 2'h2 & ~(|_GEN_0) & (&out_frontMask);	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9, generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire             out_f_wivalid_5 = _out_wifireMux_T_2 & (&_GEN_2) & ~(|_GEN_0) & (&_out_wimask_T_5);	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24, src/main/scala/chisel3/util/OneHot.scala:58:35]
  always @(posedge clock) begin	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9]
    if (reset) begin	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9]
      flushInValid <= 1'h0;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:45:33]
      flushOutValid <= 1'h0;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:45:33, :47:33]
    end
    else begin	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9]
      flushInValid <= out_f_wivalid_5 | out_f_wivalid_4 | ~(_GEN_7 | io_flush_req_ready) & flushInValid;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:45:33, :52:{31,46}, :56:{27,44}, :57:20, :63:{21,36}, :70:{21,36}, generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
      flushOutValid <= _GEN_7 | io_flush_resp | ~(_out_wofireMux_T_2 & out_backSel_3 & ~(|_GEN_1) & (&_out_womask_T_5) | _out_wofireMux_T_2 & out_backSel_2 & ~(|_GEN_1) & (&out_backMask)) & flushOutValid;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:47:33, :50:{26,42}, :51:{26,42}, :56:{27,44}, :58:21, :62:{21,37}, :69:21, generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
    end
    if (out_f_wivalid_5 & ~flushInValid)	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:45:33, :64:20, :71:23, generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
      flushInAddress <= {28'h0, auto_ctrl_in_a_bits_data[31:0], 4'h0};	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:46:29, :64:{55,63}, generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
    else if (out_f_wivalid_4 & ~flushInValid)	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:45:33, :71:{20,23}, generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
      flushInAddress <= auto_ctrl_in_a_bits_data;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:46:29]
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9]
      `FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:2];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9]
    initial begin	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9]
        `INIT_RANDOM_PROLOG_	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9]
        for (logic [1:0] i = 2'h0; i < 2'h3; i += 2'h1) begin
          _RANDOM[i] = `RANDOM;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9]
        end	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9]
        flushInValid = _RANDOM[2'h0][0];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9, :45:33]
        flushInAddress = {_RANDOM[2'h0][31:1], _RANDOM[2'h1], _RANDOM[2'h2][0]};	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9, :45:33, :46:29]
        flushOutValid = _RANDOM[2'h2][1];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9, :46:29, :47:33]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9]
      `FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_35 monitor (	// @[generators/rocket-chip/src/main/scala/tilelink/Nodes.scala:27:25]
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (in_ready),	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
    .io_in_a_valid        (auto_ctrl_in_a_valid),
    .io_in_a_bits_opcode  (auto_ctrl_in_a_bits_opcode),
    .io_in_a_bits_param   (auto_ctrl_in_a_bits_param),
    .io_in_a_bits_size    (auto_ctrl_in_a_bits_size),
    .io_in_a_bits_source  (auto_ctrl_in_a_bits_source),
    .io_in_a_bits_address (auto_ctrl_in_a_bits_address),
    .io_in_a_bits_mask    (auto_ctrl_in_a_bits_mask),
    .io_in_a_bits_corrupt (auto_ctrl_in_a_bits_corrupt),
    .io_in_d_ready        (auto_ctrl_in_d_ready),
    .io_in_d_valid        (out_valid),	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
    .io_in_d_bits_opcode  (ctrlnodeIn_d_bits_opcode),	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:105:19]
    .io_in_d_bits_size    (_out_back_front_q_io_deq_bits_extra_tlrr_extra_size),	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
    .io_in_d_bits_source  (_out_back_front_q_io_deq_bits_extra_tlrr_extra_source)	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  );
  Queue1_RegMapperInput_i9_m8 out_back_front_q (	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
    .clock                               (clock),
    .reset                               (reset),
    .io_enq_ready                        (_out_back_front_q_io_enq_ready),
    .io_enq_valid                        (auto_ctrl_in_a_valid & out_iready),	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
    .io_enq_bits_read                    (out_front_bits_read),	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:74:36]
    .io_enq_bits_index                   (auto_ctrl_in_a_bits_address[11:3]),	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:192:34, generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:75:19]
    .io_enq_bits_data                    (auto_ctrl_in_a_bits_data),
    .io_enq_bits_mask                    (auto_ctrl_in_a_bits_mask),
    .io_enq_bits_extra_tlrr_extra_source (auto_ctrl_in_a_bits_source),
    .io_enq_bits_extra_tlrr_extra_size   (auto_ctrl_in_a_bits_size),
    .io_deq_ready                        (auto_ctrl_in_d_ready & out_oready),	// @[generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
    .io_deq_valid                        (_out_back_front_q_io_deq_valid),
    .io_deq_bits_read                    (_out_back_front_q_io_deq_bits_read),
    .io_deq_bits_index                   (_out_back_front_q_io_deq_bits_index),
    .io_deq_bits_mask                    (_out_back_front_q_io_deq_bits_mask),
    .io_deq_bits_extra_tlrr_extra_source (_out_back_front_q_io_deq_bits_extra_tlrr_extra_source),
    .io_deq_bits_extra_tlrr_extra_size   (_out_back_front_q_io_deq_bits_extra_tlrr_extra_size)
  );
  assign auto_ctrl_in_a_ready = in_ready;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9, generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  assign auto_ctrl_in_d_valid = out_valid;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9, generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  assign auto_ctrl_in_d_bits_opcode = ctrlnodeIn_d_bits_opcode;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9, generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:105:19]
  assign auto_ctrl_in_d_bits_size = _out_back_front_q_io_deq_bits_extra_tlrr_extra_size;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9, generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  assign auto_ctrl_in_d_bits_source = _out_back_front_q_io_deq_bits_extra_tlrr_extra_source;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9, generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24]
  assign auto_ctrl_in_d_bits_data = _GEN_6[out_oindex] ? _GEN[out_oindex] : 64'h0;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9, generators/rocket-chip/src/main/scala/tilelink/RegisterRouter.scala:87:24, generators/rocket-chip/src/main/scala/util/MuxLiteral.scala:49:10]
  assign io_flush_req_valid = flushInValid;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9, :45:33]
  assign io_flush_req_bits = flushInAddress;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Control.scala:38:9, :46:29]
endmodule

