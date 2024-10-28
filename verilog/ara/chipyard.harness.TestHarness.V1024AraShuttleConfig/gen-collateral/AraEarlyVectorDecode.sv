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

module AraEarlyVectorDecode(	// @[generators/ara/src/main/scala/EarlyDecode.scala:8:7]
  input  [31:0] io_inst,	// @[generators/rocket-chip/src/main/scala/rocket/VectorUnit.scala:91:14]
  output        io_legal,	// @[generators/rocket-chip/src/main/scala/rocket/VectorUnit.scala:91:14]
  output        io_fp,	// @[generators/rocket-chip/src/main/scala/rocket/VectorUnit.scala:91:14]
  output        io_read_rs1,	// @[generators/rocket-chip/src/main/scala/rocket/VectorUnit.scala:91:14]
  output        io_read_rs2,	// @[generators/rocket-chip/src/main/scala/rocket/VectorUnit.scala:91:14]
  output        io_read_frs1,	// @[generators/rocket-chip/src/main/scala/rocket/VectorUnit.scala:91:14]
  output        io_write_rd,	// @[generators/rocket-chip/src/main/scala/rocket/VectorUnit.scala:91:14]
  output        io_write_frd	// @[generators/rocket-chip/src/main/scala/rocket/VectorUnit.scala:91:14]
);

  wire v_load = io_inst[6:0] == 7'h7;	// @[generators/ara/src/main/scala/EarlyDecode.scala:45:23, :57:23]
  wire v_store = io_inst[6:0] == 7'h27;	// @[generators/ara/src/main/scala/EarlyDecode.scala:45:23, :58:24]
  wire v_arith = io_inst[6:0] == 7'h57 & io_inst[14:12] != 3'h7;	// @[generators/ara/src/main/scala/EarlyDecode.scala:45:23, :47:22, :57:23, :59:{24,38,48}]
  wire _GEN = v_load | v_store;	// @[generators/ara/src/main/scala/EarlyDecode.scala:57:23, :58:24, :61:16]
  wire _GEN_0 = io_inst[24:20] == 5'h0 | io_inst[24:20] == 5'h8 | io_inst[24:20] == 5'hB;	// @[generators/ara/src/main/scala/EarlyDecode.scala:48:22, generators/rocket-chip/src/main/scala/util/package.scala:16:47, :81:59]
  wire _GEN_1 = ~_GEN & v_arith & io_inst[14:12] == 3'h5;	// @[generators/ara/src/main/scala/EarlyDecode.scala:41:16, :47:22, :59:38, :61:{16,28}, :71:25, :74:28, generators/rocket-chip/src/main/scala/util/package.scala:16:47]
  wire _io_write_frd_T_1 = io_inst[31:26] == 6'h10;	// @[generators/ara/src/main/scala/EarlyDecode.scala:55:23, :75:47]
  assign io_legal = _GEN ? ~(io_inst[28] | io_inst[27:26] == 2'h0 & (v_store & ~_GEN_0 | v_load & ~(_GEN_0 | io_inst[24:20] == 5'h10))) & ~(io_inst[28]) & (io_inst[14:12] == 3'h0 | io_inst[14:12] == 3'h5 | io_inst[14:12] == 3'h6 | (&(io_inst[14:12]))) : v_arith;	// @[generators/ara/src/main/scala/EarlyDecode.scala:8:7, :47:22, :48:22, :51:20, :52:20, :57:23, :58:24, :59:38, :61:{16,28}, :62:{14,21}, :63:20, :64:17, :65:{20,23,82,93}, :66:{21,24,74,85}, :68:{24,35}, :71:25, generators/rocket-chip/src/main/scala/util/package.scala:16:47, :81:59]
  assign io_fp = _GEN_1;	// @[generators/ara/src/main/scala/EarlyDecode.scala:8:7, :41:16, :61:28, :71:25]
  assign io_read_rs1 = _GEN | v_arith & (io_inst[14:12] == 3'h4 | io_inst[14:12] == 3'h6);	// @[generators/ara/src/main/scala/EarlyDecode.scala:8:7, :39:15, :47:22, :59:38, :61:{16,28}, :69:17, :71:25, :73:17, generators/rocket-chip/src/main/scala/util/package.scala:16:47, :81:59]
  assign io_read_rs2 = _GEN & io_inst[27:26] == 2'h2;	// @[generators/ara/src/main/scala/EarlyDecode.scala:8:7, :40:15, :51:20, :61:{16,28}, :70:{17,24}]
  assign io_read_frs1 = _GEN_1;	// @[generators/ara/src/main/scala/EarlyDecode.scala:8:7, :41:16, :61:28, :71:25]
  assign io_write_rd = ~_GEN & v_arith & io_inst[14:12] == 3'h2 & _io_write_frd_T_1;	// @[generators/ara/src/main/scala/EarlyDecode.scala:8:7, :41:16, :42:15, :47:22, :59:38, :61:{16,28}, :71:25, :75:{27,47}]
  assign io_write_frd = ~_GEN & v_arith & io_inst[14:12] == 3'h1 & _io_write_frd_T_1;	// @[generators/ara/src/main/scala/EarlyDecode.scala:8:7, :41:16, :43:16, :47:22, :59:38, :61:{16,28}, :71:25, :75:47, :76:28]
endmodule
