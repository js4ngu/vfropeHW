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

module ShiftBlock_8(	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:12:7]
  input  [7:0] io_in,	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:13:14]
  input  [3:0] io_shamt,	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:13:14]
  input        io_shl,	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:13:14]
  input        io_sign,	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:13:14]
  input  [1:0] io_rm,	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:13:14]
  output [7:0] io_out,	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:13:14]
  output       io_round	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:13:14]
);

  wire [9:0]  _full_shifted_T_33 = $signed($signed({io_shl ? {1'h0, io_in[0], io_in[1], io_in[2], io_in[3], io_in[4], io_in[5], io_in[6], io_in[7]} : {io_sign, io_in}, 1'h0}) >>> io_shamt);	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:22:26, :23:{8,25}, :24:{8,42}]
  wire [15:0] _io_round_T_2 = 16'h1 << io_shamt;	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:30:25]
  wire [8:0]  _io_round_T_3 = _io_round_T_2[8:0] - 9'h1;	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:30:{25,38}]
  wire [7:0]  _io_round_T_7 = io_in & _io_round_T_3[8:1];	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:30:{16,38,45,50}]
  assign io_out = io_shl ? {_full_shifted_T_33[1], _full_shifted_T_33[2], _full_shifted_T_33[3], _full_shifted_T_33[4], _full_shifted_T_33[5], _full_shifted_T_33[6], _full_shifted_T_33[7], _full_shifted_T_33[8]} : _full_shifted_T_33[8:1];	// @[generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:12:7, :24:{42,54}, :26:29, :28:{16,32}]
  assign io_round = (&io_rm) ? ~(_full_shifted_T_33[1]) & (|{_full_shifted_T_33[0], _io_round_T_7}) : io_rm != 2'h2 & (io_rm != 2'h1 | (|_io_round_T_7) | _full_shifted_T_33[1]) & _full_shifted_T_33[0];	// @[generators/saturn/src/main/scala/exu/Rounding.scala:8:106, :10:35, :12:{14,19,25,58}, generators/saturn/src/main/scala/exu/int/ShiftPipe.scala:12:7, :24:{42,54}, :26:29, :29:{47,64}, :30:16]
endmodule

