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

module SinkC(	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
  input          clock,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
  input          reset,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
  input          io_req_ready,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output         io_req_valid,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output [2:0]   io_req_bits_opcode,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output [2:0]   io_req_bits_param,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output [2:0]   io_req_bits_size,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output [6:0]   io_req_bits_source,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output [12:0]  io_req_bits_tag,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output [5:0]   io_req_bits_offset,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output [5:0]   io_req_bits_put,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output [9:0]   io_req_bits_set,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output         io_resp_valid,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output         io_resp_bits_last,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output [9:0]   io_resp_bits_set,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output [12:0]  io_resp_bits_tag,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output [6:0]   io_resp_bits_source,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output [2:0]   io_resp_bits_param,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output         io_resp_bits_data,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output         io_c_ready,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  input          io_c_valid,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  input  [2:0]   io_c_bits_opcode,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  input  [2:0]   io_c_bits_param,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  input  [2:0]   io_c_bits_size,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  input  [6:0]   io_c_bits_source,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  input  [31:0]  io_c_bits_address,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  input  [127:0] io_c_bits_data,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  input          io_c_bits_corrupt,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output [9:0]   io_set,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  input  [2:0]   io_way,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  input          io_bs_adr_ready,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output         io_bs_adr_valid,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output         io_bs_adr_bits_noop,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output [2:0]   io_bs_adr_bits_way,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output [9:0]   io_bs_adr_bits_set,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output [1:0]   io_bs_adr_bits_beat,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output [1:0]   io_bs_adr_bits_mask,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output [127:0] io_bs_dat_data,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output         io_rel_pop_ready,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  input          io_rel_pop_valid,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  input  [5:0]   io_rel_pop_bits_index,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  input          io_rel_pop_bits_last,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output [127:0] io_rel_beat_data,	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
  output         io_rel_beat_corrupt	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:43:14]
);

  wire         _io_rel_pop_ready_output;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:160:43]
  wire         _putbuffer_io_push_ready;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:115:27]
  wire [1:0]   _putbuffer_io_valid;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:115:27]
  wire         _io_bs_adr_q_io_enq_ready;	// @[src/main/scala/chisel3/util/Decoupled.scala:362:21]
  wire         _c_q_io_deq_valid;	// @[src/main/scala/chisel3/util/Decoupled.scala:362:21]
  wire [2:0]   _c_q_io_deq_bits_opcode;	// @[src/main/scala/chisel3/util/Decoupled.scala:362:21]
  wire [2:0]   _c_q_io_deq_bits_param;	// @[src/main/scala/chisel3/util/Decoupled.scala:362:21]
  wire [2:0]   _c_q_io_deq_bits_size;	// @[src/main/scala/chisel3/util/Decoupled.scala:362:21]
  wire [6:0]   _c_q_io_deq_bits_source;	// @[src/main/scala/chisel3/util/Decoupled.scala:362:21]
  wire [31:0]  _c_q_io_deq_bits_address;	// @[src/main/scala/chisel3/util/Decoupled.scala:362:21]
  wire [127:0] _c_q_io_deq_bits_data;	// @[src/main/scala/chisel3/util/Decoupled.scala:362:21]
  wire         _c_q_io_deq_bits_corrupt;	// @[src/main/scala/chisel3/util/Decoupled.scala:362:21]
  wire [12:0]  tag = {_c_q_io_deq_bits_address[31], _c_q_io_deq_bits_address[27:16]};	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Parameters.scala:214:47, :215:22, :216:19, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  wire [12:0]  _r_beats1_decode_T = 13'h3F << _c_q_io_deq_bits_size;	// @[generators/rocket-chip/src/main/scala/util/package.scala:243:71, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  wire [1:0]   r_beats1 = _c_q_io_deq_bits_opcode[0] ? ~(_r_beats1_decode_T[5:4]) : 2'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:102:36, :221:14, :229:27, generators/rocket-chip/src/main/scala/util/package.scala:243:{46,71,76}, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  reg  [1:0]   r_counter;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
  wire [1:0]   _r_counter1_T = r_counter - 2'h1;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, :230:28]
  wire         last = r_counter == 2'h1 | r_beats1 == 2'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:221:14, :229:27, :232:{25,33,43}]
  wire [1:0]   beat = r_beats1 & ~_r_counter1_T;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:221:14, :230:28, :234:{25,27}]
  wire         raw_resp = _c_q_io_deq_bits_opcode == 3'h4 | _c_q_io_deq_bits_opcode == 3'h5;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, :78:{34,58,75}, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  reg          resp_r;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:79:48]
  wire         resp = _c_q_io_deq_valid ? raw_resp : resp_r;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:78:58, :79:{19,48}, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  `ifndef SYNTHESIS	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:90:12]
    always @(posedge clock) begin	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:90:12]
      if (~reset & _c_q_io_deq_valid & _c_q_io_deq_bits_corrupt) begin	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:90:12, src/main/scala/chisel3/util/Decoupled.scala:362:21]
        if (`ASSERT_VERBOSE_COND_)	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:90:12]
          $error("Assertion failed: Data poisoning unavailable\n    at SinkC.scala:90 assert (!(c.valid && c.bits.corrupt), \"Data poisoning unavailable\")\n");	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:90:12]
        if (`STOP_COND_)	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:90:12]
          $fatal;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:90:12]
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  reg  [9:0]   io_set_r;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:92:42]
  wire [9:0]   _io_set_output = _c_q_io_deq_valid ? _c_q_io_deq_bits_address[15:6] : io_set_r;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Parameters.scala:215:22, :217:28, generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:92:{18,42}, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  reg  [127:0] io_bs_dat_data_r;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:98:34]
  wire         bs_adr_valid = resp & ((|r_counter) | _c_q_io_deq_valid & _c_q_io_deq_bits_opcode[0]);	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:79:19, :99:{30,41,53}, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:102:36, :229:27, :231:25, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  reg  [1:0]   bs_adr_bits_beat_r;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:103:53]
  reg  [1:0]   lists;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:116:24]
  wire [1:0]   _freeOH_T_7 = ~lists;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:116:24, :123:27]
  wire [1:0]   freeIdx_lo = {~(_freeOH_T_7[0]), 1'h1} & _freeOH_T_7;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:123:{18,27,41}, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:230:28]
  wire [1:0]   freeIdx = {1'h0, freeIdx_lo[1]};	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:123:41, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:230:28, src/main/scala/chisel3/util/CircuitMath.scala:28:8, src/main/scala/chisel3/util/OneHot.scala:32:10]
  wire         req_block = ~(|r_counter) & ~io_req_ready;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:126:{27,30}, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, :231:25]
  wire         buf_block = _c_q_io_deq_bits_opcode[0] & ~_putbuffer_io_push_ready;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:115:27, :127:{29,32}, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:102:36, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  wire         set_block = _c_q_io_deq_bits_opcode[0] & ~(|r_counter) & (&lists);	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:116:24, :122:23, :128:38, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:102:36, :229:27, :231:25, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  wire         _q_io_deq_ready_T_7 = raw_resp ? ~(_c_q_io_deq_bits_opcode[0]) | _io_bs_adr_q_io_enq_ready : ~req_block & ~buf_block & ~set_block;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:78:58, :107:61, :126:27, :127:29, :128:38, :134:{19,39,56,70,81,84}, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:102:36, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  reg  [1:0]   put_r;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:140:44]
  wire [1:0]   put = (|r_counter) ? put_r : freeIdx;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:140:{18,44}, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, :231:25, src/main/scala/chisel3/util/OneHot.scala:32:10]
  wire         _putbuffer_io_pop_valid_T = _io_rel_pop_ready_output & io_rel_pop_valid;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:160:43, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  wire [1:0]   _GEN = {1'h0, io_rel_pop_bits_index[0]};	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:160:{43,65}, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:230:28]
  wire [1:0]   _io_rel_pop_ready_T_1 = _putbuffer_io_valid >> _GEN;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:115:27, :160:43]
  assign _io_rel_pop_ready_output = _io_rel_pop_ready_T_1[0];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:160:43]
  always @(posedge clock) begin	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
    if (reset) begin	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
      r_counter <= 2'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
      lists <= 2'h0;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:116:24, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
    end
    else begin	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
      if (_q_io_deq_ready_T_7 & _c_q_io_deq_valid) begin	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:134:19, src/main/scala/chisel3/util/Decoupled.scala:51:35, :362:21]
        if (|r_counter)	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, :231:25]
          r_counter <= _r_counter1_T;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, :230:28]
        else	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:231:25]
          r_counter <= r_beats1;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:221:14, :229:27]
      end
      lists <= (lists | (~resp & _c_q_io_deq_valid & ~(|r_counter) & _c_q_io_deq_bits_opcode[0] & ~req_block & ~buf_block ? freeIdx_lo : 2'h0)) & ~(_putbuffer_io_pop_valid_T & io_rel_pop_bits_last ? 2'h1 << _GEN : 2'h0);	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:79:19, :116:24, :118:29, :119:29, :120:{21,34,36}, :123:41, :126:27, :127:29, :134:{56,70}, :136:21, :138:{62,77,89}, :160:43, :163:{27,52}, :164:17, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:102:36, :229:27, :231:25, :232:25, src/main/scala/chisel3/util/Decoupled.scala:51:35, :362:21, src/main/scala/chisel3/util/OneHot.scala:65:12]
    end
    if (_c_q_io_deq_valid) begin	// @[src/main/scala/chisel3/util/Decoupled.scala:362:21]
      resp_r <= raw_resp;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:78:58, :79:48]
      io_set_r <= _c_q_io_deq_bits_address[15:6];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Parameters.scala:215:22, :217:28, generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:92:42, src/main/scala/chisel3/util/Decoupled.scala:362:21]
      bs_adr_bits_beat_r <= beat + {1'h0, _io_bs_adr_q_io_enq_ready};	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:103:{53,59}, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:230:28, :234:25, src/main/scala/chisel3/util/Decoupled.scala:362:21]
    end
    if (_io_bs_adr_q_io_enq_ready & bs_adr_valid)	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:99:30, src/main/scala/chisel3/util/Decoupled.scala:51:35, :362:21]
      io_bs_dat_data_r <= _c_q_io_deq_bits_data;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:98:34, src/main/scala/chisel3/util/Decoupled.scala:362:21]
    if (~(|r_counter))	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, :231:25]
      put_r <= freeIdx;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:140:44, src/main/scala/chisel3/util/OneHot.scala:32:10]
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
      `FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:4];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
    initial begin	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
        `INIT_RANDOM_PROLOG_	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
        for (logic [2:0] i = 3'h0; i < 3'h5; i += 3'h1) begin
          _RANDOM[i] = `RANDOM;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
        end	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
        r_counter = _RANDOM[3'h0][1:0];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
        resp_r = _RANDOM[3'h0][2];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, :79:48, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
        io_set_r = _RANDOM[3'h0][12:3];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, :92:42, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
        io_bs_dat_data_r = {_RANDOM[3'h0][31:13], _RANDOM[3'h1], _RANDOM[3'h2], _RANDOM[3'h3], _RANDOM[3'h4][12:0]};	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, :98:34, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
        bs_adr_bits_beat_r = _RANDOM[3'h4][14:13];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, :98:34, :103:53]
        lists = _RANDOM[3'h4][16:15];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, :98:34, :116:24]
        put_r = _RANDOM[3'h4][18:17];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, :98:34, :140:44]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
      `FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  Queue2_TLBundleC_a32d128s7k4z3c c_q (	// @[src/main/scala/chisel3/util/Decoupled.scala:362:21]
    .clock               (clock),
    .reset               (reset),
    .io_enq_ready        (io_c_ready),
    .io_enq_valid        (io_c_valid),
    .io_enq_bits_opcode  (io_c_bits_opcode),
    .io_enq_bits_param   (io_c_bits_param),
    .io_enq_bits_size    (io_c_bits_size),
    .io_enq_bits_source  (io_c_bits_source),
    .io_enq_bits_address (io_c_bits_address),
    .io_enq_bits_data    (io_c_bits_data),
    .io_enq_bits_corrupt (io_c_bits_corrupt),
    .io_deq_ready        (_q_io_deq_ready_T_7),	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:134:19]
    .io_deq_valid        (_c_q_io_deq_valid),
    .io_deq_bits_opcode  (_c_q_io_deq_bits_opcode),
    .io_deq_bits_param   (_c_q_io_deq_bits_param),
    .io_deq_bits_size    (_c_q_io_deq_bits_size),
    .io_deq_bits_source  (_c_q_io_deq_bits_source),
    .io_deq_bits_address (_c_q_io_deq_bits_address),
    .io_deq_bits_data    (_c_q_io_deq_bits_data),
    .io_deq_bits_corrupt (_c_q_io_deq_bits_corrupt)
  );
  Queue1_BankedStoreInnerAddress io_bs_adr_q (	// @[src/main/scala/chisel3/util/Decoupled.scala:362:21]
    .clock            (clock),
    .reset            (reset),
    .io_enq_ready     (_io_bs_adr_q_io_enq_ready),
    .io_enq_valid     (bs_adr_valid),	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:99:30]
    .io_enq_bits_noop (~_c_q_io_deq_valid),	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:100:25, src/main/scala/chisel3/util/Decoupled.scala:362:21]
    .io_enq_bits_way  (io_way),
    .io_enq_bits_set  (_io_set_output),	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:92:18]
    .io_enq_bits_beat (_c_q_io_deq_valid ? beat : bs_adr_bits_beat_r),	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:103:{28,53}, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:234:25, src/main/scala/chisel3/util/Decoupled.scala:362:21]
    .io_deq_ready     (io_bs_adr_ready),
    .io_deq_valid     (io_bs_adr_valid),
    .io_deq_bits_noop (io_bs_adr_bits_noop),
    .io_deq_bits_way  (io_bs_adr_bits_way),
    .io_deq_bits_set  (io_bs_adr_bits_set),
    .io_deq_bits_beat (io_bs_adr_bits_beat),
    .io_deq_bits_mask (io_bs_adr_bits_mask)
  );
  ListBuffer_PutBufferCEntry_q2_e8 putbuffer (	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:115:27]
    .clock                     (clock),
    .reset                     (reset),
    .io_push_ready             (_putbuffer_io_push_ready),
    .io_push_valid             (~resp & _c_q_io_deq_valid & _c_q_io_deq_bits_opcode[0] & ~req_block & ~set_block),	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:79:19, :126:27, :128:38, :134:{56,84}, :136:21, :137:74, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:102:36, src/main/scala/chisel3/util/Decoupled.scala:362:21]
    .io_push_bits_index        (put[0]),	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:140:18, :153:34]
    .io_push_bits_data_data    (_c_q_io_deq_bits_data),	// @[src/main/scala/chisel3/util/Decoupled.scala:362:21]
    .io_push_bits_data_corrupt (_c_q_io_deq_bits_corrupt),	// @[src/main/scala/chisel3/util/Decoupled.scala:362:21]
    .io_valid                  (_putbuffer_io_valid),
    .io_pop_valid              (_putbuffer_io_pop_valid_T),	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
    .io_pop_bits               (io_rel_pop_bits_index[0]),	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:158:27]
    .io_data_data              (io_rel_beat_data),
    .io_data_corrupt           (io_rel_beat_corrupt)
  );
  assign io_req_valid = ~resp & _c_q_io_deq_valid & ~(|r_counter) & ~buf_block & ~set_block;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, :79:19, :127:29, :128:38, :134:{70,84}, :136:{21,61}, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, :231:25, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  assign io_req_bits_opcode = _c_q_io_deq_bits_opcode;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  assign io_req_bits_param = _c_q_io_deq_bits_param;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  assign io_req_bits_size = _c_q_io_deq_bits_size;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  assign io_req_bits_source = _c_q_io_deq_bits_source;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  assign io_req_bits_tag = tag;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Parameters.scala:215:22, :216:19, generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
  assign io_req_bits_offset = _c_q_io_deq_bits_address[5:0];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Parameters.scala:217:50, generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  assign io_req_bits_put = {4'h0, put};	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, :140:18, :151:24]
  assign io_req_bits_set = _c_q_io_deq_bits_address[15:6];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Parameters.scala:215:22, :217:28, generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  assign io_resp_valid = resp & _c_q_io_deq_valid & (~(|r_counter) | last) & (~(_c_q_io_deq_bits_opcode[0]) | _io_bs_adr_q_io_enq_ready);	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, :79:19, :107:{48,57,61,70}, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:102:36, :229:27, :231:25, :232:33, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  assign io_resp_bits_last = last;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:232:33]
  assign io_resp_bits_set = _c_q_io_deq_bits_address[15:6];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Parameters.scala:215:22, :217:28, generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  assign io_resp_bits_tag = tag;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/Parameters.scala:215:22, :216:19, generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7]
  assign io_resp_bits_source = _c_q_io_deq_bits_source;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  assign io_resp_bits_param = _c_q_io_deq_bits_param;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  assign io_resp_bits_data = _c_q_io_deq_bits_opcode[0];	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, generators/rocket-chip/src/main/scala/tilelink/Edges.scala:102:36, src/main/scala/chisel3/util/Decoupled.scala:362:21]
  assign io_set = _io_set_output;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, :92:18]
  assign io_bs_dat_data = io_bs_dat_data_r;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, :98:34]
  assign io_rel_pop_ready = _io_rel_pop_ready_output;	// @[generators/rocket-chip-inclusive-cache/design/craft/inclusivecache/src/SinkC.scala:41:7, :160:43]
endmodule

