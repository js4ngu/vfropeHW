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

module ShiftBlock(	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:12:7]
  input  [63:0] io_in,	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:13:14]
  input  [6:0]  io_shamt,	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:13:14]
  input         io_shl,	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:13:14]
  input         io_sign,	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:13:14]
  input  [1:0]  io_rm,	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:13:14]
  output [63:0] io_out,	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:13:14]
  output        io_round	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:13:14]
);

  wire [15:0]  _GEN = {{io_in[23:16], io_in[31:28]} & 12'hF0F, 4'h0} | {io_in[31:24], io_in[39:32]} & 16'hF0F;	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:23:25]
  wire [37:0]  _GEN_0 = {io_in[11:8], io_in[15:12], io_in[19:16], _GEN, io_in[39:36], io_in[43:40], io_in[47:46]} & 38'h3333333333;	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:23:25]
  wire [7:0]   _GEN_1 = _GEN_0[37:30] | {io_in[15:12], io_in[19:16]} & 8'h33;	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:23:25]
  wire [15:0]  _GEN_2 = _GEN_0[29:14] | _GEN & 16'h3333;	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:23:25]
  wire [1:0]   _GEN_3 = _GEN_0[11:10] | io_in[37:36];	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:23:25]
  wire [7:0]   _GEN_4 = {_GEN_0[5:0], 2'h0} | {io_in[47:44], io_in[51:48]} & 8'h33;	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:23:25]
  wire [50:0]  _GEN_5 = {io_in[5:4], io_in[7:6], io_in[9:8], _GEN_1, _GEN_2, _GEN[3:2], _GEN_3, io_in[39:38], io_in[41:40], _GEN_4, io_in[51:50], io_in[53:52], io_in[55]} & 51'h5555555555555;	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:23:25]
  wire [65:0]  _full_shifted_T_63 = $signed($signed({io_shl ? {1'h0, io_in[0], io_in[1], io_in[2], io_in[3], io_in[4], _GEN_5[50:47] | {io_in[7:6], io_in[9:8]} & 4'h5, _GEN_5[46:39] | _GEN_1 & 8'h55, _GEN_5[38:23] | _GEN_2 & 16'h5555, _GEN_2[1], _GEN_5[21] | _GEN[2], {_GEN[3], 1'h0} | _GEN_3 & 2'h1, _GEN_5[18:15] | {io_in[39:38], io_in[41:40]} & 4'h5, _GEN_5[14:7] | _GEN_4 & 8'h55, _GEN_4[1], _GEN_5[5] | io_in[50], io_in[51], io_in[52], {_GEN_5[2:0], 1'h0} | {io_in[55:54], io_in[57:56]} & 4'h5, io_in[57], io_in[58], io_in[59], io_in[60], io_in[61], io_in[62], io_in[63]} : {io_sign, io_in}, 1'h0}) >>> io_shamt);	// @[generators/saturn/src/main/scala/exu/Rounding.scala:8:106, generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:22:26, :23:{8,25}, :24:{8,42}]
  wire [15:0]  _GEN_6 = {{_full_shifted_T_63[24:17], _full_shifted_T_63[32:29]} & 12'hF0F, 4'h0} | {_full_shifted_T_63[32:25], _full_shifted_T_63[40:33]} & 16'hF0F;	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:23:25, :24:{42,54}, :26:29, :28:32]
  wire [37:0]  _GEN_7 = {_full_shifted_T_63[12:9], _full_shifted_T_63[16:13], _full_shifted_T_63[20:17], _GEN_6, _full_shifted_T_63[40:37], _full_shifted_T_63[44:41], _full_shifted_T_63[48:47]} & 38'h3333333333;	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:23:25, :24:42, :28:32]
  wire [7:0]   _GEN_8 = _GEN_7[37:30] | {_full_shifted_T_63[16:13], _full_shifted_T_63[20:17]} & 8'h33;	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:23:25, :24:42, :28:32]
  wire [15:0]  _GEN_9 = _GEN_7[29:14] | _GEN_6 & 16'h3333;	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:23:25, :28:32]
  wire [1:0]   _GEN_10 = _GEN_7[11:10] | _full_shifted_T_63[38:37];	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:23:25, :24:42, :28:32]
  wire [7:0]   _GEN_11 = {_GEN_7[5:0], 2'h0} | {_full_shifted_T_63[48:45], _full_shifted_T_63[52:49]} & 8'h33;	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:23:25, :24:42, :28:32]
  wire [50:0]  _GEN_12 = {_full_shifted_T_63[6:5], _full_shifted_T_63[8:7], _full_shifted_T_63[10:9], _GEN_8, _GEN_9, _GEN_6[3:2], _GEN_10, _full_shifted_T_63[40:39], _full_shifted_T_63[42:41], _GEN_11, _full_shifted_T_63[52:51], _full_shifted_T_63[54:53], _full_shifted_T_63[56]} & 51'h5555555555555;	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:23:25, :24:42, :28:32]
  wire [127:0] _io_round_T_2 = 128'h1 << io_shamt;	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:30:25]
  wire [64:0]  _io_round_T_3 = _io_round_T_2[64:0] - 65'h1;	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:30:{25,38}]
  wire [63:0]  _io_round_T_7 = io_in & _io_round_T_3[64:1];	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:30:{16,38,45,50}]
  assign io_out = io_shl ? {_full_shifted_T_63[1], _full_shifted_T_63[2], _full_shifted_T_63[3], _full_shifted_T_63[4], _full_shifted_T_63[5], _GEN_12[50:47] | {_full_shifted_T_63[8:7], _full_shifted_T_63[10:9]} & 4'h5, _GEN_12[46:39] | _GEN_8 & 8'h55, _GEN_12[38:23] | _GEN_9 & 16'h5555, _GEN_9[1], _GEN_12[21] | _GEN_6[2], {_GEN_6[3], 1'h0} | _GEN_10 & 2'h1, _GEN_12[18:15] | {_full_shifted_T_63[40:39], _full_shifted_T_63[42:41]} & 4'h5, _GEN_12[14:7] | _GEN_11 & 8'h55, _GEN_11[1], _GEN_12[5] | _full_shifted_T_63[51], _full_shifted_T_63[52], _full_shifted_T_63[53], {_GEN_12[2:0], 1'h0} | {_full_shifted_T_63[56:55], _full_shifted_T_63[58:57]} & 4'h5, _full_shifted_T_63[58], _full_shifted_T_63[59], _full_shifted_T_63[60], _full_shifted_T_63[61], _full_shifted_T_63[62], _full_shifted_T_63[63], _full_shifted_T_63[64]} : _full_shifted_T_63[64:1];	// @[generators/saturn/src/main/scala/exu/Rounding.scala:8:106, generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:12:7, :23:{8,25}, :24:{42,54}, :26:29, :28:{16,32}]
  assign io_round = (&io_rm) ? ~(_full_shifted_T_63[1]) & (|{_full_shifted_T_63[0], _io_round_T_7}) : io_rm != 2'h2 & (io_rm != 2'h1 | (|_io_round_T_7) | _full_shifted_T_63[1]) & _full_shifted_T_63[0];	// @[generators/saturn/src/main/scala/exu/Rounding.scala:8:106, :10:35, :12:{14,19,25,58}, generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:12:7, :24:{42,54}, :26:29, :29:{47,64}, :30:16]
endmodule
