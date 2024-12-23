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

module MulDiv(	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7]
  input         clock,	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7]
  input         reset,	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7]
  output        io_req_ready,	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:45:14]
  input         io_req_valid,	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:45:14]
  input  [4:0]  io_req_bits_fn,	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:45:14]
  input  [63:0] io_req_bits_in1,	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:45:14]
  input  [63:0] io_req_bits_in2,	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:45:14]
  input         io_resp_ready,	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:45:14]
  output        io_resp_valid,	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:45:14]
  output [63:0] io_resp_bits_data	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:45:14]
);

  reg  [2:0]   state;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:51:22]
  reg  [6:0]   count;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:54:18]
  reg          neg_out;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:57:20]
  reg          isHi;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:58:17]
  reg          resHi;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:59:18]
  reg  [64:0]  divisor;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:60:20]
  reg  [129:0] remainder;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:61:22]
  wire [63:0]  result = resHi ? remainder[128:65] : remainder[63:0];	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:59:18, :61:22, :89:{19,36,57}]
  wire         _io_resp_valid_output = state == 3'h6 | (&state);	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:51:22, :175:37, :182:{27,42,51}]
  wire         _io_req_ready_output = state == 3'h0;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:51:22, :183:25]
  wire [64:0]  _subtractor_T_1 = remainder[128:64] - divisor;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:60:20, :61:22, :88:{29,37}]
  wire [1:0]   _decoded_andMatrixOutputs_T = {~(io_req_bits_fn[0]), io_req_bits_fn[2]};	// @[src/main/scala/chisel3/util/experimental/decode/decoder.scala:39:16, src/main/scala/chisel3/util/pla.scala:78:21, :90:45, :98:53]
  wire         lhs_sign = (&_decoded_andMatrixOutputs_T) & io_req_bits_in1[63];	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:81:{23,48}, src/main/scala/chisel3/util/pla.scala:98:{53,70}]
  wire         rhs_sign = (&_decoded_andMatrixOutputs_T) & io_req_bits_in2[63];	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:81:{23,48}, src/main/scala/chisel3/util/pla.scala:98:{53,70}]
  wire         _GEN = state == 3'h1;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:51:22, :92:39]
  wire         _GEN_0 = state == 3'h5;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:51:22, :101:39]
  wire         _GEN_1 = state == 3'h3;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:51:22, :99:11, :129:39]
  wire         _GEN_2 = _GEN_1 & count == 7'h40;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:54:18, :101:57, :129:{39,50}, :138:{17,42}, :139:13]
  wire         _GEN_3 = _io_req_ready_output & io_req_valid;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:183:25, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  wire [1:0]   _decoded_andMatrixOutputs_T_1 = {io_req_bits_fn[1], io_req_bits_fn[2]};	// @[src/main/scala/chisel3/util/pla.scala:90:45, :98:53]
  always @(posedge clock) begin	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7]
    if (reset)	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7]
      state <= 3'h0;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:51:22]
    else if (_GEN_3)	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
      state <= {1'h0, ~(lhs_sign | rhs_sign), 1'h1};	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:45:14, :51:22, :78:60, :81:23, :165:{36,46}]
    else if (io_resp_ready & _io_resp_valid_output)	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:182:42, src/main/scala/chisel3/util/Decoupled.scala:51:35]
      state <= 3'h0;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:51:22]
    else if (_GEN_2)	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:101:57, :129:50, :138:42, :139:13]
      state <= {1'h1, ~neg_out, 1'h1};	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:45:14, :51:22, :57:20, :139:19]
    else if (_GEN_0)	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:101:39]
      state <= 3'h7;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:51:22, :103:11]
    else if (_GEN)	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:92:39]
      state <= 3'h3;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:51:22, :99:11]
    if (_GEN_3) begin	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
      count <= 7'h0;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:54:18, :168:11]
      neg_out <= (&_decoded_andMatrixOutputs_T_1) ? lhs_sign : lhs_sign != rhs_sign;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:57:20, :81:23, :169:{19,46}, src/main/scala/chisel3/util/pla.scala:98:{53,70}]
      isHi <= &_decoded_andMatrixOutputs_T_1;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:58:17, src/main/scala/chisel3/util/pla.scala:98:{53,70}]
      divisor <= {rhs_sign, io_req_bits_in2};	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:60:20, :81:23, :170:19]
      remainder <= {66'h0, io_req_bits_in1};	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:61:22, :94:17, :171:15]
    end
    else begin	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
      if (_GEN_1) begin	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:129:39]
        count <= count + 7'h1;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:54:18, :144:20]
        remainder <= {1'h0, _subtractor_T_1[64] ? remainder[127:64] : _subtractor_T_1[63:0], remainder[63:0], ~(_subtractor_T_1[64])};	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:45:14, :61:22, :78:60, :88:37, :89:57, :133:28, :134:{14,24,45,67}, :137:15]
      end
      else if (_GEN_0 | _GEN & remainder[63])	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:61:22, :92:{39,57}, :93:{20,27}, :94:17, :101:{39,57}, :102:15]
        remainder <= {66'h0, 64'h0 - result};	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:61:22, :89:19, :90:27, :94:17, src/main/scala/chisel3/util/pla.scala:102:36]
      neg_out <= ~(_GEN_1 & count == 7'h0 & ~(_subtractor_T_1[64]) & ~isHi) & neg_out;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:54:18, :57:20, :58:17, :88:37, :129:{39,50}, :133:28, :146:{24,35}, :159:{21,28,38}, :168:11]
      if (_GEN & divisor[63])	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:60:20, :92:{39,57}, :96:{18,25}, :97:15]
        divisor <= _subtractor_T_1;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:60:20, :88:37]
    end
    resHi <= ~_GEN_3 & (_GEN_2 ? isHi : ~_GEN_0 & resHi);	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:58:17, :59:18, :101:{39,57}, :104:11, :129:50, :138:42, :139:13, :140:13, :164:22, :167:11, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7]
      `FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:10];	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7]
    initial begin	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7]
        `INIT_RANDOM_PROLOG_	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7]
        for (logic [3:0] i = 4'h0; i < 4'hB; i += 4'h1) begin
          _RANDOM[i] = `RANDOM;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7]
        end	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7]
        state = _RANDOM[4'h0][2:0];	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7, :51:22]
        count = _RANDOM[4'h4][16:10];	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7, :54:18]
        neg_out = _RANDOM[4'h4][17];	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7, :54:18, :57:20]
        isHi = _RANDOM[4'h4][18];	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7, :54:18, :58:17]
        resHi = _RANDOM[4'h4][19];	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7, :54:18, :59:18]
        divisor = {_RANDOM[4'h4][31:20], _RANDOM[4'h5], _RANDOM[4'h6][20:0]};	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7, :54:18, :60:20]
        remainder = {_RANDOM[4'h6][31:21], _RANDOM[4'h7], _RANDOM[4'h8], _RANDOM[4'h9], _RANDOM[4'hA][22:0]};	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7, :60:20, :61:22]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7]
      `FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_req_ready = _io_req_ready_output;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7, :183:25]
  assign io_resp_valid = _io_resp_valid_output;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7, :182:42]
  assign io_resp_bits_data = result;	// @[generators/rocket-chip/src/main/scala/rocket/Multiplier.scala:40:7, :89:19]
endmodule

