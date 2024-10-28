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

module L1MetadataArrayBank(	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7]
  input         clock,	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7]
  input         reset,	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7]
  output        io_read_ready,	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:14:14]
  input         io_read_valid,	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:14:14]
  input  [5:0]  io_read_bits_idx,	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:14:14]
  output        io_write_ready,	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:14:14]
  input         io_write_valid,	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:14:14]
  input  [5:0]  io_write_bits_idx,	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:14:14]
  input  [3:0]  io_write_bits_way_en,	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:14:14]
  input  [1:0]  io_write_bits_data_coh_state,	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:14:14]
  input  [19:0] io_write_bits_data_tag,	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:14:14]
  output [1:0]  io_resp_0_coh_state,	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:14:14]
  output [19:0] io_resp_0_tag,	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:14:14]
  output [1:0]  io_resp_1_coh_state,	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:14:14]
  output [19:0] io_resp_1_tag,	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:14:14]
  output [1:0]  io_resp_2_coh_state,	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:14:14]
  output [19:0] io_resp_2_tag,	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:14:14]
  output [1:0]  io_resp_3_coh_state,	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:14:14]
  output [19:0] io_resp_3_tag	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:14:14]
);

  wire [3:0]  tag_array_MPORT_1_addr;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:87:28]
  wire        tag_array_MPORT_1_en;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:87:51]
  wire        wen;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:47:14, :48:9, :53:41]
  wire [87:0] _tag_array_RW0_rdata;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:28:30]
  reg  [4:0]  rst_cnt;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:19:24]
  wire [1:0]  _wdata_T_coh_state = rst_cnt[4] ? io_write_bits_data_coh_state : 2'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Metadata.scala:161:16, generators/shuttle/src/main/scala/dmem/TagArray.scala:19:24, :20:21, :22:18]
  wire [19:0] _wdata_T_tag = rst_cnt[4] ? io_write_bits_data_tag : 20'h0;	// @[generators/rocket-chip/src/main/scala/rocket/HellaCache.scala:306:14, generators/shuttle/src/main/scala/dmem/TagArray.scala:19:24, :20:21, :22:18]
  reg  [1:0]  stall_ctr;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:32:26]
  reg         rbuf_valid;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:36:27]
  reg  [3:0]  rbuf_idx;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:37:21]
  reg  [1:0]  rbuf_0_coh_state;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17]
  reg  [19:0] rbuf_0_tag;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17]
  reg  [1:0]  rbuf_1_coh_state;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17]
  reg  [19:0] rbuf_1_tag;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17]
  reg  [1:0]  rbuf_2_coh_state;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17]
  reg  [19:0] rbuf_2_tag;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17]
  reg  [1:0]  rbuf_3_coh_state;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17]
  reg  [19:0] rbuf_3_tag;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17]
  wire        _GEN = io_read_valid & stall_ctr != 2'h3;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:32:26, :33:30, :53:25]
  wire [5:0]  _GEN_0 = {2'h0, rbuf_idx};	// @[generators/rocket-chip/src/main/scala/tilelink/Metadata.scala:161:16, generators/shuttle/src/main/scala/dmem/TagArray.scala:37:21, :54:30]
  wire        _GEN_1 = io_read_bits_idx == _GEN_0 & rbuf_valid;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:36:27, :54:{30,43}]
  wire        _GEN_2 = ~_GEN | _GEN_1;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:53:{25,41}, :54:{43,58}, :69:11]
  assign wen = ~(rst_cnt[4]) | _GEN_2 & io_write_valid;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:19:24, :20:21, :47:14, :48:9, :53:41, :54:58, :69:11]
  wire        _io_read_ready_output = rst_cnt[4] & _GEN;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:19:24, :20:21, :47:14, :50:19, :53:{25,41}]
  reg  [5:0]  s1_read_idx;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:74:30]
  reg         REG;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:75:16]
  assign tag_array_MPORT_1_en = rst_cnt[4] & _GEN & ~_GEN_1 & ~wen;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :19:24, :20:21, :47:14, :48:9, :53:{25,41}, :54:{43,58}, :56:13, :61:13, :87:{51,54}]
  assign tag_array_MPORT_1_addr = io_read_bits_idx[3:0];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:87:28]
  reg         REG_1;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:88:16]
  reg  [1:0]  r_0_coh_state;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:89:25]
  reg  [19:0] r_0_tag;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:89:25]
  reg  [1:0]  r_1_coh_state;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:89:25]
  reg  [19:0] r_1_tag;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:89:25]
  reg  [1:0]  r_2_coh_state;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:89:25]
  reg  [19:0] r_2_tag;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:89:25]
  reg  [1:0]  r_3_coh_state;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:89:25]
  reg  [19:0] r_3_tag;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:89:25]
  wire [1:0]  _io_resp_0_coh_state_output = REG_1 ? r_0_coh_state : _tag_array_RW0_rdata[21:20];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:28:30, :87:{11,74}, :88:{16,37}, :89:{13,25}]
  wire [19:0] _io_resp_0_tag_output = REG_1 ? r_0_tag : _tag_array_RW0_rdata[19:0];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:28:30, :87:{11,74}, :88:{16,37}, :89:{13,25}]
  wire [1:0]  _io_resp_1_coh_state_output = REG_1 ? r_1_coh_state : _tag_array_RW0_rdata[43:42];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:28:30, :87:{11,74}, :88:{16,37}, :89:{13,25}]
  wire [19:0] _io_resp_1_tag_output = REG_1 ? r_1_tag : _tag_array_RW0_rdata[41:22];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:28:30, :87:{11,74}, :88:{16,37}, :89:{13,25}]
  wire [1:0]  _io_resp_2_coh_state_output = REG_1 ? r_2_coh_state : _tag_array_RW0_rdata[65:64];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:28:30, :87:{11,74}, :88:{16,37}, :89:{13,25}]
  wire [19:0] _io_resp_2_tag_output = REG_1 ? r_2_tag : _tag_array_RW0_rdata[63:44];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:28:30, :87:{11,74}, :88:{16,37}, :89:{13,25}]
  wire [1:0]  _io_resp_3_coh_state_output = REG_1 ? r_3_coh_state : _tag_array_RW0_rdata[87:86];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:28:30, :87:{11,74}, :88:{16,37}, :89:{13,25}]
  wire [19:0] _io_resp_3_tag_output = REG_1 ? r_3_tag : _tag_array_RW0_rdata[85:66];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:28:30, :87:{11,74}, :88:{16,37}, :89:{13,25}]
  wire        forward_from_rbuf = rst_cnt[4] & _GEN & _GEN_1;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:19:24, :20:21, :39:35, :47:14, :53:{25,41}, :54:43]
  wire        _GEN_3 = REG & ~(io_write_valid & io_write_bits_idx == s1_read_idx);	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:74:30, :75:{16,53,56,73,94}]
  always @(posedge clock) begin	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7]
    if (reset) begin	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7]
      rst_cnt <= 5'h0;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:19:24]
      stall_ctr <= 2'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Metadata.scala:161:16, generators/shuttle/src/main/scala/dmem/TagArray.scala:32:26]
      rbuf_valid <= 1'h0;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :36:27]
    end
    else begin	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7]
      if (rst_cnt[4]) begin	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:19:24, :20:21]
      end
      else	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:20:21]
        rst_cnt <= rst_cnt + 5'h1;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:19:24, :25:35]
      if (io_read_valid & rst_cnt[4] & _GEN & ~_GEN_1 & io_write_valid)	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:19:24, :20:21, :34:29, :41:23, :53:25, :54:{43,58}, :65:21]
        stall_ctr <= stall_ctr + 2'h1;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:32:26, :42:28]
      else	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:41:23]
        stall_ctr <= 2'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Metadata.scala:161:16, generators/shuttle/src/main/scala/dmem/TagArray.scala:32:26]
      rbuf_valid <= ~(io_write_valid & io_write_bits_idx == _GEN_0) & (_GEN_3 | rbuf_valid);	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:36:27, :54:30, :75:{53,112}, :76:16, :80:{24,45,59}, :81:16]
    end
    if (_GEN_3) begin	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:75:53]
      rbuf_idx <= s1_read_idx[3:0];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:37:21, :74:30, :77:14]
      rbuf_0_coh_state <= _io_resp_0_coh_state_output;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17, :87:11, :88:37, :89:13]
      rbuf_0_tag <= _io_resp_0_tag_output;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17, :87:11, :88:37, :89:13]
      rbuf_1_coh_state <= _io_resp_1_coh_state_output;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17, :87:11, :88:37, :89:13]
      rbuf_1_tag <= _io_resp_1_tag_output;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17, :87:11, :88:37, :89:13]
      rbuf_2_coh_state <= _io_resp_2_coh_state_output;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17, :87:11, :88:37, :89:13]
      rbuf_2_tag <= _io_resp_2_tag_output;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17, :87:11, :88:37, :89:13]
      rbuf_3_coh_state <= _io_resp_3_coh_state_output;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17, :87:11, :88:37, :89:13]
      rbuf_3_tag <= _io_resp_3_tag_output;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17, :87:11, :88:37, :89:13]
    end
    if (io_read_valid)	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:14:14]
      s1_read_idx <= io_read_bits_idx;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:74:30]
    REG <= _io_read_ready_output & io_read_valid & ~forward_from_rbuf;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:39:35, :47:14, :50:19, :53:41, :75:{16,30,33}]
    REG_1 <= forward_from_rbuf;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:39:35, :47:14, :53:41, :88:16]
    if (forward_from_rbuf) begin	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:39:35, :47:14, :53:41]
      r_0_coh_state <= rbuf_0_coh_state;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17, :89:25]
      r_0_tag <= rbuf_0_tag;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17, :89:25]
      r_1_coh_state <= rbuf_1_coh_state;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17, :89:25]
      r_1_tag <= rbuf_1_tag;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17, :89:25]
      r_2_coh_state <= rbuf_2_coh_state;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17, :89:25]
      r_2_tag <= rbuf_2_tag;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17, :89:25]
      r_3_coh_state <= rbuf_3_coh_state;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17, :89:25]
      r_3_tag <= rbuf_3_tag;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:38:17, :89:25]
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7]
      `FIRRTL_BEFORE_INITIAL	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:6];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7]
    initial begin	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7]
        `INIT_RANDOM_PROLOG_	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7]
        for (logic [2:0] i = 3'h0; i < 3'h7; i += 3'h1) begin
          _RANDOM[i] = `RANDOM;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7]
        end	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7]
        rst_cnt = _RANDOM[3'h0][4:0];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :19:24]
        stall_ctr = _RANDOM[3'h0][6:5];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :19:24, :32:26]
        rbuf_valid = _RANDOM[3'h0][7];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :19:24, :36:27]
        rbuf_idx = _RANDOM[3'h0][11:8];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :19:24, :37:21]
        rbuf_0_coh_state = _RANDOM[3'h0][13:12];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :19:24, :38:17]
        rbuf_0_tag = {_RANDOM[3'h0][31:14], _RANDOM[3'h1][1:0]};	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :19:24, :38:17]
        rbuf_1_coh_state = _RANDOM[3'h1][3:2];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :38:17]
        rbuf_1_tag = _RANDOM[3'h1][23:4];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :38:17]
        rbuf_2_coh_state = _RANDOM[3'h1][25:24];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :38:17]
        rbuf_2_tag = {_RANDOM[3'h1][31:26], _RANDOM[3'h2][13:0]};	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :38:17]
        rbuf_3_coh_state = _RANDOM[3'h2][15:14];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :38:17]
        rbuf_3_tag = {_RANDOM[3'h2][31:16], _RANDOM[3'h3][3:0]};	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :38:17]
        s1_read_idx = _RANDOM[3'h3][9:4];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :38:17, :74:30]
        REG = _RANDOM[3'h3][10];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :38:17, :75:16]
        REG_1 = _RANDOM[3'h3][11];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :38:17, :88:16]
        r_0_coh_state = _RANDOM[3'h3][13:12];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :38:17, :89:25]
        r_0_tag = {_RANDOM[3'h3][31:14], _RANDOM[3'h4][1:0]};	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :38:17, :89:25]
        r_1_coh_state = _RANDOM[3'h4][3:2];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :89:25]
        r_1_tag = _RANDOM[3'h4][23:4];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :89:25]
        r_2_coh_state = _RANDOM[3'h4][25:24];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :89:25]
        r_2_tag = {_RANDOM[3'h4][31:26], _RANDOM[3'h5][13:0]};	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :89:25]
        r_3_coh_state = _RANDOM[3'h5][15:14];	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :89:25]
        r_3_tag = {_RANDOM[3'h5][31:16], _RANDOM[3'h6][3:0]};	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :89:25]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7]
      `FIRRTL_AFTER_INITIAL	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  tag_array_0 tag_array (	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:28:30]
    .RW0_addr  (wen ? (rst_cnt[4] ? io_write_bits_idx[3:0] : rst_cnt[3:0]) : tag_array_MPORT_1_addr),	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:14:14, :19:24, :20:21, :21:18, :28:30, :47:14, :48:9, :53:41, :87:28]
    .RW0_en    (tag_array_MPORT_1_en | wen),	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:28:30, :47:14, :48:9, :53:41, :87:51]
    .RW0_clk   (clock),
    .RW0_wmode (wen),	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:47:14, :48:9, :53:41]
    .RW0_wdata ({_wdata_T_coh_state, _wdata_T_tag, _wdata_T_coh_state, _wdata_T_tag, _wdata_T_coh_state, _wdata_T_tag, _wdata_T_coh_state, _wdata_T_tag}),	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:22:18, :28:30]
    .RW0_rdata (_tag_array_RW0_rdata),
    .RW0_wmask (rst_cnt[4] ? io_write_bits_way_en : 4'hF)	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:19:24, :20:21, :23:{18,42}]
  );
  assign io_read_ready = _io_read_ready_output;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :47:14, :50:19, :53:41]
  assign io_write_ready = rst_cnt[4] & _GEN_2;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :19:24, :20:21, :47:14, :51:20, :53:41, :54:58, :69:11]
  assign io_resp_0_coh_state = _io_resp_0_coh_state_output;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :87:11, :88:37, :89:13]
  assign io_resp_0_tag = _io_resp_0_tag_output;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :87:11, :88:37, :89:13]
  assign io_resp_1_coh_state = _io_resp_1_coh_state_output;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :87:11, :88:37, :89:13]
  assign io_resp_1_tag = _io_resp_1_tag_output;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :87:11, :88:37, :89:13]
  assign io_resp_2_coh_state = _io_resp_2_coh_state_output;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :87:11, :88:37, :89:13]
  assign io_resp_2_tag = _io_resp_2_tag_output;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :87:11, :88:37, :89:13]
  assign io_resp_3_coh_state = _io_resp_3_coh_state_output;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :87:11, :88:37, :89:13]
  assign io_resp_3_tag = _io_resp_3_tag_output;	// @[generators/shuttle/src/main/scala/dmem/TagArray.scala:12:7, :87:11, :88:37, :89:13]
endmodule

