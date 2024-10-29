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

// VCS coverage exclude_file
module ram_2x177(	// @[src/main/scala/chisel3/util/Decoupled.scala:256:91]
  input          R0_addr,
  input          R0_en,
  input          R0_clk,
  output [176:0] R0_data,
  input          W0_addr,
  input          W0_en,
  input          W0_clk,
  input  [176:0] W0_data
);

  reg [176:0] Memory[0:1];	// @[src/main/scala/chisel3/util/Decoupled.scala:256:91]
  always @(posedge W0_clk) begin	// @[src/main/scala/chisel3/util/Decoupled.scala:256:91]
    if (W0_en)	// @[src/main/scala/chisel3/util/Decoupled.scala:256:91]
      Memory[W0_addr] <= W0_data;	// @[src/main/scala/chisel3/util/Decoupled.scala:256:91]
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_MEM_	// @[src/main/scala/chisel3/util/Decoupled.scala:256:91]
    reg [191:0] _RANDOM_MEM;	// @[src/main/scala/chisel3/util/Decoupled.scala:256:91]
    initial begin	// @[src/main/scala/chisel3/util/Decoupled.scala:256:91]
      `INIT_RANDOM_PROLOG_	// @[src/main/scala/chisel3/util/Decoupled.scala:256:91]
      `ifdef RANDOMIZE_MEM_INIT	// @[src/main/scala/chisel3/util/Decoupled.scala:256:91]
        for (logic [1:0] i = 2'h0; i < 2'h2; i += 2'h1) begin
          for (logic [7:0] j = 8'h0; j < 8'hC0; j += 8'h20) begin
            _RANDOM_MEM[j +: 32] = `RANDOM;	// @[src/main/scala/chisel3/util/Decoupled.scala:256:91]
          end	// @[src/main/scala/chisel3/util/Decoupled.scala:256:91]
          Memory[i[0]] = _RANDOM_MEM[176:0];	// @[src/main/scala/chisel3/util/Decoupled.scala:256:91]
        end	// @[src/main/scala/chisel3/util/Decoupled.scala:256:91]
      `endif // RANDOMIZE_MEM_INIT
    end // initial
  `endif // ENABLE_INITIAL_MEM_
  assign R0_data = R0_en ? Memory[R0_addr] : 177'bx;	// @[src/main/scala/chisel3/util/Decoupled.scala:256:91]
endmodule
