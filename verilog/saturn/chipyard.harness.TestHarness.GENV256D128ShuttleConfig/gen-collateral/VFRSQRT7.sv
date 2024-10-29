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

module VFRSQRT7(	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:132:7]
  input  [63:0] io_rvs2_input,	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:133:14]
  input  [1:0]  io_eew,	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:133:14]
  output [63:0] io_out,	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:133:14]
  output [4:0]  io_exc	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:133:14]
);

  wire [127:0][6:0] _GEN = {7'h35, 7'h36, 7'h37, 7'h38, 7'h38, 7'h39, 7'h3A, 7'h3B, 7'h3B, 7'h3C, 7'h3D, 7'h3E, 7'h3F, 7'h3F, 7'h40, 7'h41, 7'h42, 7'h43, 7'h44, 7'h45, 7'h46, 7'h46, 7'h47, 7'h48, 7'h49, 7'h4A, 7'h4B, 7'h4C, 7'h4D, 7'h4E, 7'h4F, 7'h50, 7'h52, 7'h53, 7'h54, 7'h55, 7'h56, 7'h57, 7'h58, 7'h5A, 7'h5B, 7'h5C, 7'h5D, 7'h5F, 7'h60, 7'h61, 7'h63, 7'h64, 7'h66, 7'h67, 7'h69, 7'h6A, 7'h6C, 7'h6D, 7'h6F, 7'h71, 7'h72, 7'h74, 7'h76, 7'h77, 7'h79, 7'h7B, 7'h7D, 7'h7F, 7'h0, 7'h1, 7'h1, 7'h2, 7'h2, 7'h3, 7'h3, 7'h4, 7'h4, 7'h5, 7'h6, 7'h6, 7'h7, 7'h7, 7'h8, 7'h9, 7'h9, 7'hA, 7'hA, 7'hB, 7'hC, 7'hC, 7'hD, 7'hE, 7'hE, 7'hF, 7'h10, 7'h10, 7'h11, 7'h12, 7'h13, 7'h13, 7'h14, 7'h15, 7'h16, 7'h17, 7'h17, 7'h18, 7'h19, 7'h1A, 7'h1B, 7'h1C, 7'h1D, 7'h1E, 7'h1E, 7'h1F, 7'h20, 7'h21, 7'h22, 7'h23, 7'h24, 7'h26, 7'h27, 7'h28, 7'h29, 7'h2A, 7'h2B, 7'h2C, 7'h2E, 7'h2F, 7'h30, 7'h32, 7'h33, 7'h34};	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:212:57]
  wire              eew_sel_0 = io_eew == 2'h1;	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:167:34, :215:63]
  wire              eew_sel_1 = io_eew == 2'h2;	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:167:34]
  wire              classify_rawIn_isZeroExpIn = io_rvs2_input[14:10] == 5'h0;	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:45:19, :48:30, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:168:78, :184:55]
  wire [3:0]        classify_rawIn_normDist = io_rvs2_input[9] ? 4'h0 : io_rvs2_input[8] ? 4'h1 : io_rvs2_input[7] ? 4'h2 : io_rvs2_input[6] ? 4'h3 : io_rvs2_input[5] ? 4'h4 : io_rvs2_input[4] ? 4'h5 : io_rvs2_input[3] ? 4'h6 : io_rvs2_input[2] ? 4'h7 : {3'h4, ~(io_rvs2_input[1])};	// @[generators/hardfloat/hardfloat/src/main/scala/primitives.scala:91:52, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:46:21, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:168:78, src/main/scala/chisel3/util/Mux.scala:50:70]
  wire [24:0]       _classify_rawIn_subnormFract_T = {15'h0, io_rvs2_input[9:0]} << classify_rawIn_normDist;	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:46:21, :52:33, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:168:78, src/main/scala/chisel3/util/Mux.scala:50:70]
  wire [5:0]        _classify_rawIn_adjustedExp_T_4 = (classify_rawIn_isZeroExpIn ? {2'h3, ~classify_rawIn_normDist} : {1'h0, io_rvs2_input[14:10]}) + {4'h4, classify_rawIn_isZeroExpIn ? 2'h2 : 2'h1};	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:45:19, :48:30, :54:10, :55:18, :57:9, :58:14, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:167:34, :168:78, :215:63, src/main/scala/chisel3/util/Mux.scala:50:70]
  wire              _classify_rawIn_out_sig_T_2 = classify_rawIn_isZeroExpIn ? _classify_rawIn_subnormFract_T[8] : io_rvs2_input[9];	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:46:21, :48:30, :52:{33,64}, :70:33, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:168:78]
  wire [2:0]        _classify_T_2 = classify_rawIn_isZeroExpIn & ~(|(io_rvs2_input[9:0])) ? 3'h0 : _classify_rawIn_adjustedExp_T_4[5:3];	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:46:21, :48:30, :49:34, :57:9, :60:30, generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:{15,50}, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:168:78]
  wire              _classify_isInf_T = _classify_T_2[0] | (&(_classify_rawIn_adjustedExp_T_4[5:4])) & (|(io_rvs2_input[9:0]));	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:46:21, :49:34, :57:9, :61:{32,57}, :64:28, generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:{15,76}, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:168:78]
  wire [2:0]        classify_code = {_classify_T_2[2:1], _classify_isInf_T};	// @[generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:{15,76}, generators/rocket-chip/src/main/scala/tile/FPU.scala:254:17]
  wire              classify_isHighSubnormalIn = {_classify_isInf_T, _classify_rawIn_adjustedExp_T_4[2:0]} < 4'h2;	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:57:9, generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:76, :50:23, generators/rocket-chip/src/main/scala/tile/FPU.scala:258:{30,55}, src/main/scala/chisel3/util/Mux.scala:50:70]
  wire              _classify_isNormal_T = _classify_T_2[2:1] == 2'h1;	// @[generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:{15,76}, generators/rocket-chip/src/main/scala/tile/FPU.scala:259:46, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:215:63]
  wire              classify_isSubnormal = classify_code == 3'h1 | _classify_isNormal_T & classify_isHighSubnormalIn;	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:254:17, :258:55, :259:{28,36,46,54}]
  wire              classify_isNormal = _classify_isNormal_T & ~classify_isHighSubnormalIn | _classify_T_2[2:1] == 2'h2;	// @[generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:{15,76}, generators/rocket-chip/src/main/scala/tile/FPU.scala:258:55, :259:46, :260:{35,38,57,67}, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:167:34]
  wire              classify_isZero = classify_code == 3'h0;	// @[generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:15, generators/rocket-chip/src/main/scala/tile/FPU.scala:254:17, :261:23]
  wire              classify_isInf = (&(_classify_T_2[2:1])) & ~_classify_isInf_T;	// @[generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:{15,76}, generators/rocket-chip/src/main/scala/tile/FPU.scala:256:28, :262:{27,30}]
  wire              classify_rawIn_isZeroExpIn_1 = io_rvs2_input[30:23] == 8'h0;	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:45:19, :48:30, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:168:78, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire [4:0]        classify_rawIn_normDist_1 = io_rvs2_input[22] ? 5'h0 : io_rvs2_input[21] ? 5'h1 : io_rvs2_input[20] ? 5'h2 : io_rvs2_input[19] ? 5'h3 : io_rvs2_input[18] ? 5'h4 : io_rvs2_input[17] ? 5'h5 : io_rvs2_input[16] ? 5'h6 : io_rvs2_input[15] ? 5'h7 : io_rvs2_input[14] ? 5'h8 : io_rvs2_input[13] ? 5'h9 : io_rvs2_input[12] ? 5'hA : io_rvs2_input[11] ? 5'hB : io_rvs2_input[10] ? 5'hC : io_rvs2_input[9] ? 5'hD : io_rvs2_input[8] ? 5'hE : io_rvs2_input[7] ? 5'hF : io_rvs2_input[6] ? 5'h10 : io_rvs2_input[5] ? 5'h11 : io_rvs2_input[4] ? 5'h12 : io_rvs2_input[3] ? 5'h13 : io_rvs2_input[2] ? 5'h14 : io_rvs2_input[1] ? 5'h15 : 5'h16;	// @[generators/hardfloat/hardfloat/src/main/scala/primitives.scala:91:52, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:46:21, :58:9, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:168:78, :184:55, src/main/scala/chisel3/util/Mux.scala:50:70]
  wire [53:0]       _classify_rawIn_subnormFract_T_2 = {31'h0, io_rvs2_input[22:0]} << classify_rawIn_normDist_1;	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:46:21, :52:33, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:168:78, src/main/scala/chisel3/util/Mux.scala:50:70]
  wire [8:0]        _classify_rawIn_adjustedExp_T_9 = (classify_rawIn_isZeroExpIn_1 ? {4'hF, ~classify_rawIn_normDist_1} : {1'h0, io_rvs2_input[30:23]}) + {7'h20, classify_rawIn_isZeroExpIn_1 ? 2'h2 : 2'h1};	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:45:19, :48:30, :54:10, :55:18, :57:9, :58:14, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:167:34, :168:78, :211:25, :215:63, src/main/scala/chisel3/util/Mux.scala:50:70]
  wire              _classify_rawIn_out_sig_T_6 = classify_rawIn_isZeroExpIn_1 ? _classify_rawIn_subnormFract_T_2[21] : io_rvs2_input[22];	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:46:21, :48:30, :52:{33,64}, :70:33, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:168:78]
  wire [2:0]        _classify_T_25 = classify_rawIn_isZeroExpIn_1 & ~(|(io_rvs2_input[22:0])) ? 3'h0 : _classify_rawIn_adjustedExp_T_9[8:6];	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:46:21, :48:30, :49:34, :57:9, :60:30, generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:{15,50}, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:168:78]
  wire              _classify_isInf_T_2 = _classify_T_25[0] | (&(_classify_rawIn_adjustedExp_T_9[8:7])) & (|(io_rvs2_input[22:0]));	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:46:21, :49:34, :57:9, :61:{32,57}, :64:28, generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:{15,76}, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:168:78]
  wire [2:0]        classify_code_1 = {_classify_T_25[2:1], _classify_isInf_T_2};	// @[generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:{15,76}, generators/rocket-chip/src/main/scala/tile/FPU.scala:254:17]
  wire              classify_isHighSubnormalIn_1 = {_classify_isInf_T_2, _classify_rawIn_adjustedExp_T_9[5:0]} < 7'h2;	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:57:9, generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:76, :50:23, generators/rocket-chip/src/main/scala/tile/FPU.scala:258:{30,55}, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:211:25]
  wire              _classify_isNormal_T_4 = _classify_T_25[2:1] == 2'h1;	// @[generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:{15,76}, generators/rocket-chip/src/main/scala/tile/FPU.scala:259:46, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:215:63]
  wire              classify_isSubnormal_1 = classify_code_1 == 3'h1 | _classify_isNormal_T_4 & classify_isHighSubnormalIn_1;	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:254:17, :258:55, :259:{28,36,46,54}]
  wire              classify_isNormal_1 = _classify_isNormal_T_4 & ~classify_isHighSubnormalIn_1 | _classify_T_25[2:1] == 2'h2;	// @[generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:{15,76}, generators/rocket-chip/src/main/scala/tile/FPU.scala:258:55, :259:46, :260:{35,38,57,67}, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:167:34]
  wire              classify_isZero_1 = classify_code_1 == 3'h0;	// @[generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:15, generators/rocket-chip/src/main/scala/tile/FPU.scala:254:17, :261:23]
  wire              classify_isInf_1 = (&(_classify_T_25[2:1])) & ~_classify_isInf_T_2;	// @[generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:{15,76}, generators/rocket-chip/src/main/scala/tile/FPU.scala:256:28, :262:{27,30}]
  wire              classify_rawIn_isZeroExpIn_2 = io_rvs2_input[62:52] == 11'h0;	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:45:19, :48:30, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire [5:0]        classify_rawIn_normDist_2 = io_rvs2_input[51] ? 6'h0 : io_rvs2_input[50] ? 6'h1 : io_rvs2_input[49] ? 6'h2 : io_rvs2_input[48] ? 6'h3 : io_rvs2_input[47] ? 6'h4 : io_rvs2_input[46] ? 6'h5 : io_rvs2_input[45] ? 6'h6 : io_rvs2_input[44] ? 6'h7 : io_rvs2_input[43] ? 6'h8 : io_rvs2_input[42] ? 6'h9 : io_rvs2_input[41] ? 6'hA : io_rvs2_input[40] ? 6'hB : io_rvs2_input[39] ? 6'hC : io_rvs2_input[38] ? 6'hD : io_rvs2_input[37] ? 6'hE : io_rvs2_input[36] ? 6'hF : io_rvs2_input[35] ? 6'h10 : io_rvs2_input[34] ? 6'h11 : io_rvs2_input[33] ? 6'h12 : io_rvs2_input[32] ? 6'h13 : io_rvs2_input[31] ? 6'h14 : io_rvs2_input[30] ? 6'h15 : io_rvs2_input[29] ? 6'h16 : io_rvs2_input[28] ? 6'h17 : io_rvs2_input[27] ? 6'h18 : io_rvs2_input[26] ? 6'h19 : io_rvs2_input[25] ? 6'h1A : io_rvs2_input[24] ? 6'h1B : io_rvs2_input[23] ? 6'h1C : io_rvs2_input[22] ? 6'h1D : io_rvs2_input[21] ? 6'h1E : io_rvs2_input[20] ? 6'h1F : io_rvs2_input[19] ? 6'h20 : io_rvs2_input[18] ? 6'h21 : io_rvs2_input[17] ? 6'h22 : io_rvs2_input[16] ? 6'h23 : io_rvs2_input[15] ? 6'h24 : io_rvs2_input[14] ? 6'h25 : io_rvs2_input[13] ? 6'h26 : io_rvs2_input[12] ? 6'h27 : io_rvs2_input[11] ? 6'h28 : io_rvs2_input[10] ? 6'h29 : io_rvs2_input[9] ? 6'h2A : io_rvs2_input[8] ? 6'h2B : io_rvs2_input[7] ? 6'h2C : io_rvs2_input[6] ? 6'h2D : io_rvs2_input[5] ? 6'h2E : io_rvs2_input[4] ? 6'h2F : io_rvs2_input[3] ? 6'h30 : io_rvs2_input[2] ? 6'h31 : {5'h19, ~(io_rvs2_input[1])};	// @[generators/hardfloat/hardfloat/src/main/scala/primitives.scala:91:52, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:46:21, src/main/scala/chisel3/util/Mux.scala:50:70]
  wire [114:0]      _classify_rawIn_subnormFract_T_4 = {63'h0, io_rvs2_input[51:0]} << classify_rawIn_normDist_2;	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:46:21, :52:33, src/main/scala/chisel3/util/Mux.scala:50:70]
  wire [11:0]       _classify_rawIn_adjustedExp_T_14 = (classify_rawIn_isZeroExpIn_2 ? {6'h3F, ~classify_rawIn_normDist_2} : {1'h0, io_rvs2_input[62:52]}) + {10'h100, classify_rawIn_isZeroExpIn_2 ? 2'h2 : 2'h1};	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:45:19, :48:30, :54:10, :55:18, :57:9, :58:14, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:167:34, :215:63, src/main/scala/chisel3/util/Mux.scala:50:70]
  wire              _classify_rawIn_out_sig_T_10 = classify_rawIn_isZeroExpIn_2 ? _classify_rawIn_subnormFract_T_4[50] : io_rvs2_input[51];	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:46:21, :48:30, :52:{33,64}, :70:33]
  wire [2:0]        _classify_T_48 = classify_rawIn_isZeroExpIn_2 & ~(|(io_rvs2_input[51:0])) ? 3'h0 : _classify_rawIn_adjustedExp_T_14[11:9];	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:46:21, :48:30, :49:34, :57:9, :60:30, generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:{15,50}]
  wire              _classify_isInf_T_4 = _classify_T_48[0] | (&(_classify_rawIn_adjustedExp_T_14[11:10])) & (|(io_rvs2_input[51:0]));	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:46:21, :49:34, :57:9, :61:{32,57}, :64:28, generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:{15,76}]
  wire [2:0]        classify_code_2 = {_classify_T_48[2:1], _classify_isInf_T_4};	// @[generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:{15,76}, generators/rocket-chip/src/main/scala/tile/FPU.scala:254:17]
  wire              classify_isHighSubnormalIn_2 = {_classify_isInf_T_4, _classify_rawIn_adjustedExp_T_14[8:0]} < 10'h2;	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:57:9, generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:76, :50:23, generators/rocket-chip/src/main/scala/tile/FPU.scala:258:{30,55}]
  wire              _classify_isNormal_T_8 = _classify_T_48[2:1] == 2'h1;	// @[generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:{15,76}, generators/rocket-chip/src/main/scala/tile/FPU.scala:259:46, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:215:63]
  wire              classify_isSubnormal_2 = classify_code_2 == 3'h1 | _classify_isNormal_T_8 & classify_isHighSubnormalIn_2;	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:254:17, :258:55, :259:{28,36,46,54}]
  wire              classify_isNormal_2 = _classify_isNormal_T_8 & ~classify_isHighSubnormalIn_2 | _classify_T_48[2:1] == 2'h2;	// @[generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:{15,76}, generators/rocket-chip/src/main/scala/tile/FPU.scala:258:55, :259:46, :260:{35,38,57,67}, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:167:34]
  wire              classify_isZero_2 = classify_code_2 == 3'h0;	// @[generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:15, generators/rocket-chip/src/main/scala/tile/FPU.scala:254:17, :261:23]
  wire              classify_isInf_2 = (&(_classify_T_48[2:1])) & ~_classify_isInf_T_4;	// @[generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:{15,76}, generators/rocket-chip/src/main/scala/tile/FPU.scala:256:28, :262:{27,30}]
  wire [9:0]        classify = (eew_sel_0 ? {(&classify_code) & _classify_rawIn_out_sig_T_2, (&classify_code) & ~_classify_rawIn_out_sig_T_2, classify_isInf & ~(io_rvs2_input[15]), classify_isNormal & ~(io_rvs2_input[15]), classify_isSubnormal & ~(io_rvs2_input[15]), classify_isZero & ~(io_rvs2_input[15]), classify_isZero & io_rvs2_input[15], classify_isSubnormal & io_rvs2_input[15], classify_isNormal & io_rvs2_input[15], classify_isInf & io_rvs2_input[15]} : 10'h0) | (eew_sel_1 ? {(&classify_code_1) & _classify_rawIn_out_sig_T_6, (&classify_code_1) & ~_classify_rawIn_out_sig_T_6, classify_isInf_1 & ~(io_rvs2_input[31]), classify_isNormal_1 & ~(io_rvs2_input[31]), classify_isSubnormal_1 & ~(io_rvs2_input[31]), classify_isZero_1 & ~(io_rvs2_input[31]), classify_isZero_1 & io_rvs2_input[31], classify_isSubnormal_1 & io_rvs2_input[31], classify_isNormal_1 & io_rvs2_input[31], classify_isInf_1 & io_rvs2_input[31]} : 10'h0) | ((&io_eew) ? {(&classify_code_2) & _classify_rawIn_out_sig_T_10, (&classify_code_2) & ~_classify_rawIn_out_sig_T_10, classify_isInf_2 & ~(io_rvs2_input[63]), classify_isNormal_2 & ~(io_rvs2_input[63]), classify_isSubnormal_2 & ~(io_rvs2_input[63]), classify_isZero_2 & ~(io_rvs2_input[63]), classify_isZero_2 & io_rvs2_input[63], classify_isSubnormal_2 & io_rvs2_input[63], classify_isNormal_2 & io_rvs2_input[63], classify_isInf_2 & io_rvs2_input[63]} : 10'h0);	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:44:18, :70:33, generators/rocket-chip/src/main/scala/tile/FPU.scala:254:17, :259:36, :260:57, :261:23, :262:27, :263:22, :264:{24,27}, :265:24, :267:{8,31,34,50}, :268:{21,38,55}, :269:{21,39,54}, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:167:34, :168:78, :184:73, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire              nv = classify[0] | classify[1] | classify[2] | classify[8];	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:178:{17,32,47,51,62}, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire [51:0]       sig = {29'h0, {13'h0, eew_sel_0 ? io_rvs2_input[9:0] : 10'h0} | (eew_sel_1 ? io_rvs2_input[22:0] : 23'h0)} | ((&io_eew) ? io_rvs2_input[51:0] : 52'h0);	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:167:34, :184:73, :195:55, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire              sign = eew_sel_0 & io_rvs2_input[15] | eew_sel_1 & io_rvs2_input[31] | (&io_eew) & io_rvs2_input[63];	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:167:34, :196:56, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire [11:0]       _GEN_0 = {1'h0, {3'h0, {3'h0, eew_sel_0 ? io_rvs2_input[14:10] : 5'h0} | (eew_sel_1 ? io_rvs2_input[30:23] : 8'h0)} | ((&io_eew) ? io_rvs2_input[62:52] : 11'h0)};	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:48:30, generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:15, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:167:34, :184:55, :194:{57,72}, :199:14, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire [3:0]        _GEN_1 = {sig[7:6], sig[9:8]} & 4'h5;	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:160:28, :203:81, src/main/scala/chisel3/util/Mux.scala:30:73, :50:70]
  wire [3:0]        _GEN_2 = {{sig[5:4], sig[7]} & 3'h5, 1'h0} | _GEN_1;	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:48:30, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:160:28, src/main/scala/chisel3/util/Mux.scala:30:73, :50:70]
  wire [7:0]        _GEN_3 = {{sig[11:8], sig[15:14]} & 6'h33, 2'h0} | {sig[15:12], sig[19:16]} & 8'h33;	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:160:28, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire [18:0]       _GEN_4 = {sig[5:4], sig[7:6], sig[9:8], _GEN_3, sig[19:18], sig[21:20], sig[23]} & 19'h55555;	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:160:28, :203:81, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire [3:0]        _GEN_5 = _GEN_4[18:15] | _GEN_1;	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:160:28]
  wire [7:0]        _GEN_6 = _GEN_4[14:7] | _GEN_3 & 8'h55;	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:160:28]
  wire [3:0]        _GEN_7 = {_GEN_4[2:0], 1'h0} | {sig[23:22], sig[25:24]} & 4'h5;	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:48:30, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:160:28, src/main/scala/chisel3/util/Mux.scala:30:73, :50:70]
  wire [3:0]        _GEN_8 = {{sig[37:36], sig[39]} & 3'h5, 1'h0} | {sig[39:38], sig[41:40]} & 4'h5;	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:48:30, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:160:28, src/main/scala/chisel3/util/Mux.scala:30:73, :50:70]
  wire [5:0]        leading_zeros = {1'h0, {1'h0, ~eew_sel_0 | sig[9] ? 4'h0 : sig[8] ? 4'h1 : sig[7] ? 4'h2 : sig[6] ? 4'h3 : sig[5] ? 4'h4 : sig[4] ? 4'h5 : sig[3] ? 4'h6 : sig[2] ? 4'h7 : {3'h4, ~(sig[1])}} | (~eew_sel_1 | sig[22] ? 5'h0 : sig[21] ? 5'h1 : sig[20] ? 5'h2 : sig[19] ? 5'h3 : sig[18] ? 5'h4 : sig[17] ? 5'h5 : sig[16] ? 5'h6 : sig[15] ? 5'h7 : sig[14] ? 5'h8 : sig[13] ? 5'h9 : sig[12] ? 5'hA : sig[11] ? 5'hB : sig[10] ? 5'hC : sig[9] ? 5'hD : _GEN_2[0] ? 5'hE : _GEN_2[1] ? 5'hF : _GEN_2[2] ? 5'h10 : _GEN_2[3] ? 5'h11 : sig[4] ? 5'h12 : sig[3] ? 5'h13 : sig[2] ? 5'h14 : sig[1] ? 5'h15 : 5'h16)} | (~(&io_eew) | sig[51] ? 6'h0 : sig[50] ? 6'h1 : sig[49] ? 6'h2 : sig[48] ? 6'h3 : sig[47] ? 6'h4 : sig[46] ? 6'h5 : sig[45] ? 6'h6 : sig[44] ? 6'h7 : sig[43] ? 6'h8 : sig[42] ? 6'h9 : sig[41] ? 6'hA : _GEN_8[0] ? 6'hB : _GEN_8[1] ? 6'hC : _GEN_8[2] ? 6'hD : _GEN_8[3] ? 6'hE : sig[36] ? 6'hF : sig[35] ? 6'h10 : sig[34] ? 6'h11 : sig[33] ? 6'h12 : sig[32] ? 6'h13 : sig[31] ? 6'h14 : sig[30] ? 6'h15 : sig[29] ? 6'h16 : sig[28] ? 6'h17 : sig[27] ? 6'h18 : sig[26] ? 6'h19 : sig[25] ? 6'h1A : _GEN_7[0] ? 6'h1B : _GEN_7[1] ? 6'h1C : _GEN_7[2] ? 6'h1D : _GEN_7[3] ? 6'h1E : sig[20] ? 6'h1F : sig[19] ? 6'h20 : _GEN_4[5] | sig[18] ? 6'h21 : _GEN_3[1] ? 6'h22 : _GEN_6[0] ? 6'h23 : _GEN_6[1] ? 6'h24 : _GEN_6[2] ? 6'h25 : _GEN_6[3] ? 6'h26 : _GEN_6[4] ? 6'h27 : _GEN_6[5] ? 6'h28 : _GEN_6[6] ? 6'h29 : _GEN_6[7] ? 6'h2A : _GEN_5[0] ? 6'h2B : _GEN_5[1] ? 6'h2C : _GEN_5[2] ? 6'h2D : _GEN_5[3] ? 6'h2E : sig[4] ? 6'h2F : sig[3] ? 6'h30 : sig[2] ? 6'h31 : {5'h19, ~(sig[1])});	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:48:30, :58:9, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:160:28, :167:34, :184:55, :203:81, src/main/scala/chisel3/util/Mux.scala:30:73, :50:70, src/main/scala/chisel3/util/OneHot.scala:48:45]
  wire [178:0]      _sig_new_T_1 = {127'h0, sig} << {1'h0, leading_zeros} + 7'h1;	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:48:30, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:205:{26,44}, :211:25, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire [11:0]       norm_exp = classify[5] ? _GEN_0 - {6'h0, leading_zeros} : _GEN_0;	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:192:23, :199:14, :202:16, :204:39, :206:16, src/main/scala/chisel3/util/Mux.scala:30:73, :50:70]
  wire [47:0]       _GEN_9 = classify[5] ? _sig_new_T_1[51:4] & ({29'h0, {13'h0, {6{eew_sel_0}}} | {19{eew_sel_1}}} | {48{&io_eew}}) : sig[51:4];	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:167:34, :192:23, :200:28, :202:16, :205:{26,53}, :207:16, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire [6:0]        _GEN_10 = (eew_sel_0 ? _GEN_9[6:0] : 7'h0) | (eew_sel_1 ? _GEN_9[19:13] : 7'h0) | ((&io_eew) ? {1'h0, _GEN_9[47:42]} : 7'h0);	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromFN.scala:48:30, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:167:34, :200:28, :202:16, :207:16, :210:77, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire [6:0]        _GEN_11 = _GEN[{norm_exp[0] | _GEN_10[6], _GEN_10[5:0]}];	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:199:14, :202:16, :206:16, :210:{25,35,102}, :212:57, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire [51:0]       out_sig = {29'h0, {13'h0, eew_sel_0 ? {_GEN_11, 3'h0} : 10'h0} | (eew_sel_1 ? {_GEN_11, 16'h0} : 23'h0)} | ((&io_eew) ? {_GEN_11, 45'h0} : 52'h0);	// @[generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:15, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:167:34, :184:73, :212:57, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire [11:0]       _out_exp_bias3_T_4 = 12'h2D - norm_exp - 12'h1;	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:199:14, :202:16, :206:16, :215:{45,63}]
  wire [11:0]       _out_exp_bias3_T_11 = 12'h17D - norm_exp - 12'h1;	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:199:14, :202:16, :206:16, :215:{45,63}]
  wire [11:0]       _out_exp_bias3_T_18 = 12'hBFD - norm_exp - 12'h1;	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:199:14, :202:16, :206:16, :215:{45,63}]
  wire [10:0]       out_exp = (eew_sel_0 ? _out_exp_bias3_T_4[11:1] : 11'h0) | (eew_sel_1 ? _out_exp_bias3_T_11[11:1] : 11'h0) | ((&io_eew) ? _out_exp_bias3_T_18[11:1] : 11'h0);	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:167:34, :215:63, :216:13, src/main/scala/chisel3/util/Mux.scala:30:73]
  wire [63:0]       ret = nv ? {32'h0, {16'h0, eew_sel_0 ? 16'h7E00 : 16'h0} | (eew_sel_1 ? 32'h7FC00000 : 32'h0)} | ((&io_eew) ? 64'h7FF8000000000000 : 64'h0) : classify[9] ? {32'h0, {16'h0, eew_sel_0 ? 16'h7E00 : 16'h0} | (eew_sel_1 ? 32'h7FC00000 : 32'h0)} | ((&io_eew) ? 64'h7FF8000000000000 : 64'h0) : classify[3] ? {32'h0, {16'h0, eew_sel_0 ? 16'hFC00 : 16'h0} | (eew_sel_1 ? 32'hFF800000 : 32'h0)} | ((&io_eew) ? 64'hFFF0000000000000 : 64'h0) : classify[4] ? {32'h0, {16'h0, eew_sel_0 ? 16'h7C00 : 16'h0} | (eew_sel_1 ? 32'h7F800000 : 32'h0)} | ((&io_eew) ? 64'h7FF0000000000000 : 64'h0) : classify[7] ? 64'h0 : {32'h0, {16'h0, eew_sel_0 ? {sign, out_exp[4:0], out_sig[9:0]} : 16'h0} | (eew_sel_1 ? {sign, out_exp[7:0], out_sig[22:0]} : 32'h0)} | ((&io_eew) ? {sign, out_exp, out_sig} : 64'h0);	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:167:34, :176:7, :178:{51,67}, :180:9, :181:{24,29}, :182:9, :183:{24,29}, :184:{9,73}, :186:{24,29}, :187:{9,73}, :189:{24,29}, :190:9, :219:{9,58,70,80}, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_out = (eew_sel_0 ? {2{{2{ret[15:0]}}}} : 64'h0) | (eew_sel_1 ? {2{ret[31:0]}} : 64'h0) | ((&io_eew) ? ret : 64'h0);	// @[generators/saturn/src/main/scala/exu/fp/FPDiv.scala:132:7, :167:34, :176:7, :178:67, :180:9, :181:29, :221:{48,70}, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_exc = {nv, ~(nv | classify[9]) & (classify[3] | classify[4]), 3'h0};	// @[generators/hardfloat/hardfloat/src/main/scala/recFNFromFN.scala:48:15, generators/saturn/src/main/scala/exu/fp/FPDiv.scala:132:7, :170:20, :178:{51,67}, :181:{24,29}, :183:{24,29}, :185:8, :186:{24,29}, :222:39, src/main/scala/chisel3/util/Mux.scala:30:73]
endmodule
