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

module ShuttleFPPipe(	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7]
  input         clock,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7]
  input         reset,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7]
  input         io_in_valid,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  input  [31:0] io_in_bits_inst,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  input         io_in_bits_fp_ctrl_ren2,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  input         io_in_bits_fp_ctrl_ren3,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  input         io_in_bits_fp_ctrl_swap23,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  input  [1:0]  io_in_bits_fp_ctrl_typeTagIn,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  input  [1:0]  io_in_bits_fp_ctrl_typeTagOut,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  input         io_in_bits_fp_ctrl_fromint,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  input         io_in_bits_fp_ctrl_toint,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  input         io_in_bits_fp_ctrl_fastpipe,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  input         io_in_bits_fp_ctrl_fma,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  input         io_in_bits_fp_ctrl_div,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  input         io_in_bits_fp_ctrl_sqrt,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  input         io_in_bits_fp_ctrl_wflags,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  input  [63:0] io_in_bits_rs1_data,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  input  [64:0] io_frs1_data,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  input  [64:0] io_frs2_data,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  input  [64:0] io_frs3_data,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  input  [2:0]  io_fcsr_rm,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  input         io_s1_kill,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  output [63:0] io_s1_store_data,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  output [63:0] io_s1_fpiu_toint,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  output [4:0]  io_s1_fpiu_fexc,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  output [2:0]  io_s1_fpiu_fdiv_rm,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  output [64:0] io_s1_fpiu_fdiv_in1,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  output [64:0] io_s1_fpiu_fdiv_in2,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  output        io_out_valid,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  output [64:0] io_out_bits_data,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  output [4:0]  io_out_bits_exc,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  output [4:0]  io_out_rd,	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
  output [1:0]  io_out_tag	// @[generators/shuttle/src/main/scala/exu/FPU.scala:17:14]
);

  wire        _fpmu_io_out_valid;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:93:20]
  wire [64:0] _fpmu_io_out_bits_data;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:93:20]
  wire [4:0]  _fpmu_io_out_bits_exc;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:93:20]
  wire        _ifpu_io_out_valid;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:88:20]
  wire [64:0] _ifpu_io_out_bits_data;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:88:20]
  wire [4:0]  _ifpu_io_out_bits_exc;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:88:20]
  wire        _hfma_io_out_valid;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:81:20]
  wire [64:0] _hfma_io_out_bits_data;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:81:20]
  wire [4:0]  _hfma_io_out_bits_exc;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:81:20]
  wire        _sfma_io_out_valid;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:80:20]
  wire [64:0] _sfma_io_out_bits_data;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:80:20]
  wire [4:0]  _sfma_io_out_bits_exc;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:80:20]
  wire        _dfma_io_out_valid;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:79:20]
  wire [64:0] _dfma_io_out_bits_data;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:79:20]
  wire [4:0]  _dfma_io_out_bits_exc;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:79:20]
  wire        _fpiu_io_out_bits_lt;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:71:20]
  wire [2:0]  fpmu_io_in_bits_req_rm = (&(io_in_bits_inst[14:12])) ? io_fcsr_rm : io_in_bits_inst[14:12];	// @[generators/shuttle/src/main/scala/exu/FPU.scala:69:{15,20,28}]
  wire        _io_out_valid_T = io_in_bits_fp_ctrl_toint | io_in_bits_fp_ctrl_div;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:72:53]
  wire [2:0]  fpiu_io_in_bits_req_in1_prev_prev_prev_prev_expOut_expCode = {io_frs1_data[23], io_frs1_data[14:13]};	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:276:18, :279:26, :358:14]
  wire [11:0] _fpiu_io_in_bits_req_in1_prev_prev_prev_prev_expOut_commonCase_T_2 = {6'h0, io_frs1_data[23], io_frs1_data[14:10]} + 12'h7E0;	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:276:18, :280:{31,50}, :358:14]
  wire [2:0]  fpiu_io_in_bits_req_in1_prev_prev_expOut_expCode = {io_frs1_data[52], io_frs1_data[30:29]};	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:276:18, :279:26, :358:14]
  wire [11:0] _GEN = {3'h0, io_frs1_data[52], io_frs1_data[30:23]};	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:276:18, :280:31, :281:19, :358:14]
  wire [11:0] _fpiu_io_in_bits_req_in1_prev_prev_expOut_commonCase_T_2 = _GEN + 12'h700;	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:280:{31,50}]
  wire        _fpmu_io_in_bits_req_in3_T_6 = io_in_bits_fp_ctrl_typeTagIn == 2'h1;	// @[generators/rocket-chip/src/main/scala/util/package.scala:39:86, generators/shuttle/src/main/scala/exu/FPU.scala:15:7]
  wire        _GEN_0 = (&io_in_bits_fp_ctrl_typeTagIn) | io_in_bits_fp_ctrl_typeTagIn == 2'h2;	// @[generators/rocket-chip/src/main/scala/util/package.scala:39:{76,86}, generators/shuttle/src/main/scala/exu/FPU.scala:15:7]
  wire [2:0]  fpiu_io_in_bits_req_in2_prev_prev_prev_prev_expOut_expCode = {io_frs2_data[23], io_frs2_data[14:13]};	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:276:18, :279:26, :358:14]
  wire [11:0] _fpiu_io_in_bits_req_in2_prev_prev_prev_prev_expOut_commonCase_T_2 = {6'h0, io_frs2_data[23], io_frs2_data[14:10]} + 12'h7E0;	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:276:18, :280:{31,50}, :358:14]
  wire [2:0]  fpiu_io_in_bits_req_in2_prev_prev_expOut_expCode = {io_frs2_data[52], io_frs2_data[30:29]};	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:276:18, :279:26, :358:14]
  wire [11:0] _GEN_1 = {3'h0, io_frs2_data[52], io_frs2_data[30:23]};	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:276:18, :280:31, :281:19, :358:14]
  wire [11:0] _fpiu_io_in_bits_req_in2_prev_prev_expOut_commonCase_T_2 = _GEN_1 + 12'h700;	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:280:{31,50}]
  wire [2:0]  fpmu_io_in_bits_req_in1_prev_prev_prev_prev_expOut_expCode = {io_frs1_data[23], io_frs1_data[14:13]};	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:276:18, :279:26, :358:14]
  wire [11:0] _fpmu_io_in_bits_req_in1_prev_prev_prev_prev_expOut_commonCase_T_2 = {6'h0, io_frs1_data[23], io_frs1_data[14:10]} + 12'h7E0;	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:276:18, :280:{31,50}, :358:14]
  wire [2:0]  fpmu_io_in_bits_req_in1_prev_prev_expOut_expCode = {io_frs1_data[52], io_frs1_data[30:29]};	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:276:18, :279:26, :358:14]
  wire [11:0] _fpmu_io_in_bits_req_in1_prev_prev_expOut_commonCase_T_2 = _GEN + 12'h700;	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:280:{31,50}]
  wire [2:0]  fpmu_io_in_bits_req_in2_prev_prev_prev_prev_expOut_expCode = {io_frs2_data[23], io_frs2_data[14:13]};	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:276:18, :279:26, :358:14]
  wire [11:0] _fpmu_io_in_bits_req_in2_prev_prev_prev_prev_expOut_commonCase_T_2 = {6'h0, io_frs2_data[23], io_frs2_data[14:10]} + 12'h7E0;	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:276:18, :280:{31,50}, :358:14]
  wire [2:0]  fpmu_io_in_bits_req_in2_prev_prev_expOut_expCode = {io_frs2_data[52], io_frs2_data[30:29]};	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:276:18, :279:26, :358:14]
  wire [11:0] _fpmu_io_in_bits_req_in2_prev_prev_expOut_commonCase_T_2 = _GEN_1 + 12'h700;	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:280:{31,50}]
  reg         io_out_valid_r;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:99:33]
  reg         io_out_valid_r_1;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:99:33]
  reg         io_out_valid_r_2;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:99:33]
  reg         io_out_valid_r_3;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:99:33]
  reg         io_out_valid_r_4;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:100:22]
  reg         io_out_valid_r_5;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:100:22]
  reg         io_out_valid_r_6;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:100:22]
  reg  [4:0]  io_out_rd_r;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:106:29]
  reg  [4:0]  io_out_rd_r_1;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:106:29]
  reg  [4:0]  io_out_rd_r_2;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:106:29]
  reg  [4:0]  io_out_rd_r_3;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:106:29]
  reg  [1:0]  io_out_tag_r;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:107:30]
  reg  [1:0]  io_out_tag_r_1;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:107:30]
  reg  [1:0]  io_out_tag_r_2;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:107:30]
  reg  [1:0]  io_out_tag_r_3;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:107:30]
  always @(posedge clock) begin	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7]
    io_out_valid_r <= io_in_valid & ~(_io_out_valid_T | io_in_bits_fp_ctrl_sqrt);	// @[generators/shuttle/src/main/scala/exu/FPU.scala:72:53, :99:{33,46,49,80}]
    io_out_valid_r_1 <= io_out_valid_r;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:99:33]
    io_out_valid_r_2 <= io_out_valid_r_1;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:99:33]
    io_out_valid_r_3 <= io_out_valid_r_2;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:99:33]
    io_out_valid_r_4 <= io_s1_kill;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:100:22]
    io_out_valid_r_5 <= io_out_valid_r_4;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:100:22]
    io_out_valid_r_6 <= io_out_valid_r_5;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:100:22]
    io_out_rd_r <= io_in_bits_inst[11:7];	// @[generators/shuttle/src/main/scala/common/MicroOp.scala:54:16, generators/shuttle/src/main/scala/exu/FPU.scala:106:29]
    io_out_rd_r_1 <= io_out_rd_r;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:106:29]
    io_out_rd_r_2 <= io_out_rd_r_1;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:106:29]
    io_out_rd_r_3 <= io_out_rd_r_2;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:106:29]
    io_out_tag_r <= io_in_bits_fp_ctrl_typeTagOut;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:107:30]
    io_out_tag_r_1 <= io_out_tag_r;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:107:30]
    io_out_tag_r_2 <= io_out_tag_r_1;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:107:30]
    io_out_tag_r_3 <= io_out_tag_r_2;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:107:30]
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7]
      `FIRRTL_BEFORE_INITIAL	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:1];	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7]
    initial begin	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7]
        `INIT_RANDOM_PROLOG_	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7]
        for (logic [1:0] i = 2'h0; i < 2'h2; i += 2'h1) begin
          _RANDOM[i[0]] = `RANDOM;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7]
        end	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7]
        io_out_valid_r = _RANDOM[1'h0][0];	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :99:33]
        io_out_valid_r_1 = _RANDOM[1'h0][1];	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :99:33]
        io_out_valid_r_2 = _RANDOM[1'h0][2];	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :99:33]
        io_out_valid_r_3 = _RANDOM[1'h0][3];	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :99:33]
        io_out_valid_r_4 = _RANDOM[1'h0][4];	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :99:33, :100:22]
        io_out_valid_r_5 = _RANDOM[1'h0][5];	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :99:33, :100:22]
        io_out_valid_r_6 = _RANDOM[1'h0][6];	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :99:33, :100:22]
        io_out_rd_r = _RANDOM[1'h0][13:9];	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :99:33, :106:29]
        io_out_rd_r_1 = _RANDOM[1'h0][18:14];	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :99:33, :106:29]
        io_out_rd_r_2 = _RANDOM[1'h0][23:19];	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :99:33, :106:29]
        io_out_rd_r_3 = _RANDOM[1'h0][28:24];	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :99:33, :106:29]
        io_out_tag_r = _RANDOM[1'h0][30:29];	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :99:33, :107:30]
        io_out_tag_r_1 = {_RANDOM[1'h0][31], _RANDOM[1'h1][0]};	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :99:33, :107:30]
        io_out_tag_r_2 = _RANDOM[1'h1][2:1];	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :107:30]
        io_out_tag_r_3 = _RANDOM[1'h1][4:3];	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :107:30]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7]
      `FIRRTL_AFTER_INITIAL	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  FPToInt fpiu (	// @[generators/shuttle/src/main/scala/exu/FPU.scala:71:20]
    .clock                 (clock),
    .io_in_valid           (io_in_valid & (_io_out_valid_T | io_in_bits_fp_ctrl_sqrt | io_in_bits_fp_ctrl_fastpipe & io_in_bits_fp_ctrl_wflags)),	// @[generators/shuttle/src/main/scala/exu/FPU.scala:72:{35,53,84,105}]
    .io_in_bits_ren2       (io_in_bits_fp_ctrl_ren2),
    .io_in_bits_typeTagOut (io_in_bits_fp_ctrl_typeTagOut),
    .io_in_bits_wflags     (io_in_bits_fp_ctrl_wflags),
    .io_in_bits_rm         (fpmu_io_in_bits_req_rm),	// @[generators/shuttle/src/main/scala/exu/FPU.scala:69:15]
    .io_in_bits_typ        (io_in_bits_inst[21:20]),	// @[generators/shuttle/src/main/scala/exu/FPU.scala:58:20]
    .io_in_bits_fmt        (io_in_bits_inst[26:25]),	// @[generators/shuttle/src/main/scala/exu/FPU.scala:59:20]
    .io_in_bits_in1        (_GEN_0 | (_fpmu_io_in_bits_req_in3_T_6 | (&{io_frs1_data[31], io_frs1_data[52], io_frs1_data[30:28]})) & (&(io_frs1_data[64:60])) ? (_GEN_0 ? io_frs1_data : _fpmu_io_in_bits_req_in3_T_6 ? {io_frs1_data[31], fpiu_io_in_bits_req_in1_prev_prev_expOut_expCode == 3'h0 | fpiu_io_in_bits_req_in1_prev_prev_expOut_expCode > 3'h5 ? {io_frs1_data[52], io_frs1_data[30:29], _fpiu_io_in_bits_req_in1_prev_prev_expOut_commonCase_T_2[8:0]} : _fpiu_io_in_bits_req_in1_prev_prev_expOut_commonCase_T_2, io_frs1_data[22:0], 29'h0} : {io_frs1_data[15], fpiu_io_in_bits_req_in1_prev_prev_prev_prev_expOut_expCode == 3'h0 | fpiu_io_in_bits_req_in1_prev_prev_prev_prev_expOut_expCode > 3'h5 ? {io_frs1_data[23], io_frs1_data[14:13], _fpiu_io_in_bits_req_in1_prev_prev_prev_prev_expOut_commonCase_T_2[8:0]} : _fpiu_io_in_bits_req_in1_prev_prev_prev_prev_expOut_commonCase_T_2, io_frs1_data[9:0], 42'h0}) : 65'hE008000000000000),	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:275:20, :276:18, :277:38, :279:26, :280:50, :281:{10,19,27,38,49,69}, :283:8, :332:{49,84}, :357:14, :358:14, :369:10, generators/rocket-chip/src/main/scala/util/package.scala:39:{76,86}]
    .io_in_bits_in2        (_GEN_0 | (_fpmu_io_in_bits_req_in3_T_6 | (&{io_frs2_data[31], io_frs2_data[52], io_frs2_data[30:28]})) & (&(io_frs2_data[64:60])) ? (_GEN_0 ? io_frs2_data : _fpmu_io_in_bits_req_in3_T_6 ? {io_frs2_data[31], fpiu_io_in_bits_req_in2_prev_prev_expOut_expCode == 3'h0 | fpiu_io_in_bits_req_in2_prev_prev_expOut_expCode > 3'h5 ? {io_frs2_data[52], io_frs2_data[30:29], _fpiu_io_in_bits_req_in2_prev_prev_expOut_commonCase_T_2[8:0]} : _fpiu_io_in_bits_req_in2_prev_prev_expOut_commonCase_T_2, io_frs2_data[22:0], 29'h0} : {io_frs2_data[15], fpiu_io_in_bits_req_in2_prev_prev_prev_prev_expOut_expCode == 3'h0 | fpiu_io_in_bits_req_in2_prev_prev_prev_prev_expOut_expCode > 3'h5 ? {io_frs2_data[23], io_frs2_data[14:13], _fpiu_io_in_bits_req_in2_prev_prev_prev_prev_expOut_commonCase_T_2[8:0]} : _fpiu_io_in_bits_req_in2_prev_prev_prev_prev_expOut_commonCase_T_2, io_frs2_data[9:0], 42'h0}) : 65'hE008000000000000),	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:275:20, :276:18, :277:38, :279:26, :280:50, :281:{10,19,27,38,49,69}, :283:8, :332:{49,84}, :357:14, :358:14, :369:10, generators/rocket-chip/src/main/scala/util/package.scala:39:{76,86}]
    .io_out_bits_in_rm     (io_s1_fpiu_fdiv_rm),
    .io_out_bits_in_in1    (io_s1_fpiu_fdiv_in1),
    .io_out_bits_in_in2    (io_s1_fpiu_fdiv_in2),
    .io_out_bits_lt        (_fpiu_io_out_bits_lt),
    .io_out_bits_store     (io_s1_store_data),
    .io_out_bits_toint     (io_s1_fpiu_toint),
    .io_out_bits_exc       (io_s1_fpiu_fexc)
  );
  FPUFMAPipe_l4_f64 dfma (	// @[generators/shuttle/src/main/scala/exu/FPU.scala:79:20]
    .clock             (clock),
    .reset             (reset),
    .io_in_valid       (io_in_valid & io_in_bits_fp_ctrl_typeTagOut == 2'h2 & io_in_bits_fp_ctrl_fma),	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :84:{58,82}]
    .io_in_bits_ren3   (io_in_bits_fp_ctrl_ren3),
    .io_in_bits_swap23 (io_in_bits_fp_ctrl_swap23),
    .io_in_bits_rm     (fpmu_io_in_bits_req_rm),	// @[generators/shuttle/src/main/scala/exu/FPU.scala:69:15]
    .io_in_bits_fmaCmd ({io_in_bits_inst[3], io_in_bits_inst[2] | ~io_in_bits_fp_ctrl_ren3 & io_in_bits_inst[27]}),	// @[generators/shuttle/src/main/scala/exu/FPU.scala:60:{23,29,32,43,50}]
    .io_in_bits_in1    (io_frs1_data),
    .io_in_bits_in2    (io_frs2_data),
    .io_in_bits_in3    (io_frs3_data),
    .io_out_valid      (_dfma_io_out_valid),
    .io_out_bits_data  (_dfma_io_out_bits_data),
    .io_out_bits_exc   (_dfma_io_out_bits_exc)
  );
  FPUFMAPipe_l4_f32 sfma (	// @[generators/shuttle/src/main/scala/exu/FPU.scala:80:20]
    .clock             (clock),
    .reset             (reset),
    .io_in_valid       (io_in_valid & io_in_bits_fp_ctrl_typeTagOut == 2'h1 & io_in_bits_fp_ctrl_fma),	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :84:{58,82}]
    .io_in_bits_ren3   (io_in_bits_fp_ctrl_ren3),
    .io_in_bits_swap23 (io_in_bits_fp_ctrl_swap23),
    .io_in_bits_rm     (fpmu_io_in_bits_req_rm),	// @[generators/shuttle/src/main/scala/exu/FPU.scala:69:15]
    .io_in_bits_fmaCmd ({io_in_bits_inst[3], io_in_bits_inst[2] | ~io_in_bits_fp_ctrl_ren3 & io_in_bits_inst[27]}),	// @[generators/shuttle/src/main/scala/exu/FPU.scala:60:{23,29,32,43,50}]
    .io_in_bits_in1    ({32'h0, {io_frs1_data[31], io_frs1_data[52], io_frs1_data[30:0]} | ((&(io_frs1_data[64:60])) ? 33'h0 : 33'hE0400000)}),	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:332:{49,84}, :356:31, :357:14, :358:14, :359:14, :372:{26,31}, generators/shuttle/src/main/scala/exu/FPU.scala:55:13]
    .io_in_bits_in2    ({32'h0, {io_frs2_data[31], io_frs2_data[52], io_frs2_data[30:0]} | ((&(io_frs2_data[64:60])) ? 33'h0 : 33'hE0400000)}),	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:332:{49,84}, :356:31, :357:14, :358:14, :359:14, :372:{26,31}, generators/shuttle/src/main/scala/exu/FPU.scala:55:13, :56:13]
    .io_in_bits_in3    ({32'h0, {io_frs3_data[31], io_frs3_data[52], io_frs3_data[30:0]} | ((&(io_frs3_data[64:60])) ? 33'h0 : 33'hE0400000)}),	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:332:{49,84}, :356:31, :357:14, :358:14, :359:14, :372:{26,31}, generators/shuttle/src/main/scala/exu/FPU.scala:55:13, :57:13]
    .io_out_valid      (_sfma_io_out_valid),
    .io_out_bits_data  (_sfma_io_out_bits_data),
    .io_out_bits_exc   (_sfma_io_out_bits_exc)
  );
  FPUFMAPipe_l4_f16 hfma (	// @[generators/shuttle/src/main/scala/exu/FPU.scala:81:20]
    .clock             (clock),
    .reset             (reset),
    .io_in_valid       (io_in_valid & io_in_bits_fp_ctrl_typeTagOut == 2'h0 & io_in_bits_fp_ctrl_fma),	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :84:{58,82}]
    .io_in_bits_ren3   (io_in_bits_fp_ctrl_ren3),
    .io_in_bits_swap23 (io_in_bits_fp_ctrl_swap23),
    .io_in_bits_rm     (fpmu_io_in_bits_req_rm),	// @[generators/shuttle/src/main/scala/exu/FPU.scala:69:15]
    .io_in_bits_fmaCmd ({io_in_bits_inst[3], io_in_bits_inst[2] | ~io_in_bits_fp_ctrl_ren3 & io_in_bits_inst[27]}),	// @[generators/shuttle/src/main/scala/exu/FPU.scala:60:{23,29,32,43,50}]
    .io_in_bits_in1    ({48'h0, {io_frs1_data[15], io_frs1_data[23], io_frs1_data[14:0]} | ((&(io_frs1_data[64:60])) & (&{io_frs1_data[31], io_frs1_data[52], io_frs1_data[30:28]}) ? 17'h0 : 17'hE200)}),	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:332:{49,84}, :356:31, :357:14, :358:14, :359:14, :362:32, :372:{26,31}, generators/shuttle/src/main/scala/exu/FPU.scala:55:13]
    .io_in_bits_in2    ({48'h0, {io_frs2_data[15], io_frs2_data[23], io_frs2_data[14:0]} | ((&(io_frs2_data[64:60])) & (&{io_frs2_data[31], io_frs2_data[52], io_frs2_data[30:28]}) ? 17'h0 : 17'hE200)}),	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:332:{49,84}, :356:31, :357:14, :358:14, :359:14, :362:32, :372:{26,31}, generators/shuttle/src/main/scala/exu/FPU.scala:55:13, :56:13]
    .io_in_bits_in3    ({48'h0, {io_frs3_data[15], io_frs3_data[23], io_frs3_data[14:0]} | ((&(io_frs3_data[64:60])) & (&{io_frs3_data[31], io_frs3_data[52], io_frs3_data[30:28]}) ? 17'h0 : 17'hE200)}),	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:332:{49,84}, :356:31, :357:14, :358:14, :359:14, :362:32, :372:{26,31}, generators/shuttle/src/main/scala/exu/FPU.scala:55:13, :57:13]
    .io_out_valid      (_hfma_io_out_valid),
    .io_out_bits_data  (_hfma_io_out_bits_data),
    .io_out_bits_exc   (_hfma_io_out_bits_exc)
  );
  IntToFP ifpu (	// @[generators/shuttle/src/main/scala/exu/FPU.scala:88:20]
    .clock                (clock),
    .reset                (reset),
    .io_in_valid          (io_in_valid & io_in_bits_fp_ctrl_fromint),	// @[generators/shuttle/src/main/scala/exu/FPU.scala:89:35]
    .io_in_bits_typeTagIn (io_in_bits_fp_ctrl_typeTagIn),
    .io_in_bits_wflags    (io_in_bits_fp_ctrl_wflags),
    .io_in_bits_rm        (fpmu_io_in_bits_req_rm),	// @[generators/shuttle/src/main/scala/exu/FPU.scala:69:15]
    .io_in_bits_typ       (io_in_bits_inst[21:20]),	// @[generators/shuttle/src/main/scala/exu/FPU.scala:58:20]
    .io_in_bits_in1       (io_in_bits_rs1_data),
    .io_out_valid         (_ifpu_io_out_valid),
    .io_out_bits_data     (_ifpu_io_out_bits_data),
    .io_out_bits_exc      (_ifpu_io_out_bits_exc)
  );
  FPToFP fpmu (	// @[generators/shuttle/src/main/scala/exu/FPU.scala:93:20]
    .clock                 (clock),
    .reset                 (reset),
    .io_in_valid           (io_in_valid & io_in_bits_fp_ctrl_fastpipe),	// @[generators/shuttle/src/main/scala/exu/FPU.scala:95:35]
    .io_in_bits_ren2       (io_in_bits_fp_ctrl_ren2),
    .io_in_bits_typeTagIn  (io_in_bits_fp_ctrl_typeTagIn),
    .io_in_bits_typeTagOut (io_in_bits_fp_ctrl_typeTagOut),
    .io_in_bits_wflags     (io_in_bits_fp_ctrl_wflags),
    .io_in_bits_rm         (fpmu_io_in_bits_req_rm),	// @[generators/shuttle/src/main/scala/exu/FPU.scala:69:15]
    .io_in_bits_in1        (_GEN_0 | (_fpmu_io_in_bits_req_in3_T_6 | (&{io_frs1_data[31], io_frs1_data[52], io_frs1_data[30:28]})) & (&(io_frs1_data[64:60])) ? (_GEN_0 ? io_frs1_data : _fpmu_io_in_bits_req_in3_T_6 ? {io_frs1_data[31], fpmu_io_in_bits_req_in1_prev_prev_expOut_expCode == 3'h0 | fpmu_io_in_bits_req_in1_prev_prev_expOut_expCode > 3'h5 ? {io_frs1_data[52], io_frs1_data[30:29], _fpmu_io_in_bits_req_in1_prev_prev_expOut_commonCase_T_2[8:0]} : _fpmu_io_in_bits_req_in1_prev_prev_expOut_commonCase_T_2, io_frs1_data[22:0], 29'h0} : {io_frs1_data[15], fpmu_io_in_bits_req_in1_prev_prev_prev_prev_expOut_expCode == 3'h0 | fpmu_io_in_bits_req_in1_prev_prev_prev_prev_expOut_expCode > 3'h5 ? {io_frs1_data[23], io_frs1_data[14:13], _fpmu_io_in_bits_req_in1_prev_prev_prev_prev_expOut_commonCase_T_2[8:0]} : _fpmu_io_in_bits_req_in1_prev_prev_prev_prev_expOut_commonCase_T_2, io_frs1_data[9:0], 42'h0}) : 65'hE008000000000000),	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:275:20, :276:18, :277:38, :279:26, :280:50, :281:{10,19,27,38,49,69}, :283:8, :332:{49,84}, :357:14, :358:14, :369:10, generators/rocket-chip/src/main/scala/util/package.scala:39:{76,86}]
    .io_in_bits_in2        (_GEN_0 | (_fpmu_io_in_bits_req_in3_T_6 | (&{io_frs2_data[31], io_frs2_data[52], io_frs2_data[30:28]})) & (&(io_frs2_data[64:60])) ? (_GEN_0 ? io_frs2_data : _fpmu_io_in_bits_req_in3_T_6 ? {io_frs2_data[31], fpmu_io_in_bits_req_in2_prev_prev_expOut_expCode == 3'h0 | fpmu_io_in_bits_req_in2_prev_prev_expOut_expCode > 3'h5 ? {io_frs2_data[52], io_frs2_data[30:29], _fpmu_io_in_bits_req_in2_prev_prev_expOut_commonCase_T_2[8:0]} : _fpmu_io_in_bits_req_in2_prev_prev_expOut_commonCase_T_2, io_frs2_data[22:0], 29'h0} : {io_frs2_data[15], fpmu_io_in_bits_req_in2_prev_prev_prev_prev_expOut_expCode == 3'h0 | fpmu_io_in_bits_req_in2_prev_prev_prev_prev_expOut_expCode > 3'h5 ? {io_frs2_data[23], io_frs2_data[14:13], _fpmu_io_in_bits_req_in2_prev_prev_prev_prev_expOut_commonCase_T_2[8:0]} : _fpmu_io_in_bits_req_in2_prev_prev_prev_prev_expOut_commonCase_T_2, io_frs2_data[9:0], 42'h0}) : 65'hE008000000000000),	// @[generators/rocket-chip/src/main/scala/tile/FPU.scala:275:20, :276:18, :277:38, :279:26, :280:50, :281:{10,19,27,38,49,69}, :283:8, :332:{49,84}, :357:14, :358:14, :369:10, generators/rocket-chip/src/main/scala/util/package.scala:39:{76,86}]
    .io_out_valid          (_fpmu_io_out_valid),
    .io_out_bits_data      (_fpmu_io_out_bits_data),
    .io_out_bits_exc       (_fpmu_io_out_bits_exc),
    .io_lt                 (_fpiu_io_out_bits_lt)	// @[generators/shuttle/src/main/scala/exu/FPU.scala:71:20]
  );
  assign io_out_valid = io_out_valid_r_3 & ~io_out_valid_r_6;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :99:33, :100:{5,8,22}]
  assign io_out_bits_data = (_dfma_io_out_valid ? _dfma_io_out_bits_data : 65'h0) | (_sfma_io_out_valid ? _sfma_io_out_bits_data : 65'h0) | (_hfma_io_out_valid ? _hfma_io_out_bits_data : 65'h0) | (_ifpu_io_out_valid ? _ifpu_io_out_bits_data : 65'h0) | (_fpmu_io_out_valid ? _fpmu_io_out_bits_data : 65'h0);	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :79:20, :80:20, :81:20, :88:20, :93:20, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_out_bits_exc = (_dfma_io_out_valid ? _dfma_io_out_bits_exc : 5'h0) | (_sfma_io_out_valid ? _sfma_io_out_bits_exc : 5'h0) | (_hfma_io_out_valid ? _hfma_io_out_bits_exc : 5'h0) | (_ifpu_io_out_valid ? _ifpu_io_out_bits_exc : 5'h0) | (_fpmu_io_out_valid ? _fpmu_io_out_bits_exc : 5'h0);	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :79:20, :80:20, :81:20, :88:20, :93:20, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_out_rd = io_out_rd_r_3;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :106:29]
  assign io_out_tag = io_out_tag_r_3;	// @[generators/shuttle/src/main/scala/exu/FPU.scala:15:7, :107:30]
endmodule

