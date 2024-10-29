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

module RegisterReadXbar_3(	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:27:7]
  input          clock,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:27:7]
  output         io_in_0_req_ready,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input          io_in_0_req_valid,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input  [5:0]   io_in_0_req_bits_eg,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input          io_in_0_req_bits_oldest,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  output [127:0] io_in_0_resp,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  output         io_in_1_req_ready,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input          io_in_1_req_valid,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input  [5:0]   io_in_1_req_bits_eg,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input          io_in_1_req_bits_oldest,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  output [127:0] io_in_1_resp,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  output         io_in_2_req_ready,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input          io_in_2_req_valid,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input  [5:0]   io_in_2_req_bits_eg,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input          io_in_2_req_bits_oldest,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  output [127:0] io_in_2_resp,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  output         io_in_3_req_ready,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input          io_in_3_req_valid,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input  [5:0]   io_in_3_req_bits_eg,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input          io_in_3_req_bits_oldest,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  output [127:0] io_in_3_resp,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  output         io_in_4_req_ready,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input          io_in_4_req_valid,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input  [5:0]   io_in_4_req_bits_eg,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input          io_in_4_req_bits_oldest,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  output [127:0] io_in_4_resp,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  output         io_in_5_req_ready,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input          io_in_5_req_valid,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input  [5:0]   io_in_5_req_bits_eg,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  output [127:0] io_in_5_resp,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input          io_out_0_req_ready,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  output [5:0]   io_out_0_req_bits_eg,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input  [127:0] io_out_0_resp,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input          io_out_1_req_ready,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  output [5:0]   io_out_1_req_bits_eg,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input  [127:0] io_out_1_resp,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input          io_out_2_req_ready,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  output [5:0]   io_out_2_req_bits_eg,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input  [127:0] io_out_2_resp,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input          io_out_3_req_ready,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  output [5:0]   io_out_3_req_bits_eg,	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
  input  [127:0] io_out_3_resp	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:28:14]
);

  wire       _arbs_3_io_in_0_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_3_io_in_1_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_3_io_in_2_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_3_io_in_3_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_3_io_in_4_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_3_io_in_5_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_2_io_in_0_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_2_io_in_1_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_2_io_in_2_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_2_io_in_3_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_2_io_in_4_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_2_io_in_5_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_1_io_in_0_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_1_io_in_1_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_1_io_in_2_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_1_io_in_3_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_1_io_in_4_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_1_io_in_5_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_0_io_in_0_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_0_io_in_1_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_0_io_in_2_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_0_io_in_3_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_0_io_in_4_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _arbs_0_io_in_5_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
  wire       _io_in_0_resp_T = io_in_0_req_bits_eg[1:0] == 2'h0;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:63, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire [5:0] _GEN = {2'h0, io_in_0_req_bits_eg[5:2]};	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:{32,56}, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire       _io_in_0_resp_T_1 = io_in_0_req_bits_eg[1:0] == 2'h1;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:63, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire       _io_in_0_resp_T_2 = io_in_0_req_bits_eg[1:0] == 2'h2;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:63, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire       _io_in_1_resp_T = io_in_1_req_bits_eg[1:0] == 2'h0;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:63, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire [5:0] _GEN_0 = {2'h0, io_in_1_req_bits_eg[5:2]};	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:{32,56}, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire       _io_in_1_resp_T_1 = io_in_1_req_bits_eg[1:0] == 2'h1;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:63, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire       _io_in_1_resp_T_2 = io_in_1_req_bits_eg[1:0] == 2'h2;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:63, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire       _io_in_2_resp_T = io_in_2_req_bits_eg[1:0] == 2'h0;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:63, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire [5:0] _GEN_1 = {2'h0, io_in_2_req_bits_eg[5:2]};	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:{32,56}, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire       _io_in_2_resp_T_1 = io_in_2_req_bits_eg[1:0] == 2'h1;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:63, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire       _io_in_2_resp_T_2 = io_in_2_req_bits_eg[1:0] == 2'h2;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:63, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire       _io_in_3_resp_T = io_in_3_req_bits_eg[1:0] == 2'h0;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:63, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire [5:0] _GEN_2 = {2'h0, io_in_3_req_bits_eg[5:2]};	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:{32,56}, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire       _io_in_3_resp_T_1 = io_in_3_req_bits_eg[1:0] == 2'h1;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:63, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire       _io_in_3_resp_T_2 = io_in_3_req_bits_eg[1:0] == 2'h2;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:63, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire       _io_in_4_resp_T = io_in_4_req_bits_eg[1:0] == 2'h0;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:63, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire [5:0] _GEN_3 = {2'h0, io_in_4_req_bits_eg[5:2]};	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:{32,56}, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire       _io_in_4_resp_T_1 = io_in_4_req_bits_eg[1:0] == 2'h1;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:63, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire       _io_in_4_resp_T_2 = io_in_4_req_bits_eg[1:0] == 2'h2;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:63, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire       _io_in_5_resp_T = io_in_5_req_bits_eg[1:0] == 2'h0;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:63, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire [5:0] _GEN_4 = {2'h0, io_in_5_req_bits_eg[5:2]};	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:{32,56}, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire       _io_in_5_resp_T_1 = io_in_5_req_bits_eg[1:0] == 2'h1;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:63, src/main/scala/chisel3/util/OneHot.scala:58:35]
  wire       _io_in_5_resp_T_2 = io_in_5_req_bits_eg[1:0] == 2'h2;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:63, src/main/scala/chisel3/util/OneHot.scala:58:35]
  OldestRRArbiter_12 arbs_0 (	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
    .clock               (clock),
    .io_in_0_ready       (_arbs_0_io_in_0_ready),
    .io_in_0_valid       (io_in_0_req_valid & _io_in_0_resp_T),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:43:{52,63}]
    .io_in_0_bits_eg     (_GEN),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_0_bits_oldest (io_in_0_req_bits_oldest),
    .io_in_1_ready       (_arbs_0_io_in_1_ready),
    .io_in_1_valid       (io_in_1_req_valid & _io_in_1_resp_T),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:43:{52,63}]
    .io_in_1_bits_eg     (_GEN_0),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_1_bits_oldest (io_in_1_req_bits_oldest),
    .io_in_2_ready       (_arbs_0_io_in_2_ready),
    .io_in_2_valid       (io_in_2_req_valid & _io_in_2_resp_T),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:43:{52,63}]
    .io_in_2_bits_eg     (_GEN_1),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_2_bits_oldest (io_in_2_req_bits_oldest),
    .io_in_3_ready       (_arbs_0_io_in_3_ready),
    .io_in_3_valid       (io_in_3_req_valid & _io_in_3_resp_T),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:43:{52,63}]
    .io_in_3_bits_eg     (_GEN_2),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_3_bits_oldest (io_in_3_req_bits_oldest),
    .io_in_4_ready       (_arbs_0_io_in_4_ready),
    .io_in_4_valid       (io_in_4_req_valid & _io_in_4_resp_T),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:43:{52,63}]
    .io_in_4_bits_eg     (_GEN_3),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_4_bits_oldest (io_in_4_req_bits_oldest),
    .io_in_5_ready       (_arbs_0_io_in_5_ready),
    .io_in_5_valid       (io_in_5_req_valid & _io_in_5_resp_T),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:43:{52,63}]
    .io_in_5_bits_eg     (_GEN_4),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_out_ready        (io_out_0_req_ready),
    .io_out_bits_eg      (io_out_0_req_bits_eg)
  );
  OldestRRArbiter_12 arbs_1 (	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
    .clock               (clock),
    .io_in_0_ready       (_arbs_1_io_in_0_ready),
    .io_in_0_valid       (io_in_0_req_valid & _io_in_0_resp_T_1),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:43:{52,63}]
    .io_in_0_bits_eg     (_GEN),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_0_bits_oldest (io_in_0_req_bits_oldest),
    .io_in_1_ready       (_arbs_1_io_in_1_ready),
    .io_in_1_valid       (io_in_1_req_valid & _io_in_1_resp_T_1),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:43:{52,63}]
    .io_in_1_bits_eg     (_GEN_0),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_1_bits_oldest (io_in_1_req_bits_oldest),
    .io_in_2_ready       (_arbs_1_io_in_2_ready),
    .io_in_2_valid       (io_in_2_req_valid & _io_in_2_resp_T_1),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:43:{52,63}]
    .io_in_2_bits_eg     (_GEN_1),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_2_bits_oldest (io_in_2_req_bits_oldest),
    .io_in_3_ready       (_arbs_1_io_in_3_ready),
    .io_in_3_valid       (io_in_3_req_valid & _io_in_3_resp_T_1),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:43:{52,63}]
    .io_in_3_bits_eg     (_GEN_2),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_3_bits_oldest (io_in_3_req_bits_oldest),
    .io_in_4_ready       (_arbs_1_io_in_4_ready),
    .io_in_4_valid       (io_in_4_req_valid & _io_in_4_resp_T_1),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:43:{52,63}]
    .io_in_4_bits_eg     (_GEN_3),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_4_bits_oldest (io_in_4_req_bits_oldest),
    .io_in_5_ready       (_arbs_1_io_in_5_ready),
    .io_in_5_valid       (io_in_5_req_valid & _io_in_5_resp_T_1),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:43:{52,63}]
    .io_in_5_bits_eg     (_GEN_4),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_out_ready        (io_out_1_req_ready),
    .io_out_bits_eg      (io_out_1_req_bits_eg)
  );
  OldestRRArbiter_12 arbs_2 (	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
    .clock               (clock),
    .io_in_0_ready       (_arbs_2_io_in_0_ready),
    .io_in_0_valid       (io_in_0_req_valid & _io_in_0_resp_T_2),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:43:{52,63}]
    .io_in_0_bits_eg     (_GEN),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_0_bits_oldest (io_in_0_req_bits_oldest),
    .io_in_1_ready       (_arbs_2_io_in_1_ready),
    .io_in_1_valid       (io_in_1_req_valid & _io_in_1_resp_T_2),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:43:{52,63}]
    .io_in_1_bits_eg     (_GEN_0),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_1_bits_oldest (io_in_1_req_bits_oldest),
    .io_in_2_ready       (_arbs_2_io_in_2_ready),
    .io_in_2_valid       (io_in_2_req_valid & _io_in_2_resp_T_2),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:43:{52,63}]
    .io_in_2_bits_eg     (_GEN_1),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_2_bits_oldest (io_in_2_req_bits_oldest),
    .io_in_3_ready       (_arbs_2_io_in_3_ready),
    .io_in_3_valid       (io_in_3_req_valid & _io_in_3_resp_T_2),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:43:{52,63}]
    .io_in_3_bits_eg     (_GEN_2),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_3_bits_oldest (io_in_3_req_bits_oldest),
    .io_in_4_ready       (_arbs_2_io_in_4_ready),
    .io_in_4_valid       (io_in_4_req_valid & _io_in_4_resp_T_2),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:43:{52,63}]
    .io_in_4_bits_eg     (_GEN_3),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_4_bits_oldest (io_in_4_req_bits_oldest),
    .io_in_5_ready       (_arbs_2_io_in_5_ready),
    .io_in_5_valid       (io_in_5_req_valid & _io_in_5_resp_T_2),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:43:{52,63}]
    .io_in_5_bits_eg     (_GEN_4),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_out_ready        (io_out_2_req_ready),
    .io_out_bits_eg      (io_out_2_req_bits_eg)
  );
  OldestRRArbiter_12 arbs_3 (	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:33:38]
    .clock               (clock),
    .io_in_0_ready       (_arbs_3_io_in_0_ready),
    .io_in_0_valid       (io_in_0_req_valid & (&(io_in_0_req_bits_eg[1:0]))),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:{52,63}]
    .io_in_0_bits_eg     (_GEN),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_0_bits_oldest (io_in_0_req_bits_oldest),
    .io_in_1_ready       (_arbs_3_io_in_1_ready),
    .io_in_1_valid       (io_in_1_req_valid & (&(io_in_1_req_bits_eg[1:0]))),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:{52,63}]
    .io_in_1_bits_eg     (_GEN_0),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_1_bits_oldest (io_in_1_req_bits_oldest),
    .io_in_2_ready       (_arbs_3_io_in_2_ready),
    .io_in_2_valid       (io_in_2_req_valid & (&(io_in_2_req_bits_eg[1:0]))),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:{52,63}]
    .io_in_2_bits_eg     (_GEN_1),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_2_bits_oldest (io_in_2_req_bits_oldest),
    .io_in_3_ready       (_arbs_3_io_in_3_ready),
    .io_in_3_valid       (io_in_3_req_valid & (&(io_in_3_req_bits_eg[1:0]))),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:{52,63}]
    .io_in_3_bits_eg     (_GEN_2),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_3_bits_oldest (io_in_3_req_bits_oldest),
    .io_in_4_ready       (_arbs_3_io_in_4_ready),
    .io_in_4_valid       (io_in_4_req_valid & (&(io_in_4_req_bits_eg[1:0]))),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:{52,63}]
    .io_in_4_bits_eg     (_GEN_3),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_in_4_bits_oldest (io_in_4_req_bits_oldest),
    .io_in_5_ready       (_arbs_3_io_in_5_ready),
    .io_in_5_valid       (io_in_5_req_valid & (&(io_in_5_req_bits_eg[1:0]))),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:41:82, :43:{52,63}]
    .io_in_5_bits_eg     (_GEN_4),	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:44:32]
    .io_out_ready        (io_out_3_req_ready),
    .io_out_bits_eg      (io_out_3_req_bits_eg)
  );
  assign io_in_0_req_ready = _io_in_0_resp_T & _arbs_0_io_in_0_ready | _io_in_0_resp_T_1 & _arbs_1_io_in_0_ready | _io_in_0_resp_T_2 & _arbs_2_io_in_0_ready | (&(io_in_0_req_bits_eg[1:0])) & _arbs_3_io_in_0_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:27:7, :33:38, :41:82, :43:63, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_in_0_resp = (_io_in_0_resp_T ? io_out_0_resp : 128'h0) | (_io_in_0_resp_T_1 ? io_out_1_resp : 128'h0) | (_io_in_0_resp_T_2 ? io_out_2_resp : 128'h0) | ((&(io_in_0_req_bits_eg[1:0])) ? io_out_3_resp : 128'h0);	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:27:7, :41:82, :43:63, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_in_1_req_ready = _io_in_1_resp_T & _arbs_0_io_in_1_ready | _io_in_1_resp_T_1 & _arbs_1_io_in_1_ready | _io_in_1_resp_T_2 & _arbs_2_io_in_1_ready | (&(io_in_1_req_bits_eg[1:0])) & _arbs_3_io_in_1_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:27:7, :33:38, :41:82, :43:63, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_in_1_resp = (_io_in_1_resp_T ? io_out_0_resp : 128'h0) | (_io_in_1_resp_T_1 ? io_out_1_resp : 128'h0) | (_io_in_1_resp_T_2 ? io_out_2_resp : 128'h0) | ((&(io_in_1_req_bits_eg[1:0])) ? io_out_3_resp : 128'h0);	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:27:7, :41:82, :43:63, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_in_2_req_ready = _io_in_2_resp_T & _arbs_0_io_in_2_ready | _io_in_2_resp_T_1 & _arbs_1_io_in_2_ready | _io_in_2_resp_T_2 & _arbs_2_io_in_2_ready | (&(io_in_2_req_bits_eg[1:0])) & _arbs_3_io_in_2_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:27:7, :33:38, :41:82, :43:63, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_in_2_resp = (_io_in_2_resp_T ? io_out_0_resp : 128'h0) | (_io_in_2_resp_T_1 ? io_out_1_resp : 128'h0) | (_io_in_2_resp_T_2 ? io_out_2_resp : 128'h0) | ((&(io_in_2_req_bits_eg[1:0])) ? io_out_3_resp : 128'h0);	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:27:7, :41:82, :43:63, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_in_3_req_ready = _io_in_3_resp_T & _arbs_0_io_in_3_ready | _io_in_3_resp_T_1 & _arbs_1_io_in_3_ready | _io_in_3_resp_T_2 & _arbs_2_io_in_3_ready | (&(io_in_3_req_bits_eg[1:0])) & _arbs_3_io_in_3_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:27:7, :33:38, :41:82, :43:63, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_in_3_resp = (_io_in_3_resp_T ? io_out_0_resp : 128'h0) | (_io_in_3_resp_T_1 ? io_out_1_resp : 128'h0) | (_io_in_3_resp_T_2 ? io_out_2_resp : 128'h0) | ((&(io_in_3_req_bits_eg[1:0])) ? io_out_3_resp : 128'h0);	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:27:7, :41:82, :43:63, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_in_4_req_ready = _io_in_4_resp_T & _arbs_0_io_in_4_ready | _io_in_4_resp_T_1 & _arbs_1_io_in_4_ready | _io_in_4_resp_T_2 & _arbs_2_io_in_4_ready | (&(io_in_4_req_bits_eg[1:0])) & _arbs_3_io_in_4_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:27:7, :33:38, :41:82, :43:63, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_in_4_resp = (_io_in_4_resp_T ? io_out_0_resp : 128'h0) | (_io_in_4_resp_T_1 ? io_out_1_resp : 128'h0) | (_io_in_4_resp_T_2 ? io_out_2_resp : 128'h0) | ((&(io_in_4_req_bits_eg[1:0])) ? io_out_3_resp : 128'h0);	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:27:7, :41:82, :43:63, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_in_5_req_ready = _io_in_5_resp_T & _arbs_0_io_in_5_ready | _io_in_5_resp_T_1 & _arbs_1_io_in_5_ready | _io_in_5_resp_T_2 & _arbs_2_io_in_5_ready | (&(io_in_5_req_bits_eg[1:0])) & _arbs_3_io_in_5_ready;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:27:7, :33:38, :41:82, :43:63, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_in_5_resp = (_io_in_5_resp_T ? io_out_0_resp : 128'h0) | (_io_in_5_resp_T_1 ? io_out_1_resp : 128'h0) | (_io_in_5_resp_T_2 ? io_out_2_resp : 128'h0) | ((&(io_in_5_req_bits_eg[1:0])) ? io_out_3_resp : 128'h0);	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:27:7, :41:82, :43:63, src/main/scala/chisel3/util/Mux.scala:30:73]
endmodule

