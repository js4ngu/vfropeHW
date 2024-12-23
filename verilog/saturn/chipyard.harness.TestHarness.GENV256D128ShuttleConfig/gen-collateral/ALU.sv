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

module ALU(	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:83:7]
  input         io_dw,	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:72:14]
  input  [4:0]  io_fn,	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:72:14]
  input  [63:0] io_in2,	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:72:14]
  input  [63:0] io_in1,	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:72:14]
  output [63:0] io_out,	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:72:14]
  output [63:0] io_adder_out,	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:72:14]
  output        io_cmp_out	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:72:14]
);

  wire [63:0]      in2_inv = {64{io_fn[3]}} ^ io_in2;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:58:29, :85:20]
  wire [63:0]      in1_xor_in2 = io_in1 ^ in2_inv;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:85:20, :86:28]
  wire [63:0]      _io_adder_out_T_3 = io_in1 + in2_inv + {63'h0, io_fn[3]};	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:58:29, :85:20, :88:36, :123:44]
  wire             slt = io_in1[63] == io_in2[63] ? _io_adder_out_T_3[63] : io_fn[1] ? io_in2[63] : io_in1[63];	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:61:35, :88:36, :92:{8,15,24,34,56}, :93:8]
  wire             _io_cmp_out_output = io_fn[0] ^ (io_fn[3] ? slt : in1_xor_in2 == 64'h0);	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:58:29, :62:35, :86:28, :92:8, :94:{36,41,68}, :122:70]
  wire [31:0]      shin_hi = io_dw ? io_in1[63:32] : {32{io_fn[3] & io_in1[31]}};	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:58:29, :101:{28,46,55}, :102:{24,48}]
  wire             _shamt_T_2 = io_in2[5] & io_dw;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:103:{29,33}]
  wire [63:0]      shin_r = {shin_hi, io_in1[31:0]};	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:102:24, :104:{18,34}]
  wire             _shout_T = io_fn == 5'h5;	// @[generators/rocket-chip/src/main/scala/util/package.scala:16:47]
  wire             _shout_T_1 = io_fn == 5'hB;	// @[generators/rocket-chip/src/main/scala/util/package.scala:16:47]
  wire             _bext_mask_T_1 = io_fn == 5'h13;	// @[generators/rocket-chip/src/main/scala/util/package.scala:16:47]
  wire [31:0]      _GEN = {io_in1[31:16], 16'h0} | shin_hi & 32'hFFFF;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:102:24, :106:46]
  wire [31:0]      _GEN_0 = {{io_in1[15:0], _GEN[31:24]} & 24'hFF00FF, 8'h0} | _GEN & 32'hFF00FF;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :141:45]
  wire [31:0]      _GEN_1 = {{io_in1[7:0], _GEN_0[31:12]} & 28'hF0F0F0F, 4'h0} | _GEN_0 & 32'hF0F0F0F;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46]
  wire [45:0]      _GEN_2 = {io_in1[3:0], _GEN_1, _GEN_0[7:4], _GEN[11:8], _GEN[15:14]} & 46'h333333333333;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46]
  wire [31:0]      _GEN_3 = _GEN_2[45:14] | _GEN_1 & 32'h33333333;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46]
  wire [1:0]       _GEN_4 = _GEN_2[11:10] | _GEN_0[5:4];	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46]
  wire [7:0]       _GEN_5 = {_GEN_2[5:0], 2'h0} | {_GEN[15:12], shin_hi[19:16]} & 8'h33;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:102:24, :106:46]
  wire [54:0]      _GEN_6 = {io_in1[1:0], _GEN_3, _GEN_1[3:2], _GEN_4, _GEN_0[7:6], _GEN[9:8], _GEN_5, shin_hi[19:18], shin_hi[21:20], shin_hi[23]} & 55'h55555555555555;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:102:24, :106:46]
  wire [63:0]      _GEN_7 = {io_in1[0], _GEN_6[54:23] | _GEN_3 & 32'h55555555, _GEN_3[1], _GEN_6[21] | _GEN_1[2], {_GEN_1[3], 1'h0} | _GEN_4 & 2'h1, _GEN_6[18:15] | {_GEN_0[7:6], _GEN[9:8]} & 4'h5, _GEN_6[14:7] | _GEN_5 & 8'h55, _GEN_5[1], _GEN_6[5] | shin_hi[18], shin_hi[19], shin_hi[20], {_GEN_6[2:0], 1'h0} | {shin_hi[23:22], shin_hi[25:24]} & 4'h5, shin_hi[25], shin_hi[26], shin_hi[27], shin_hi[28], shin_hi[29], shin_hi[30], shin_hi[31]};	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:88:26, :102:24, :106:46, :130:62]
  wire [63:0]      shin = _shout_T | _shout_T_1 | io_fn == 5'h12 | _bext_mask_T_1 ? shin_r : _GEN_7;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:104:18, :106:{17,46}, generators/rocket-chip/src/main/scala/util/package.scala:16:47, :81:59]
  wire [64:0]      _shout_r_T_5 = $signed($signed({io_fn[3] & shin[63], shin}) >>> {59'h0, _shamt_T_2, io_in2[4:0]});	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:58:29, :103:{33,60}, :106:17, :107:{21,35,41,64}]
  wire [15:0]      _GEN_8 = {{_shout_r_T_5[23:16], _shout_r_T_5[31:28]} & 12'hF0F, 4'h0} | {_shout_r_T_5[31:24], _shout_r_T_5[39:32]} & 16'hF0F;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :107:{64,73}, :108:24]
  wire [37:0]      _GEN_9 = {_shout_r_T_5[11:8], _shout_r_T_5[15:12], _shout_r_T_5[19:16], _GEN_8, _shout_r_T_5[39:36], _shout_r_T_5[43:40], _shout_r_T_5[47:46]} & 38'h3333333333;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :107:64, :108:24]
  wire [7:0]       _GEN_10 = _GEN_9[37:30] | {_shout_r_T_5[15:12], _shout_r_T_5[19:16]} & 8'h33;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :107:64, :108:24]
  wire [15:0]      _GEN_11 = _GEN_9[29:14] | _GEN_8 & 16'h3333;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :108:24]
  wire [1:0]       _GEN_12 = _GEN_9[11:10] | _shout_r_T_5[37:36];	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :107:64, :108:24]
  wire [7:0]       _GEN_13 = {_GEN_9[5:0], 2'h0} | {_shout_r_T_5[47:44], _shout_r_T_5[51:48]} & 8'h33;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :107:64, :108:24]
  wire [50:0]      _GEN_14 = {_shout_r_T_5[5:4], _shout_r_T_5[7:6], _shout_r_T_5[9:8], _GEN_10, _GEN_11, _GEN_8[3:2], _GEN_12, _shout_r_T_5[39:38], _shout_r_T_5[41:40], _GEN_13, _shout_r_T_5[51:50], _shout_r_T_5[53:52], _shout_r_T_5[55]} & 51'h5555555555555;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :107:64, :108:24]
  wire [63:0]      _GEN_15 = {_shout_r_T_5[0], _shout_r_T_5[1], _shout_r_T_5[2], _shout_r_T_5[3], _shout_r_T_5[4], _GEN_14[50:47] | {_shout_r_T_5[7:6], _shout_r_T_5[9:8]} & 4'h5, _GEN_14[46:39] | _GEN_10 & 8'h55, _GEN_14[38:23] | _GEN_11 & 16'h5555, _GEN_11[1], _GEN_14[21] | _GEN_8[2], {_GEN_8[3], 1'h0} | _GEN_12 & 2'h1, _GEN_14[18:15] | {_shout_r_T_5[39:38], _shout_r_T_5[41:40]} & 4'h5, _GEN_14[14:7] | _GEN_13 & 8'h55, _GEN_13[1], _GEN_14[5] | _shout_r_T_5[50], _shout_r_T_5[51], _shout_r_T_5[52], {_GEN_14[2:0], 1'h0} | {_shout_r_T_5[55:54], _shout_r_T_5[57:56]} & 4'h5, _shout_r_T_5[57], _shout_r_T_5[58], _shout_r_T_5[59], _shout_r_T_5[60], _shout_r_T_5[61], _shout_r_T_5[62], _shout_r_T_5[63]};	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:88:26, :106:46, :107:64, :108:24, :130:62]
  wire             _logic_T_8 = io_fn == 5'h6;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:119:45]
  wire             _logic_T_11 = io_fn == 5'h19;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:119:64]
  wire [15:0]      _GEN_16 = {{io_in1[23:16], io_in1[31:28]} & 12'hF0F, 4'h0} | {io_in1[31:24], io_in1[39:32]} & 16'hF0F;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :108:24, :132:19]
  wire [37:0]      _GEN_17 = {io_in1[11:8], io_in1[15:12], io_in1[19:16], _GEN_16, io_in1[39:36], io_in1[43:40], io_in1[47:46]} & 38'h3333333333;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :132:19]
  wire [7:0]       _GEN_18 = {io_in1[15:12], io_in1[19:16]} & 8'h33;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :132:19]
  wire [7:0]       _GEN_19 = _GEN_17[37:30] | _GEN_18;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :132:19]
  wire [15:0]      _GEN_20 = _GEN_17[29:14] | _GEN_16 & 16'h3333;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :108:24, :132:19]
  wire [1:0]       _GEN_21 = _GEN_17[11:10] | io_in1[37:36];	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :132:19]
  wire [7:0]       _GEN_22 = {_GEN_17[5:0], 2'h0} | {io_in1[47:44], io_in1[51:48]} & 8'h33;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :132:19]
  wire [50:0]      _GEN_23 = {io_in1[5:4], io_in1[7:6], io_in1[9:8], _GEN_19, _GEN_20, _GEN_16[3:2], _GEN_21, io_in1[39:38], io_in1[41:40], _GEN_22, io_in1[51:50], io_in1[53:52], io_in1[55]} & 51'h5555555555555;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :132:19]
  wire [3:0]       _GEN_24 = {io_in1[7:6], io_in1[9:8]} & 4'h5;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :132:19]
  wire [7:0]       _GEN_25 = {{io_in1[11:8], io_in1[15:14]} & 6'h33, 2'h0} | _GEN_18;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :132:19, :134:26]
  wire [18:0]      _GEN_26 = {io_in1[5:4], io_in1[7:6], io_in1[9:8], _GEN_25, io_in1[19:18], io_in1[21:20], io_in1[23]} & 19'h55555;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:132:19, :134:26]
  wire [3:0][63:0] _GEN_27 = {{{32'h1, io_in1[0], io_in1[1], io_in1[2], io_in1[3], io_in1[4], _GEN_26[18:15] | _GEN_24, _GEN_26[14:7] | _GEN_25 & 8'h55, _GEN_25[1], _GEN_26[5] | io_in1[18], io_in1[19], io_in1[20], {_GEN_26[2:0], 1'h0} | {io_in1[23:22], io_in1[25:24]} & 4'h5, io_in1[25], io_in1[26], io_in1[27], io_in1[28], io_in1[29], io_in1[30], io_in1[31]}}, {{32'h1, io_in1[31:0]}}, {{io_in1[0], io_in1[1], io_in1[2], io_in1[3], io_in1[4], _GEN_23[50:47] | _GEN_24, _GEN_23[46:39] | _GEN_19 & 8'h55, _GEN_23[38:23] | _GEN_20 & 16'h5555, _GEN_20[1], _GEN_23[21] | _GEN_16[2], {_GEN_16[3], 1'h0} | _GEN_21 & 2'h1, _GEN_23[18:15] | {io_in1[39:38], io_in1[41:40]} & 4'h5, _GEN_23[14:7] | _GEN_22 & 8'h55, _GEN_22[1], _GEN_23[5] | io_in1[50], io_in1[51], io_in1[52], {_GEN_23[2:0], 1'h0} | {io_in1[55:54], io_in1[57:56]} & 4'h5, io_in1[57], io_in1[58], io_in1[59], io_in1[60], io_in1[61], io_in1[62], io_in1[63]}}, {io_in1}};	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:88:26, :104:34, :106:46, :108:24, :130:62, :132:19, :134:26]
  wire [63:0]      tz_in = _GEN_27[{~io_dw, ~(io_in2[0])}];	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:130:{32,43,46,53,62}]
  wire [64:0]      _popc_in_T_116 = tz_in[18] ? 65'h40000 : tz_in[19] ? 65'h80000 : tz_in[20] ? 65'h100000 : tz_in[21] ? 65'h200000 : tz_in[22] ? 65'h400000 : tz_in[23] ? 65'h800000 : tz_in[24] ? 65'h1000000 : tz_in[25] ? 65'h2000000 : tz_in[26] ? 65'h4000000 : tz_in[27] ? 65'h8000000 : tz_in[28] ? 65'h10000000 : tz_in[29] ? 65'h20000000 : tz_in[30] ? 65'h40000000 : tz_in[31] ? 65'h80000000 : tz_in[32] ? 65'h100000000 : tz_in[33] ? 65'h200000000 : tz_in[34] ? 65'h400000000 : tz_in[35] ? 65'h800000000 : tz_in[36] ? 65'h1000000000 : tz_in[37] ? 65'h2000000000 : tz_in[38] ? 65'h4000000000 : tz_in[39] ? 65'h8000000000 : tz_in[40] ? 65'h10000000000 : tz_in[41] ? 65'h20000000000 : tz_in[42] ? 65'h40000000000 : tz_in[43] ? 65'h80000000000 : tz_in[44] ? 65'h100000000000 : tz_in[45] ? 65'h200000000000 : tz_in[46] ? 65'h400000000000 : tz_in[47] ? 65'h800000000000 : tz_in[48] ? 65'h1000000000000 : tz_in[49] ? 65'h2000000000000 : tz_in[50] ? 65'h4000000000000 : tz_in[51] ? 65'h8000000000000 : tz_in[52] ? 65'h10000000000000 : tz_in[53] ? 65'h20000000000000 : tz_in[54] ? 65'h40000000000000 : tz_in[55] ? 65'h80000000000000 : tz_in[56] ? 65'h100000000000000 : tz_in[57] ? 65'h200000000000000 : tz_in[58] ? 65'h400000000000000 : tz_in[59] ? 65'h800000000000000 : tz_in[60] ? 65'h1000000000000000 : tz_in[61] ? 65'h2000000000000000 : tz_in[62] ? 65'h4000000000000000 : tz_in[63] ? 65'h8000000000000000 : 65'h10000000000000000;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:130:62, src/main/scala/chisel3/util/Mux.scala:50:70, src/main/scala/chisel3/util/OneHot.scala:85:71]
  wire [63:0]      _popc_in_T_137 = io_in2[1] ? (io_dw ? io_in1 : {32'h0, io_in1[31:0]}) : (tz_in[0] ? 64'h1 : tz_in[1] ? 64'h2 : tz_in[2] ? 64'h4 : tz_in[3] ? 64'h8 : tz_in[4] ? 64'h10 : tz_in[5] ? 64'h20 : tz_in[6] ? 64'h40 : tz_in[7] ? 64'h80 : tz_in[8] ? 64'h100 : tz_in[9] ? 64'h200 : tz_in[10] ? 64'h400 : tz_in[11] ? 64'h800 : tz_in[12] ? 64'h1000 : tz_in[13] ? 64'h2000 : tz_in[14] ? 64'h4000 : tz_in[15] ? 64'h8000 : tz_in[16] ? 64'h10000 : tz_in[17] ? 64'h20000 : _popc_in_T_116[63:0]) - 64'h1;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:101:28, :104:34, :122:22, :130:62, :136:{20,27}, :137:8, :138:37, src/main/scala/chisel3/util/Mux.scala:50:70, src/main/scala/chisel3/util/OneHot.scala:85:71]
  wire [63:0]      rotout_r = (io_fn[0] ? shin_r : _GEN_7) >> (io_dw ? 7'h40 : 7'h20) - {1'h0, _shamt_T_2, io_in2[4:0]};	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:62:35, :88:26, :103:{33,60}, :104:18, :106:46, :155:{22,54}, :156:18, :157:25]
  wire [15:0]      _GEN_28 = {{rotout_r[23:16], rotout_r[31:28]} & 12'hF0F, 4'h0} | {rotout_r[31:24], rotout_r[39:32]} & 16'hF0F;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :108:24, :157:25, :158:25]
  wire [37:0]      _GEN_29 = {rotout_r[11:8], rotout_r[15:12], rotout_r[19:16], _GEN_28, rotout_r[39:36], rotout_r[43:40], rotout_r[47:46]} & 38'h3333333333;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :157:25, :158:25]
  wire [7:0]       _GEN_30 = _GEN_29[37:30] | {rotout_r[15:12], rotout_r[19:16]} & 8'h33;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :157:25, :158:25]
  wire [15:0]      _GEN_31 = _GEN_29[29:14] | _GEN_28 & 16'h3333;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :108:24, :158:25]
  wire [1:0]       _GEN_32 = _GEN_29[11:10] | rotout_r[37:36];	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :157:25, :158:25]
  wire [7:0]       _GEN_33 = {_GEN_29[5:0], 2'h0} | {rotout_r[47:44], rotout_r[51:48]} & 8'h33;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :157:25, :158:25]
  wire [50:0]      _GEN_34 = {rotout_r[5:4], rotout_r[7:6], rotout_r[9:8], _GEN_30, _GEN_31, _GEN_28[3:2], _GEN_32, rotout_r[39:38], rotout_r[41:40], _GEN_33, rotout_r[51:50], rotout_r[53:52], rotout_r[55]} & 51'h5555555555555;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:106:46, :157:25, :158:25]
  wire [63:0]      _out_T_5 =
    io_fn == 5'h10
      ? (io_in2[11:0] == 12'h605
           ? {{48{io_in1[15]}}, io_in1[15:0]}
           : io_in2[11:0] == 12'h604
               ? {{56{io_in1[7]}}, io_in1[7:0]}
               : io_in2[11:0] == 12'h80
                   ? {48'h0, io_in1[15:0]}
                   : io_in2[11:0] == 12'h6B8
                       ? {io_in1[7:0], io_in1[15:8], io_in1[23:16], io_in1[31:24], io_in1[39:32], io_in1[47:40], io_in1[55:48], io_in1[63:56]}
                       : io_in2[11:0] == 12'h287
                           ? {{8{|(io_in1[63:56])}}, {8{|(io_in1[55:48])}}, {8{|(io_in1[47:40])}}, {8{|(io_in1[39:32])}}, {8{|(io_in1[31:24])}}, {8{|(io_in1[23:16])}}, {8{|(io_in1[15:8])}}, {8{|(io_in1[7:0])}}}
                           : {57'h0,
                              {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, _popc_in_T_137[0]} + {1'h0, _popc_in_T_137[1]}} + {1'h0, {1'h0, _popc_in_T_137[2]} + {1'h0, _popc_in_T_137[3]}}} + {1'h0, {1'h0, {1'h0, _popc_in_T_137[4]} + {1'h0, _popc_in_T_137[5]}} + {1'h0, {1'h0, _popc_in_T_137[6]} + {1'h0, _popc_in_T_137[7]}}}} + {1'h0, {1'h0, {1'h0, {1'h0, _popc_in_T_137[8]} + {1'h0, _popc_in_T_137[9]}} + {1'h0, {1'h0, _popc_in_T_137[10]} + {1'h0, _popc_in_T_137[11]}}} + {1'h0, {1'h0, {1'h0, _popc_in_T_137[12]} + {1'h0, _popc_in_T_137[13]}} + {1'h0, {1'h0, _popc_in_T_137[14]} + {1'h0, _popc_in_T_137[15]}}}}} + {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, _popc_in_T_137[16]} + {1'h0, _popc_in_T_137[17]}} + {1'h0, {1'h0, _popc_in_T_137[18]} + {1'h0, _popc_in_T_137[19]}}} + {1'h0, {1'h0, {1'h0, _popc_in_T_137[20]} + {1'h0, _popc_in_T_137[21]}} + {1'h0, {1'h0, _popc_in_T_137[22]} + {1'h0, _popc_in_T_137[23]}}}} + {1'h0, {1'h0, {1'h0, {1'h0, _popc_in_T_137[24]} + {1'h0, _popc_in_T_137[25]}} + {1'h0, {1'h0, _popc_in_T_137[26]} + {1'h0, _popc_in_T_137[27]}}} + {1'h0, {1'h0, {1'h0, _popc_in_T_137[28]} + {1'h0, _popc_in_T_137[29]}} + {1'h0, {1'h0, _popc_in_T_137[30]} + {1'h0, _popc_in_T_137[31]}}}}}}
                                + {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, _popc_in_T_137[32]} + {1'h0, _popc_in_T_137[33]}} + {1'h0, {1'h0, _popc_in_T_137[34]} + {1'h0, _popc_in_T_137[35]}}} + {1'h0, {1'h0, {1'h0, _popc_in_T_137[36]} + {1'h0, _popc_in_T_137[37]}} + {1'h0, {1'h0, _popc_in_T_137[38]} + {1'h0, _popc_in_T_137[39]}}}} + {1'h0, {1'h0, {1'h0, {1'h0, _popc_in_T_137[40]} + {1'h0, _popc_in_T_137[41]}} + {1'h0, {1'h0, _popc_in_T_137[42]} + {1'h0, _popc_in_T_137[43]}}} + {1'h0, {1'h0, {1'h0, _popc_in_T_137[44]} + {1'h0, _popc_in_T_137[45]}} + {1'h0, {1'h0, _popc_in_T_137[46]} + {1'h0, _popc_in_T_137[47]}}}}} + {1'h0, {1'h0, {1'h0, {1'h0, {1'h0, _popc_in_T_137[48]} + {1'h0, _popc_in_T_137[49]}} + {1'h0, {1'h0, _popc_in_T_137[50]} + {1'h0, _popc_in_T_137[51]}}} + {1'h0, {1'h0, {1'h0, _popc_in_T_137[52]} + {1'h0, _popc_in_T_137[53]}} + {1'h0, {1'h0, _popc_in_T_137[54]} + {1'h0, _popc_in_T_137[55]}}}} + {1'h0, {1'h0, {1'h0, {1'h0, _popc_in_T_137[56]} + {1'h0, _popc_in_T_137[57]}} + {1'h0, {1'h0, _popc_in_T_137[58]} + {1'h0, _popc_in_T_137[59]}}} + {1'h0, {1'h0, {1'h0, _popc_in_T_137[60]} + {1'h0, _popc_in_T_137[61]}} + {1'h0, {1'h0, _popc_in_T_137[62]} + {1'h0, _popc_in_T_137[63]}}}}}}})
      : io_fn == 5'hA | io_fn == 5'h0 ? _io_adder_out_T_3 : {63'h0, io_fn > 5'hB & ~(io_fn[4]) & slt} | (io_fn == 5'h4 | _logic_T_8 | _logic_T_11 | io_fn == 5'h1A ? in1_xor_in2 : 64'h0) | (_logic_T_8 | io_fn == 5'h7 | _logic_T_11 | io_fn == 5'h18 ? io_in1 & in2_inv : 64'h0) | ((_shout_T | _shout_T_1 | _bext_mask_T_1 ? _shout_r_T_5[63:0] : 64'h0) | (io_fn == 5'h1 ? _GEN_15 : 64'h0)) & (_bext_mask_T_1 ? 64'h1 : 64'hFFFFFFFFFFFFFFFF);	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:59:{31,48}, :85:20, :86:28, :87:28, :88:{26,36}, :92:8, :106:46, :107:{64,73}, :108:24, :109:{18,55,91}, :110:{18,25}, :119:{18,25,45,64,75,84}, :120:{18,44,75,84}, :122:{22,70}, :123:{36,44,52,61}, :136:20, :138:43, :139:23, :140:34, :141:{45,51,62}, :142:41, :143:{31,45}, :146:22, :147:{20,35,40,49}, :148:{20,36,42}, :161:47, generators/rocket-chip/src/main/scala/util/package.scala:16:47]
  wire [63:0]      out = io_fn == 5'h12 | io_fn == 5'h11 ? (io_fn[0] ? rotout_r : {rotout_r[0], rotout_r[1], rotout_r[2], rotout_r[3], rotout_r[4], _GEN_34[50:47] | {rotout_r[7:6], rotout_r[9:8]} & 4'h5, _GEN_34[46:39] | _GEN_30 & 8'h55, _GEN_34[38:23] | _GEN_31 & 16'h5555, _GEN_31[1], _GEN_34[21] | _GEN_28[2], {_GEN_28[3], 1'h0} | _GEN_32 & 2'h1, _GEN_34[18:15] | {rotout_r[39:38], rotout_r[41:40]} & 4'h5, _GEN_34[14:7] | _GEN_33 & 8'h55, _GEN_33[1], _GEN_34[5] | rotout_r[50], rotout_r[51], rotout_r[52], {_GEN_34[2:0], 1'h0} | {rotout_r[55:54], rotout_r[57:56]} & 4'h5, rotout_r[57], rotout_r[58], rotout_r[59], rotout_r[60], rotout_r[61], rotout_r[62], rotout_r[63]}) | (io_fn[0] ? _GEN_15 : _shout_r_T_5[63:0]) : (&io_fn) | io_fn == 5'h1E | io_fn == 5'h1D | io_fn == 5'h1C ? (_io_cmp_out_output ? io_in2 : io_in1) : _out_T_5;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:62:35, :88:26, :94:36, :106:46, :107:{64,73}, :108:24, :130:62, :152:23, :157:25, :158:25, :159:{19,50,55}, :161:47, generators/rocket-chip/src/main/scala/util/package.scala:16:47]
  assign io_out = io_dw ? out : {{32{out[31]}}, out[31:0]};	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:83:7, :161:47, :175:10, :178:{28,37,43,48,56,66}]
  assign io_adder_out = _io_adder_out_T_3;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:83:7, :88:36]
  assign io_cmp_out = _io_cmp_out_output;	// @[generators/rocket-chip/src/main/scala/rocket/ALU.scala:83:7, :94:36]
endmodule

