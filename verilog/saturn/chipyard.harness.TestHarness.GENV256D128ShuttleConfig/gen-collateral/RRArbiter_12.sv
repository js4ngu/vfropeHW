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

module RRArbiter_12(	// @[src/main/scala/chisel3/util/Arbiter.scala:118:7]
  input        clock,	// @[src/main/scala/chisel3/util/Arbiter.scala:118:7]
  output       io_in_0_ready,	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
  input        io_in_0_valid,	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
  input  [5:0] io_in_0_bits_eg,	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
  output       io_in_1_ready,	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
  input        io_in_1_valid,	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
  input  [5:0] io_in_1_bits_eg,	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
  output       io_in_2_ready,	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
  input        io_in_2_valid,	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
  input  [5:0] io_in_2_bits_eg,	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
  output       io_in_3_ready,	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
  input        io_in_3_valid,	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
  input  [5:0] io_in_3_bits_eg,	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
  output       io_in_4_ready,	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
  input        io_in_4_valid,	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
  input  [5:0] io_in_4_bits_eg,	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
  output       io_in_5_ready,	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
  input        io_in_5_valid,	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
  input  [5:0] io_in_5_bits_eg,	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
  input        io_out_ready,	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
  output [5:0] io_out_bits_eg	// @[src/main/scala/chisel3/util/Arbiter.scala:52:14]
);

  wire [2:0]      io_chosen_choice;	// @[src/main/scala/chisel3/util/Arbiter.scala:94:{24,33}]
  wire [7:0][5:0] _GEN = {{io_in_0_bits_eg}, {io_in_0_bits_eg}, {io_in_5_bits_eg}, {io_in_4_bits_eg}, {io_in_3_bits_eg}, {io_in_2_bits_eg}, {io_in_1_bits_eg}, {io_in_0_bits_eg}};	// @[src/main/scala/chisel3/util/Arbiter.scala:55:16]
  reg  [2:0]      ctrl_validMask_grantMask_lastGrant;	// @[src/main/scala/chisel3/util/Arbiter.scala:81:33]
  wire            ctrl_validMask_grantMask_1 = ctrl_validMask_grantMask_lastGrant == 3'h0;	// @[src/main/scala/chisel3/util/Arbiter.scala:81:33, :82:49, :92:{26,35}]
  wire            ctrl_validMask_grantMask_2 = ctrl_validMask_grantMask_lastGrant < 3'h2;	// @[src/main/scala/chisel3/util/Arbiter.scala:81:33, :82:49, :92:{26,35}]
  wire            ctrl_validMask_grantMask_3 = ctrl_validMask_grantMask_lastGrant < 3'h3;	// @[src/main/scala/chisel3/util/Arbiter.scala:81:33, :82:49, :92:{26,35}]
  wire            ctrl_validMask_grantMask_5 = ctrl_validMask_grantMask_lastGrant < 3'h5;	// @[src/main/scala/chisel3/util/Arbiter.scala:81:33, :82:49, :90:41]
  wire            ctrl_validMask_1 = io_in_1_valid & ctrl_validMask_grantMask_1;	// @[src/main/scala/chisel3/util/Arbiter.scala:82:49, :83:76]
  wire            ctrl_validMask_2 = io_in_2_valid & ctrl_validMask_grantMask_2;	// @[src/main/scala/chisel3/util/Arbiter.scala:82:49, :83:76]
  wire            ctrl_validMask_3 = io_in_3_valid & ctrl_validMask_grantMask_3;	// @[src/main/scala/chisel3/util/Arbiter.scala:82:49, :83:76]
  wire            ctrl_validMask_4 = io_in_4_valid & ~(ctrl_validMask_grantMask_lastGrant[2]);	// @[src/main/scala/chisel3/util/Arbiter.scala:81:33, :82:49, :83:76]
  wire            ctrl_validMask_5 = io_in_5_valid & ctrl_validMask_grantMask_5;	// @[src/main/scala/chisel3/util/Arbiter.scala:82:49, :83:76]
  wire            _ctrl_T_1 = ctrl_validMask_1 | ctrl_validMask_2;	// @[src/main/scala/chisel3/util/Arbiter.scala:45:68, :83:76]
  wire            _ctrl_T_2 = _ctrl_T_1 | ctrl_validMask_3;	// @[src/main/scala/chisel3/util/Arbiter.scala:45:68, :83:76]
  wire            _ctrl_T_3 = _ctrl_T_2 | ctrl_validMask_4;	// @[src/main/scala/chisel3/util/Arbiter.scala:45:68, :83:76]
  wire            _ctrl_T_4 = _ctrl_T_3 | ctrl_validMask_5;	// @[src/main/scala/chisel3/util/Arbiter.scala:45:68, :83:76]
  wire            _ctrl_T_5 = _ctrl_T_4 | io_in_0_valid;	// @[src/main/scala/chisel3/util/Arbiter.scala:45:68]
  wire            _ctrl_T_6 = _ctrl_T_5 | io_in_1_valid;	// @[src/main/scala/chisel3/util/Arbiter.scala:45:68]
  wire            _ctrl_T_7 = _ctrl_T_6 | io_in_2_valid;	// @[src/main/scala/chisel3/util/Arbiter.scala:45:68]
  wire            _ctrl_T_8 = _ctrl_T_7 | io_in_3_valid;	// @[src/main/scala/chisel3/util/Arbiter.scala:45:68]
  wire [2:0]      _GEN_0 = io_in_0_valid ? 3'h0 : io_in_1_valid ? 3'h1 : io_in_2_valid ? 3'h2 : io_in_3_valid ? 3'h3 : {2'h2, ~io_in_4_valid};	// @[src/main/scala/chisel3/util/Arbiter.scala:90:41, :92:{26,35}]
  assign io_chosen_choice = ctrl_validMask_1 ? 3'h1 : ctrl_validMask_2 ? 3'h2 : ctrl_validMask_3 ? 3'h3 : ctrl_validMask_4 ? 3'h4 : ctrl_validMask_5 ? 3'h5 : _GEN_0;	// @[src/main/scala/chisel3/util/Arbiter.scala:82:49, :83:76, :90:41, :92:{26,35}, :94:{24,33}]
  wire [7:0]      _GEN_1 = {{io_in_0_valid}, {io_in_0_valid}, {io_in_5_valid}, {io_in_4_valid}, {io_in_3_valid}, {io_in_2_valid}, {io_in_1_valid}, {io_in_0_valid}};	// @[src/main/scala/chisel3/util/Arbiter.scala:55:16]
  always @(posedge clock) begin	// @[src/main/scala/chisel3/util/Arbiter.scala:118:7]
    if (io_out_ready & _GEN_1[io_chosen_choice]) begin	// @[src/main/scala/chisel3/util/Arbiter.scala:55:16, :94:{24,33}, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      if (ctrl_validMask_1)	// @[src/main/scala/chisel3/util/Arbiter.scala:83:76]
        ctrl_validMask_grantMask_lastGrant <= 3'h1;	// @[src/main/scala/chisel3/util/Arbiter.scala:81:33, :92:{26,35}]
      else if (ctrl_validMask_2)	// @[src/main/scala/chisel3/util/Arbiter.scala:83:76]
        ctrl_validMask_grantMask_lastGrant <= 3'h2;	// @[src/main/scala/chisel3/util/Arbiter.scala:81:33, :92:{26,35}]
      else if (ctrl_validMask_3)	// @[src/main/scala/chisel3/util/Arbiter.scala:83:76]
        ctrl_validMask_grantMask_lastGrant <= 3'h3;	// @[src/main/scala/chisel3/util/Arbiter.scala:81:33, :92:{26,35}]
      else if (ctrl_validMask_4)	// @[src/main/scala/chisel3/util/Arbiter.scala:83:76]
        ctrl_validMask_grantMask_lastGrant <= 3'h4;	// @[src/main/scala/chisel3/util/Arbiter.scala:81:33, :82:49]
      else if (ctrl_validMask_5)	// @[src/main/scala/chisel3/util/Arbiter.scala:83:76]
        ctrl_validMask_grantMask_lastGrant <= 3'h5;	// @[src/main/scala/chisel3/util/Arbiter.scala:81:33, :90:41]
      else	// @[src/main/scala/chisel3/util/Arbiter.scala:83:76]
        ctrl_validMask_grantMask_lastGrant <= _GEN_0;	// @[src/main/scala/chisel3/util/Arbiter.scala:81:33, :92:{26,35}]
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[src/main/scala/chisel3/util/Arbiter.scala:118:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[src/main/scala/chisel3/util/Arbiter.scala:118:7]
      `FIRRTL_BEFORE_INITIAL	// @[src/main/scala/chisel3/util/Arbiter.scala:118:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:0];	// @[src/main/scala/chisel3/util/Arbiter.scala:118:7]
    initial begin	// @[src/main/scala/chisel3/util/Arbiter.scala:118:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[src/main/scala/chisel3/util/Arbiter.scala:118:7]
        `INIT_RANDOM_PROLOG_	// @[src/main/scala/chisel3/util/Arbiter.scala:118:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[src/main/scala/chisel3/util/Arbiter.scala:118:7]
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;	// @[src/main/scala/chisel3/util/Arbiter.scala:118:7]
        ctrl_validMask_grantMask_lastGrant = _RANDOM[/*Zero width*/ 1'b0][2:0];	// @[src/main/scala/chisel3/util/Arbiter.scala:81:33, :118:7]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[src/main/scala/chisel3/util/Arbiter.scala:118:7]
      `FIRRTL_AFTER_INITIAL	// @[src/main/scala/chisel3/util/Arbiter.scala:118:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_in_0_ready = ~_ctrl_T_4 & io_out_ready;	// @[src/main/scala/chisel3/util/Arbiter.scala:45:{68,78}, :74:21, :118:7]
  assign io_in_1_ready = (ctrl_validMask_grantMask_1 | ~_ctrl_T_5) & io_out_ready;	// @[src/main/scala/chisel3/util/Arbiter.scala:45:{68,78}, :74:21, :82:49, :87:50, :118:7]
  assign io_in_2_ready = (~ctrl_validMask_1 & ctrl_validMask_grantMask_2 | ~_ctrl_T_6) & io_out_ready;	// @[src/main/scala/chisel3/util/Arbiter.scala:45:{68,78}, :74:21, :82:49, :83:76, :87:{34,50}, :118:7]
  assign io_in_3_ready = (~_ctrl_T_1 & ctrl_validMask_grantMask_3 | ~_ctrl_T_7) & io_out_ready;	// @[src/main/scala/chisel3/util/Arbiter.scala:45:{68,78}, :74:21, :82:49, :87:{34,50}, :118:7]
  assign io_in_4_ready = (~_ctrl_T_2 & ~(ctrl_validMask_grantMask_lastGrant[2]) | ~_ctrl_T_8) & io_out_ready;	// @[src/main/scala/chisel3/util/Arbiter.scala:45:{68,78}, :74:21, :81:33, :82:49, :87:{34,50}, :118:7]
  assign io_in_5_ready = (~_ctrl_T_3 & ctrl_validMask_grantMask_5 | ~(_ctrl_T_8 | io_in_4_valid)) & io_out_ready;	// @[src/main/scala/chisel3/util/Arbiter.scala:45:{68,78}, :74:21, :82:49, :87:{34,50}, :118:7]
  assign io_out_bits_eg = _GEN[io_chosen_choice];	// @[src/main/scala/chisel3/util/Arbiter.scala:55:16, :94:{24,33}, :118:7]
endmodule

