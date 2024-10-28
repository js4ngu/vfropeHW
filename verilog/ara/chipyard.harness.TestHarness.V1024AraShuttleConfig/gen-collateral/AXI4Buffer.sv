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

module AXI4Buffer(	// @[generators/rocket-chip/src/main/scala/amba/axi4/Buffer.scala:37:9]
  input          clock,	// @[generators/rocket-chip/src/main/scala/amba/axi4/Buffer.scala:37:9]
  input          reset,	// @[generators/rocket-chip/src/main/scala/amba/axi4/Buffer.scala:37:9]
  output         auto_in_aw_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_in_aw_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [3:0]   auto_in_aw_bits_id,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [31:0]  auto_in_aw_bits_addr,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [7:0]   auto_in_aw_bits_len,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]   auto_in_aw_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [1:0]   auto_in_aw_bits_burst,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_in_aw_bits_lock,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [3:0]   auto_in_aw_bits_cache,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]   auto_in_aw_bits_prot,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [3:0]   auto_in_aw_bits_qos,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_in_w_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_in_w_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [255:0] auto_in_w_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [31:0]  auto_in_w_bits_strb,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_in_w_bits_last,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_in_b_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_in_b_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [3:0]   auto_in_b_bits_id,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [1:0]   auto_in_b_bits_resp,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_in_ar_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_in_ar_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [3:0]   auto_in_ar_bits_id,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [31:0]  auto_in_ar_bits_addr,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [7:0]   auto_in_ar_bits_len,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]   auto_in_ar_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [1:0]   auto_in_ar_bits_burst,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_in_ar_bits_lock,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [3:0]   auto_in_ar_bits_cache,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]   auto_in_ar_bits_prot,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [3:0]   auto_in_ar_bits_qos,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_in_r_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_in_r_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [3:0]   auto_in_r_bits_id,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [255:0] auto_in_r_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [1:0]   auto_in_r_bits_resp,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_in_r_bits_last,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_out_aw_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_out_aw_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [3:0]   auto_out_aw_bits_id,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [31:0]  auto_out_aw_bits_addr,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [7:0]   auto_out_aw_bits_len,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [2:0]   auto_out_aw_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [1:0]   auto_out_aw_bits_burst,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_out_w_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_out_w_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [255:0] auto_out_w_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [31:0]  auto_out_w_bits_strb,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_out_w_bits_last,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_out_b_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_out_b_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [3:0]   auto_out_b_bits_id,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [1:0]   auto_out_b_bits_resp,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_out_ar_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_out_ar_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [3:0]   auto_out_ar_bits_id,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [31:0]  auto_out_ar_bits_addr,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [7:0]   auto_out_ar_bits_len,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [2:0]   auto_out_ar_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [1:0]   auto_out_ar_bits_burst,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output         auto_out_r_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_out_r_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [3:0]   auto_out_r_bits_id,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [255:0] auto_out_r_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [1:0]   auto_out_r_bits_resp,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input          auto_out_r_bits_last	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
);

  Queue2_AXI4BundleAW nodeOut_aw_deq_q (	// @[src/main/scala/chisel3/util/Decoupled.scala:362:21]
    .clock             (clock),
    .reset             (reset),
    .io_enq_ready      (auto_in_aw_ready),
    .io_enq_valid      (auto_in_aw_valid),
    .io_enq_bits_id    (auto_in_aw_bits_id),
    .io_enq_bits_addr  (auto_in_aw_bits_addr),
    .io_enq_bits_len   (auto_in_aw_bits_len),
    .io_enq_bits_size  (auto_in_aw_bits_size),
    .io_enq_bits_burst (auto_in_aw_bits_burst),
    .io_enq_bits_lock  (auto_in_aw_bits_lock),
    .io_enq_bits_cache (auto_in_aw_bits_cache),
    .io_enq_bits_prot  (auto_in_aw_bits_prot),
    .io_enq_bits_qos   (auto_in_aw_bits_qos),
    .io_deq_ready      (auto_out_aw_ready),
    .io_deq_valid      (auto_out_aw_valid),
    .io_deq_bits_id    (auto_out_aw_bits_id),
    .io_deq_bits_addr  (auto_out_aw_bits_addr),
    .io_deq_bits_len   (auto_out_aw_bits_len),
    .io_deq_bits_size  (auto_out_aw_bits_size),
    .io_deq_bits_burst (auto_out_aw_bits_burst)
  );
  Queue2_AXI4BundleW nodeOut_w_deq_q (	// @[src/main/scala/chisel3/util/Decoupled.scala:362:21]
    .clock            (clock),
    .reset            (reset),
    .io_enq_ready     (auto_in_w_ready),
    .io_enq_valid     (auto_in_w_valid),
    .io_enq_bits_data (auto_in_w_bits_data),
    .io_enq_bits_strb (auto_in_w_bits_strb),
    .io_enq_bits_last (auto_in_w_bits_last),
    .io_deq_ready     (auto_out_w_ready),
    .io_deq_valid     (auto_out_w_valid),
    .io_deq_bits_data (auto_out_w_bits_data),
    .io_deq_bits_strb (auto_out_w_bits_strb),
    .io_deq_bits_last (auto_out_w_bits_last)
  );
  Queue2_AXI4BundleB nodeIn_b_deq_q (	// @[src/main/scala/chisel3/util/Decoupled.scala:362:21]
    .clock            (clock),
    .reset            (reset),
    .io_enq_ready     (auto_out_b_ready),
    .io_enq_valid     (auto_out_b_valid),
    .io_enq_bits_id   (auto_out_b_bits_id),
    .io_enq_bits_resp (auto_out_b_bits_resp),
    .io_deq_ready     (auto_in_b_ready),
    .io_deq_valid     (auto_in_b_valid),
    .io_deq_bits_id   (auto_in_b_bits_id),
    .io_deq_bits_resp (auto_in_b_bits_resp)
  );
  Queue2_AXI4BundleAR nodeOut_ar_deq_q (	// @[src/main/scala/chisel3/util/Decoupled.scala:362:21]
    .clock             (clock),
    .reset             (reset),
    .io_enq_ready      (auto_in_ar_ready),
    .io_enq_valid      (auto_in_ar_valid),
    .io_enq_bits_id    (auto_in_ar_bits_id),
    .io_enq_bits_addr  (auto_in_ar_bits_addr),
    .io_enq_bits_len   (auto_in_ar_bits_len),
    .io_enq_bits_size  (auto_in_ar_bits_size),
    .io_enq_bits_burst (auto_in_ar_bits_burst),
    .io_enq_bits_lock  (auto_in_ar_bits_lock),
    .io_enq_bits_cache (auto_in_ar_bits_cache),
    .io_enq_bits_prot  (auto_in_ar_bits_prot),
    .io_enq_bits_qos   (auto_in_ar_bits_qos),
    .io_deq_ready      (auto_out_ar_ready),
    .io_deq_valid      (auto_out_ar_valid),
    .io_deq_bits_id    (auto_out_ar_bits_id),
    .io_deq_bits_addr  (auto_out_ar_bits_addr),
    .io_deq_bits_len   (auto_out_ar_bits_len),
    .io_deq_bits_size  (auto_out_ar_bits_size),
    .io_deq_bits_burst (auto_out_ar_bits_burst)
  );
  Queue2_AXI4BundleR nodeIn_r_deq_q (	// @[src/main/scala/chisel3/util/Decoupled.scala:362:21]
    .clock            (clock),
    .reset            (reset),
    .io_enq_ready     (auto_out_r_ready),
    .io_enq_valid     (auto_out_r_valid),
    .io_enq_bits_id   (auto_out_r_bits_id),
    .io_enq_bits_data (auto_out_r_bits_data),
    .io_enq_bits_resp (auto_out_r_bits_resp),
    .io_enq_bits_last (auto_out_r_bits_last),
    .io_deq_ready     (auto_in_r_ready),
    .io_deq_valid     (auto_in_r_valid),
    .io_deq_bits_id   (auto_in_r_bits_id),
    .io_deq_bits_data (auto_in_r_bits_data),
    .io_deq_bits_resp (auto_in_r_bits_resp),
    .io_deq_bits_last (auto_in_r_bits_last)
  );
endmodule

