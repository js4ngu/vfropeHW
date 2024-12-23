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

module ShuttleDCacheArbiter(	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
  input         clock,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
  output        io_requestor_0_req_ready,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input         io_requestor_0_req_valid,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input  [39:0] io_requestor_0_req_bits_addr,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input  [31:0] io_requestor_0_s1_paddr,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input         io_requestor_0_s1_kill,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output        io_requestor_0_s2_nack,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output        io_requestor_0_resp_valid,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output [63:0] io_requestor_0_resp_bits_data,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output        io_requestor_1_req_ready,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input         io_requestor_1_req_valid,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input  [39:0] io_requestor_1_req_bits_addr,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input  [6:0]  io_requestor_1_req_bits_tag,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input  [4:0]  io_requestor_1_req_bits_cmd,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input  [1:0]  io_requestor_1_req_bits_size,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input         io_requestor_1_req_bits_signed,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input  [31:0] io_requestor_1_s1_paddr,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input         io_requestor_1_s1_kill,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input  [63:0] io_requestor_1_s1_data_data,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output        io_requestor_1_s2_nack,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input         io_requestor_1_s2_kill,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output        io_requestor_1_resp_valid,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output        io_requestor_1_resp_bits_has_data,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output [6:0]  io_requestor_1_resp_bits_tag,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output [63:0] io_requestor_1_resp_bits_data,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output [1:0]  io_requestor_1_resp_bits_size,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output        io_requestor_1_ordered,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output        io_requestor_1_store_pending,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input         io_mem_req_ready,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output        io_mem_req_valid,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output [39:0] io_mem_req_bits_addr,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output [6:0]  io_mem_req_bits_tag,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output [4:0]  io_mem_req_bits_cmd,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output [1:0]  io_mem_req_bits_size,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output        io_mem_req_bits_signed,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output [31:0] io_mem_s1_paddr,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output        io_mem_s1_kill,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output [63:0] io_mem_s1_data_data,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input         io_mem_s2_nack,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  output        io_mem_s2_kill,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input         io_mem_resp_valid,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input         io_mem_resp_bits_has_data,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input  [6:0]  io_mem_resp_bits_tag,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input  [63:0] io_mem_resp_bits_data,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input  [1:0]  io_mem_resp_bits_size,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input         io_mem_ordered,	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
  input         io_mem_store_pending	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:9:14]
);

  reg s1_id;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:17:20]
  reg s2_id;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:18:24]
  always @(posedge clock) begin	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
    s1_id <= ~io_requestor_0_req_valid;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:17:20, :25:67, :31:35, :32:15, :48:26]
    s2_id <= s1_id;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:17:20, :18:24]
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
      `FIRRTL_BEFORE_INITIAL	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:0];	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
    initial begin	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
        `INIT_RANDOM_PROLOG_	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
        s1_id = _RANDOM[/*Zero width*/ 1'b0][0];	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7, :17:20]
        s2_id = _RANDOM[/*Zero width*/ 1'b0][1];	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7, :17:20, :18:24]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
      `FIRRTL_AFTER_INITIAL	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_requestor_0_req_ready = io_mem_req_ready;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
  assign io_requestor_0_s2_nack = io_mem_s2_nack & ~s2_id;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7, :18:24, :50:21, :62:49]
  assign io_requestor_0_resp_valid = io_mem_resp_valid & ~(io_mem_resp_bits_tag[0]);	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7, :57:{41,57}, :58:39]
  assign io_requestor_0_resp_bits_data = io_mem_resp_bits_data;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
  assign io_requestor_1_req_ready = io_mem_req_ready & ~io_requestor_0_req_valid;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7, :25:{64,67}]
  assign io_requestor_1_s2_nack = io_mem_s2_nack & s2_id;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7, :18:24, :62:49]
  assign io_requestor_1_resp_valid = io_mem_resp_valid & io_mem_resp_bits_tag[0];	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7, :57:41, :58:39]
  assign io_requestor_1_resp_bits_has_data = io_mem_resp_bits_has_data;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
  assign io_requestor_1_resp_bits_tag = {1'h0, io_mem_resp_bits_tag[6:1]};	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7, :65:{21,45}]
  assign io_requestor_1_resp_bits_data = io_mem_resp_bits_data;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
  assign io_requestor_1_resp_bits_size = io_mem_resp_bits_size;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
  assign io_requestor_1_ordered = io_mem_ordered;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
  assign io_requestor_1_store_pending = io_mem_store_pending;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7]
  assign io_mem_req_valid = io_requestor_0_req_valid | io_requestor_1_req_valid;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7, :22:63]
  assign io_mem_req_bits_addr = io_requestor_0_req_valid ? io_requestor_0_req_bits_addr : io_requestor_1_req_bits_addr;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7, :30:25, :48:26]
  assign io_mem_req_bits_tag = io_requestor_0_req_valid ? 7'h0 : {io_requestor_1_req_bits_tag[5:0], 1'h1};	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7, :9:14, :31:29, :48:26]
  assign io_mem_req_bits_cmd = io_requestor_0_req_valid ? 5'h0 : io_requestor_1_req_bits_cmd;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7, :9:14, :30:25, :48:26]
  assign io_mem_req_bits_size = io_requestor_0_req_valid ? 2'h3 : io_requestor_1_req_bits_size;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7, :9:14, :30:25, :48:26]
  assign io_mem_req_bits_signed = ~io_requestor_0_req_valid & io_requestor_1_req_bits_signed;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7, :30:25, :48:26]
  assign io_mem_s1_paddr = s1_id ? io_requestor_1_s1_paddr : io_requestor_0_s1_paddr;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7, :17:20, :35:25, :49:30]
  assign io_mem_s1_kill = s1_id ? io_requestor_1_s1_kill : io_requestor_0_s1_kill;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7, :17:20, :36:24, :49:30]
  assign io_mem_s1_data_data = s1_id ? io_requestor_1_s1_data_data : 64'h0;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7, :9:14, :17:20, :30:25, :37:24, :48:26, :49:30]
  assign io_mem_s2_kill = s2_id & io_requestor_1_s2_kill;	// @[generators/shuttle/src/main/scala/dmem/Arbiter.scala:7:7, :18:24, :40:24, :50:30]
endmodule

