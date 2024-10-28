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

module AsyncQueueSink_Phit(	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7]
  input         clock,	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7]
  input         reset,	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7]
  input         io_deq_ready,	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:139:14]
  output        io_deq_valid,	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:139:14]
  output [31:0] io_deq_bits_phit,	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:139:14]
  input  [31:0] io_async_mem_0_phit,	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:139:14]
  input  [31:0] io_async_mem_1_phit,	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:139:14]
  input  [31:0] io_async_mem_2_phit,	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:139:14]
  input  [31:0] io_async_mem_3_phit,	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:139:14]
  input  [31:0] io_async_mem_4_phit,	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:139:14]
  input  [31:0] io_async_mem_5_phit,	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:139:14]
  input  [31:0] io_async_mem_6_phit,	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:139:14]
  input  [31:0] io_async_mem_7_phit,	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:139:14]
  output [3:0]  io_async_ridx,	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:139:14]
  input  [3:0]  io_async_widx,	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:139:14]
  output        io_async_safe_ridx_valid,	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:139:14]
  input         io_async_safe_widx_valid,	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:139:14]
  input         io_async_safe_source_reset_n,	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:139:14]
  output        io_async_safe_sink_reset_n	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:139:14]
);

  wire             _io_deq_valid_output;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:166:29]
  wire             _source_valid_io_out;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:176:31]
  wire             _source_extend_io_out;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:175:31]
  wire             _sink_valid_0_io_out;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:172:33]
  wire [3:0]       _widx_widx_gray_io_q;	// @[generators/rocket-chip/src/main/scala/util/ShiftReg.scala:45:23]
  reg  [3:0]       ridx_ridx_bin;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:52:25]
  wire [3:0]       _ridx_incremented_T = ridx_ridx_bin + {3'h0, io_deq_ready & _io_deq_valid_output};	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:52:25, :53:43, :166:29, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  wire [3:0]       ridx_incremented = _source_valid_io_out ? _ridx_incremented_T : 4'h0;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:53:{23,43}, :176:31]
  wire [2:0]       _index_T = ridx_incremented[2:0] ^ ridx_incremented[3:1];	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:53:23, :54:{17,32}]
  wire [3:0]       ridx = {ridx_incremented[3], _index_T};	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:53:23, :54:17]
  wire             valid = _source_valid_io_out & ridx != _widx_widx_gray_io_q;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:54:17, :150:{28,36}, :176:31, generators/rocket-chip/src/main/scala/util/ShiftReg.scala:45:23]
  wire [7:0][31:0] _GEN = {{io_async_mem_7_phit}, {io_async_mem_6_phit}, {io_async_mem_5_phit}, {io_async_mem_4_phit}, {io_async_mem_3_phit}, {io_async_mem_2_phit}, {io_async_mem_1_phit}, {io_async_mem_0_phit}};	// @[generators/rocket-chip/src/main/scala/util/SynchronizerReg.scala:209:18]
  reg              valid_reg;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:165:56]
  assign _io_deq_valid_output = valid_reg & _source_valid_io_out;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:165:56, :166:29, :176:31]
  reg  [3:0]       ridx_gray;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:168:55]
  always @(posedge clock or posedge reset) begin	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7]
    if (reset) begin	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7]
      ridx_ridx_bin <= 4'h0;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:52:25, :53:23]
      valid_reg <= 1'h0;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7, :165:56]
      ridx_gray <= 4'h0;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:53:23, :168:55]
    end
    else begin	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7]
      if (_source_valid_io_out)	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:176:31]
        ridx_ridx_bin <= _ridx_incremented_T;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:52:25, :53:43]
      else	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:176:31]
        ridx_ridx_bin <= 4'h0;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:52:25, :53:23]
      valid_reg <= valid;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:150:28, :165:56]
      ridx_gray <= ridx;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:54:17, :168:55]
    end
  end // always @(posedge, posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7]
      `FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:0];	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7]
    initial begin	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7]
        `INIT_RANDOM_PROLOG_	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7]
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7]
        ridx_ridx_bin = _RANDOM[/*Zero width*/ 1'b0][3:0];	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:52:25, :136:7]
        valid_reg = _RANDOM[/*Zero width*/ 1'b0][4];	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:52:25, :136:7, :165:56]
        ridx_gray = _RANDOM[/*Zero width*/ 1'b0][8:5];	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:52:25, :136:7, :168:55]
      `endif // RANDOMIZE_REG_INIT
      if (reset) begin	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7]
        ridx_ridx_bin = 4'h0;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:52:25, :53:23]
        valid_reg = 1'h0;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7, :165:56]
        ridx_gray = 4'h0;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:53:23, :168:55]
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7]
      `FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  AsyncResetSynchronizerShiftReg_w4_d3_i0 widx_widx_gray (	// @[generators/rocket-chip/src/main/scala/util/ShiftReg.scala:45:23]
    .clock (clock),
    .reset (reset),
    .io_d  (io_async_widx),
    .io_q  (_widx_widx_gray_io_q)
  );
  ClockCrossingReg_w32 io_deq_bits_deq_bits_reg (	// @[generators/rocket-chip/src/main/scala/util/SynchronizerReg.scala:207:25]
    .clock (clock),
    .io_d  (_GEN[_index_T ^ {ridx_incremented[3], 2'h0}]),	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:53:23, :54:17, :156:{55,75}, generators/rocket-chip/src/main/scala/util/SynchronizerReg.scala:209:18]
    .io_q  (io_deq_bits_phit),
    .io_en (valid)	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:150:28]
  );
  AsyncValidSync sink_valid_0 (	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:172:33]
    .io_in  (1'h1),	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7]
    .io_out (_sink_valid_0_io_out),
    .clock  (clock),
    .reset  (reset | ~io_async_safe_source_reset_n)	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:177:{42,45}]
  );
  AsyncValidSync sink_valid_1 (	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:173:33]
    .io_in  (_sink_valid_0_io_out),	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:172:33]
    .io_out (io_async_safe_ridx_valid),
    .clock  (clock),
    .reset  (reset | ~io_async_safe_source_reset_n)	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:177:45, :178:42]
  );
  AsyncValidSync source_extend (	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:175:31]
    .io_in  (io_async_safe_widx_valid),
    .io_out (_source_extend_io_out),
    .clock  (clock),
    .reset  (reset | ~io_async_safe_source_reset_n)	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:177:45, :179:42]
  );
  AsyncValidSync source_valid (	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:176:31]
    .io_in  (_source_extend_io_out),	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:175:31]
    .io_out (_source_valid_io_out),
    .clock  (clock),
    .reset  (reset)
  );
  assign io_deq_valid = _io_deq_valid_output;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7, :166:29]
  assign io_async_ridx = ridx_gray;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7, :168:55]
  assign io_async_safe_sink_reset_n = ~reset;	// @[generators/rocket-chip/src/main/scala/util/AsyncQueue.scala:136:7, :193:25]
endmodule
