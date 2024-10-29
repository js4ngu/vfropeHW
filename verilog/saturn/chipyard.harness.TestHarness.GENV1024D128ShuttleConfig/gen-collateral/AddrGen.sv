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

module AddrGen(	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
  input         clock,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
  input         reset,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
  input         io_valid,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  output        io_done,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  output        io_tag_ready,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input         io_tag_valid,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input  [3:0]  io_tag_bits,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input  [11:0] io_op_base_offset,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input  [19:0] io_op_page,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input  [11:0] io_op_stride,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input  [2:0]  io_op_segstart,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input  [2:0]  io_op_segend,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input  [9:0]  io_op_vstart,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input  [10:0] io_op_vl,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input  [1:0]  io_op_mop,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input         io_op_vm,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input  [2:0]  io_op_nf,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input  [1:0]  io_op_idx_size,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input  [1:0]  io_op_elem_size,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input         io_op_whole_reg,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input  [63:0] io_maskindex_index,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input         io_maskindex_mask,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  output [1:0]  io_maskindex_eew,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  output        io_maskindex_needs_mask,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  output        io_maskindex_needs_index,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input         io_maskindex_valid,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  output        io_maskindex_ready,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input         io_req_ready,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  output        io_req_valid,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  output [39:0] io_req_bits_addr,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  output [15:0] io_req_bits_mask,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  output [3:0]  io_req_bits_tag,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  input         io_out_ready,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  output        io_out_valid,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  output [3:0]  io_out_bits_head,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  output [3:0]  io_out_bits_tail,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  output        io_out_bits_masked,	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
  output        io_out_bits_last	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:12:14]
);

  reg  [31:0]  r_eaddr;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:38:20]
  reg  [31:0]  r_saddr;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:39:20]
  reg  [13:0]  r_eidx;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:40:19]
  reg  [2:0]   r_sidx;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:41:19]
  reg          r_head;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:42:23]
  wire         _next_eaddr_T = io_op_mop == 2'h0;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :44:34]
  wire [2:0]   _may_clear_T = io_op_whole_reg ? 3'h0 : io_op_nf;	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19]
  wire         fast_segmented = _next_eaddr_T & io_op_segend == _may_clear_T & io_op_segstart == 3'h0;	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/mem/AddrGen.scala:44:{34,62,79,97}]
  wire [13:0]  _GEN = {4'h0, io_op_vstart};	// @[generators/saturn/src/main/scala/common/Parameters.scala:351:8, generators/saturn/src/main/scala/mem/AddrGen.scala:46:18]
  wire [2:0]   sidx = r_head ? io_op_segstart : r_sidx;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:41:19, :42:23, :48:17]
  wire         _next_eaddr_T_1 = io_op_mop == 2'h2;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :49:52]
  wire [3:0]   _GEN_0 = {1'h0, _may_clear_T};	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/mem/AddrGen.scala:51:19]
  wire [5:0]   _eaddr_T_6 = {3'h0, io_op_segstart} << io_op_elem_size;	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/mem/AddrGen.scala:52:71]
  wire [3:0]   _index_offset_T_11 = {2'h0, {1'h0, io_op_idx_size == 2'h0} | {2{io_op_idx_size == 2'h1}}} | {4{io_op_idx_size == 2'h2}} | {4{&io_op_idx_size}};	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/common/Parameters.scala:351:{8,13}, :352:13, generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
  wire [31:0]  eaddr = _next_eaddr_T | _next_eaddr_T_1 ? (r_head ? {20'h0, io_op_base_offset + {2'h0, io_op_vstart} * (_next_eaddr_T_1 ? io_op_stride : {5'h0, {3'h0, _GEN_0 + 4'h1} << io_op_elem_size}) + {6'h0, _eaddr_T_6}} : r_eaddr) : {20'h0, io_op_base_offset} + (io_maskindex_index[31:0] & {{8{_index_offset_T_11[3]}}, {8{_index_offset_T_11[2]}}, {8{_index_offset_T_11[1]}}, {8{_index_offset_T_11[0]}}}) + {26'h0, r_head ? _eaddr_T_6 : 6'h0};	// @[generators/rocket-chip/src/main/scala/util/package.scala:81:59, generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/common/Parameters.scala:352:13, :353:46, generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :12:14, :38:20, :42:23, :44:34, :46:60, :49:{36,41,52}, :51:{19,27}, :52:{53,71}, :53:41, :54:18, :55:{23,38,43}, :56:8]
  wire [31:0]  saddr = ~((|_may_clear_T) & ~fast_segmented) | r_head ? eaddr : r_saddr;	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/mem/AddrGen.scala:39:20, :42:23, :44:79, :54:18, :57:{18,32,40,43}]
  wire [14:0]  _GEN_1 = {4'h0, io_op_vl};	// @[generators/saturn/src/main/scala/common/Parameters.scala:351:8, generators/saturn/src/main/scala/mem/AddrGen.scala:61:14]
  wire [14:0]  max_eidx = fast_segmented ? _GEN_1 * {11'h0, _GEN_0 + 4'h1} : _GEN_1;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:44:79, :46:60, :51:19, :60:21, :61:{14,30}]
  wire [4:0]   next_max_elems = 5'h10 - {1'h0, saddr[3:0]} >> io_op_elem_size;	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/mem/AddrGen.scala:35:{14,19,38}, :57:18]
  wire [14:0]  _GEN_2 = {1'h0, r_head ? _GEN * {10'h0, {1'h0, ~fast_segmented | io_op_whole_reg ? 3'h0 : io_op_nf} + 4'h1} : r_eidx};	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/mem/AddrGen.scala:40:19, :42:23, :44:79, :45:17, :46:{18,24,60}, :66:14]
  wire [14:0]  next_contig_elems = fast_segmented ? max_eidx - _GEN_2 : {11'h0, _GEN_0 + 4'h1 - {1'h0, sidx}};	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/mem/AddrGen.scala:44:79, :46:60, :48:17, :51:19, :60:21, :61:14, :65:30, :66:14, :67:{18,25}]
  wire [4:0]   _next_act_elems_T_1 = next_contig_elems > {10'h0, next_max_elems} ? next_max_elems : next_contig_elems[4:0];	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:32:{34,37}, :35:38, :46:18, :65:30]
  wire [7:0]   next_act_bytes = {3'h0, _next_act_elems_T_1} << io_op_elem_size;	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/mem/AddrGen.scala:32:34, :69:39]
  wire [5:0]   next_sidx = {3'h0, sidx} + {1'h0, _next_act_elems_T_1};	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/mem/AddrGen.scala:32:34, :48:17, :71:24]
  wire [14:0]  next_eidx = _GEN_2 + {10'h0, fast_segmented ? _next_act_elems_T_1 : 5'h1};	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:32:34, :44:79, :46:18, :66:14, :72:{24,30}]
  wire [31:0]  _io_out_bits_tail_T = saddr + {24'h0, next_act_bytes};	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:57:18, :69:39, :75:26]
  wire         needs_mask = ~io_op_vm & (|io_op_mop);	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:77:{20,30,43}]
  wire         _io_maskindex_ready_T = needs_mask | io_op_mop[0];	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:77:30, :78:30, :79:37]
  wire         block_maskindex = _io_maskindex_ready_T & ~io_maskindex_valid;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:79:{37,53,56}]
  wire         masked = needs_mask & ~io_maskindex_mask | (|_may_clear_T) & sidx > io_op_segend;	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/mem/AddrGen.scala:48:17, :77:30, :81:{28,31,51,68,74,82}]
  wire [5:0]   _GEN_3 = {3'h0, _may_clear_T};	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/mem/AddrGen.scala:82:48]
  wire         may_clear = (fast_segmented | next_sidx > _GEN_3) & next_eidx >= max_eidx;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:44:79, :60:21, :71:24, :72:24, :82:{35,48,64,77}]
  wire         _io_out_valid_output = io_valid & ~block_maskindex & (masked | io_req_ready) & io_tag_valid;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:79:53, :81:51, :90:{31,59,76}]
  wire [270:0] _io_req_bits_mask_T_4 = {15'h0, (256'h1 << next_act_bytes) - 256'h1} << saddr[3:0];	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:35:19, :57:18, :69:39, :101:{29,48,55}]
  wire         _GEN_4 = io_out_ready & _io_out_valid_output;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:90:76, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  wire         _GEN_5 = next_sidx > _GEN_3 | fast_segmented;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:44:79, :71:24, :82:48, :108:{21,36}]
  wire [31:0]  _next_eaddr_T_4 = eaddr + {20'h0, _next_eaddr_T ? {4'h0, next_act_bytes} : _next_eaddr_T_1 ? io_op_stride : 12'h0};	// @[generators/saturn/src/main/scala/common/Parameters.scala:351:8, generators/saturn/src/main/scala/mem/AddrGen.scala:44:34, :49:52, :54:18, :56:8, :69:39, :74:{26,31,74}]
  always @(posedge clock) begin	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
    if (_GEN_4) begin	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
      if (_GEN_5) begin	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:108:36]
        r_eaddr <= _next_eaddr_T_4;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:38:20, :74:26]
        r_saddr <= _next_eaddr_T_4;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:39:20, :74:26]
        r_eidx <= next_eidx[13:0];	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:40:19, :72:24, :111:14]
        r_sidx <= 3'h0;	// @[generators/saturn/src/main/scala/common/Bundles.scala:33:19, generators/saturn/src/main/scala/mem/AddrGen.scala:41:19]
      end
      else begin	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:108:36]
        r_eaddr <= eaddr;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:38:20, :54:18]
        r_saddr <= _io_out_bits_tail_T;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:39:20, :75:26]
        r_eidx <= _GEN;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:40:19, :46:18]
        r_sidx <= next_sidx[2:0];	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:41:19, :71:24, :118:14]
      end
    end
    if (reset)	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
      r_head <= 1'h1;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:42:23]
    else if (_GEN_4)	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
      r_head <= may_clear;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:42:23, :82:64]
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
      `FIRRTL_BEFORE_INITIAL	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:2];	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
    initial begin	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
        `INIT_RANDOM_PROLOG_	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
        for (logic [1:0] i = 2'h0; i < 2'h3; i += 2'h1) begin
          _RANDOM[i] = `RANDOM;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
        end	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
        r_eaddr = _RANDOM[2'h0];	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :38:20]
        r_saddr = _RANDOM[2'h1];	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :39:20]
        r_eidx = _RANDOM[2'h2][13:0];	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :40:19]
        r_sidx = _RANDOM[2'h2][16:14];	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :40:19, :41:19]
        r_head = _RANDOM[2'h2][17];	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :40:19, :42:23]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
      `FIRRTL_AFTER_INITIAL	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_done = _GEN_4 & may_clear;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :82:64, :85:11, :107:22, :121:22, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  assign io_tag_ready = io_valid & (io_req_ready | masked) & io_out_ready & ~block_maskindex;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :79:53, :81:51, :90:31, :105:{45,72}]
  assign io_maskindex_eew = io_op_idx_size;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
  assign io_maskindex_needs_mask = needs_mask;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :77:30]
  assign io_maskindex_needs_index = io_op_mop[0];	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :78:30]
  assign io_maskindex_ready = _GEN_4 & _GEN_5 & _io_maskindex_ready_T;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :79:37, :86:22, :107:22, :108:{36,55}, :113:26, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  assign io_req_valid = io_valid & io_out_ready & ~block_maskindex & ~masked & io_tag_valid;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :79:53, :81:51, :90:31, :98:{67,75}]
  assign io_req_bits_addr = {8'h0, io_op_page, saddr[11:0]};	// @[generators/saturn/src/main/scala/common/Parameters.scala:353:46, generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :57:18, :96:35, :99:20]
  assign io_req_bits_mask = _io_req_bits_mask_T_4[15:0];	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :101:{20,55}]
  assign io_req_bits_tag = io_tag_bits;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7]
  assign io_out_valid = _io_out_valid_output;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :90:76]
  assign io_out_bits_head = saddr[3:0];	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :57:18, :91:20]
  assign io_out_bits_tail = _io_out_bits_tail_T[3:0];	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :75:26, :92:{20,29}]
  assign io_out_bits_masked = masked;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :81:51]
  assign io_out_bits_last = may_clear;	// @[generators/saturn/src/main/scala/mem/AddrGen.scala:11:7, :82:64]
endmodule
