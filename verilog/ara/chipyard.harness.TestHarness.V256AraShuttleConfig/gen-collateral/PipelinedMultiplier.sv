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

module PipelinedMultiplier(	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7]
  input         clock,	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7]
  input         reset,	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7]
  input         io_req_valid,	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:187:14]
  input  [4:0]  io_req_bits_fn,	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:187:14]
  input         io_req_bits_dw,	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:187:14]
  input  [63:0] io_req_bits_in1,	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:187:14]
  input  [63:0] io_req_bits_in2,	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:187:14]
  output [63:0] io_resp_bits_data	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:187:14]
);

  reg          in_pipe_v;	// @[src/main/scala/chisel3/util/Valid.scala:141:24]
  reg  [4:0]   in_pipe_b_fn;	// @[src/main/scala/chisel3/util/Valid.scala:142:26]
  reg          in_pipe_b_dw;	// @[src/main/scala/chisel3/util/Valid.scala:142:26]
  reg  [63:0]  in_pipe_b_in1;	// @[src/main/scala/chisel3/util/Valid.scala:142:26]
  reg  [63:0]  in_pipe_b_in2;	// @[src/main/scala/chisel3/util/Valid.scala:142:26]
  reg  [63:0]  io_resp_bits_data_pipe_b;	// @[src/main/scala/chisel3/util/Valid.scala:142:26]
  wire [1:0]   decoded_invInputs = ~(in_pipe_b_fn[1:0]);	// @[src/main/scala/chisel3/util/Valid.scala:142:26, src/main/scala/chisel3/util/experimental/decode/decoder.scala:39:16, src/main/scala/chisel3/util/pla.scala:78:21]
  wire [127:0] prod = {{64{(|{decoded_invInputs[1], &{decoded_invInputs[0], in_pipe_b_fn[1]}}) & in_pipe_b_in1[63]}}, in_pipe_b_in1} * {{64{decoded_invInputs[1] & in_pipe_b_in2[63]}}, in_pipe_b_in2};	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:203:{27,41}, :204:{27,41}, :205:18, src/main/scala/chisel3/util/Valid.scala:142:26, src/main/scala/chisel3/util/pla.scala:78:21, :90:45, :91:29, :98:{53,70}, :114:{19,36}]
  always @(posedge clock) begin	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7]
    if (reset)	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7]
      in_pipe_v <= 1'h0;	// @[src/main/scala/chisel3/util/Valid.scala:141:24]
    else	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7]
      in_pipe_v <= io_req_valid;	// @[src/main/scala/chisel3/util/Valid.scala:141:24]
    if (io_req_valid) begin	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:187:14]
      in_pipe_b_fn <= io_req_bits_fn;	// @[src/main/scala/chisel3/util/Valid.scala:142:26]
      in_pipe_b_dw <= io_req_bits_dw;	// @[src/main/scala/chisel3/util/Valid.scala:142:26]
      in_pipe_b_in1 <= io_req_bits_in1;	// @[src/main/scala/chisel3/util/Valid.scala:142:26]
      in_pipe_b_in2 <= io_req_bits_in2;	// @[src/main/scala/chisel3/util/Valid.scala:142:26]
    end
    if (in_pipe_v)	// @[src/main/scala/chisel3/util/Valid.scala:141:24]
      io_resp_bits_data_pipe_b <= (|{in_pipe_b_fn[0], in_pipe_b_fn[1]}) ? prod[127:64] : in_pipe_b_dw ? prod[63:0] : {{32{prod[31]}}, prod[31:0]};	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:205:18, :206:{18,30,53,67,101}, generators/rocket-chip/src/main/scala/util/package.scala:132:{15,20,38}, src/main/scala/chisel3/util/Valid.scala:142:26, src/main/scala/chisel3/util/pla.scala:90:45, :114:{19,36}]
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7]
      `FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:10];	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7]
    initial begin	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7]
        `INIT_RANDOM_PROLOG_	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7]
        for (logic [3:0] i = 4'h0; i < 4'hB; i += 4'h1) begin
          _RANDOM[i] = `RANDOM;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7]
        end	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7]
        in_pipe_v = _RANDOM[4'h0][0];	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7, src/main/scala/chisel3/util/Valid.scala:141:24]
        in_pipe_b_fn = _RANDOM[4'h0][5:1];	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7, src/main/scala/chisel3/util/Valid.scala:141:24, :142:26]
        in_pipe_b_dw = _RANDOM[4'h0][6];	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7, src/main/scala/chisel3/util/Valid.scala:141:24, :142:26]
        in_pipe_b_in1 = {_RANDOM[4'h0][31:7], _RANDOM[4'h1], _RANDOM[4'h2][6:0]};	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7, src/main/scala/chisel3/util/Valid.scala:141:24, :142:26]
        in_pipe_b_in2 = {_RANDOM[4'h2][31:7], _RANDOM[4'h3], _RANDOM[4'h4][6:0]};	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7, src/main/scala/chisel3/util/Valid.scala:142:26]
        io_resp_bits_data_pipe_b = {_RANDOM[4'h8][31:25], _RANDOM[4'h9], _RANDOM[4'hA][24:0]};	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7, src/main/scala/chisel3/util/Valid.scala:142:26]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7]
      `FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_resp_bits_data = io_resp_bits_data_pipe_b;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:186:7, src/main/scala/chisel3/util/Valid.scala:142:26]
endmodule

