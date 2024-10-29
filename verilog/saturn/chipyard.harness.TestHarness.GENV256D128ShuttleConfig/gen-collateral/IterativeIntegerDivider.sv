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

module IterativeIntegerDivider(	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
  input          clock,	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
  input          reset,	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
  input          io_iss_valid,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14]
  input  [63:0]  io_iss_op_rvs1_elem,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14]
  input  [63:0]  io_iss_op_rvs2_elem,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14]
  input  [1:0]   io_iss_op_rvs1_eew,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14]
  input  [1:0]   io_iss_op_rvs2_eew,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14]
  input  [1:0]   io_iss_op_rvd_eew,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14]
  input  [15:0]  io_iss_op_wmask,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14]
  input  [5:0]   io_iss_op_wvd_eg,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14]
  input  [2:0]   io_iss_op_funct3,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14]
  input  [5:0]   io_iss_op_funct6,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14]
  output         io_iss_ready,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14]
  input          io_write_ready,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14]
  output         io_write_valid,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14]
  output [5:0]   io_write_bits_eg,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14]
  output [127:0] io_write_bits_data,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14]
  output [127:0] io_write_bits_mask,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14]
  output         io_hazard_valid,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14]
  output [5:0]   io_hazard_bits_eg,	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14]
  output         io_busy	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14]
);

  wire              last;	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
  wire              _io_iss_ready_output;	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:43:127]
  wire              _div_io_req_ready;	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:42:19]
  wire              _div_io_resp_valid;	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:42:19]
  wire [63:0]       _div_io_resp_bits_data;	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:42:19]
  wire [3:0][2:0]   _GEN = {3'h6, 3'h7, 3'h4, 3'h5};	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:51:25]
  reg               valid;	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:70:22]
  reg  [1:0]        op_rvd_eew;	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:71:15]
  reg  [15:0]       op_wmask;	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:71:15]
  reg  [5:0]        op_wvd_eg;	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:71:15]
  wire              _div_io_req_valid_T = io_iss_valid & _io_iss_ready_output;	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:78:22, generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:43:127]
  wire [2:0]        _GEN_0 = ~(io_iss_op_funct6[4:2]);	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14, src/main/scala/chisel3/util/pla.scala:78:21]
  assign _io_iss_ready_output = (&{_GEN_0[0], _GEN_0[1], _GEN_0[2], io_iss_op_funct6[5], ~(io_iss_op_funct3[0]), io_iss_op_funct3[1]}) & _div_io_req_ready & (~valid | last);	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:68:14, :70:22, generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:42:19, :43:{127,131,138}, src/main/scala/chisel3/util/Decoupled.scala:51:35, src/main/scala/chisel3/util/pla.scala:78:21, :90:45, :91:29, :98:{53,70}]
  wire [3:0][64:0]  _GEN_1 = {{{io_iss_op_rvs2_elem[63], io_iss_op_rvs2_elem}}, {{{33{io_iss_op_rvs2_elem[31]}}, io_iss_op_rvs2_elem[31:0]}}, {{{49{io_iss_op_rvs2_elem[15]}}, io_iss_op_rvs2_elem[15:0]}}, {{{57{io_iss_op_rvs2_elem[7]}}, io_iss_op_rvs2_elem[7:0]}}};	// @[generators/saturn/src/main/scala/common/Parameters.scala:363:67, :364:{8,11,29}, :365:13]
  wire [3:0][64:0]  _GEN_2 = {{{io_iss_op_rvs1_elem[63], io_iss_op_rvs1_elem}}, {{{33{io_iss_op_rvs1_elem[31]}}, io_iss_op_rvs1_elem[31:0]}}, {{{49{io_iss_op_rvs1_elem[15]}}, io_iss_op_rvs1_elem[15:0]}}, {{{57{io_iss_op_rvs1_elem[7]}}, io_iss_op_rvs1_elem[7:0]}}};	// @[generators/saturn/src/main/scala/common/Parameters.scala:363:67, :364:{8,11,29}, :365:13]
  wire [3:0][127:0] _GEN_3 = {{{2{_div_io_resp_bits_data}}}, {{2{{2{_div_io_resp_bits_data[31:0]}}}}}, {{2{{2{{2{_div_io_resp_bits_data[15:0]}}}}}}}, {{2{{2{{2{{2{_div_io_resp_bits_data[7:0]}}}}}}}}}};	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:42:19, :88:{48,73}, :122:22]
  assign last = io_write_ready & _div_io_resp_valid;	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:42:19, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  always @(posedge clock) begin	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
    if (reset)	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
      valid <= 1'h0;	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:70:22]
    else	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
      valid <= _div_io_req_valid_T | ~last & valid;	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:70:22, :78:{22,39}, :79:11, :81:22, :82:11, src/main/scala/chisel3/util/Decoupled.scala:51:35]
    if (_div_io_req_valid_T) begin	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:78:22]
      op_rvd_eew <= io_iss_op_rvd_eew;	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:71:15]
      op_wmask <= io_iss_op_wmask;	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:71:15]
      op_wvd_eg <= io_iss_op_wvd_eg;	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:71:15]
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
      `FIRRTL_BEFORE_INITIAL	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:27];	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
    initial begin	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
        `INIT_RANDOM_PROLOG_	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
        for (logic [4:0] i = 5'h0; i < 5'h1C; i += 5'h1) begin
          _RANDOM[i] = `RANDOM;	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
        end	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
        valid = _RANDOM[5'h0][0];	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:70:22, generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
        op_rvd_eew = _RANDOM[5'h16][23:22];	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:71:15, generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
        op_wmask = _RANDOM[5'h17][25:10];	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:71:15, generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
        op_wvd_eg = _RANDOM[5'h1B][31:26];	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:71:15, generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
      `FIRRTL_AFTER_INITIAL	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  MulDiv div (	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:42:19]
    .clock             (clock),
    .reset             (reset),
    .io_req_ready      (_div_io_req_ready),
    .io_req_valid      (_div_io_req_valid_T),	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:78:22]
    .io_req_bits_fn    ({2'h0, _GEN[io_iss_op_funct6[1:0]]}),	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:51:{25,89}, :71:22]
    .io_req_bits_in1   (io_iss_op_funct6[0] ? _GEN_1[io_iss_op_rvs2_eew][63:0] : io_iss_op_rvs2_elem),	// @[generators/saturn/src/main/scala/common/Parameters.scala:365:13, generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:52:45, :72:68]
    .io_req_bits_in2   (io_iss_op_funct6[0] ? _GEN_2[io_iss_op_rvs1_eew][63:0] : io_iss_op_rvs1_elem),	// @[generators/saturn/src/main/scala/common/Parameters.scala:365:13, generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:52:45, :75:29]
    .io_resp_ready     (io_write_ready),
    .io_resp_valid     (_div_io_resp_valid),
    .io_resp_bits_data (_div_io_resp_bits_data)
  );
  assign io_iss_ready = _io_iss_ready_output;	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7, :43:127]
  assign io_write_valid = _div_io_resp_valid;	// @[generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7, :42:19]
  assign io_write_bits_eg = op_wvd_eg;	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:71:15, generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
  assign io_write_bits_data = _GEN_3[op_rvd_eew];	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:71:15, generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7, :122:22]
  assign io_write_bits_mask = {{8{op_wmask[15]}}, {8{op_wmask[14]}}, {8{op_wmask[13]}}, {8{op_wmask[12]}}, {8{op_wmask[11]}}, {8{op_wmask[10]}}, {8{op_wmask[9]}}, {8{op_wmask[8]}}, {8{op_wmask[7]}}, {8{op_wmask[6]}}, {8{op_wmask[5]}}, {8{op_wmask[4]}}, {8{op_wmask[3]}}, {8{op_wmask[2]}}, {8{op_wmask[1]}}, {8{op_wmask[0]}}};	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:71:15, generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7, :121:40]
  assign io_hazard_valid = valid;	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:70:22, generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
  assign io_hazard_bits_eg = op_wvd_eg;	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:71:15, generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
  assign io_busy = valid;	// @[generators/saturn/src/main/scala/exu/FunctionalUnit.scala:70:22, generators/saturn/src/main/scala/exu/int/IntegerDivide.scala:38:7]
endmodule

