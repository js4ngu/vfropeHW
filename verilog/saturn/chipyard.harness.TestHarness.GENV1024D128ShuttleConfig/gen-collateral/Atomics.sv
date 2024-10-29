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

module Atomics(	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:8:7]
  input          io_write,	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:10:14]
  input  [2:0]   io_a_opcode,	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:10:14]
  input  [2:0]   io_a_param,	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:10:14]
  input  [15:0]  io_a_mask,	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:10:14]
  input  [127:0] io_a_data,	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:10:14]
  input  [127:0] io_data_in,	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:10:14]
  output [127:0] io_data_out	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:10:14]
);

  wire [3:0][3:0] _GEN = {4'hC, 4'h8, 4'hE, 4'h6};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:41:8]
  wire [15:0]     signBit = io_a_mask & {1'h1, ~(io_a_mask[15:1])};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:10:14, :22:{27,32,38}]
  wire [127:0]    _sum_T_34 = ({{8{io_a_mask[15]}}, {8{io_a_mask[14]}}, {8{io_a_mask[13]}}, {8{io_a_mask[12]}}, {8{io_a_mask[11]}}, {8{io_a_mask[10]}}, {8{io_a_mask[9]}}, {8{io_a_mask[8]}}, {8{io_a_mask[7]}}, {8{io_a_mask[6]}}, {8{io_a_mask[5]}}, {8{io_a_mask[4]}}, {8{io_a_mask[3]}}, {8{io_a_mask[2]}}, {8{io_a_mask[1]}}, {8{io_a_mask[0]}}} & io_a_data) + ({128{~(io_a_param[2])}} ^ io_data_in);	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:18:28, :23:18, :24:{29,44,57}]
  wire [15:0]     _sign_a_T_129 = {io_a_data[127], io_a_data[119], io_a_data[111], io_a_data[103], io_a_data[95], io_a_data[87], io_a_data[79], io_a_data[71], io_a_data[63], io_a_data[55], io_a_data[47], io_a_data[39], io_a_data[31], io_a_data[23], io_a_data[15], io_a_data[7]} & signBit;	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:22:27, :25:{33,36,83}]
  wire [3:0]      _GEN_0 = _GEN[io_a_param[1:0]];	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:39:15, :41:8]
  wire [3:0]      _logical_T_257 = _GEN_0 >> {2'h0, io_a_data[0], io_data_in[0]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_260 = _GEN_0 >> {2'h0, io_a_data[1], io_data_in[1]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_263 = _GEN_0 >> {2'h0, io_a_data[2], io_data_in[2]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_266 = _GEN_0 >> {2'h0, io_a_data[3], io_data_in[3]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_269 = _GEN_0 >> {2'h0, io_a_data[4], io_data_in[4]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_272 = _GEN_0 >> {2'h0, io_a_data[5], io_data_in[5]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_275 = _GEN_0 >> {2'h0, io_a_data[6], io_data_in[6]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_278 = _GEN_0 >> {2'h0, io_a_data[7], io_data_in[7]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_281 = _GEN_0 >> {2'h0, io_a_data[8], io_data_in[8]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_284 = _GEN_0 >> {2'h0, io_a_data[9], io_data_in[9]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_287 = _GEN_0 >> {2'h0, io_a_data[10], io_data_in[10]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_290 = _GEN_0 >> {2'h0, io_a_data[11], io_data_in[11]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_293 = _GEN_0 >> {2'h0, io_a_data[12], io_data_in[12]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_296 = _GEN_0 >> {2'h0, io_a_data[13], io_data_in[13]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_299 = _GEN_0 >> {2'h0, io_a_data[14], io_data_in[14]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_302 = _GEN_0 >> {2'h0, io_a_data[15], io_data_in[15]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_305 = _GEN_0 >> {2'h0, io_a_data[16], io_data_in[16]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_308 = _GEN_0 >> {2'h0, io_a_data[17], io_data_in[17]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_311 = _GEN_0 >> {2'h0, io_a_data[18], io_data_in[18]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_314 = _GEN_0 >> {2'h0, io_a_data[19], io_data_in[19]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_317 = _GEN_0 >> {2'h0, io_a_data[20], io_data_in[20]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_320 = _GEN_0 >> {2'h0, io_a_data[21], io_data_in[21]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_323 = _GEN_0 >> {2'h0, io_a_data[22], io_data_in[22]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_326 = _GEN_0 >> {2'h0, io_a_data[23], io_data_in[23]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_329 = _GEN_0 >> {2'h0, io_a_data[24], io_data_in[24]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_332 = _GEN_0 >> {2'h0, io_a_data[25], io_data_in[25]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_335 = _GEN_0 >> {2'h0, io_a_data[26], io_data_in[26]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_338 = _GEN_0 >> {2'h0, io_a_data[27], io_data_in[27]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_341 = _GEN_0 >> {2'h0, io_a_data[28], io_data_in[28]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_344 = _GEN_0 >> {2'h0, io_a_data[29], io_data_in[29]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_347 = _GEN_0 >> {2'h0, io_a_data[30], io_data_in[30]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_350 = _GEN_0 >> {2'h0, io_a_data[31], io_data_in[31]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_353 = _GEN_0 >> {2'h0, io_a_data[32], io_data_in[32]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_356 = _GEN_0 >> {2'h0, io_a_data[33], io_data_in[33]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_359 = _GEN_0 >> {2'h0, io_a_data[34], io_data_in[34]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_362 = _GEN_0 >> {2'h0, io_a_data[35], io_data_in[35]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_365 = _GEN_0 >> {2'h0, io_a_data[36], io_data_in[36]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_368 = _GEN_0 >> {2'h0, io_a_data[37], io_data_in[37]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_371 = _GEN_0 >> {2'h0, io_a_data[38], io_data_in[38]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_374 = _GEN_0 >> {2'h0, io_a_data[39], io_data_in[39]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_377 = _GEN_0 >> {2'h0, io_a_data[40], io_data_in[40]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_380 = _GEN_0 >> {2'h0, io_a_data[41], io_data_in[41]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_383 = _GEN_0 >> {2'h0, io_a_data[42], io_data_in[42]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_386 = _GEN_0 >> {2'h0, io_a_data[43], io_data_in[43]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_389 = _GEN_0 >> {2'h0, io_a_data[44], io_data_in[44]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_392 = _GEN_0 >> {2'h0, io_a_data[45], io_data_in[45]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_395 = _GEN_0 >> {2'h0, io_a_data[46], io_data_in[46]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_398 = _GEN_0 >> {2'h0, io_a_data[47], io_data_in[47]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_401 = _GEN_0 >> {2'h0, io_a_data[48], io_data_in[48]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_404 = _GEN_0 >> {2'h0, io_a_data[49], io_data_in[49]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_407 = _GEN_0 >> {2'h0, io_a_data[50], io_data_in[50]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_410 = _GEN_0 >> {2'h0, io_a_data[51], io_data_in[51]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_413 = _GEN_0 >> {2'h0, io_a_data[52], io_data_in[52]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_416 = _GEN_0 >> {2'h0, io_a_data[53], io_data_in[53]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_419 = _GEN_0 >> {2'h0, io_a_data[54], io_data_in[54]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_422 = _GEN_0 >> {2'h0, io_a_data[55], io_data_in[55]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_425 = _GEN_0 >> {2'h0, io_a_data[56], io_data_in[56]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_428 = _GEN_0 >> {2'h0, io_a_data[57], io_data_in[57]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_431 = _GEN_0 >> {2'h0, io_a_data[58], io_data_in[58]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_434 = _GEN_0 >> {2'h0, io_a_data[59], io_data_in[59]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_437 = _GEN_0 >> {2'h0, io_a_data[60], io_data_in[60]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_440 = _GEN_0 >> {2'h0, io_a_data[61], io_data_in[61]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_443 = _GEN_0 >> {2'h0, io_a_data[62], io_data_in[62]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_446 = _GEN_0 >> {2'h0, io_a_data[63], io_data_in[63]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_449 = _GEN_0 >> {2'h0, io_a_data[64], io_data_in[64]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_452 = _GEN_0 >> {2'h0, io_a_data[65], io_data_in[65]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_455 = _GEN_0 >> {2'h0, io_a_data[66], io_data_in[66]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_458 = _GEN_0 >> {2'h0, io_a_data[67], io_data_in[67]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_461 = _GEN_0 >> {2'h0, io_a_data[68], io_data_in[68]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_464 = _GEN_0 >> {2'h0, io_a_data[69], io_data_in[69]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_467 = _GEN_0 >> {2'h0, io_a_data[70], io_data_in[70]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_470 = _GEN_0 >> {2'h0, io_a_data[71], io_data_in[71]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_473 = _GEN_0 >> {2'h0, io_a_data[72], io_data_in[72]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_476 = _GEN_0 >> {2'h0, io_a_data[73], io_data_in[73]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_479 = _GEN_0 >> {2'h0, io_a_data[74], io_data_in[74]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_482 = _GEN_0 >> {2'h0, io_a_data[75], io_data_in[75]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_485 = _GEN_0 >> {2'h0, io_a_data[76], io_data_in[76]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_488 = _GEN_0 >> {2'h0, io_a_data[77], io_data_in[77]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_491 = _GEN_0 >> {2'h0, io_a_data[78], io_data_in[78]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_494 = _GEN_0 >> {2'h0, io_a_data[79], io_data_in[79]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_497 = _GEN_0 >> {2'h0, io_a_data[80], io_data_in[80]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_500 = _GEN_0 >> {2'h0, io_a_data[81], io_data_in[81]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_503 = _GEN_0 >> {2'h0, io_a_data[82], io_data_in[82]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_506 = _GEN_0 >> {2'h0, io_a_data[83], io_data_in[83]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_509 = _GEN_0 >> {2'h0, io_a_data[84], io_data_in[84]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_512 = _GEN_0 >> {2'h0, io_a_data[85], io_data_in[85]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_515 = _GEN_0 >> {2'h0, io_a_data[86], io_data_in[86]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_518 = _GEN_0 >> {2'h0, io_a_data[87], io_data_in[87]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_521 = _GEN_0 >> {2'h0, io_a_data[88], io_data_in[88]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_524 = _GEN_0 >> {2'h0, io_a_data[89], io_data_in[89]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_527 = _GEN_0 >> {2'h0, io_a_data[90], io_data_in[90]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_530 = _GEN_0 >> {2'h0, io_a_data[91], io_data_in[91]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_533 = _GEN_0 >> {2'h0, io_a_data[92], io_data_in[92]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_536 = _GEN_0 >> {2'h0, io_a_data[93], io_data_in[93]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_539 = _GEN_0 >> {2'h0, io_a_data[94], io_data_in[94]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_542 = _GEN_0 >> {2'h0, io_a_data[95], io_data_in[95]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_545 = _GEN_0 >> {2'h0, io_a_data[96], io_data_in[96]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_548 = _GEN_0 >> {2'h0, io_a_data[97], io_data_in[97]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_551 = _GEN_0 >> {2'h0, io_a_data[98], io_data_in[98]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_554 = _GEN_0 >> {2'h0, io_a_data[99], io_data_in[99]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_557 = _GEN_0 >> {2'h0, io_a_data[100], io_data_in[100]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_560 = _GEN_0 >> {2'h0, io_a_data[101], io_data_in[101]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_563 = _GEN_0 >> {2'h0, io_a_data[102], io_data_in[102]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_566 = _GEN_0 >> {2'h0, io_a_data[103], io_data_in[103]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_569 = _GEN_0 >> {2'h0, io_a_data[104], io_data_in[104]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_572 = _GEN_0 >> {2'h0, io_a_data[105], io_data_in[105]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_575 = _GEN_0 >> {2'h0, io_a_data[106], io_data_in[106]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_578 = _GEN_0 >> {2'h0, io_a_data[107], io_data_in[107]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_581 = _GEN_0 >> {2'h0, io_a_data[108], io_data_in[108]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_584 = _GEN_0 >> {2'h0, io_a_data[109], io_data_in[109]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_587 = _GEN_0 >> {2'h0, io_a_data[110], io_data_in[110]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_590 = _GEN_0 >> {2'h0, io_a_data[111], io_data_in[111]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_593 = _GEN_0 >> {2'h0, io_a_data[112], io_data_in[112]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_596 = _GEN_0 >> {2'h0, io_a_data[113], io_data_in[113]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_599 = _GEN_0 >> {2'h0, io_a_data[114], io_data_in[114]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_602 = _GEN_0 >> {2'h0, io_a_data[115], io_data_in[115]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_605 = _GEN_0 >> {2'h0, io_a_data[116], io_data_in[116]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_608 = _GEN_0 >> {2'h0, io_a_data[117], io_data_in[117]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_611 = _GEN_0 >> {2'h0, io_a_data[118], io_data_in[118]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_614 = _GEN_0 >> {2'h0, io_a_data[119], io_data_in[119]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_617 = _GEN_0 >> {2'h0, io_a_data[120], io_data_in[120]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_620 = _GEN_0 >> {2'h0, io_a_data[121], io_data_in[121]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_623 = _GEN_0 >> {2'h0, io_a_data[122], io_data_in[122]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_626 = _GEN_0 >> {2'h0, io_a_data[123], io_data_in[123]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_629 = _GEN_0 >> {2'h0, io_a_data[124], io_data_in[124]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_632 = _GEN_0 >> {2'h0, io_a_data[125], io_data_in[125]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_635 = _GEN_0 >> {2'h0, io_a_data[126], io_data_in[126]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [3:0]      _logical_T_638 = _GEN_0 >> {2'h0, io_a_data[127], io_data_in[127]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:25:36, :41:8, :45:42]
  wire [7:0][1:0] _GEN_1 = {{2'h0}, {2'h0}, {2'h0}, {2'h0}, {2'h3}, {io_a_param[2] ? 2'h2 : {1'h0, io_a_param[0] == ((|_sign_a_T_129) == (|({io_data_in[127], io_data_in[119], io_data_in[111], io_data_in[103], io_data_in[95], io_data_in[87], io_data_in[79], io_data_in[71], io_data_in[63], io_data_in[55], io_data_in[47], io_data_in[39], io_data_in[31], io_data_in[23], io_data_in[15], io_data_in[7]} & signBit)) ? ({_sum_T_34[127], _sum_T_34[119], _sum_T_34[111], _sum_T_34[103], _sum_T_34[95], _sum_T_34[87], _sum_T_34[79], _sum_T_34[71], _sum_T_34[63], _sum_T_34[55], _sum_T_34[47], _sum_T_34[39], _sum_T_34[31], _sum_T_34[23], _sum_T_34[15], _sum_T_34[7]} & signBit) == 16'h0 : io_a_param[1] == (|_sign_a_T_129))}}, {2'h1}, {2'h1}};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:18:28, :19:28, :20:28, :22:27, :24:57, :25:{33,36,83,94}, :29:32, :30:{21,29}, :31:25, :45:{19,42}, :48:8]
  wire [1:0]      select = io_write ? 2'h1 : _GEN_1[io_a_opcode];	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:45:{19,42}]
  wire [3:0][7:0] _GEN_2 = {{{_logical_T_302[0], _logical_T_299[0], _logical_T_296[0], _logical_T_293[0], _logical_T_290[0], _logical_T_287[0], _logical_T_284[0], _logical_T_281[0]}}, {_sum_T_34[15:8]}, {io_a_data[15:8]}, {io_data_in[15:8]}};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:24:57, :41:8, :58:21, :59:59]
  wire [3:0][7:0] _GEN_3 = {{{_logical_T_278[0], _logical_T_275[0], _logical_T_272[0], _logical_T_269[0], _logical_T_266[0], _logical_T_263[0], _logical_T_260[0], _logical_T_257[0]}}, {_sum_T_34[7:0]}, {io_a_data[7:0]}, {io_data_in[7:0]}};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:24:57, :41:8, :58:21, :59:59]
  wire [3:0][7:0] _GEN_4 = {{{_logical_T_350[0], _logical_T_347[0], _logical_T_344[0], _logical_T_341[0], _logical_T_338[0], _logical_T_335[0], _logical_T_332[0], _logical_T_329[0]}}, {_sum_T_34[31:24]}, {io_a_data[31:24]}, {io_data_in[31:24]}};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:24:57, :41:8, :58:21, :59:59]
  wire [3:0][7:0] _GEN_5 = {{{_logical_T_326[0], _logical_T_323[0], _logical_T_320[0], _logical_T_317[0], _logical_T_314[0], _logical_T_311[0], _logical_T_308[0], _logical_T_305[0]}}, {_sum_T_34[23:16]}, {io_a_data[23:16]}, {io_data_in[23:16]}};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:24:57, :41:8, :58:21, :59:59]
  wire [3:0][7:0] _GEN_6 = {{{_logical_T_398[0], _logical_T_395[0], _logical_T_392[0], _logical_T_389[0], _logical_T_386[0], _logical_T_383[0], _logical_T_380[0], _logical_T_377[0]}}, {_sum_T_34[47:40]}, {io_a_data[47:40]}, {io_data_in[47:40]}};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:24:57, :41:8, :58:21, :59:59]
  wire [3:0][7:0] _GEN_7 = {{{_logical_T_374[0], _logical_T_371[0], _logical_T_368[0], _logical_T_365[0], _logical_T_362[0], _logical_T_359[0], _logical_T_356[0], _logical_T_353[0]}}, {_sum_T_34[39:32]}, {io_a_data[39:32]}, {io_data_in[39:32]}};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:24:57, :41:8, :58:21, :59:59]
  wire [3:0][7:0] _GEN_8 = {{{_logical_T_446[0], _logical_T_443[0], _logical_T_440[0], _logical_T_437[0], _logical_T_434[0], _logical_T_431[0], _logical_T_428[0], _logical_T_425[0]}}, {_sum_T_34[63:56]}, {io_a_data[63:56]}, {io_data_in[63:56]}};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:24:57, :41:8, :58:21, :59:59]
  wire [3:0][7:0] _GEN_9 = {{{_logical_T_422[0], _logical_T_419[0], _logical_T_416[0], _logical_T_413[0], _logical_T_410[0], _logical_T_407[0], _logical_T_404[0], _logical_T_401[0]}}, {_sum_T_34[55:48]}, {io_a_data[55:48]}, {io_data_in[55:48]}};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:24:57, :41:8, :58:21, :59:59]
  wire [3:0][7:0] _GEN_10 = {{{_logical_T_494[0], _logical_T_491[0], _logical_T_488[0], _logical_T_485[0], _logical_T_482[0], _logical_T_479[0], _logical_T_476[0], _logical_T_473[0]}}, {_sum_T_34[79:72]}, {io_a_data[79:72]}, {io_data_in[79:72]}};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:24:57, :41:8, :58:21, :59:59]
  wire [3:0][7:0] _GEN_11 = {{{_logical_T_470[0], _logical_T_467[0], _logical_T_464[0], _logical_T_461[0], _logical_T_458[0], _logical_T_455[0], _logical_T_452[0], _logical_T_449[0]}}, {_sum_T_34[71:64]}, {io_a_data[71:64]}, {io_data_in[71:64]}};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:24:57, :41:8, :58:21, :59:59]
  wire [3:0][7:0] _GEN_12 = {{{_logical_T_542[0], _logical_T_539[0], _logical_T_536[0], _logical_T_533[0], _logical_T_530[0], _logical_T_527[0], _logical_T_524[0], _logical_T_521[0]}}, {_sum_T_34[95:88]}, {io_a_data[95:88]}, {io_data_in[95:88]}};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:24:57, :41:8, :58:21, :59:59]
  wire [3:0][7:0] _GEN_13 = {{{_logical_T_518[0], _logical_T_515[0], _logical_T_512[0], _logical_T_509[0], _logical_T_506[0], _logical_T_503[0], _logical_T_500[0], _logical_T_497[0]}}, {_sum_T_34[87:80]}, {io_a_data[87:80]}, {io_data_in[87:80]}};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:24:57, :41:8, :58:21, :59:59]
  wire [3:0][7:0] _GEN_14 = {{{_logical_T_590[0], _logical_T_587[0], _logical_T_584[0], _logical_T_581[0], _logical_T_578[0], _logical_T_575[0], _logical_T_572[0], _logical_T_569[0]}}, {_sum_T_34[111:104]}, {io_a_data[111:104]}, {io_data_in[111:104]}};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:24:57, :41:8, :58:21, :59:59]
  wire [3:0][7:0] _GEN_15 = {{{_logical_T_566[0], _logical_T_563[0], _logical_T_560[0], _logical_T_557[0], _logical_T_554[0], _logical_T_551[0], _logical_T_548[0], _logical_T_545[0]}}, {_sum_T_34[103:96]}, {io_a_data[103:96]}, {io_data_in[103:96]}};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:24:57, :41:8, :58:21, :59:59]
  wire [3:0][7:0] _GEN_16 = {{{_logical_T_638[0], _logical_T_635[0], _logical_T_632[0], _logical_T_629[0], _logical_T_626[0], _logical_T_623[0], _logical_T_620[0], _logical_T_617[0]}}, {_sum_T_34[127:120]}, {io_a_data[127:120]}, {io_data_in[127:120]}};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:24:57, :41:8, :58:21, :59:59]
  wire [3:0][7:0] _GEN_17 = {{{_logical_T_614[0], _logical_T_611[0], _logical_T_608[0], _logical_T_605[0], _logical_T_602[0], _logical_T_599[0], _logical_T_596[0], _logical_T_593[0]}}, {_sum_T_34[119:112]}, {io_a_data[119:112]}, {io_data_in[119:112]}};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:24:57, :41:8, :58:21, :59:59]
  assign io_data_out = {_GEN_16[io_a_mask[15] ? select : 2'h0], _GEN_17[io_a_mask[14] ? select : 2'h0], _GEN_14[io_a_mask[13] ? select : 2'h0], _GEN_15[io_a_mask[12] ? select : 2'h0], _GEN_12[io_a_mask[11] ? select : 2'h0], _GEN_13[io_a_mask[10] ? select : 2'h0], _GEN_10[io_a_mask[9] ? select : 2'h0], _GEN_11[io_a_mask[8] ? select : 2'h0], _GEN_8[io_a_mask[7] ? select : 2'h0], _GEN_9[io_a_mask[6] ? select : 2'h0], _GEN_6[io_a_mask[5] ? select : 2'h0], _GEN_7[io_a_mask[4] ? select : 2'h0], _GEN_4[io_a_mask[3] ? select : 2'h0], _GEN_5[io_a_mask[2] ? select : 2'h0], _GEN_2[io_a_mask[1] ? select : 2'h0], _GEN_3[io_a_mask[0] ? select : 2'h0]};	// @[generators/rocket-chip/src/main/scala/tilelink/Atomics.scala:8:7, :24:29, :45:{19,42}, :57:47, :58:21]
endmodule
