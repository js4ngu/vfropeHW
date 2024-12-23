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

module StoreSegmenter(	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7]
  input          clock,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7]
  input          reset,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7]
  input          io_valid,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output         io_done,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  input  [15:0]  io_op_debug_id,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  input  [2:0]   io_op_segstart,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  input  [7:0]   io_op_vstart,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  input  [8:0]   io_op_vl,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  input  [2:0]   io_op_nf,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  input  [1:0]   io_op_elem_size,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  input          io_op_whole_reg,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  input          io_compactor_ready,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output         io_compactor_valid,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [3:0]   io_compactor_bits_head,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [3:0]   io_compactor_bits_tail,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [15:0]  io_compactor_data_0_debug_id,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [7:0]   io_compactor_data_0_data,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output         io_compactor_data_0_mask,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [15:0]  io_compactor_data_1_debug_id,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [7:0]   io_compactor_data_1_data,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output         io_compactor_data_1_mask,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [15:0]  io_compactor_data_2_debug_id,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [7:0]   io_compactor_data_2_data,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output         io_compactor_data_2_mask,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [15:0]  io_compactor_data_3_debug_id,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [7:0]   io_compactor_data_3_data,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output         io_compactor_data_3_mask,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [15:0]  io_compactor_data_4_debug_id,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [7:0]   io_compactor_data_4_data,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output         io_compactor_data_4_mask,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [15:0]  io_compactor_data_5_debug_id,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [7:0]   io_compactor_data_5_data,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output         io_compactor_data_5_mask,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [15:0]  io_compactor_data_6_debug_id,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [7:0]   io_compactor_data_6_data,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output         io_compactor_data_6_mask,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [15:0]  io_compactor_data_7_debug_id,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [7:0]   io_compactor_data_7_data,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output         io_compactor_data_7_mask,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [15:0]  io_compactor_data_8_debug_id,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [7:0]   io_compactor_data_8_data,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output         io_compactor_data_8_mask,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [15:0]  io_compactor_data_9_debug_id,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [7:0]   io_compactor_data_9_data,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output         io_compactor_data_9_mask,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [15:0]  io_compactor_data_10_debug_id,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [7:0]   io_compactor_data_10_data,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output         io_compactor_data_10_mask,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [15:0]  io_compactor_data_11_debug_id,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [7:0]   io_compactor_data_11_data,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output         io_compactor_data_11_mask,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [15:0]  io_compactor_data_12_debug_id,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [7:0]   io_compactor_data_12_data,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output         io_compactor_data_12_mask,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [15:0]  io_compactor_data_13_debug_id,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [7:0]   io_compactor_data_13_data,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output         io_compactor_data_13_mask,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [15:0]  io_compactor_data_14_debug_id,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [7:0]   io_compactor_data_14_data,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output         io_compactor_data_14_mask,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [15:0]  io_compactor_data_15_debug_id,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output [7:0]   io_compactor_data_15_data,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output         io_compactor_data_15_mask,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  output         io_stdata_ready,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  input          io_stdata_valid,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  input  [127:0] io_stdata_bits_stdata,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  input  [15:0]  io_stdata_bits_stmask,	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
  input  [15:0]  io_stdata_bits_debug_id	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14]
);

  wire         _segbuf_io_in_ready;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:22:22]
  wire         _segbuf_io_out_valid;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:22:22]
  wire [127:0] _segbuf_io_out_bits_data_stdata;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:22:22]
  wire [15:0]  _segbuf_io_out_bits_data_stmask;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:22:22]
  wire [15:0]  _segbuf_io_out_bits_data_debug_id;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:22:22]
  wire [3:0]   _segbuf_io_out_bits_head;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:22:22]
  wire [3:0]   _segbuf_io_out_bits_tail;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:22:22]
  wire         _segbuf_io_busy;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:22:22]
  reg  [7:0]   r_eidx;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:24:19]
  reg          r_head;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:25:23]
  reg  [2:0]   r_sidx;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:26:19]
  wire [7:0]   eidx = r_head ? io_op_vstart : r_eidx;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:24:19, :25:23, :27:17]
  wire [2:0]   sidx = r_head ? 3'h0 : r_sidx;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:25:23, :26:19, :28:17]
  wire [2:0]   _io_compactor_valid_T_1 = io_op_whole_reg ? 3'h0 : io_op_nf;	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:28:17]
  wire [2:0]   _GEN = {1'h0, io_op_elem_size};	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :31:72]
  wire [2:0]   _sub_dlen_T_2 = _GEN + 3'h3;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:31:72]
  wire [3:0]   _eidx_incr_T_5 = {2'h0, io_op_elem_size} + {1'h0, (|_io_compactor_valid_T_1) & ~(_sub_dlen_T_2[2]) ? 3'h1 - _GEN : 3'h0};	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :28:17, :31:{21,35,43,65,72}, :32:29, :34:50]
  wire [22:0]  _eidx_incr_T_1 = {15'h0, eidx} << _eidx_incr_T_5;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:27:17, :34:{37,50}]
  wire [4:0]   eidx_incr = 5'h10 - {1'h0, _eidx_incr_T_1[3:0]} >> _eidx_incr_T_5;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :34:{28,37,50,63,83}]
  wire [8:0]   next_eidx = {1'h0, eidx} + {4'h0, eidx_incr};	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :27:17, :34:83, :35:24]
  wire [3:0]   next_sidx = {1'h0, sidx} + 4'h1;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :28:17, :32:29, :36:24]
  wire         eidx_tail = next_eidx >= io_op_vl;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:35:24, :39:29]
  `ifndef SYNTHESIS	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:42:11]
    always @(posedge clock) begin	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:42:11]
      if (io_valid & io_stdata_valid & ~reset & io_stdata_bits_debug_id != io_op_debug_id) begin	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:42:{11,36}]
        if (`ASSERT_VERBOSE_COND_)	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:42:11]
          $error("Assertion failed\n    at StoreSegmenter.scala:42 assert(io.stdata.bits.debug_id === io.op.debug_id)\n");	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:42:11]
        if (`STOP_COND_)	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:42:11]
          $fatal;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:42:11]
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire         _io_stdata_ready_output = io_valid & ((|_io_compactor_valid_T_1) ? _segbuf_io_in_ready : ~_segbuf_io_busy & io_compactor_ready);	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:22:22, :45:{31,37,51}, :46:{5,21}]
  wire [10:0]  _io_compactor_bits_head_T = {3'h0, eidx} << io_op_elem_size;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:27:17, :28:17, :50:61]
  wire [127:0] _GEN_0 = _segbuf_io_busy ? _segbuf_io_out_bits_data_stdata : io_stdata_bits_stdata;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:22:22, :63:27]
  wire [15:0]  _GEN_1 = _segbuf_io_busy ? _segbuf_io_out_bits_data_stmask : io_stdata_bits_stmask;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:22:22, :63:27]
  wire [15:0]  bytes_15_debug_id = _segbuf_io_busy ? _segbuf_io_out_bits_data_debug_id : io_stdata_bits_debug_id;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:22:22, :63:27]
  wire [11:0]  _io_compactor_bits_tail_T = {3'h0, io_op_vl} << io_op_elem_size;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:28:17, :68:54]
  wire         _GEN_2 = _io_stdata_ready_output & io_stdata_valid;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:45:31, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  wire         _GEN_3 = (|_io_compactor_valid_T_1) & next_sidx <= {1'h0, _io_compactor_valid_T_1};	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :36:24, :38:29, :45:51, :75:32]
  wire         _GEN_4 = ~_GEN_3 & eidx_tail;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:39:29, :72:11, :75:{32,47}, :81:15]
  always @(posedge clock) begin	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7]
    if (_GEN_2) begin	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
      if (_GEN_3) begin	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:75:32]
        if (r_head)	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:25:23]
          r_eidx <= io_op_vstart;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:24:19]
        r_sidx <= next_sidx[2:0];	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:26:19, :36:24, :77:14]
      end
      else begin	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:75:32]
        r_eidx <= next_eidx[7:0];	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:24:19, :35:24, :79:14]
        r_sidx <= 3'h0;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:26:19, :28:17]
      end
    end
    if (reset)	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7]
      r_head <= 1'h1;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :25:23]
    else if (_GEN_2)	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
      r_head <= _GEN_4;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:25:23, :72:11, :75:47, :81:15]
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7]
      `FIRRTL_BEFORE_INITIAL	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:0];	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7]
    initial begin	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7]
        `INIT_RANDOM_PROLOG_	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7]
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7]
        r_eidx = _RANDOM[/*Zero width*/ 1'b0][7:0];	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :24:19]
        r_head = _RANDOM[/*Zero width*/ 1'b0][8];	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :24:19, :25:23]
        r_sidx = _RANDOM[/*Zero width*/ 1'b0][11:9];	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :24:19, :26:19]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7]
      `FIRRTL_AFTER_INITIAL	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  StoreSegmentBuffer segbuf (	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:22:22]
    .clock                     (clock),
    .reset                     (reset),
    .io_in_ready               (_segbuf_io_in_ready),
    .io_in_valid               (io_valid & (|_io_compactor_valid_T_1) & io_stdata_valid),	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:49:{50,58}]
    .io_in_bits_data           (io_stdata_bits_stdata >> {121'h0, _io_compactor_bits_head_T[3:0], 3'h0}),	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:28:17, :50:{51,61,73}]
    .io_in_bits_mask           (io_stdata_bits_stmask >> _io_compactor_bits_head_T[3:0]),	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:50:61, :51:{51,72}]
    .io_in_bits_debug_id       (io_op_debug_id),
    .io_in_bits_eew            (io_op_elem_size),
    .io_in_bits_nf             (io_op_nf),
    .io_in_bits_rows           (eidx_tail ? io_op_vl[3:0] - eidx[3:0] : eidx_incr[3:0]),	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:12:14, :27:17, :34:83, :35:24, :39:29, :54:{32,66}]
    .io_in_bits_sidx           (sidx),	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:28:17]
    .io_in_bits_segstart       (io_op_segstart),
    .io_in_bits_segend         (_io_compactor_valid_T_1),	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19]
    .io_out_ready              (io_compactor_ready),
    .io_out_valid              (_segbuf_io_out_valid),
    .io_out_bits_data_stdata   (_segbuf_io_out_bits_data_stdata),
    .io_out_bits_data_stmask   (_segbuf_io_out_bits_data_stmask),
    .io_out_bits_data_debug_id (_segbuf_io_out_bits_data_debug_id),
    .io_out_bits_head          (_segbuf_io_out_bits_head),
    .io_out_bits_tail          (_segbuf_io_out_bits_tail),
    .io_busy                   (_segbuf_io_busy)
  );
  assign io_done = _GEN_2 & _GEN_4;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :72:11, :73:25, :75:47, :81:15, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  assign io_compactor_valid = _segbuf_io_busy ? _segbuf_io_out_valid : io_stdata_valid & io_valid & ~(|_io_compactor_valid_T_1);	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :22:22, :45:51, :60:28, :62:{33,49}]
  assign io_compactor_bits_head = _segbuf_io_busy ? _segbuf_io_out_bits_head : _io_compactor_bits_head_T[3:0];	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :22:22, :50:61, :65:32]
  assign io_compactor_bits_tail = _segbuf_io_busy ? _segbuf_io_out_bits_tail : eidx_tail ? _io_compactor_bits_tail_T[3:0] : 4'h0;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :22:22, :35:24, :39:29, :67:32, :68:{33,54}]
  assign io_compactor_data_0_debug_id = bytes_15_debug_id;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_0_data = _GEN_0[7:0];	// @[generators/saturn/src/main/scala/common/Bundles.scala:220:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_0_mask = _GEN_1[0];	// @[generators/saturn/src/main/scala/common/Bundles.scala:221:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_1_debug_id = bytes_15_debug_id;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_1_data = _GEN_0[15:8];	// @[generators/saturn/src/main/scala/common/Bundles.scala:220:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_1_mask = _GEN_1[1];	// @[generators/saturn/src/main/scala/common/Bundles.scala:221:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_2_debug_id = bytes_15_debug_id;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_2_data = _GEN_0[23:16];	// @[generators/saturn/src/main/scala/common/Bundles.scala:220:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_2_mask = _GEN_1[2];	// @[generators/saturn/src/main/scala/common/Bundles.scala:221:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_3_debug_id = bytes_15_debug_id;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_3_data = _GEN_0[31:24];	// @[generators/saturn/src/main/scala/common/Bundles.scala:220:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_3_mask = _GEN_1[3];	// @[generators/saturn/src/main/scala/common/Bundles.scala:221:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_4_debug_id = bytes_15_debug_id;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_4_data = _GEN_0[39:32];	// @[generators/saturn/src/main/scala/common/Bundles.scala:220:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_4_mask = _GEN_1[4];	// @[generators/saturn/src/main/scala/common/Bundles.scala:221:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_5_debug_id = bytes_15_debug_id;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_5_data = _GEN_0[47:40];	// @[generators/saturn/src/main/scala/common/Bundles.scala:220:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_5_mask = _GEN_1[5];	// @[generators/saturn/src/main/scala/common/Bundles.scala:221:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_6_debug_id = bytes_15_debug_id;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_6_data = _GEN_0[55:48];	// @[generators/saturn/src/main/scala/common/Bundles.scala:220:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_6_mask = _GEN_1[6];	// @[generators/saturn/src/main/scala/common/Bundles.scala:221:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_7_debug_id = bytes_15_debug_id;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_7_data = _GEN_0[63:56];	// @[generators/saturn/src/main/scala/common/Bundles.scala:220:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_7_mask = _GEN_1[7];	// @[generators/saturn/src/main/scala/common/Bundles.scala:221:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_8_debug_id = bytes_15_debug_id;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_8_data = _GEN_0[71:64];	// @[generators/saturn/src/main/scala/common/Bundles.scala:220:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_8_mask = _GEN_1[8];	// @[generators/saturn/src/main/scala/common/Bundles.scala:221:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_9_debug_id = bytes_15_debug_id;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_9_data = _GEN_0[79:72];	// @[generators/saturn/src/main/scala/common/Bundles.scala:220:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_9_mask = _GEN_1[9];	// @[generators/saturn/src/main/scala/common/Bundles.scala:221:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_10_debug_id = bytes_15_debug_id;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_10_data = _GEN_0[87:80];	// @[generators/saturn/src/main/scala/common/Bundles.scala:220:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_10_mask = _GEN_1[10];	// @[generators/saturn/src/main/scala/common/Bundles.scala:221:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_11_debug_id = bytes_15_debug_id;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_11_data = _GEN_0[95:88];	// @[generators/saturn/src/main/scala/common/Bundles.scala:220:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_11_mask = _GEN_1[11];	// @[generators/saturn/src/main/scala/common/Bundles.scala:221:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_12_debug_id = bytes_15_debug_id;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_12_data = _GEN_0[103:96];	// @[generators/saturn/src/main/scala/common/Bundles.scala:220:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_12_mask = _GEN_1[12];	// @[generators/saturn/src/main/scala/common/Bundles.scala:221:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_13_debug_id = bytes_15_debug_id;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_13_data = _GEN_0[111:104];	// @[generators/saturn/src/main/scala/common/Bundles.scala:220:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_13_mask = _GEN_1[13];	// @[generators/saturn/src/main/scala/common/Bundles.scala:221:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_14_debug_id = bytes_15_debug_id;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_14_data = _GEN_0[119:112];	// @[generators/saturn/src/main/scala/common/Bundles.scala:220:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_14_mask = _GEN_1[14];	// @[generators/saturn/src/main/scala/common/Bundles.scala:221:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_15_debug_id = bytes_15_debug_id;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_15_data = _GEN_0[127:120];	// @[generators/saturn/src/main/scala/common/Bundles.scala:220:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_compactor_data_15_mask = _GEN_1[15];	// @[generators/saturn/src/main/scala/common/Bundles.scala:221:30, generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :63:27]
  assign io_stdata_ready = _io_stdata_ready_output;	// @[generators/saturn/src/main/scala/mem/StoreSegmenter.scala:11:7, :45:31]
endmodule

