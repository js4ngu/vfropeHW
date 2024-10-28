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

module MultiWritebackUnit(	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7]
  input         clock,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7]
  input         reset,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7]
  output        io_req_ready,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  input         io_req_valid,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  input  [19:0] io_req_bits_tag,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  input  [5:0]  io_req_bits_idx,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  input  [2:0]  io_req_bits_source,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  input  [2:0]  io_req_bits_param,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  input  [3:0]  io_req_bits_way_en,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  input         io_req_bits_voluntary,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  output        io_occupied_0,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  output        io_occupied_1,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  output [5:0]  io_meta_read_bits_idx,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  output [19:0] io_meta_read_bits_tag,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  input         io_data_req_ready,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  output        io_data_req_valid,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  output [3:0]  io_data_req_bits_way_en,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  output [11:0] io_data_req_bits_addr,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  input  [63:0] io_data_resp,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  input         io_release_ready,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  output        io_release_valid,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  output [2:0]  io_release_bits_opcode,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  output [2:0]  io_release_bits_param,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  output [3:0]  io_release_bits_size,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  output [2:0]  io_release_bits_source,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  output [31:0] io_release_bits_address,	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
  output [63:0] io_release_bits_data	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:12:14]
);

  wire        _wbs_1_io_req_ready;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire [5:0]  _wbs_1_io_meta_read_bits_idx;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire [19:0] _wbs_1_io_meta_read_bits_tag;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire        _wbs_1_io_data_req_valid;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire [3:0]  _wbs_1_io_data_req_bits_way_en;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire [11:0] _wbs_1_io_data_req_bits_addr;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire        _wbs_1_io_release_valid;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire [2:0]  _wbs_1_io_release_bits_opcode;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire [2:0]  _wbs_1_io_release_bits_param;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire [2:0]  _wbs_1_io_release_bits_source;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire [31:0] _wbs_1_io_release_bits_address;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire [63:0] _wbs_1_io_release_bits_data;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire        _wbs_0_io_req_ready;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire [5:0]  _wbs_0_io_meta_read_bits_idx;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire [19:0] _wbs_0_io_meta_read_bits_tag;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire        _wbs_0_io_data_req_valid;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire [3:0]  _wbs_0_io_data_req_bits_way_en;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire [11:0] _wbs_0_io_data_req_bits_addr;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire        _wbs_0_io_release_valid;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire [2:0]  _wbs_0_io_release_bits_opcode;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire [2:0]  _wbs_0_io_release_bits_param;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire [2:0]  _wbs_0_io_release_bits_source;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire [31:0] _wbs_0_io_release_bits_address;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire [63:0] _wbs_0_io_release_bits_data;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  reg  [1:0]  head;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:22:21]
  reg  [1:0]  tail;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:23:21]
  wire        _io_req_ready_WIRE = tail[0] & _wbs_0_io_req_ready | tail[1] & _wbs_1_io_req_ready;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33, :23:21, src/main/scala/chisel3/util/Mux.scala:30:73, :32:36]
  wire        _wbs_0_io_data_req_ready_T_1 = head[0] & io_data_req_ready;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:22:21, :32:62, src/main/scala/chisel3/util/Mux.scala:32:36]
  wire        _wbs_1_io_data_req_ready_T_1 = head[1] & io_data_req_ready;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:22:21, :32:62, src/main/scala/chisel3/util/Mux.scala:32:36]
  reg  [8:0]  counter;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
  reg  [8:0]  counter_1;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
  wire        _GEN = io_release_ready & _wbs_0_io_release_valid;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  wire [8:0]  beats1 = _wbs_0_io_release_bits_opcode[0] ? 9'h7 : 9'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:102:36, :220:59, :221:14, :229:27, generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  wire        _GEN_0 = io_release_ready & _wbs_1_io_release_valid;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  wire [8:0]  beats1_1 = _wbs_1_io_release_bits_opcode[0] ? 9'h7 : 9'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:102:36, :220:59, :221:14, :229:27, generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
  always @(posedge clock) begin	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7]
    if (reset) begin	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7]
      head <= 2'h1;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:22:21]
      tail <= 2'h1;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:22:21, :23:21]
      counter <= 9'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
      counter_1 <= 9'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27]
    end
    else begin	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7]
      if (head[0] & (counter == 9'h1 | beats1[2:0] == 3'h0) & _GEN | head[1] & (counter_1 == 9'h1 | beats1_1[2:0] == 3'h0) & _GEN_0)	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:221:14, :229:27, :232:{25,33,43}, generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:22:21, src/main/scala/chisel3/util/Decoupled.scala:51:35, src/main/scala/chisel3/util/Mux.scala:30:73, :32:36]
        head <= {head[0], head[1]};	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:22:21, :33:68, src/main/scala/chisel3/util/Mux.scala:32:36]
      if (_io_req_ready_WIRE & io_req_valid)	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35, src/main/scala/chisel3/util/Mux.scala:30:73]
        tail <= {tail[0], tail[1]};	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:23:21, :28:29, src/main/scala/chisel3/util/Mux.scala:32:36]
      if (_GEN) begin	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
        if (counter == 9'h0)	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, :231:25]
          counter <= beats1;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:221:14, :229:27]
        else	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:231:25]
          counter <= counter - 9'h1;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, :230:28]
      end
      if (_GEN_0) begin	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
        if (counter_1 == 9'h0)	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, :231:25]
          counter_1 <= beats1_1;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:221:14, :229:27]
        else	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:231:25]
          counter_1 <= counter_1 - 9'h1;	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, :230:28]
      end
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7]
      `FIRRTL_BEFORE_INITIAL	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:0];	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7]
    initial begin	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7]
        `INIT_RANDOM_PROLOG_	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7]
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7]
        head = _RANDOM[/*Zero width*/ 1'b0][1:0];	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7, :22:21]
        tail = _RANDOM[/*Zero width*/ 1'b0][3:2];	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7, :22:21, :23:21]
        counter = _RANDOM[/*Zero width*/ 1'b0][12:4];	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7, :22:21]
        counter_1 = _RANDOM[/*Zero width*/ 1'b0][21:13];	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:229:27, generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7, :22:21]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7]
      `FIRRTL_AFTER_INITIAL	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  WritebackUnit wbs_0 (	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
    .clock                   (clock),
    .reset                   (reset),
    .io_req_ready            (_wbs_0_io_req_ready),
    .io_req_valid            (io_req_valid & tail[0]),	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:23:21, :27:62, src/main/scala/chisel3/util/Mux.scala:32:36]
    .io_req_bits_tag         (io_req_bits_tag),
    .io_req_bits_idx         (io_req_bits_idx),
    .io_req_bits_source      (io_req_bits_source),
    .io_req_bits_param       (io_req_bits_param),
    .io_req_bits_way_en      (io_req_bits_way_en),
    .io_req_bits_voluntary   (io_req_bits_voluntary),
    .io_meta_read_bits_idx   (_wbs_0_io_meta_read_bits_idx),
    .io_meta_read_bits_tag   (_wbs_0_io_meta_read_bits_tag),
    .io_data_req_ready       (_wbs_0_io_data_req_ready_T_1),	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:32:62]
    .io_data_req_valid       (_wbs_0_io_data_req_valid),
    .io_data_req_bits_way_en (_wbs_0_io_data_req_bits_way_en),
    .io_data_req_bits_addr   (_wbs_0_io_data_req_bits_addr),
    .io_data_resp            (io_data_resp),
    .io_release_ready        (io_release_ready),
    .io_release_valid        (_wbs_0_io_release_valid),
    .io_release_bits_opcode  (_wbs_0_io_release_bits_opcode),
    .io_release_bits_param   (_wbs_0_io_release_bits_param),
    .io_release_bits_source  (_wbs_0_io_release_bits_source),
    .io_release_bits_address (_wbs_0_io_release_bits_address),
    .io_release_bits_data    (_wbs_0_io_release_bits_data)
  );
  WritebackUnit wbs_1 (	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:20:33]
    .clock                   (clock),
    .reset                   (reset),
    .io_req_ready            (_wbs_1_io_req_ready),
    .io_req_valid            (io_req_valid & tail[1]),	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:23:21, :27:62, src/main/scala/chisel3/util/Mux.scala:32:36]
    .io_req_bits_tag         (io_req_bits_tag),
    .io_req_bits_idx         (io_req_bits_idx),
    .io_req_bits_source      (io_req_bits_source),
    .io_req_bits_param       (io_req_bits_param),
    .io_req_bits_way_en      (io_req_bits_way_en),
    .io_req_bits_voluntary   (io_req_bits_voluntary),
    .io_meta_read_bits_idx   (_wbs_1_io_meta_read_bits_idx),
    .io_meta_read_bits_tag   (_wbs_1_io_meta_read_bits_tag),
    .io_data_req_ready       (_wbs_1_io_data_req_ready_T_1),	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:32:62]
    .io_data_req_valid       (_wbs_1_io_data_req_valid),
    .io_data_req_bits_way_en (_wbs_1_io_data_req_bits_way_en),
    .io_data_req_bits_addr   (_wbs_1_io_data_req_bits_addr),
    .io_data_resp            (io_data_resp),
    .io_release_ready        (io_release_ready),
    .io_release_valid        (_wbs_1_io_release_valid),
    .io_release_bits_opcode  (_wbs_1_io_release_bits_opcode),
    .io_release_bits_param   (_wbs_1_io_release_bits_param),
    .io_release_bits_source  (_wbs_1_io_release_bits_source),
    .io_release_bits_address (_wbs_1_io_release_bits_address),
    .io_release_bits_data    (_wbs_1_io_release_bits_data)
  );
  assign io_req_ready = _io_req_ready_WIRE;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_occupied_0 = ~_wbs_0_io_req_ready;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7, :20:33, :21:52]
  assign io_occupied_1 = ~_wbs_1_io_req_ready;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7, :20:33, :21:52]
  assign io_meta_read_bits_idx = (_wbs_0_io_data_req_ready_T_1 ? _wbs_0_io_meta_read_bits_idx : 6'h0) | (_wbs_1_io_data_req_ready_T_1 ? _wbs_1_io_meta_read_bits_idx : 6'h0);	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7, :20:33, :32:62, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_meta_read_bits_tag = (_wbs_0_io_data_req_ready_T_1 ? _wbs_0_io_meta_read_bits_tag : 20'h0) | (_wbs_1_io_data_req_ready_T_1 ? _wbs_1_io_meta_read_bits_tag : 20'h0);	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7, :20:33, :32:62, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_data_req_valid = head[0] & _wbs_0_io_data_req_valid | head[1] & _wbs_1_io_data_req_valid;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7, :20:33, :22:21, src/main/scala/chisel3/util/Mux.scala:30:73, :32:36]
  assign io_data_req_bits_way_en = (head[0] ? _wbs_0_io_data_req_bits_way_en : 4'h0) | (head[1] ? _wbs_1_io_data_req_bits_way_en : 4'h0);	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7, :20:33, :22:21, src/main/scala/chisel3/util/Mux.scala:30:73, :32:36]
  assign io_data_req_bits_addr = (head[0] ? _wbs_0_io_data_req_bits_addr : 12'h0) | (head[1] ? _wbs_1_io_data_req_bits_addr : 12'h0);	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7, :20:33, :22:21, src/main/scala/chisel3/util/Mux.scala:30:73, :32:36]
  assign io_release_valid = _wbs_0_io_release_valid | _wbs_1_io_release_valid;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7, :20:33, :39:59]
  assign io_release_bits_opcode = (_wbs_0_io_release_valid ? _wbs_0_io_release_bits_opcode : 3'h0) | (_wbs_1_io_release_valid ? _wbs_1_io_release_bits_opcode : 3'h0);	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7, :20:33, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_release_bits_param = (_wbs_0_io_release_valid ? _wbs_0_io_release_bits_param : 3'h0) | (_wbs_1_io_release_valid ? _wbs_1_io_release_bits_param : 3'h0);	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7, :20:33, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_release_bits_size = _wbs_0_io_release_valid | _wbs_1_io_release_valid ? 4'h6 : 4'h0;	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7, :20:33, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_release_bits_source = (_wbs_0_io_release_valid ? _wbs_0_io_release_bits_source : 3'h0) | (_wbs_1_io_release_valid ? _wbs_1_io_release_bits_source : 3'h0);	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7, :20:33, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_release_bits_address = (_wbs_0_io_release_valid ? _wbs_0_io_release_bits_address : 32'h0) | (_wbs_1_io_release_valid ? _wbs_1_io_release_bits_address : 32'h0);	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7, :20:33, src/main/scala/chisel3/util/Mux.scala:30:73]
  assign io_release_bits_data = (_wbs_0_io_release_valid ? _wbs_0_io_release_bits_data : 64'h0) | (_wbs_1_io_release_valid ? _wbs_1_io_release_bits_data : 64'h0);	// @[generators/shuttle/src/main/scala/dmem/MultiWritebackUnit.scala:11:7, :20:33, src/main/scala/chisel3/util/Mux.scala:30:73]
endmodule
