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

module PermuteUnit(	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7]
  input          clock,	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7]
  input  [2:0]   io_iss_op_funct3,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [5:0]   io_iss_op_funct6,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [4:0]   io_iss_op_rs1,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [4:0]   io_iss_op_rs2,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  output         io_iss_ready,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  output         io_write_valid,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  output [5:0]   io_write_bits_eg,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  output [127:0] io_write_bits_data,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  output [127:0] io_write_bits_mask,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input          io_pipe_0_valid,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [7:0]   io_pipe_0_bits_eidx,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [8:0]   io_pipe_0_bits_vl,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [127:0] io_pipe_0_bits_rvs1_data,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [127:0] io_pipe_0_bits_rvs2_data,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [1:0]   io_pipe_0_bits_rvs2_eew,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [15:0]  io_pipe_0_bits_wmask,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [5:0]   io_pipe_0_bits_wvd_eg,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [2:0]   io_pipe_0_bits_funct3,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [5:0]   io_pipe_0_bits_funct6,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input          io_pipe_0_bits_head,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input          io_pipe_0_bits_tail	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
);

  wire [8:0]       io_iss_ready_decode_invInputs = ~{io_iss_op_funct3, io_iss_op_funct6};	// @[generators/saturn/src/main/scala/insns/Decode.scala:19:18, src/main/scala/chisel3/util/pla.scala:78:21]
  reg  [4:0]       wvd_reg;	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:30:20]
  reg  [63:0]      result_reg;	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:31:23]
  wire             _slide1_T = io_pipe_0_bits_funct3 == 3'h0;	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:33:38]
  wire             _slide1_T_1 = io_pipe_0_bits_funct3 == 3'h3;	// @[generators/rocket-chip/src/main/scala/util/package.scala:16:47]
  wire             _slide1_T_2 = io_pipe_0_bits_funct3 == 3'h4;	// @[generators/rocket-chip/src/main/scala/util/package.scala:16:47]
  wire [6:0]       _rgather_WIRE_1 = {1'h0, io_pipe_0_bits_funct6};	// @[generators/saturn/src/main/scala/common/Bundles.scala:187:35]
  wire             compress = (io_pipe_0_bits_funct3 == 3'h2 | io_pipe_0_bits_funct3 == 3'h6 ? _rgather_WIRE_1 : 7'h40) == 7'h17;	// @[generators/rocket-chip/src/main/scala/util/package.scala:16:47, :81:59, generators/saturn/src/main/scala/common/Bundles.scala:186:18, :187:{18,35}, generators/saturn/src/main/scala/exu/PermuteUnit.scala:34:40]
  wire             rgather = (_slide1_T | _slide1_T_1 | _slide1_T_2 ? _rgather_WIRE_1 : 7'h40) == 7'hC | _slide1_T & (_slide1_T | _slide1_T_1 | _slide1_T_2 ? _rgather_WIRE_1 : 7'h40) == 7'hE;	// @[generators/rocket-chip/src/main/scala/util/package.scala:16:47, :81:59, generators/saturn/src/main/scala/common/Bundles.scala:187:{18,35}, generators/saturn/src/main/scala/exu/PermuteUnit.scala:33:38, :35:{54,79}, :36:{39,61}]
  wire [3:0]       elem_eidx = rgather ? io_pipe_0_bits_rvs1_data[3:0] : io_pipe_0_bits_eidx[3:0];	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14, generators/saturn/src/main/scala/exu/PermuteUnit.scala:36:61, :40:22]
  wire [15:0][7:0] _GEN = {{io_pipe_0_bits_rvs2_data[127:120]}, {io_pipe_0_bits_rvs2_data[119:112]}, {io_pipe_0_bits_rvs2_data[111:104]}, {io_pipe_0_bits_rvs2_data[103:96]}, {io_pipe_0_bits_rvs2_data[95:88]}, {io_pipe_0_bits_rvs2_data[87:80]}, {io_pipe_0_bits_rvs2_data[79:72]}, {io_pipe_0_bits_rvs2_data[71:64]}, {io_pipe_0_bits_rvs2_data[63:56]}, {io_pipe_0_bits_rvs2_data[55:48]}, {io_pipe_0_bits_rvs2_data[47:40]}, {io_pipe_0_bits_rvs2_data[39:32]}, {io_pipe_0_bits_rvs2_data[31:24]}, {io_pipe_0_bits_rvs2_data[23:16]}, {io_pipe_0_bits_rvs2_data[15:8]}, {io_pipe_0_bits_rvs2_data[7:0]}};	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:41:33, :44:39]
  wire [7:0][15:0] _GEN_0 = {{io_pipe_0_bits_rvs2_data[127:112]}, {io_pipe_0_bits_rvs2_data[111:96]}, {io_pipe_0_bits_rvs2_data[95:80]}, {io_pipe_0_bits_rvs2_data[79:64]}, {io_pipe_0_bits_rvs2_data[63:48]}, {io_pipe_0_bits_rvs2_data[47:32]}, {io_pipe_0_bits_rvs2_data[31:16]}, {io_pipe_0_bits_rvs2_data[15:0]}};	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:41:33, :44:39]
  wire [3:0][31:0] _GEN_1 = {{io_pipe_0_bits_rvs2_data[127:96]}, {io_pipe_0_bits_rvs2_data[95:64]}, {io_pipe_0_bits_rvs2_data[63:32]}, {io_pipe_0_bits_rvs2_data[31:0]}};	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:41:33, :44:39]
  wire [3:0][63:0] _GEN_2 = {{elem_eidx[0] ? io_pipe_0_bits_rvs2_data[127:64] : io_pipe_0_bits_rvs2_data[63:0]}, {{32'h0, _GEN_1[elem_eidx[1:0]]}}, {{48'h0, _GEN_0[elem_eidx[2:0]]}}, {{56'h0, _GEN[elem_eidx]}}};	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:40:22, :41:33, :44:39, :46:25]
  wire [63:0]      splat_v = compress | io_pipe_0_bits_head | _slide1_T ? _GEN_2[io_pipe_0_bits_rvs2_eew] : result_reg;	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:31:23, :33:38, :34:40, :46:25, :47:28]
  wire [127:0]     _compress_bit_T_1 = io_pipe_0_bits_rvs1_data >> io_pipe_0_bits_eidx[6:0];	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:50:{49,72}]
  wire [8:0]       _compress_eidx_T = io_pipe_0_bits_head ? 9'h0 : result_reg[8:0];	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:31:23, :51:26, :60:34]
  wire [3:0]       shifted_mask_eidx = compress ? _compress_eidx_T[3:0] : io_pipe_0_bits_vl[3:0] - 4'h1;	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14, generators/saturn/src/main/scala/exu/PermuteUnit.scala:34:40, :51:26, :63:{30,75}]
  wire [3:0][15:0] _GEN_3 = {{{{8{shifted_mask_eidx[0]}}, {8{~(shifted_mask_eidx[0])}}}}, {{{4{&(shifted_mask_eidx[1:0])}}, {4{shifted_mask_eidx[1:0] == 2'h2}}, {4{shifted_mask_eidx[1:0] == 2'h1}}, {4{shifted_mask_eidx[1:0] == 2'h0}}}}, {{{2{&(shifted_mask_eidx[2:0])}}, {2{shifted_mask_eidx[2:0] == 3'h6}}, {2{shifted_mask_eidx[2:0] == 3'h5}}, {2{shifted_mask_eidx[2:0] == 3'h4}}, {2{shifted_mask_eidx[2:0] == 3'h3}}, {2{shifted_mask_eidx[2:0] == 3'h2}}, {2{shifted_mask_eidx[2:0] == 3'h1}}, {2{shifted_mask_eidx[2:0] == 3'h0}}}}, {16'h1 << shifted_mask_eidx}};	// @[generators/rocket-chip/src/main/scala/util/package.scala:16:47, generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7, :33:38, :63:30, :65:{20,57}, :74:8, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire [15:0]      _use_rvs1_mask_T = _slide1_T | _slide1_T_1 | _slide1_T_2 ? 16'h0 : io_pipe_0_bits_funct6[0] ? (io_pipe_0_bits_tail ? _GEN_3[io_pipe_0_bits_rvs2_eew] : 16'h0) : {8'h0, io_pipe_0_bits_head ? {4'h0, {2'h0, {1'h0, io_pipe_0_bits_rvs2_eew == 2'h0} | {2{io_pipe_0_bits_rvs2_eew == 2'h1}}} | {4{io_pipe_0_bits_rvs2_eew == 2'h2}}} | {8{&io_pipe_0_bits_rvs2_eew}} : 8'h0};	// @[generators/rocket-chip/src/main/scala/util/package.scala:16:47, :81:59, generators/saturn/src/main/scala/common/Bundles.scala:187:35, generators/saturn/src/main/scala/common/Parameters.scala:351:{8,13}, :352:13, generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7, :33:38, :65:20, :69:41, :72:24, :73:8, :74:8, :75:45, :77:26]
  wire [127:0]     use_rvs1_mask = {{8{_use_rvs1_mask_T[15]}}, {8{_use_rvs1_mask_T[14]}}, {8{_use_rvs1_mask_T[13]}}, {8{_use_rvs1_mask_T[12]}}, {8{_use_rvs1_mask_T[11]}}, {8{_use_rvs1_mask_T[10]}}, {8{_use_rvs1_mask_T[9]}}, {8{_use_rvs1_mask_T[8]}}, {8{_use_rvs1_mask_T[7]}}, {8{_use_rvs1_mask_T[6]}}, {8{_use_rvs1_mask_T[5]}}, {8{_use_rvs1_mask_T[4]}}, {8{_use_rvs1_mask_T[3]}}, {8{_use_rvs1_mask_T[2]}}, {8{_use_rvs1_mask_T[1]}}, {8{_use_rvs1_mask_T[0]}}};	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:75:{38,45}]
  wire [15:0]      wmask = _slide1_T & (_slide1_T | _slide1_T_1 | _slide1_T_2 ? _rgather_WIRE_1 : 7'h40) == 7'h27 ? 16'hFFFF : compress ? (_compress_bit_T_1[0] ? _GEN_3[io_pipe_0_bits_rvs2_eew] : 16'h0) : io_pipe_0_bits_wmask;	// @[generators/rocket-chip/src/main/scala/util/package.scala:16:47, :81:59, generators/saturn/src/main/scala/common/Bundles.scala:187:{18,35}, generators/saturn/src/main/scala/exu/PermuteUnit.scala:33:{38,48,73}, :34:40, :50:{49,93}, :74:8, :77:{18,26}, :78:{8,22}]
  wire [8:0]       io_write_bits_eg_off = _compress_eidx_T >> 3'h4 - {1'h0, io_pipe_0_bits_rvs2_eew};	// @[generators/rocket-chip/src/main/scala/util/package.scala:16:47, generators/saturn/src/main/scala/common/Bundles.scala:187:35, generators/saturn/src/main/scala/common/Parameters.scala:343:{20,73}, generators/saturn/src/main/scala/exu/PermuteUnit.scala:51:26, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire             _GEN_4 = io_pipe_0_valid & io_pipe_0_bits_head;	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:53:26]
  always @(posedge clock) begin	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7]
    if (_GEN_4)	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:53:26]
      wvd_reg <= io_pipe_0_bits_wvd_eg[5:1];	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:30:20, :49:71]
    if (io_pipe_0_valid & compress)	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:34:40, :59:26]
      result_reg <= {55'h0, _compress_eidx_T + {8'h0, _compress_bit_T_1[0]}};	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:31:23, :50:{49,93}, :51:26, :60:{16,34}, :65:20]
    else if (_GEN_4 & rgather)	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:36:61, :53:{26,50}]
      result_reg <= _GEN_2[io_pipe_0_bits_rvs2_eew];	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:31:23, :46:25]
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7]
      `FIRRTL_BEFORE_INITIAL	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:2];	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7]
    initial begin	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7]
        `INIT_RANDOM_PROLOG_	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7]
        for (logic [1:0] i = 2'h0; i < 2'h3; i += 2'h1) begin
          _RANDOM[i] = `RANDOM;	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7]
        end	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7]
        wvd_reg = _RANDOM[2'h0][4:0];	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7, :30:20]
        result_reg = {_RANDOM[2'h0][31:5], _RANDOM[2'h1], _RANDOM[2'h2][4:0]};	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7, :30:20, :31:23]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7]
      `FIRRTL_AFTER_INITIAL	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_iss_ready = |{&{io_iss_ready_decode_invInputs[0], io_iss_op_funct6[2], io_iss_op_funct6[3], io_iss_ready_decode_invInputs[4], io_iss_ready_decode_invInputs[5], io_iss_ready_decode_invInputs[6], io_iss_ready_decode_invInputs[7]}, &{io_iss_op_funct6[0], io_iss_op_funct6[1], io_iss_op_funct6[2], io_iss_ready_decode_invInputs[3], io_iss_op_funct6[4], io_iss_ready_decode_invInputs[5], io_iss_ready_decode_invInputs[6], io_iss_op_funct3[1], io_iss_ready_decode_invInputs[8]}, &{io_iss_ready_decode_invInputs[0], io_iss_op_funct6[2], io_iss_op_funct6[3], io_iss_ready_decode_invInputs[4], io_iss_ready_decode_invInputs[5], io_iss_op_funct3[0], io_iss_op_funct3[1], io_iss_ready_decode_invInputs[8]}, &{io_iss_op_funct6[1], io_iss_op_funct6[2], io_iss_op_funct6[3], io_iss_ready_decode_invInputs[4], io_iss_ready_decode_invInputs[5], io_iss_op_funct3[0], io_iss_op_funct3[1], io_iss_ready_decode_invInputs[8]}, &{io_iss_op_funct6[0], io_iss_op_funct6[1], io_iss_op_funct6[2], io_iss_ready_decode_invInputs[3], io_iss_ready_decode_invInputs[4], io_iss_op_funct6[5], io_iss_op_funct3[0], io_iss_op_funct3[1], io_iss_ready_decode_invInputs[8]}, &{io_iss_op_funct6[1], io_iss_op_funct6[2], io_iss_op_funct6[3], io_iss_ready_decode_invInputs[4], io_iss_ready_decode_invInputs[5], io_iss_ready_decode_invInputs[6], io_iss_op_funct3[2]}, &{io_iss_op_funct6[1], io_iss_op_funct6[2], io_iss_op_funct6[3], io_iss_ready_decode_invInputs[4], io_iss_ready_decode_invInputs[5], io_iss_ready_decode_invInputs[7], io_iss_op_funct3[2]}};	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7, src/main/scala/chisel3/util/pla.scala:78:21, :90:45, :91:29, :98:{53,70}, :114:{19,36}]
  assign io_write_valid = io_pipe_0_valid & (~compress | _compress_bit_T_1[0]);	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7, :34:40, :50:{49,93}, :87:{38,42,52}]
  assign io_write_bits_eg = compress ? {io_pipe_0_bits_head ? io_pipe_0_bits_wvd_eg[5:1] : wvd_reg, 1'h0} + io_write_bits_eg_off[5:0] : io_pipe_0_bits_wvd_eg;	// @[generators/saturn/src/main/scala/common/Bundles.scala:187:35, generators/saturn/src/main/scala/common/Parameters.scala:343:20, :344:10, generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7, :30:20, :34:40, :49:{25,71}, :88:26]
  assign io_write_bits_data = rgather | compress ? (io_pipe_0_bits_rvs2_eew == 2'h0 ? {2{{2{{2{{2{splat_v[7:0]}}}}}}}} : 128'h0) | (io_pipe_0_bits_rvs2_eew == 2'h1 ? {2{{2{{2{splat_v[15:0]}}}}}} : 128'h0) | (io_pipe_0_bits_rvs2_eew == 2'h2 ? {2{{2{splat_v[31:0]}}}} : 128'h0) | ((&io_pipe_0_bits_rvs2_eew) ? {2{splat_v}} : 128'h0) : io_pipe_0_bits_rvs2_data & ~use_rvs1_mask | io_pipe_0_bits_rvs1_data & use_rvs1_mask;	// @[generators/saturn/src/main/scala/common/Parameters.scala:360:{53,67}, generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7, :34:40, :36:61, :46:25, :47:28, :75:38, :92:{28,37}, :94:{32,34,50,79}, src/main/scala/chisel3/util/Mux.scala:30:73, :32:36]
  assign io_write_bits_mask = {{8{wmask[15]}}, {8{wmask[14]}}, {8{wmask[13]}}, {8{wmask[12]}}, {8{wmask[11]}}, {8{wmask[10]}}, {8{wmask[9]}}, {8{wmask[8]}}, {8{wmask[7]}}, {8{wmask[6]}}, {8{wmask[5]}}, {8{wmask[4]}}, {8{wmask[3]}}, {8{wmask[2]}}, {8{wmask[1]}}, {8{wmask[0]}}};	// @[generators/saturn/src/main/scala/exu/PermuteUnit.scala:24:7, :77:18, :91:40]
endmodule
