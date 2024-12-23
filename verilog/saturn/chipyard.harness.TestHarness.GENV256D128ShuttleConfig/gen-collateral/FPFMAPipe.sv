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

module FPFMAPipe(	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:106:7]
  input          clock,	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:106:7]
  input          reset,	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:106:7]
  input  [2:0]   io_iss_op_funct3,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [5:0]   io_iss_op_funct6,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  output         io_iss_ready,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  output         io_set_fflags_valid,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  output [4:0]   io_set_fflags_bits,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  output         io_write_valid,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  output [5:0]   io_write_bits_eg,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  output [127:0] io_write_bits_data,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  output [127:0] io_write_bits_mask,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input          io_pipe_0_valid,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [7:0]   io_pipe_0_bits_eidx,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [127:0] io_pipe_0_bits_rvs1_data,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [127:0] io_pipe_0_bits_rvs2_data,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [127:0] io_pipe_0_bits_rvd_data,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [1:0]   io_pipe_0_bits_rvs1_eew,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [1:0]   io_pipe_0_bits_rvs2_eew,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [1:0]   io_pipe_0_bits_vd_eew,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [15:0]  io_pipe_0_bits_wmask,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [2:0]   io_pipe_0_bits_funct3,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [5:0]   io_pipe_0_bits_funct6,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input          io_pipe_0_bits_acc,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [2:0]   io_pipe_0_bits_rm,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input          io_pipe_3_valid,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [15:0]  io_pipe_3_bits_wmask,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
  input  [5:0]   io_pipe_3_bits_wvd_eg	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14]
);

  wire [63:0]      _TandemFMAPipe_1_io_out;	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:134:46]
  wire [4:0]       _TandemFMAPipe_1_io_exc;	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:134:46]
  wire [63:0]      _TandemFMAPipe_io_out;	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:134:46]
  wire [4:0]       _TandemFMAPipe_io_exc;	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:134:46]
  wire [1:0]       _GEN = ~(io_iss_op_funct3[2:1]);	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14, src/main/scala/chisel3/util/pla.scala:78:21]
  wire [5:0]       _GEN_0 = ~io_iss_op_funct6;	// @[src/main/scala/chisel3/util/pla.scala:78:21]
  wire [4:0]       _GEN_1 = ~(io_pipe_0_bits_funct6[4:0]);	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14, src/main/scala/chisel3/util/pla.scala:78:21]
  wire [1:0]       _decode_andMatrixOutputs_T_3 = {io_pipe_0_bits_funct6[0], io_pipe_0_bits_funct6[2]};	// @[src/main/scala/chisel3/util/pla.scala:90:45, :98:53]
  wire [2:0]       _decode_andMatrixOutputs_T_4 = {_GEN_1[2], io_pipe_0_bits_funct6[3], _GEN_1[4]};	// @[src/main/scala/chisel3/util/pla.scala:78:21, :90:45, :91:29, :98:53]
  wire [1:0]       _decode_orMatrixOutputs_T_7 = {&{_GEN_1[0], io_pipe_0_bits_funct6[2], _GEN_1[4]}, io_pipe_0_bits_funct6[3]};	// @[src/main/scala/chisel3/util/pla.scala:78:21, :90:45, :91:29, :98:{53,70}, :114:19]
  wire [3:0]       _decode_orMatrixOutputs_T_9 = {&{_GEN_1[2], _GEN_1[4]}, &_decode_andMatrixOutputs_T_3, &{io_pipe_0_bits_funct6[2], io_pipe_0_bits_funct6[3]}, &{_GEN_1[3], io_pipe_0_bits_funct6[4]}};	// @[src/main/scala/chisel3/util/pla.scala:78:21, :90:45, :91:29, :98:{53,70}, :114:19]
  wire [1:0]       decoded_3 = {|{&_decode_andMatrixOutputs_T_3, &{io_pipe_0_bits_funct6[0], io_pipe_0_bits_funct6[3]}}, |{&{_GEN_1[0], io_pipe_0_bits_funct6[1]}, &{io_pipe_0_bits_funct6[0], _GEN_1[1], io_pipe_0_bits_funct6[3]}}};	// @[generators/saturn/src/main/scala/insns/Decode.scala:34:88, src/main/scala/chisel3/util/pla.scala:78:21, :90:45, :91:29, :98:{53,70}, :114:{19,36}]
  wire [1:0]       eidx = io_pipe_0_bits_acc ? 2'h0 : io_pipe_0_bits_eidx[1:0];	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:49:14, generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:125:17, :203:24]
  wire [3:0][31:0] _GEN_2 = {{io_pipe_0_bits_rvs1_data[127:96]}, {io_pipe_0_bits_rvs1_data[95:64]}, {io_pipe_0_bits_rvs1_data[63:32]}, {io_pipe_0_bits_rvs1_data[31:0]}};	// @[generators/saturn/src/main/scala/common/Parameters.scala:373:61, :375:11]
  wire             _GEN_3 = io_pipe_0_bits_rvs1_eew == io_pipe_0_bits_vd_eew;	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:120:32, :136:23]
  wire [63:0]      fma_pipes_rs1_bits = _GEN_3 ? io_pipe_0_bits_rvs1_data[63:0] : {32'h0, _GEN_2[eidx]};	// @[generators/saturn/src/main/scala/common/Parameters.scala:369:25, :375:11, generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:120:32, :125:17, :130:52, :136:23]
  wire [3:0][31:0] _GEN_4 = {{io_pipe_0_bits_rvs2_data[127:96]}, {io_pipe_0_bits_rvs2_data[95:64]}, {io_pipe_0_bits_rvs2_data[63:32]}, {io_pipe_0_bits_rvs2_data[31:0]}};	// @[generators/saturn/src/main/scala/common/Parameters.scala:373:61, :375:11]
  wire             _GEN_5 = io_pipe_0_bits_rvs2_eew == io_pipe_0_bits_vd_eew;	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:119:32, :138:23]
  wire [63:0]      fma_pipes_vs2_bits = _GEN_5 ? io_pipe_0_bits_rvs2_data[63:0] : {32'h0, _GEN_4[eidx]};	// @[generators/saturn/src/main/scala/common/Parameters.scala:369:25, :375:11, generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:119:32, :125:17, :131:52, :138:23]
  wire             _fma_pipes_T_34 = io_pipe_0_bits_rvs1_eew == 2'h1;	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:126:67, :140:35]
  wire             _fma_pipes_T_30 = io_pipe_0_bits_rvs1_eew != 2'h3;	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:140:76, src/main/scala/chisel3/util/pla.scala:98:70]
  wire             _fma_pipes_T_23 = (|_decode_orMatrixOutputs_T_7) & (|_decode_orMatrixOutputs_T_9);	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:147:28, src/main/scala/chisel3/util/pla.scala:114:{19,36}]
  wire [1:0]       _GEN_6 = (&_decode_andMatrixOutputs_T_4) ? io_pipe_0_bits_vd_eew : io_pipe_0_bits_rvs2_eew;	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:150:36, :152:27, :157:27, src/main/scala/chisel3/util/pla.scala:98:{53,70}]
  wire [1:0]       _GEN_7 = (&_decode_andMatrixOutputs_T_4) ? io_pipe_0_bits_rvs2_eew : io_pipe_0_bits_vd_eew;	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:150:36, :154:27, :159:27, src/main/scala/chisel3/util/pla.scala:98:{53,70}]
  wire             _GEN_8 = (|_decode_orMatrixOutputs_T_7) | (|_decode_orMatrixOutputs_T_9);	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:163:34, :164:25, :172:34, :173:25, :180:25, src/main/scala/chisel3/util/pla.scala:114:{19,36}]
  wire [1:0]       _GEN_9 = _GEN_8 ? io_pipe_0_bits_rvs2_eew : 2'h0;	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:163:34, :164:25, :165:25, :172:34, :173:25, :174:25, :180:25, :181:25, :203:24]
  wire [63:0]      _GEN_10 = (|_decode_orMatrixOutputs_T_9) ? {2'h0, ((&io_pipe_0_bits_vd_eew) ? 62'h3FF0000000000000 : 62'h0) | (io_pipe_0_bits_vd_eew == 2'h2 ? 62'h3F8000003F800000 : 62'h0) | (io_pipe_0_bits_vd_eew == 2'h1 ? 62'h3C003C003C003C00 : 62'h0)} : 64'h0;	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:126:{35,51,67}, :172:34, :175:25, :182:25, :203:24, src/main/scala/chisel3/util/Mux.scala:30:73, src/main/scala/chisel3/util/pla.scala:114:{19,36}]
  wire             _GEN_11 = _fma_pipes_T_23 | (|_decode_orMatrixOutputs_T_7);	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:147:{28,49}, :148:25, :163:34, :166:25, :172:34, src/main/scala/chisel3/util/pla.scala:114:{19,36}]
  wire [1:0]       _GEN_12 = (|_decode_orMatrixOutputs_T_9) ? io_pipe_0_bits_vd_eew : 2'h0;	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:172:34, :176:25, :183:25, :203:24, src/main/scala/chisel3/util/pla.scala:114:{19,36}]
  wire             _GEN_13 = (|_decode_orMatrixOutputs_T_7) | ~(|_decode_orMatrixOutputs_T_9);	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:163:34, :168:25, :172:34, src/main/scala/chisel3/util/pla.scala:114:{19,36}]
  wire [1:0]       _GEN_14 = (|_decode_orMatrixOutputs_T_7) ? io_pipe_0_bits_rvs2_eew : (|_decode_orMatrixOutputs_T_9) ? io_pipe_0_bits_rvs1_eew : 2'h0;	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:163:34, :169:25, :172:34, :178:25, :185:25, :203:24, src/main/scala/chisel3/util/pla.scala:114:{19,36}]
  wire [1:0]       _fma_pipes_widening_vs2_bits_T_6 = eidx + 2'h1;	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:125:17, :126:67, :135:78]
  wire [3:0][31:0] _GEN_15 = {{io_pipe_0_bits_rvs1_data[127:96]}, {io_pipe_0_bits_rvs1_data[95:64]}, {io_pipe_0_bits_rvs1_data[63:32]}, {io_pipe_0_bits_rvs1_data[31:0]}};	// @[generators/saturn/src/main/scala/common/Parameters.scala:373:61, :375:11]
  wire [63:0]      fma_pipes_rs1_bits_1 = _GEN_3 ? io_pipe_0_bits_rvs1_data[127:64] : {32'h0, _GEN_15[_fma_pipes_widening_vs2_bits_T_6]};	// @[generators/saturn/src/main/scala/common/Parameters.scala:369:25, :375:11, generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:120:32, :130:52, :135:78, :136:23]
  wire [3:0][31:0] _GEN_16 = {{io_pipe_0_bits_rvs2_data[127:96]}, {io_pipe_0_bits_rvs2_data[95:64]}, {io_pipe_0_bits_rvs2_data[63:32]}, {io_pipe_0_bits_rvs2_data[31:0]}};	// @[generators/saturn/src/main/scala/common/Parameters.scala:373:61, :375:11]
  wire [63:0]      fma_pipes_vs2_bits_1 = _GEN_5 ? io_pipe_0_bits_rvs2_data[127:64] : {32'h0, _GEN_16[_fma_pipes_widening_vs2_bits_T_6]};	// @[generators/saturn/src/main/scala/common/Parameters.scala:369:25, :375:11, generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:119:32, :131:52, :135:78, :138:23]
  wire             _fma_pipes_T_50 = (|_decode_orMatrixOutputs_T_7) & (|_decode_orMatrixOutputs_T_9);	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:147:28, src/main/scala/chisel3/util/pla.scala:114:{19,36}]
  wire             _GEN_17 = _fma_pipes_T_50 | (|_decode_orMatrixOutputs_T_7);	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:147:{28,49}, :148:25, :163:34, :166:25, :172:34, src/main/scala/chisel3/util/pla.scala:114:{19,36}]
  TandemFMAPipe TandemFMAPipe (	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:134:46]
    .clock      (clock),
    .reset      (reset),
    .io_valid   (io_pipe_0_valid),
    .io_frm     (io_pipe_0_bits_rm),
    .io_addsub  ((|_decode_orMatrixOutputs_T_9) & ~(|_decode_orMatrixOutputs_T_7)),	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:142:{44,47}, src/main/scala/chisel3/util/pla.scala:114:{19,36}]
    .io_mul     ((|_decode_orMatrixOutputs_T_7) & ~(|_decode_orMatrixOutputs_T_9)),	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:143:{41,44}, src/main/scala/chisel3/util/pla.scala:114:{19,36}]
    .io_op      (decoded_3),	// @[generators/saturn/src/main/scala/insns/Decode.scala:34:88]
    .io_a_eew   (_fma_pipes_T_23 ? _GEN_6 : _GEN_9),	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:147:{28,49}, :150:36, :152:27, :157:27, :163:34, :165:25, :172:34, :174:25, :181:25]
    .io_b_eew   (_GEN_11 ? io_pipe_0_bits_rvs1_eew : _GEN_12),	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:147:49, :148:25, :149:25, :163:34, :166:25, :167:25, :172:34, :176:25, :183:25]
    .io_c_eew   (_fma_pipes_T_23 ? _GEN_7 : _GEN_14),	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:147:{28,49}, :150:36, :154:27, :159:27, :163:34, :169:25, :172:34]
    .io_out_eew (io_pipe_0_bits_vd_eew),
    .io_a       (_fma_pipes_T_23 ? ((&_decode_andMatrixOutputs_T_4) ? io_pipe_0_bits_rvd_data[63:0] : fma_pipes_vs2_bits) : _GEN_8 ? fma_pipes_vs2_bits : 64'h0),	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:119:32, :132:50, :138:23, :147:{28,49}, :150:36, :151:27, :156:27, :163:34, :164:25, :172:34, :173:25, :180:25, :203:24, src/main/scala/chisel3/util/pla.scala:98:{53,70}]
    .io_b       (_GEN_11 ? fma_pipes_rs1_bits : _GEN_10),	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:120:32, :136:23, :147:49, :148:25, :163:34, :166:25, :172:34, :175:25, :182:25]
    .io_c       (_fma_pipes_T_23 ? ((&_decode_andMatrixOutputs_T_4) ? fma_pipes_vs2_bits : io_pipe_0_bits_rvd_data[63:0]) : _GEN_13 ? 64'h0 : fma_pipes_rs1_bits),	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:119:32, :120:32, :132:50, :136:23, :138:23, :147:{28,49}, :150:36, :153:27, :158:27, :163:34, :168:25, :172:34, :203:24, src/main/scala/chisel3/util/pla.scala:98:{53,70}]
    .io_mask    ({_fma_pipes_T_34 & io_pipe_0_bits_wmask[6], _fma_pipes_T_30 & io_pipe_0_bits_wmask[4], _fma_pipes_T_34 & io_pipe_0_bits_wmask[2], io_pipe_0_bits_wmask[0]}),	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:140:{35,44,52,76,84,92}, :141:{44,52,63,71}]
    .io_out     (_TandemFMAPipe_io_out),
    .io_exc     (_TandemFMAPipe_io_exc)
  );
  TandemFMAPipe TandemFMAPipe_1 (	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:134:46]
    .clock      (clock),
    .reset      (reset),
    .io_valid   (io_pipe_0_valid),
    .io_frm     (io_pipe_0_bits_rm),
    .io_addsub  ((|_decode_orMatrixOutputs_T_9) & ~(|_decode_orMatrixOutputs_T_7)),	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:142:{44,47}, src/main/scala/chisel3/util/pla.scala:114:{19,36}]
    .io_mul     ((|_decode_orMatrixOutputs_T_7) & ~(|_decode_orMatrixOutputs_T_9)),	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:143:{41,44}, src/main/scala/chisel3/util/pla.scala:114:{19,36}]
    .io_op      (decoded_3),	// @[generators/saturn/src/main/scala/insns/Decode.scala:34:88]
    .io_a_eew   (_fma_pipes_T_50 ? _GEN_6 : _GEN_9),	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:147:{28,49}, :150:36, :152:27, :157:27, :163:34, :165:25, :172:34, :174:25, :181:25]
    .io_b_eew   (_GEN_17 ? io_pipe_0_bits_rvs1_eew : _GEN_12),	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:147:49, :148:25, :149:25, :163:34, :166:25, :167:25, :172:34, :176:25, :183:25]
    .io_c_eew   (_fma_pipes_T_50 ? _GEN_7 : _GEN_14),	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:147:{28,49}, :150:36, :154:27, :159:27, :163:34, :169:25, :172:34]
    .io_out_eew (io_pipe_0_bits_vd_eew),
    .io_a       (_fma_pipes_T_50 ? ((&_decode_andMatrixOutputs_T_4) ? io_pipe_0_bits_rvd_data[127:64] : fma_pipes_vs2_bits_1) : _GEN_8 ? fma_pipes_vs2_bits_1 : 64'h0),	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:119:32, :132:50, :138:23, :147:{28,49}, :150:36, :151:27, :156:27, :163:34, :164:25, :172:34, :173:25, :180:25, :203:24, src/main/scala/chisel3/util/pla.scala:98:{53,70}]
    .io_b       (_GEN_17 ? fma_pipes_rs1_bits_1 : _GEN_10),	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:120:32, :136:23, :147:49, :148:25, :163:34, :166:25, :172:34, :175:25, :182:25]
    .io_c       (_fma_pipes_T_50 ? ((&_decode_andMatrixOutputs_T_4) ? fma_pipes_vs2_bits_1 : io_pipe_0_bits_rvd_data[127:64]) : _GEN_13 ? 64'h0 : fma_pipes_rs1_bits_1),	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:119:32, :120:32, :132:50, :136:23, :138:23, :147:{28,49}, :150:36, :153:27, :158:27, :163:34, :168:25, :172:34, :203:24, src/main/scala/chisel3/util/pla.scala:98:{53,70}]
    .io_mask    ({_fma_pipes_T_34 & io_pipe_0_bits_wmask[14], _fma_pipes_T_30 & io_pipe_0_bits_wmask[12], _fma_pipes_T_34 & io_pipe_0_bits_wmask[10], io_pipe_0_bits_wmask[8]}),	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:140:{35,44,52,76,84,92}, :141:{44,52,63,71}]
    .io_out     (_TandemFMAPipe_1_io_out),
    .io_exc     (_TandemFMAPipe_1_io_exc)
  );
  assign io_iss_ready = |{&{_GEN_0[0], _GEN_0[2], _GEN_0[3], _GEN_0[4], _GEN_0[5], io_iss_op_funct3[0], _GEN[0]}, &{_GEN_0[2], _GEN_0[3], _GEN_0[4], _GEN_0[5], io_iss_op_funct3[0], _GEN[0], _GEN[1]}, &{_GEN_0[0], _GEN_0[1], io_iss_op_funct6[2], io_iss_op_funct6[5], io_iss_op_funct3[0], _GEN[0]}, &{_GEN_0[0], _GEN_0[1], io_iss_op_funct6[3], io_iss_op_funct6[5], io_iss_op_funct3[0], _GEN[0]}, &{io_iss_op_funct6[3], _GEN_0[4], io_iss_op_funct6[5], io_iss_op_funct3[0], _GEN[0]}, &{io_iss_op_funct6[2], io_iss_op_funct6[3], io_iss_op_funct6[5], io_iss_op_funct3[0], _GEN[0]}, &{_GEN_0[0], _GEN_0[3], io_iss_op_funct6[4], io_iss_op_funct6[5], io_iss_op_funct3[0], _GEN[0]}, &{_GEN_0[2], _GEN_0[3], io_iss_op_funct6[4], io_iss_op_funct6[5], io_iss_op_funct3[0], _GEN[0], _GEN[1]}, &{io_iss_op_funct6[0], io_iss_op_funct6[1], io_iss_op_funct6[2], _GEN_0[4], io_iss_op_funct6[5], io_iss_op_funct3[0], _GEN[0], io_iss_op_funct3[2]}};	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:106:7, src/main/scala/chisel3/util/pla.scala:78:21, :90:45, :91:29, :98:{53,70}, :114:{19,36}]
  assign io_set_fflags_valid = io_pipe_3_valid;	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:106:7]
  assign io_set_fflags_bits = _TandemFMAPipe_io_exc | _TandemFMAPipe_1_io_exc;	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:106:7, :134:46, :201:66]
  assign io_write_valid = io_pipe_3_valid;	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:106:7]
  assign io_write_bits_eg = io_pipe_3_bits_wvd_eg;	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:106:7]
  assign io_write_bits_data = {_TandemFMAPipe_1_io_out, _TandemFMAPipe_io_out};	// @[generators/rocket-chip/src/main/scala/util/package.scala:45:27, generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:106:7, :134:46]
  assign io_write_bits_mask = {{8{io_pipe_3_bits_wmask[15]}}, {8{io_pipe_3_bits_wmask[14]}}, {8{io_pipe_3_bits_wmask[13]}}, {8{io_pipe_3_bits_wmask[12]}}, {8{io_pipe_3_bits_wmask[11]}}, {8{io_pipe_3_bits_wmask[10]}}, {8{io_pipe_3_bits_wmask[9]}}, {8{io_pipe_3_bits_wmask[8]}}, {8{io_pipe_3_bits_wmask[7]}}, {8{io_pipe_3_bits_wmask[6]}}, {8{io_pipe_3_bits_wmask[5]}}, {8{io_pipe_3_bits_wmask[4]}}, {8{io_pipe_3_bits_wmask[3]}}, {8{io_pipe_3_bits_wmask[2]}}, {8{io_pipe_3_bits_wmask[1]}}, {8{io_pipe_3_bits_wmask[0]}}};	// @[generators/saturn/src/main/scala/exu/fp/FPFMAPipe.scala:106:7, :197:40]
endmodule

