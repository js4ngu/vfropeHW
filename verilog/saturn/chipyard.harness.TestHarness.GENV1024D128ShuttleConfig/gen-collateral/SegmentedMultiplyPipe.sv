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

module SegmentedMultiplyPipe(	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7]
  input          clock,	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7]
  input  [2:0]   io_iss_op_funct3,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [5:0]   io_iss_op_funct6,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  output         io_iss_ready,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  output         io_set_vxsat,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  output         io_write_valid,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  output [7:0]   io_write_bits_eg,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  output [127:0] io_write_bits_data,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  output [127:0] io_write_bits_mask,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input          io_pipe_0_valid,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [127:0] io_pipe_0_bits_rvs1_data,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [127:0] io_pipe_0_bits_rvs2_data,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [127:0] io_pipe_0_bits_rvd_data,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [1:0]   io_pipe_0_bits_rvs1_eew,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [2:0]   io_pipe_0_bits_funct3,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [5:0]   io_pipe_0_bits_funct6,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input          io_pipe_1_valid,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [9:0]   io_pipe_1_bits_eidx,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [127:0] io_pipe_1_bits_rvs2_data,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [127:0] io_pipe_1_bits_rvd_data,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [1:0]   io_pipe_1_bits_rvs1_eew,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [1:0]   io_pipe_1_bits_vd_eew,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [15:0]  io_pipe_1_bits_wmask,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [2:0]   io_pipe_1_bits_funct3,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [2:0]   io_pipe_1_bits_rm,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input          io_pipe_2_valid,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [15:0]  io_pipe_2_bits_wmask,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [7:0]   io_pipe_2_bits_wvd_eg	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
);

  wire [7:0]        _adder_arr_io_out_0;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:96:25]
  wire [7:0]        _adder_arr_io_out_1;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:96:25]
  wire [7:0]        _adder_arr_io_out_2;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:96:25]
  wire [7:0]        _adder_arr_io_out_3;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:96:25]
  wire [7:0]        _adder_arr_io_out_4;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:96:25]
  wire [7:0]        _adder_arr_io_out_5;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:96:25]
  wire [7:0]        _adder_arr_io_out_6;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:96:25]
  wire [7:0]        _adder_arr_io_out_7;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:96:25]
  wire [7:0]        _adder_arr_io_out_8;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:96:25]
  wire [7:0]        _adder_arr_io_out_9;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:96:25]
  wire [7:0]        _adder_arr_io_out_10;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:96:25]
  wire [7:0]        _adder_arr_io_out_11;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:96:25]
  wire [7:0]        _adder_arr_io_out_12;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:96:25]
  wire [7:0]        _adder_arr_io_out_13;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:96:25]
  wire [7:0]        _adder_arr_io_out_14;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:96:25]
  wire [7:0]        _adder_arr_io_out_15;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:96:25]
  wire [127:0]      _smul_arr_io_clipped;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:89:26]
  wire [15:0]       _smul_arr_io_sat;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:89:26]
  wire [127:0]      _multipliers_1_io_out_data;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:52:48]
  wire [127:0]      _multipliers_0_io_out_data;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:52:48]
  wire [4:0]        _GEN = ~(io_iss_op_funct6[4:0]);	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14, src/main/scala/chisel3/util/pla.scala:78:21]
  wire [4:0]        _GEN_0 = ~(io_pipe_0_bits_funct6[4:0]);	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14, src/main/scala/chisel3/util/pla.scala:78:21]
  wire [1:0]        _decode_andMatrixOutputs_T_1 = {_GEN_0[2], _GEN_0[4]};	// @[src/main/scala/chisel3/util/pla.scala:78:21, :91:29, :98:53]
  wire [3:0]        _decode_orMatrixOutputs_T_6 = {&{io_pipe_0_bits_funct6[0], _GEN_0[1]}, &{io_pipe_0_bits_funct6[0], _GEN_0[2]}, &{io_pipe_0_bits_funct6[0], _GEN_0[3]}, &{_GEN_0[0], io_pipe_0_bits_funct6[1]}};	// @[src/main/scala/chisel3/util/pla.scala:78:21, :90:45, :91:29, :98:{53,70}, :114:19]
  wire [127:0]      _multipliers_1_io_in2_WIRE_1 = (&_decode_andMatrixOutputs_T_1) ? io_pipe_0_bits_rvd_data : io_pipe_0_bits_rvs2_data;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:50:20, src/main/scala/chisel3/util/pla.scala:98:{53,70}]
  reg  [255:0]      mul_out_pipe_b;	// @[src/main/scala/chisel3/util/Valid.scala:142:26]
  reg               ctrl_MULSub_pipe_b;	// @[src/main/scala/chisel3/util/Valid.scala:142:26]
  reg               ctrl_MULSwapVdV2_pipe_b;	// @[src/main/scala/chisel3/util/Valid.scala:142:26]
  reg               ctrl_MULAccumulate_pipe_b;	// @[src/main/scala/chisel3/util/Valid.scala:142:26]
  reg               ctrl_MULHi_pipe_b;	// @[src/main/scala/chisel3/util/Valid.scala:142:26]
  wire [9:0]        _half_sel_T_2 = io_pipe_1_bits_eidx >> 3'h4 - {1'h0, io_pipe_1_bits_vd_eew};	// @[generators/rocket-chip/src/main/scala/util/package.scala:16:47, generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16, :85:{46,64}]
  wire [3:0][127:0] _GEN_1 = {{{mul_out_pipe_b[191:128], mul_out_pipe_b[63:0]}}, {{mul_out_pipe_b[223:192], mul_out_pipe_b[159:128], mul_out_pipe_b[95:64], mul_out_pipe_b[31:0]}}, {{mul_out_pipe_b[239:224], mul_out_pipe_b[207:192], mul_out_pipe_b[175:160], mul_out_pipe_b[143:128], mul_out_pipe_b[111:96], mul_out_pipe_b[79:64], mul_out_pipe_b[47:32], mul_out_pipe_b[15:0]}}, {{mul_out_pipe_b[247:240], mul_out_pipe_b[231:224], mul_out_pipe_b[215:208], mul_out_pipe_b[199:192], mul_out_pipe_b[183:176], mul_out_pipe_b[167:160], mul_out_pipe_b[151:144], mul_out_pipe_b[135:128], mul_out_pipe_b[119:112], mul_out_pipe_b[103:96], mul_out_pipe_b[87:80], mul_out_pipe_b[71:64], mul_out_pipe_b[55:48], mul_out_pipe_b[39:32], mul_out_pipe_b[23:16], mul_out_pipe_b[7:0]}}};	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:83:{29,103}, :97:26, src/main/scala/chisel3/util/Valid.scala:142:26]
  wire [127:0]      _GEN_2 = io_pipe_1_bits_vd_eew > io_pipe_1_bits_rvs1_eew ? (_half_sel_T_2[0] ? mul_out_pipe_b[255:128] : mul_out_pipe_b[127:0]) : _GEN_1[io_pipe_1_bits_rvs1_eew];	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:69:32, :85:{46,80}, :86:{17,36}, :97:26, src/main/scala/chisel3/util/Valid.scala:142:26]
  wire [127:0]      _GEN_3 = ctrl_MULAccumulate_pipe_b ? (ctrl_MULSwapVdV2_pipe_b ? io_pipe_1_bits_rvs2_data : io_pipe_1_bits_rvd_data) : 128'h0;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:98:{26,50}, src/main/scala/chisel3/util/Valid.scala:142:26]
  reg  [127:0]      pipe_out_pipe_b;	// @[src/main/scala/chisel3/util/Valid.scala:142:26]
  reg  [15:0]       pipe_vxsat_pipe_b;	// @[src/main/scala/chisel3/util/Valid.scala:142:26]
  wire              ctrl_smul = io_pipe_1_bits_funct3 == 3'h0 | io_pipe_1_bits_funct3 == 3'h3 | io_pipe_1_bits_funct3 == 3'h4;	// @[generators/rocket-chip/src/main/scala/util/package.scala:16:47, :81:59]
  wire [3:0][127:0] _GEN_4 = {{{mul_out_pipe_b[255:192], mul_out_pipe_b[127:64]}}, {{mul_out_pipe_b[255:224], mul_out_pipe_b[191:160], mul_out_pipe_b[127:96], mul_out_pipe_b[63:32]}}, {{mul_out_pipe_b[255:240], mul_out_pipe_b[223:208], mul_out_pipe_b[191:176], mul_out_pipe_b[159:144], mul_out_pipe_b[127:112], mul_out_pipe_b[95:80], mul_out_pipe_b[63:48], mul_out_pipe_b[31:16]}}, {{mul_out_pipe_b[255:248], mul_out_pipe_b[239:232], mul_out_pipe_b[223:216], mul_out_pipe_b[207:200], mul_out_pipe_b[191:184], mul_out_pipe_b[175:168], mul_out_pipe_b[159:152], mul_out_pipe_b[143:136], mul_out_pipe_b[127:120], mul_out_pipe_b[111:104], mul_out_pipe_b[95:88], mul_out_pipe_b[79:72], mul_out_pipe_b[63:56], mul_out_pipe_b[47:40], mul_out_pipe_b[31:24], mul_out_pipe_b[15:8]}}};	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:80:{29,103}, :110:52, src/main/scala/chisel3/util/Valid.scala:142:26]
  always @(posedge clock) begin	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7]
    if (io_pipe_0_valid) begin	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
      mul_out_pipe_b <= {_multipliers_1_io_out_data, _multipliers_0_io_out_data};	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:52:48, :60:62, src/main/scala/chisel3/util/Valid.scala:142:26]
      ctrl_MULSub_pipe_b <= &{io_pipe_0_bits_funct6[1], io_pipe_0_bits_funct6[3], _GEN_0[4]};	// @[src/main/scala/chisel3/util/Valid.scala:142:26, src/main/scala/chisel3/util/pla.scala:78:21, :90:45, :91:29, :98:{53,70}]
      ctrl_MULSwapVdV2_pipe_b <= &_decode_andMatrixOutputs_T_1;	// @[src/main/scala/chisel3/util/Valid.scala:142:26, src/main/scala/chisel3/util/pla.scala:98:{53,70}]
      ctrl_MULAccumulate_pipe_b <= |{&_decode_andMatrixOutputs_T_1, &{io_pipe_0_bits_funct6[2], io_pipe_0_bits_funct6[3]}};	// @[src/main/scala/chisel3/util/Valid.scala:142:26, src/main/scala/chisel3/util/pla.scala:90:45, :98:{53,70}, :114:{19,36}]
      ctrl_MULHi_pipe_b <= |{&{_GEN_0[0], _GEN_0[3]}, &{io_pipe_0_bits_funct6[1], _GEN_0[3], io_pipe_0_bits_funct3[1]}};	// @[src/main/scala/chisel3/util/Valid.scala:142:26, src/main/scala/chisel3/util/pla.scala:78:21, :90:45, :91:29, :98:{53,70}, :114:{19,36}]
    end
    if (io_pipe_1_valid) begin	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
      pipe_out_pipe_b <= (ctrl_smul ? _smul_arr_io_clipped : 128'h0) | (ctrl_MULHi_pipe_b ? _GEN_4[io_pipe_1_bits_rvs1_eew] : 128'h0) | (ctrl_smul | ctrl_MULHi_pipe_b ? 128'h0 : {_adder_arr_io_out_15, _adder_arr_io_out_14, _adder_arr_io_out_13, _adder_arr_io_out_12, _adder_arr_io_out_11, _adder_arr_io_out_10, _adder_arr_io_out_9, _adder_arr_io_out_8, _adder_arr_io_out_7, _adder_arr_io_out_6, _adder_arr_io_out_5, _adder_arr_io_out_4, _adder_arr_io_out_3, _adder_arr_io_out_2, _adder_arr_io_out_1, _adder_arr_io_out_0});	// @[generators/rocket-chip/src/main/scala/util/package.scala:81:59, generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:89:26, :96:25, :98:26, :110:{16,52,74,79,115}, src/main/scala/chisel3/util/Valid.scala:142:26]
      pipe_vxsat_pipe_b <= (ctrl_smul ? _smul_arr_io_sat : 16'h0) & io_pipe_1_bits_wmask;	// @[generators/rocket-chip/src/main/scala/util/package.scala:81:59, generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:89:26, :100:27, :113:{18,45}, src/main/scala/chisel3/util/Valid.scala:142:26]
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7]
      `FIRRTL_BEFORE_INITIAL	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:12];	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7]
    initial begin	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7]
        `INIT_RANDOM_PROLOG_	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7]
        for (logic [3:0] i = 4'h0; i < 4'hD; i += 4'h1) begin
          _RANDOM[i] = `RANDOM;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7]
        end	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7]
        mul_out_pipe_b = {_RANDOM[4'h0][31:1], _RANDOM[4'h1], _RANDOM[4'h2], _RANDOM[4'h3], _RANDOM[4'h4], _RANDOM[4'h5], _RANDOM[4'h6], _RANDOM[4'h7], _RANDOM[4'h8][0]};	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7, src/main/scala/chisel3/util/Valid.scala:142:26]
        ctrl_MULSub_pipe_b = _RANDOM[4'h8][2];	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7, src/main/scala/chisel3/util/Valid.scala:142:26]
        ctrl_MULSwapVdV2_pipe_b = _RANDOM[4'h8][4];	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7, src/main/scala/chisel3/util/Valid.scala:142:26]
        ctrl_MULAccumulate_pipe_b = _RANDOM[4'h8][6];	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7, src/main/scala/chisel3/util/Valid.scala:142:26]
        ctrl_MULHi_pipe_b = _RANDOM[4'h8][8];	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7, src/main/scala/chisel3/util/Valid.scala:142:26]
        pipe_out_pipe_b = {_RANDOM[4'h8][31:10], _RANDOM[4'h9], _RANDOM[4'hA], _RANDOM[4'hB], _RANDOM[4'hC][9:0]};	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7, src/main/scala/chisel3/util/Valid.scala:142:26]
        pipe_vxsat_pipe_b = _RANDOM[4'hC][26:11];	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7, src/main/scala/chisel3/util/Valid.scala:142:26]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7]
      `FIRRTL_AFTER_INITIAL	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  MultiplyBlock multipliers_0 (	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:52:48]
    .io_in1_signed (io_pipe_0_bits_funct6[0]),	// @[src/main/scala/chisel3/util/pla.scala:90:45]
    .io_in2_signed (|_decode_orMatrixOutputs_T_6),	// @[src/main/scala/chisel3/util/pla.scala:114:{19,36}]
    .io_eew        (io_pipe_0_bits_rvs1_eew),
    .io_in1        (io_pipe_0_bits_rvs1_data[63:0]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:57:53]
    .io_in2        (_multipliers_1_io_in2_WIRE_1[63:0]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:50:20, :58:53]
    .io_out_data   (_multipliers_0_io_out_data)
  );
  MultiplyBlock multipliers_1 (	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:52:48]
    .io_in1_signed (io_pipe_0_bits_funct6[0]),	// @[src/main/scala/chisel3/util/pla.scala:90:45]
    .io_in2_signed (|_decode_orMatrixOutputs_T_6),	// @[src/main/scala/chisel3/util/pla.scala:114:{19,36}]
    .io_eew        (io_pipe_0_bits_rvs1_eew),
    .io_in1        (io_pipe_0_bits_rvs1_data[127:64]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:57:53]
    .io_in2        (_multipliers_1_io_in2_WIRE_1[127:64]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:50:20, :58:53]
    .io_out_data   (_multipliers_1_io_out_data)
  );
  VectorSMul smul_arr (	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:89:26]
    .io_eew     (io_pipe_1_bits_vd_eew),
    .io_vxrm    (io_pipe_1_bits_rm[1:0]),	// @[generators/saturn/src/main/scala/common/Bundles.scala:207:16]
    .io_mul_in  (mul_out_pipe_b),	// @[src/main/scala/chisel3/util/Valid.scala:142:26]
    .io_clipped (_smul_arr_io_clipped),
    .io_sat     (_smul_arr_io_sat)
  );
  AdderArray adder_arr (	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:96:25]
    .io_in1_0      (_GEN_2[7:0]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:97:{26,56}]
    .io_in1_1      (_GEN_2[15:8]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:97:{26,56}]
    .io_in1_2      (_GEN_2[23:16]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:97:{26,56}]
    .io_in1_3      (_GEN_2[31:24]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:97:{26,56}]
    .io_in1_4      (_GEN_2[39:32]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:97:{26,56}]
    .io_in1_5      (_GEN_2[47:40]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:97:{26,56}]
    .io_in1_6      (_GEN_2[55:48]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:97:{26,56}]
    .io_in1_7      (_GEN_2[63:56]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:97:{26,56}]
    .io_in1_8      (_GEN_2[71:64]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:97:{26,56}]
    .io_in1_9      (_GEN_2[79:72]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:97:{26,56}]
    .io_in1_10     (_GEN_2[87:80]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:97:{26,56}]
    .io_in1_11     (_GEN_2[95:88]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:97:{26,56}]
    .io_in1_12     (_GEN_2[103:96]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:97:{26,56}]
    .io_in1_13     (_GEN_2[111:104]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:97:{26,56}]
    .io_in1_14     (_GEN_2[119:112]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:97:{26,56}]
    .io_in1_15     (_GEN_2[127:120]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:97:{26,56}]
    .io_in2_0      (_GEN_3[7:0]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:98:{26,116}]
    .io_in2_1      (_GEN_3[15:8]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:98:{26,116}]
    .io_in2_2      (_GEN_3[23:16]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:98:{26,116}]
    .io_in2_3      (_GEN_3[31:24]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:98:{26,116}]
    .io_in2_4      (_GEN_3[39:32]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:98:{26,116}]
    .io_in2_5      (_GEN_3[47:40]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:98:{26,116}]
    .io_in2_6      (_GEN_3[55:48]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:98:{26,116}]
    .io_in2_7      (_GEN_3[63:56]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:98:{26,116}]
    .io_in2_8      (_GEN_3[71:64]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:98:{26,116}]
    .io_in2_9      (_GEN_3[79:72]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:98:{26,116}]
    .io_in2_10     (_GEN_3[87:80]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:98:{26,116}]
    .io_in2_11     (_GEN_3[95:88]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:98:{26,116}]
    .io_in2_12     (_GEN_3[103:96]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:98:{26,116}]
    .io_in2_13     (_GEN_3[111:104]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:98:{26,116}]
    .io_in2_14     (_GEN_3[119:112]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:98:{26,116}]
    .io_in2_15     (_GEN_3[127:120]),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:98:{26,116}]
    .io_incr_0     (1'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16]
    .io_incr_1     (1'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16]
    .io_incr_2     (1'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16]
    .io_incr_3     (1'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16]
    .io_incr_4     (1'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16]
    .io_incr_5     (1'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16]
    .io_incr_6     (1'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16]
    .io_incr_7     (1'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16]
    .io_incr_8     (1'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16]
    .io_incr_9     (1'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16]
    .io_incr_10    (1'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16]
    .io_incr_11    (1'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16]
    .io_incr_12    (1'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16]
    .io_incr_13    (1'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16]
    .io_incr_14    (1'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16]
    .io_incr_15    (1'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16]
    .io_mask_carry (16'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:100:27]
    .io_signed     (1'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16]
    .io_eew        (io_pipe_1_bits_vd_eew),
    .io_avg        (1'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16]
    .io_rm         (2'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:104:19]
    .io_sub        (ctrl_MULSub_pipe_b),	// @[src/main/scala/chisel3/util/Valid.scala:142:26]
    .io_cmask      (1'h0),	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:35:16]
    .io_out_0      (_adder_arr_io_out_0),
    .io_out_1      (_adder_arr_io_out_1),
    .io_out_2      (_adder_arr_io_out_2),
    .io_out_3      (_adder_arr_io_out_3),
    .io_out_4      (_adder_arr_io_out_4),
    .io_out_5      (_adder_arr_io_out_5),
    .io_out_6      (_adder_arr_io_out_6),
    .io_out_7      (_adder_arr_io_out_7),
    .io_out_8      (_adder_arr_io_out_8),
    .io_out_9      (_adder_arr_io_out_9),
    .io_out_10     (_adder_arr_io_out_10),
    .io_out_11     (_adder_arr_io_out_11),
    .io_out_12     (_adder_arr_io_out_12),
    .io_out_13     (_adder_arr_io_out_13),
    .io_out_14     (_adder_arr_io_out_14),
    .io_out_15     (_adder_arr_io_out_15),
    .io_carry_0    (/* unused */),
    .io_carry_1    (/* unused */),
    .io_carry_2    (/* unused */),
    .io_carry_3    (/* unused */),
    .io_carry_4    (/* unused */),
    .io_carry_5    (/* unused */),
    .io_carry_6    (/* unused */),
    .io_carry_7    (/* unused */),
    .io_carry_8    (/* unused */),
    .io_carry_9    (/* unused */),
    .io_carry_10   (/* unused */),
    .io_carry_11   (/* unused */),
    .io_carry_12   (/* unused */),
    .io_carry_13   (/* unused */),
    .io_carry_14   (/* unused */),
    .io_carry_15   (/* unused */)
  );
  assign io_iss_ready = |{&{io_iss_op_funct6[0], io_iss_op_funct6[1], io_iss_op_funct6[2], _GEN[3], _GEN[4], io_iss_op_funct6[5], ~(io_iss_op_funct3[0])}, &{io_iss_op_funct6[2], _GEN[3], _GEN[4], io_iss_op_funct6[5], ~(io_iss_op_funct3[0]), io_iss_op_funct3[1]}, &{io_iss_op_funct6[0], io_iss_op_funct6[3], _GEN[4], io_iss_op_funct6[5], ~(io_iss_op_funct3[0]), io_iss_op_funct3[1]}, &{io_iss_op_funct6[0], io_iss_op_funct6[1], io_iss_op_funct6[3], io_iss_op_funct6[5], ~(io_iss_op_funct3[0]), io_iss_op_funct3[1]}, &{io_iss_op_funct6[0], io_iss_op_funct6[2], io_iss_op_funct6[3], io_iss_op_funct6[5], ~(io_iss_op_funct3[0]), io_iss_op_funct3[1]}, &{_GEN[0], io_iss_op_funct6[3], io_iss_op_funct6[4], io_iss_op_funct6[5], ~(io_iss_op_funct3[0]), io_iss_op_funct3[1]}};	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14, generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7, src/main/scala/chisel3/util/pla.scala:78:21, :90:45, :91:29, :98:{53,70}, :114:{19,36}]
  assign io_set_vxsat = io_pipe_2_valid & (|pipe_vxsat_pipe_b);	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7, :122:{42,57}, src/main/scala/chisel3/util/Valid.scala:142:26]
  assign io_write_valid = io_pipe_2_valid;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7]
  assign io_write_bits_eg = io_pipe_2_bits_wvd_eg;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7]
  assign io_write_bits_data = pipe_out_pipe_b;	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7, src/main/scala/chisel3/util/Valid.scala:142:26]
  assign io_write_bits_mask = {{8{io_pipe_2_bits_wmask[15]}}, {8{io_pipe_2_bits_wmask[14]}}, {8{io_pipe_2_bits_wmask[13]}}, {8{io_pipe_2_bits_wmask[12]}}, {8{io_pipe_2_bits_wmask[11]}}, {8{io_pipe_2_bits_wmask[10]}}, {8{io_pipe_2_bits_wmask[9]}}, {8{io_pipe_2_bits_wmask[8]}}, {8{io_pipe_2_bits_wmask[7]}}, {8{io_pipe_2_bits_wmask[6]}}, {8{io_pipe_2_bits_wmask[5]}}, {8{io_pipe_2_bits_wmask[4]}}, {8{io_pipe_2_bits_wmask[3]}}, {8{io_pipe_2_bits_wmask[2]}}, {8{io_pipe_2_bits_wmask[1]}}, {8{io_pipe_2_bits_wmask[0]}}};	// @[generators/saturn/src/main/scala/exu/int/SegmentedMultiplyPipe.scala:31:7, :120:40]
endmodule

