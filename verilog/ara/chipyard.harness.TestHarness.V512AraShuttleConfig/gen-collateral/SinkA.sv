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

module SinkA(	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
  input          clock,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
  input          reset,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
  input          io_req_ready,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  output         io_req_valid,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  output [2:0]   io_req_bits_opcode,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  output [2:0]   io_req_bits_param,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  output [2:0]   io_req_bits_size,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  output [7:0]   io_req_bits_source,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  output [12:0]  io_req_bits_tag,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  output [5:0]   io_req_bits_offset,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  output [5:0]   io_req_bits_put,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  output [9:0]   io_req_bits_set,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  output         io_a_ready,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  input          io_a_valid,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  input  [2:0]   io_a_bits_opcode,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  input  [2:0]   io_a_bits_param,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  input  [2:0]   io_a_bits_size,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  input  [7:0]   io_a_bits_source,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  input  [31:0]  io_a_bits_address,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  input  [15:0]  io_a_bits_mask,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  input  [127:0] io_a_bits_data,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  input          io_a_bits_corrupt,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  output         io_pb_pop_ready,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  input          io_pb_pop_valid,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  input  [5:0]   io_pb_pop_bits_index,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  input          io_pb_pop_bits_last,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  output [127:0] io_pb_beat_data,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  output [15:0]  io_pb_beat_mask,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
  output         io_pb_beat_corrupt	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:40:14]
);

  wire        _io_pb_pop_ready_output;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:105:40]
  wire        _putbuffer_io_push_ready;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:51:25]
  wire [39:0] _putbuffer_io_valid;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:51:25]
  reg  [39:0] lists;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:52:22]
  wire [39:0] _freeOH_T_22 = ~lists;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:52:22, :59:25]
  wire [38:0] _freeOH_T_3 = _freeOH_T_22[38:0] | {_freeOH_T_22[37:0], 1'h0};	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7, :59:25, generators/rocket-chip/src/main/scala/util/package.scala:253:{43,53}]
  wire [38:0] _freeOH_T_6 = _freeOH_T_3 | {_freeOH_T_3[36:0], 2'h0};	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7, generators/rocket-chip/src/main/scala/util/package.scala:253:{43,53}]
  wire [38:0] _freeOH_T_9 = _freeOH_T_6 | {_freeOH_T_6[34:0], 4'h0};	// @[generators/rocket-chip/src/main/scala/util/package.scala:253:{43,48,53}]
  wire [38:0] _freeOH_T_12 = _freeOH_T_9 | {_freeOH_T_9[30:0], 8'h0};	// @[generators/rocket-chip/src/main/scala/util/package.scala:253:{43,48,53}]
  wire [38:0] _freeOH_T_15 = _freeOH_T_12 | {_freeOH_T_12[22:0], 16'h0};	// @[generators/rocket-chip/src/main/scala/util/package.scala:253:{43,48,53}]
  wire [39:0] _GEN = {~(_freeOH_T_15 | {_freeOH_T_15[6:0], 32'h0}), 1'h1} & _freeOH_T_22;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7, :59:{16,25,39}, generators/rocket-chip/src/main/scala/util/package.scala:253:{43,48,53}]
  wire [30:0] _freeIdx_T_1 = {24'h0, _GEN[39:33]} | _GEN[31:1];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:59:39, src/main/scala/chisel3/util/OneHot.scala:31:18, :32:28]
  wire [14:0] _freeIdx_T_3 = _freeIdx_T_1[30:16] | _freeIdx_T_1[14:0];	// @[src/main/scala/chisel3/util/OneHot.scala:30:18, :31:18, :32:28]
  wire [6:0]  _freeIdx_T_5 = _freeIdx_T_3[14:8] | _freeIdx_T_3[6:0];	// @[src/main/scala/chisel3/util/OneHot.scala:30:18, :31:18, :32:28]
  wire [2:0]  _freeIdx_T_7 = _freeIdx_T_5[6:4] | _freeIdx_T_5[2:0];	// @[src/main/scala/chisel3/util/OneHot.scala:30:18, :31:18, :32:28]
  wire [5:0]  freeIdx = {|(_GEN[39:32]), |(_freeIdx_T_1[30:15]), |(_freeIdx_T_3[14:7]), |(_freeIdx_T_5[6:3]), |(_freeIdx_T_7[2:1]), _freeIdx_T_7[2] | _freeIdx_T_7[0]};	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:59:39, src/main/scala/chisel3/util/OneHot.scala:30:18, :31:18, :32:{10,14,28}]
  reg  [1:0]  first_counter;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
  wire        first = first_counter == 2'h0;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, :231:25]
  wire        req_block = first & ~io_req_ready;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:70:{25,28}, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:231:25]
  wire        buf_block = ~(io_a_bits_opcode[2]) & ~_putbuffer_io_push_ready;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:51:25, :71:{27,30}, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:92:{28,37}]
  wire        set_block = ~(io_a_bits_opcode[2]) & first & (&lists);	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:52:22, :58:21, :72:36, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:92:{28,37}, :231:25]
  wire        _io_a_ready_output = ~req_block & ~buf_block & ~set_block;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:70:25, :71:27, :72:36, :78:{14,28,39,42}]
  wire        _io_req_valid_T = io_a_valid & first;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:79:27, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:231:25]
  reg  [5:0]  put_r;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:84:42]
  wire [5:0]  put = first ? freeIdx : put_r;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:84:{16,42}, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:231:25, src/main/scala/chisel3/util/OneHot.scala:32:10]
  wire        _putbuffer_io_pop_valid_T = _io_pb_pop_ready_output & io_pb_pop_valid;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:105:40, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  wire [39:0] _io_pb_pop_ready_T = _putbuffer_io_valid >> io_pb_pop_bits_index;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:51:25, :105:40]
  assign _io_pb_pop_ready_output = _io_pb_pop_ready_T[0];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:105:40]
  wire [63:0] _lists_clr_T = 64'h1 << io_pb_pop_bits_index;	// @[src/main/scala/chisel3/util/OneHot.scala:65:12]
  wire [12:0] _first_beats1_decode_T = 13'h3F << io_a_bits_size;	// @[generators/rocket-chip/src/main/scala/util/package.scala:243:71]
  always @(posedge clock) begin	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
    if (reset) begin	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
      lists <= 40'h0;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:52:22]
      first_counter <= 2'h0;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
    end
    else begin	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
      lists <= (lists | (_io_req_valid_T & ~(io_a_bits_opcode[2]) & ~req_block & ~buf_block ? _GEN : 40'h0)) & ~(_putbuffer_io_pop_valid_T & io_pb_pop_bits_last ? _lists_clr_T[39:0] : 40'h0);	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:52:22, :54:27, :55:27, :56:{19,32,34}, :59:39, :70:25, :71:27, :78:{14,28}, :79:27, :81:{51,66,78}, :108:{24,48}, :109:15, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:92:{28,37}, src/main/scala/chisel3/util/Decoupled.scala:51:35, src/main/scala/chisel3/util/OneHot.scala:65:{12,27}]
      if (_io_a_ready_output & io_a_valid) begin	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:78:39, src/main/scala/chisel3/util/Decoupled.scala:51:35]
        if (first)	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:231:25]
          first_counter <= io_a_bits_opcode[2] ? 2'h0 : ~(_first_beats1_decode_T[5:4]);	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:92:37, :221:14, :229:27, generators/rocket-chip/src/main/scala/util/package.scala:243:{46,71,76}]
        else	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:231:25]
          first_counter <= first_counter - 2'h1;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, :230:28]
      end
    end
    if (first)	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:231:25]
      put_r <= freeIdx;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:84:42, src/main/scala/chisel3/util/OneHot.scala:32:10]
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
      `FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:1];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
    initial begin	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
        `INIT_RANDOM_PROLOG_	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
        for (logic [1:0] i = 2'h0; i < 2'h2; i += 2'h1) begin
          _RANDOM[i[0]] = `RANDOM;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
        end	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
        lists = {_RANDOM[1'h0], _RANDOM[1'h1][7:0]};	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7, :52:22]
        first_counter = _RANDOM[1'h1][9:8];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7, :52:22, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
        put_r = _RANDOM[1'h1][15:10];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7, :52:22, :84:42]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
      `FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  ListBuffer_PutBufferAEntry_q40_e40 putbuffer (	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:51:25]
    .clock                     (clock),
    .reset                     (reset),
    .io_push_ready             (_putbuffer_io_push_ready),
    .io_push_valid             (io_a_valid & ~(io_a_bits_opcode[2]) & ~req_block & ~set_block),	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:70:25, :72:36, :78:{14,42}, :80:63, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:92:{28,37}]
    .io_push_bits_index        (put),	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:84:16]
    .io_push_bits_data_data    (io_a_bits_data),
    .io_push_bits_data_mask    (io_a_bits_mask),
    .io_push_bits_data_corrupt (io_a_bits_corrupt),
    .io_valid                  (_putbuffer_io_valid),
    .io_pop_valid              (_putbuffer_io_pop_valid_T),	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
    .io_pop_bits               (io_pb_pop_bits_index),
    .io_data_data              (io_pb_beat_data),
    .io_data_mask              (io_pb_beat_mask),
    .io_data_corrupt           (io_pb_beat_corrupt)
  );
  assign io_req_valid = _io_req_valid_T & ~buf_block & ~set_block;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7, :71:27, :72:36, :78:{28,42}, :79:{27,50}]
  assign io_req_bits_opcode = io_a_bits_opcode;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
  assign io_req_bits_param = io_a_bits_param;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
  assign io_req_bits_size = io_a_bits_size;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
  assign io_req_bits_source = io_a_bits_source;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
  assign io_req_bits_tag = {io_a_bits_address[31], io_a_bits_address[27:16]};	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Parameters.scala:214:47, :215:22, :216:19, generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
  assign io_req_bits_offset = io_a_bits_address[5:0];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Parameters.scala:217:50, generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
  assign io_req_bits_put = put;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7, :84:16]
  assign io_req_bits_set = io_a_bits_address[15:6];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Parameters.scala:215:22, :217:28, generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7]
  assign io_a_ready = _io_a_ready_output;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7, :78:39]
  assign io_pb_pop_ready = _io_pb_pop_ready_output;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkA.scala:38:7, :105:40]
endmodule

