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

module ChipyardPRCICtrlClockSinkDomain(	// @[generators/rocket-chip/src/main/scala/prci/ClockDomain.scala:14:9]
  input         auto_reset_setter_clock_in_member_allClocks_uncore_clock,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_reset_setter_clock_in_member_allClocks_uncore_reset,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output        auto_resetSynchronizer_out_member_allClocks_uncore_clock,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output        auto_resetSynchronizer_out_member_allClocks_uncore_reset,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output        auto_xbar_anon_in_a_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_xbar_anon_in_a_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]  auto_xbar_anon_in_a_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]  auto_xbar_anon_in_a_bits_param,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]  auto_xbar_anon_in_a_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [7:0]  auto_xbar_anon_in_a_bits_source,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [20:0] auto_xbar_anon_in_a_bits_address,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [7:0]  auto_xbar_anon_in_a_bits_mask,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [63:0] auto_xbar_anon_in_a_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_xbar_anon_in_a_bits_corrupt,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_xbar_anon_in_d_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output        auto_xbar_anon_in_d_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [2:0]  auto_xbar_anon_in_d_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [2:0]  auto_xbar_anon_in_d_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [7:0]  auto_xbar_anon_in_d_bits_source,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [63:0] auto_xbar_anon_in_d_bits_data,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_clock_in_clock,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_clock_in_reset	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
);

  wire        _fragmenter_1_auto_anon_in_a_ready;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire        _fragmenter_1_auto_anon_in_d_valid;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [2:0]  _fragmenter_1_auto_anon_in_d_bits_opcode;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [2:0]  _fragmenter_1_auto_anon_in_d_bits_size;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [7:0]  _fragmenter_1_auto_anon_in_d_bits_source;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire        _fragmenter_1_auto_anon_out_a_valid;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [2:0]  _fragmenter_1_auto_anon_out_a_bits_opcode;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [2:0]  _fragmenter_1_auto_anon_out_a_bits_param;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [1:0]  _fragmenter_1_auto_anon_out_a_bits_size;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [11:0] _fragmenter_1_auto_anon_out_a_bits_source;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [20:0] _fragmenter_1_auto_anon_out_a_bits_address;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [7:0]  _fragmenter_1_auto_anon_out_a_bits_mask;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire        _fragmenter_1_auto_anon_out_a_bits_corrupt;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire        _fragmenter_1_auto_anon_out_d_ready;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire        _reset_setter_auto_clock_out_member_allClocks_uncore_clock;	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:78:34]
  wire        _reset_setter_auto_clock_out_member_allClocks_uncore_reset;	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:78:34]
  wire        _reset_setter_auto_tl_in_a_ready;	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:78:34]
  wire        _reset_setter_auto_tl_in_d_valid;	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:78:34]
  wire [2:0]  _reset_setter_auto_tl_in_d_bits_opcode;	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:78:34]
  wire [1:0]  _reset_setter_auto_tl_in_d_bits_size;	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:78:34]
  wire [11:0] _reset_setter_auto_tl_in_d_bits_source;	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:78:34]
  wire        _fragmenter_auto_anon_in_a_ready;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire        _fragmenter_auto_anon_in_d_valid;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [2:0]  _fragmenter_auto_anon_in_d_bits_opcode;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [2:0]  _fragmenter_auto_anon_in_d_bits_size;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [7:0]  _fragmenter_auto_anon_in_d_bits_source;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [63:0] _fragmenter_auto_anon_in_d_bits_data;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire        _fragmenter_auto_anon_out_a_valid;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [2:0]  _fragmenter_auto_anon_out_a_bits_opcode;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [2:0]  _fragmenter_auto_anon_out_a_bits_param;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [1:0]  _fragmenter_auto_anon_out_a_bits_size;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [11:0] _fragmenter_auto_anon_out_a_bits_source;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [20:0] _fragmenter_auto_anon_out_a_bits_address;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [7:0]  _fragmenter_auto_anon_out_a_bits_mask;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire [63:0] _fragmenter_auto_anon_out_a_bits_data;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire        _fragmenter_auto_anon_out_a_bits_corrupt;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire        _fragmenter_auto_anon_out_d_ready;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  wire        _clock_gater_auto_clock_gater_in_1_a_ready;	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:73:33]
  wire        _clock_gater_auto_clock_gater_in_1_d_valid;	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:73:33]
  wire [2:0]  _clock_gater_auto_clock_gater_in_1_d_bits_opcode;	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:73:33]
  wire [1:0]  _clock_gater_auto_clock_gater_in_1_d_bits_size;	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:73:33]
  wire [11:0] _clock_gater_auto_clock_gater_in_1_d_bits_source;	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:73:33]
  wire [63:0] _clock_gater_auto_clock_gater_in_1_d_bits_data;	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:73:33]
  wire        _clock_gater_auto_clock_gater_out_member_allClocks_uncore_clock;	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:73:33]
  wire        _clock_gater_auto_clock_gater_out_member_allClocks_uncore_reset;	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:73:33]
  wire        _xbar_auto_anon_out_1_a_valid;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
  wire [2:0]  _xbar_auto_anon_out_1_a_bits_opcode;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
  wire [2:0]  _xbar_auto_anon_out_1_a_bits_param;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
  wire [2:0]  _xbar_auto_anon_out_1_a_bits_size;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
  wire [7:0]  _xbar_auto_anon_out_1_a_bits_source;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
  wire [20:0] _xbar_auto_anon_out_1_a_bits_address;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
  wire [7:0]  _xbar_auto_anon_out_1_a_bits_mask;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
  wire        _xbar_auto_anon_out_1_a_bits_corrupt;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
  wire        _xbar_auto_anon_out_1_d_ready;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
  wire        _xbar_auto_anon_out_0_a_valid;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
  wire [2:0]  _xbar_auto_anon_out_0_a_bits_opcode;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
  wire [2:0]  _xbar_auto_anon_out_0_a_bits_param;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
  wire [2:0]  _xbar_auto_anon_out_0_a_bits_size;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
  wire [7:0]  _xbar_auto_anon_out_0_a_bits_source;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
  wire [20:0] _xbar_auto_anon_out_0_a_bits_address;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
  wire [7:0]  _xbar_auto_anon_out_0_a_bits_mask;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
  wire [63:0] _xbar_auto_anon_out_0_a_bits_data;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
  wire        _xbar_auto_anon_out_0_a_bits_corrupt;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
  wire        _xbar_auto_anon_out_0_d_ready;	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
  TLXbar_prcibus_i1_o2_a21d64s8k1z3u xbar (	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .clock                          (auto_clock_in_clock),
    .reset                          (auto_clock_in_reset),
    .auto_anon_in_a_ready           (auto_xbar_anon_in_a_ready),
    .auto_anon_in_a_valid           (auto_xbar_anon_in_a_valid),
    .auto_anon_in_a_bits_opcode     (auto_xbar_anon_in_a_bits_opcode),
    .auto_anon_in_a_bits_param      (auto_xbar_anon_in_a_bits_param),
    .auto_anon_in_a_bits_size       (auto_xbar_anon_in_a_bits_size),
    .auto_anon_in_a_bits_source     (auto_xbar_anon_in_a_bits_source),
    .auto_anon_in_a_bits_address    (auto_xbar_anon_in_a_bits_address),
    .auto_anon_in_a_bits_mask       (auto_xbar_anon_in_a_bits_mask),
    .auto_anon_in_a_bits_data       (auto_xbar_anon_in_a_bits_data),
    .auto_anon_in_a_bits_corrupt    (auto_xbar_anon_in_a_bits_corrupt),
    .auto_anon_in_d_ready           (auto_xbar_anon_in_d_ready),
    .auto_anon_in_d_valid           (auto_xbar_anon_in_d_valid),
    .auto_anon_in_d_bits_opcode     (auto_xbar_anon_in_d_bits_opcode),
    .auto_anon_in_d_bits_size       (auto_xbar_anon_in_d_bits_size),
    .auto_anon_in_d_bits_source     (auto_xbar_anon_in_d_bits_source),
    .auto_anon_in_d_bits_data       (auto_xbar_anon_in_d_bits_data),
    .auto_anon_out_1_a_ready        (_fragmenter_1_auto_anon_in_a_ready),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_anon_out_1_a_valid        (_xbar_auto_anon_out_1_a_valid),
    .auto_anon_out_1_a_bits_opcode  (_xbar_auto_anon_out_1_a_bits_opcode),
    .auto_anon_out_1_a_bits_param   (_xbar_auto_anon_out_1_a_bits_param),
    .auto_anon_out_1_a_bits_size    (_xbar_auto_anon_out_1_a_bits_size),
    .auto_anon_out_1_a_bits_source  (_xbar_auto_anon_out_1_a_bits_source),
    .auto_anon_out_1_a_bits_address (_xbar_auto_anon_out_1_a_bits_address),
    .auto_anon_out_1_a_bits_mask    (_xbar_auto_anon_out_1_a_bits_mask),
    .auto_anon_out_1_a_bits_corrupt (_xbar_auto_anon_out_1_a_bits_corrupt),
    .auto_anon_out_1_d_ready        (_xbar_auto_anon_out_1_d_ready),
    .auto_anon_out_1_d_valid        (_fragmenter_1_auto_anon_in_d_valid),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_anon_out_1_d_bits_opcode  (_fragmenter_1_auto_anon_in_d_bits_opcode),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_anon_out_1_d_bits_size    (_fragmenter_1_auto_anon_in_d_bits_size),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_anon_out_1_d_bits_source  (_fragmenter_1_auto_anon_in_d_bits_source),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_anon_out_0_a_ready        (_fragmenter_auto_anon_in_a_ready),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_anon_out_0_a_valid        (_xbar_auto_anon_out_0_a_valid),
    .auto_anon_out_0_a_bits_opcode  (_xbar_auto_anon_out_0_a_bits_opcode),
    .auto_anon_out_0_a_bits_param   (_xbar_auto_anon_out_0_a_bits_param),
    .auto_anon_out_0_a_bits_size    (_xbar_auto_anon_out_0_a_bits_size),
    .auto_anon_out_0_a_bits_source  (_xbar_auto_anon_out_0_a_bits_source),
    .auto_anon_out_0_a_bits_address (_xbar_auto_anon_out_0_a_bits_address),
    .auto_anon_out_0_a_bits_mask    (_xbar_auto_anon_out_0_a_bits_mask),
    .auto_anon_out_0_a_bits_data    (_xbar_auto_anon_out_0_a_bits_data),
    .auto_anon_out_0_a_bits_corrupt (_xbar_auto_anon_out_0_a_bits_corrupt),
    .auto_anon_out_0_d_ready        (_xbar_auto_anon_out_0_d_ready),
    .auto_anon_out_0_d_valid        (_fragmenter_auto_anon_in_d_valid),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_anon_out_0_d_bits_opcode  (_fragmenter_auto_anon_in_d_bits_opcode),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_anon_out_0_d_bits_size    (_fragmenter_auto_anon_in_d_bits_size),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_anon_out_0_d_bits_source  (_fragmenter_auto_anon_in_d_bits_source),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_anon_out_0_d_bits_data    (_fragmenter_auto_anon_in_d_bits_data)	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
  );
  ClockGroupResetSynchronizer resetSynchronizer (	// @[generators/rocket-chip/src/main/scala/prci/ResetSynchronizer.scala:46:69]
    .auto_in_member_allClocks_uncore_clock  (_clock_gater_auto_clock_gater_out_member_allClocks_uncore_clock),	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:73:33]
    .auto_in_member_allClocks_uncore_reset  (_clock_gater_auto_clock_gater_out_member_allClocks_uncore_reset),	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:73:33]
    .auto_out_member_allClocks_uncore_clock (auto_resetSynchronizer_out_member_allClocks_uncore_clock),
    .auto_out_member_allClocks_uncore_reset (auto_resetSynchronizer_out_member_allClocks_uncore_reset)
  );
  TileClockGater clock_gater (	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:73:33]
    .clock                                               (auto_clock_in_clock),
    .reset                                               (auto_clock_in_reset),
    .auto_clock_gater_in_1_a_ready                       (_clock_gater_auto_clock_gater_in_1_a_ready),
    .auto_clock_gater_in_1_a_valid                       (_fragmenter_auto_anon_out_a_valid),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_clock_gater_in_1_a_bits_opcode                 (_fragmenter_auto_anon_out_a_bits_opcode),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_clock_gater_in_1_a_bits_param                  (_fragmenter_auto_anon_out_a_bits_param),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_clock_gater_in_1_a_bits_size                   (_fragmenter_auto_anon_out_a_bits_size),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_clock_gater_in_1_a_bits_source                 (_fragmenter_auto_anon_out_a_bits_source),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_clock_gater_in_1_a_bits_address                (_fragmenter_auto_anon_out_a_bits_address),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_clock_gater_in_1_a_bits_mask                   (_fragmenter_auto_anon_out_a_bits_mask),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_clock_gater_in_1_a_bits_data                   (_fragmenter_auto_anon_out_a_bits_data),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_clock_gater_in_1_a_bits_corrupt                (_fragmenter_auto_anon_out_a_bits_corrupt),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_clock_gater_in_1_d_ready                       (_fragmenter_auto_anon_out_d_ready),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_clock_gater_in_1_d_valid                       (_clock_gater_auto_clock_gater_in_1_d_valid),
    .auto_clock_gater_in_1_d_bits_opcode                 (_clock_gater_auto_clock_gater_in_1_d_bits_opcode),
    .auto_clock_gater_in_1_d_bits_size                   (_clock_gater_auto_clock_gater_in_1_d_bits_size),
    .auto_clock_gater_in_1_d_bits_source                 (_clock_gater_auto_clock_gater_in_1_d_bits_source),
    .auto_clock_gater_in_1_d_bits_data                   (_clock_gater_auto_clock_gater_in_1_d_bits_data),
    .auto_clock_gater_in_0_member_allClocks_uncore_clock (_reset_setter_auto_clock_out_member_allClocks_uncore_clock),	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:78:34]
    .auto_clock_gater_in_0_member_allClocks_uncore_reset (_reset_setter_auto_clock_out_member_allClocks_uncore_reset),	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:78:34]
    .auto_clock_gater_out_member_allClocks_uncore_clock  (_clock_gater_auto_clock_gater_out_member_allClocks_uncore_clock),
    .auto_clock_gater_out_member_allClocks_uncore_reset  (_clock_gater_auto_clock_gater_out_member_allClocks_uncore_reset)
  );
  TLFragmenter_TileClockGater fragmenter (	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .clock                        (auto_clock_in_clock),
    .reset                        (auto_clock_in_reset),
    .auto_anon_in_a_ready         (_fragmenter_auto_anon_in_a_ready),
    .auto_anon_in_a_valid         (_xbar_auto_anon_out_0_a_valid),	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .auto_anon_in_a_bits_opcode   (_xbar_auto_anon_out_0_a_bits_opcode),	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .auto_anon_in_a_bits_param    (_xbar_auto_anon_out_0_a_bits_param),	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .auto_anon_in_a_bits_size     (_xbar_auto_anon_out_0_a_bits_size),	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .auto_anon_in_a_bits_source   (_xbar_auto_anon_out_0_a_bits_source),	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .auto_anon_in_a_bits_address  (_xbar_auto_anon_out_0_a_bits_address),	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .auto_anon_in_a_bits_mask     (_xbar_auto_anon_out_0_a_bits_mask),	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .auto_anon_in_a_bits_data     (_xbar_auto_anon_out_0_a_bits_data),	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .auto_anon_in_a_bits_corrupt  (_xbar_auto_anon_out_0_a_bits_corrupt),	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .auto_anon_in_d_ready         (_xbar_auto_anon_out_0_d_ready),	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .auto_anon_in_d_valid         (_fragmenter_auto_anon_in_d_valid),
    .auto_anon_in_d_bits_opcode   (_fragmenter_auto_anon_in_d_bits_opcode),
    .auto_anon_in_d_bits_size     (_fragmenter_auto_anon_in_d_bits_size),
    .auto_anon_in_d_bits_source   (_fragmenter_auto_anon_in_d_bits_source),
    .auto_anon_in_d_bits_data     (_fragmenter_auto_anon_in_d_bits_data),
    .auto_anon_out_a_ready        (_clock_gater_auto_clock_gater_in_1_a_ready),	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:73:33]
    .auto_anon_out_a_valid        (_fragmenter_auto_anon_out_a_valid),
    .auto_anon_out_a_bits_opcode  (_fragmenter_auto_anon_out_a_bits_opcode),
    .auto_anon_out_a_bits_param   (_fragmenter_auto_anon_out_a_bits_param),
    .auto_anon_out_a_bits_size    (_fragmenter_auto_anon_out_a_bits_size),
    .auto_anon_out_a_bits_source  (_fragmenter_auto_anon_out_a_bits_source),
    .auto_anon_out_a_bits_address (_fragmenter_auto_anon_out_a_bits_address),
    .auto_anon_out_a_bits_mask    (_fragmenter_auto_anon_out_a_bits_mask),
    .auto_anon_out_a_bits_data    (_fragmenter_auto_anon_out_a_bits_data),
    .auto_anon_out_a_bits_corrupt (_fragmenter_auto_anon_out_a_bits_corrupt),
    .auto_anon_out_d_ready        (_fragmenter_auto_anon_out_d_ready),
    .auto_anon_out_d_valid        (_clock_gater_auto_clock_gater_in_1_d_valid),	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:73:33]
    .auto_anon_out_d_bits_opcode  (_clock_gater_auto_clock_gater_in_1_d_bits_opcode),	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:73:33]
    .auto_anon_out_d_bits_size    (_clock_gater_auto_clock_gater_in_1_d_bits_size),	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:73:33]
    .auto_anon_out_d_bits_source  (_clock_gater_auto_clock_gater_in_1_d_bits_source),	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:73:33]
    .auto_anon_out_d_bits_data    (_clock_gater_auto_clock_gater_in_1_d_bits_data)	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:73:33]
  );
  TileResetSetter reset_setter (	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:78:34]
    .clock                                        (auto_clock_in_clock),
    .reset                                        (auto_clock_in_reset),
    .auto_clock_in_member_allClocks_uncore_clock  (auto_reset_setter_clock_in_member_allClocks_uncore_clock),
    .auto_clock_in_member_allClocks_uncore_reset  (auto_reset_setter_clock_in_member_allClocks_uncore_reset),
    .auto_clock_out_member_allClocks_uncore_clock (_reset_setter_auto_clock_out_member_allClocks_uncore_clock),
    .auto_clock_out_member_allClocks_uncore_reset (_reset_setter_auto_clock_out_member_allClocks_uncore_reset),
    .auto_tl_in_a_ready                           (_reset_setter_auto_tl_in_a_ready),
    .auto_tl_in_a_valid                           (_fragmenter_1_auto_anon_out_a_valid),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_tl_in_a_bits_opcode                     (_fragmenter_1_auto_anon_out_a_bits_opcode),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_tl_in_a_bits_param                      (_fragmenter_1_auto_anon_out_a_bits_param),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_tl_in_a_bits_size                       (_fragmenter_1_auto_anon_out_a_bits_size),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_tl_in_a_bits_source                     (_fragmenter_1_auto_anon_out_a_bits_source),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_tl_in_a_bits_address                    (_fragmenter_1_auto_anon_out_a_bits_address),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_tl_in_a_bits_mask                       (_fragmenter_1_auto_anon_out_a_bits_mask),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_tl_in_a_bits_corrupt                    (_fragmenter_1_auto_anon_out_a_bits_corrupt),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_tl_in_d_ready                           (_fragmenter_1_auto_anon_out_d_ready),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .auto_tl_in_d_valid                           (_reset_setter_auto_tl_in_d_valid),
    .auto_tl_in_d_bits_opcode                     (_reset_setter_auto_tl_in_d_bits_opcode),
    .auto_tl_in_d_bits_size                       (_reset_setter_auto_tl_in_d_bits_size),
    .auto_tl_in_d_bits_source                     (_reset_setter_auto_tl_in_d_bits_source)
  );
  TLFragmenter_TileResetSetter fragmenter_1 (	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:345:34]
    .clock                        (auto_clock_in_clock),
    .reset                        (auto_clock_in_reset),
    .auto_anon_in_a_ready         (_fragmenter_1_auto_anon_in_a_ready),
    .auto_anon_in_a_valid         (_xbar_auto_anon_out_1_a_valid),	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .auto_anon_in_a_bits_opcode   (_xbar_auto_anon_out_1_a_bits_opcode),	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .auto_anon_in_a_bits_param    (_xbar_auto_anon_out_1_a_bits_param),	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .auto_anon_in_a_bits_size     (_xbar_auto_anon_out_1_a_bits_size),	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .auto_anon_in_a_bits_source   (_xbar_auto_anon_out_1_a_bits_source),	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .auto_anon_in_a_bits_address  (_xbar_auto_anon_out_1_a_bits_address),	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .auto_anon_in_a_bits_mask     (_xbar_auto_anon_out_1_a_bits_mask),	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .auto_anon_in_a_bits_corrupt  (_xbar_auto_anon_out_1_a_bits_corrupt),	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .auto_anon_in_d_ready         (_xbar_auto_anon_out_1_d_ready),	// @[generators/rocket-chip/src/main/scala/tilelink/Xbar.scala:346:26]
    .auto_anon_in_d_valid         (_fragmenter_1_auto_anon_in_d_valid),
    .auto_anon_in_d_bits_opcode   (_fragmenter_1_auto_anon_in_d_bits_opcode),
    .auto_anon_in_d_bits_size     (_fragmenter_1_auto_anon_in_d_bits_size),
    .auto_anon_in_d_bits_source   (_fragmenter_1_auto_anon_in_d_bits_source),
    .auto_anon_out_a_ready        (_reset_setter_auto_tl_in_a_ready),	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:78:34]
    .auto_anon_out_a_valid        (_fragmenter_1_auto_anon_out_a_valid),
    .auto_anon_out_a_bits_opcode  (_fragmenter_1_auto_anon_out_a_bits_opcode),
    .auto_anon_out_a_bits_param   (_fragmenter_1_auto_anon_out_a_bits_param),
    .auto_anon_out_a_bits_size    (_fragmenter_1_auto_anon_out_a_bits_size),
    .auto_anon_out_a_bits_source  (_fragmenter_1_auto_anon_out_a_bits_source),
    .auto_anon_out_a_bits_address (_fragmenter_1_auto_anon_out_a_bits_address),
    .auto_anon_out_a_bits_mask    (_fragmenter_1_auto_anon_out_a_bits_mask),
    .auto_anon_out_a_bits_corrupt (_fragmenter_1_auto_anon_out_a_bits_corrupt),
    .auto_anon_out_d_ready        (_fragmenter_1_auto_anon_out_d_ready),
    .auto_anon_out_d_valid        (_reset_setter_auto_tl_in_d_valid),	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:78:34]
    .auto_anon_out_d_bits_opcode  (_reset_setter_auto_tl_in_d_bits_opcode),	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:78:34]
    .auto_anon_out_d_bits_size    (_reset_setter_auto_tl_in_d_bits_size),	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:78:34]
    .auto_anon_out_d_bits_source  (_reset_setter_auto_tl_in_d_bits_source)	// @[generators/chipyard/src/main/scala/clocking/HasChipyardPRCI.scala:78:34]
  );
endmodule
