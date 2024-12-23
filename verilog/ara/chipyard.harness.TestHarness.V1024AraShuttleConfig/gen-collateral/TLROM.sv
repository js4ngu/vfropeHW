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

module TLROM(	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:41:9]
  input         clock,	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:41:9]
  input         reset,	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:41:9]
  output        auto_in_a_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_in_a_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]  auto_in_a_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]  auto_in_a_bits_param,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [1:0]  auto_in_a_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [12:0] auto_in_a_bits_source,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [16:0] auto_in_a_bits_address,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [7:0]  auto_in_a_bits_mask,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_in_a_bits_corrupt,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_in_d_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output        auto_in_d_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [1:0]  auto_in_d_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [12:0] auto_in_d_bits_source,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [63:0] auto_in_d_bits_data	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
);

  wire [511:0][63:0] _GEN =
    {64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h0,
     64'h7374707572,
     64'h7265746E6900746E,
     64'h657261702D747075,
     64'h727265746E690073,
     64'h6B636F6C63007665,
     64'h646E2C7663736972,
     64'h797469726F6972,
     64'h702D78616D2C7663,
     64'h7369720068636174,
     64'h74612D6775626564,
     64'h6465646E657478,
     64'h652D737470757272,
     64'h65746E690073656D,
     64'h616E2D7475707475,
     64'h6F2D6B636F6C6300,
     64'h736C6C65632D6B63,
     64'h6F6C632300746E75,
     64'h6F632D7268736D2C,
     64'h6576696669730064,
     64'h656966696E752D65,
     64'h68636163006C6576,
     64'h656C2D6568636163,
     64'h73656D616E2D67,
     64'h6572007365676E61,
     64'h7200656C646E6168,
     64'h700072656C6C6F72,
     64'h746E6F632D747075,
     64'h727265746E690073,
     64'h6C6C65632D747075,
     64'h727265746E692300,
     64'h74696C70732D626C,
     64'h7400737574617473,
     64'h6173692C766373,
     64'h6972006765720065,
     64'h686361632D6C6576,
     64'h656C2D7478656E00,
     64'h657079742D756D6D,
     64'h657A69732D626C,
     64'h742D690073746573,
     64'h2D626C742D690065,
     64'h7A69732D65686361,
     64'h632D690073746573,
     64'h2D65686361632D69,
     64'h657A69732D6B63,
     64'h6F6C622D65686361,
     64'h632D6900746E756F,
     64'h632D746E696F706B,
     64'h616572622D636578,
     64'h652D657261776472,
     64'h616800657079745F,
     64'h6563697665640065,
     64'h7A69732D626C742D,
     64'h6400737465732D62,
     64'h6C742D6400657A69,
     64'h732D65686361632D,
     64'h6400737465732D65,
     64'h686361632D640065,
     64'h7A69732D6B636F6C,
     64'h622D65686361632D,
     64'h640079636E657571,
     64'h6572662D6B636F6C,
     64'h630079636E657571,
     64'h6572662D65736162,
     64'h656D697400687461,
     64'h702D74756F647473,
     64'h306C6169726573,
     64'h6C65646F6D0065,
     64'h6C62697461706D6F,
     64'h6300736C6C65632D,
     64'h657A69732300736C,
     64'h6C65632D73736572,
     64'h6464612309000000,
     64'h200000002000000,
     64'h2000000006C6F72,
     64'h746E6F6382010000,
     64'h800000003000000,
     64'h10000000001100,
     64'h2E01000008000000,
     64'h300000000000000,
     64'h3030303031314072,
     64'h65747465732D7465,
     64'h7365722D656C6974,
     64'h100000002000000,
     64'h6C6F72746E6F63,
     64'h8201000008000000,
     64'h300000000100000,
     64'h2102E010000,
     64'h800000003000000,
     64'h10000002F020000,
     64'h400000003000000,
     64'h60000001E020000,
     64'h400000003000000,
     64'h30747261,
     64'h752C657669666973,
     64'h1B0000000D000000,
     64'h300000005000000,
     64'h1702000004000000,
     64'h300000000303030,
     64'h3032303031406C61,
     64'h6972657301000000,
     64'h2000000006B636F,
     64'h6C632D6465786966,
     64'h1B0000000C000000,
     64'h300000000006B63,
     64'h6F6C635F73756273,
     64'hC50100000B000000,
     64'h30000000065CD1D,
     64'h5300000004000000,
     64'h300000000000000,
     64'hB801000004000000,
     64'h300000000006B63,
     64'h6F6C635F73756273,
     64'h100000002000000,
     64'h6D656D82010000,
     64'h400000003000000,
     64'h10000000100,
     64'h2E01000008000000,
     64'h300000000306D6F,
     64'h722C657669666973,
     64'h1B0000000C000000,
     64'h300000000000030,
     64'h30303031406D6F72,
     64'h100000002000000,
     64'h500000073010000,
     64'h400000003000000,
     64'h6B636F6C632D64,
     64'h657869661B000000,
     64'hC00000003000000,
     64'h6B636F6C635F,
     64'h73756270C5010000,
     64'hB00000003000000,
     64'h65CD1D53000000,
     64'h400000003000000,
     64'hB8010000,
     64'h400000003000000,
     64'h6B636F6C635F,
     64'h7375627001000000,
     64'h2000000006B636F,
     64'h6C632D6465786966,
     64'h1B0000000C000000,
     64'h300000000006B63,
     64'h6F6C635F7375626D,
     64'hC50100000B000000,
     64'h30000000065CD1D,
     64'h5300000004000000,
     64'h300000000000000,
     64'hB801000004000000,
     64'h300000000006B63,
     64'h6F6C635F7375626D,
     64'h100000002000000,
     64'h600000073010000,
     64'h400000003000000,
     64'h10000000C020000,
     64'h400000003000000,
     64'h1000000F9010000,
     64'h400000003000000,
     64'h6C6F72746E6F63,
     64'h8201000008000000,
     64'h300000000000004,
     64'hC2E010000,
     64'h800000003000000,
     64'h900000004000000,
     64'hB00000004000000,
     64'hD801000010000000,
     64'h30000005E010000,
     64'h3000000,
     64'h3063696C702C76,
     64'h637369721B000000,
     64'hC00000003000000,
     64'h10000004D010000,
     64'h400000003000000,
     64'h30303030,
     64'h3030634072656C6C,
     64'h6F72746E6F632D74,
     64'h7075727265746E69,
     64'h100000002000000,
     64'h6B636F6C632D64,
     64'h657869661B000000,
     64'hC00000003000000,
     64'h6B636F6C635F,
     64'h73756266C5010000,
     64'hB00000003000000,
     64'h65CD1D53000000,
     64'h400000003000000,
     64'hB8010000,
     64'h400000003000000,
     64'h6B636F6C635F,
     64'h7375626601000000,
     64'h200000000100000,
     64'h3000002E010000,
     64'h800000003000000,
     64'h30726F7272,
     64'h652C657669666973,
     64'h1B0000000E000000,
     64'h300000000000030,
     64'h3030334065636976,
     64'h65642D726F727265,
     64'h100000002000000,
     64'h6C6F72746E6F63,
     64'h8201000008000000,
     64'h300000000100000,
     64'h2E010000,
     64'h800000003000000,
     64'hFFFF000004000000,
     64'hD801000008000000,
     64'h300000000000000,
     64'h6761746AEC010000,
     64'h500000003000000,
     64'h3331302D,
     64'h67756265642C7663,
     64'h736972003331302D,
     64'h67756265642C6576,
     64'h696669731B000000,
     64'h2100000003000000,
     64'h304072656C6C,
     64'h6F72746E6F632D67,
     64'h7562656401000000,
     64'h2000000006C6F72,
     64'h746E6F6382010000,
     64'h800000003000000,
     64'h10000000001000,
     64'h2E01000008000000,
     64'h300000000003030,
     64'h3030303140726574,
     64'h61672D6B636F6C63,
     64'h100000002000000,
     64'h6C6F72746E6F63,
     64'h8201000008000000,
     64'h300000000000100,
     64'h22E010000,
     64'h800000003000000,
     64'h700000004000000,
     64'h300000004000000,
     64'hD801000010000000,
     64'h300000000000000,
     64'h30746E696C632C76,
     64'h637369721B000000,
     64'hD00000003000000,
     64'h3030303030,
     64'h303240746E696C63,
     64'h100000002000000,
     64'h6B636F6C632D64,
     64'h657869661B000000,
     64'hC00000003000000,
     64'h6B636F6C635F,
     64'h73756263C5010000,
     64'hB00000003000000,
     64'h65CD1D53000000,
     64'h400000003000000,
     64'hB8010000,
     64'h400000003000000,
     64'h6B636F6C635F,
     64'h7375626301000000,
     64'h200000001000000,
     64'h7301000004000000,
     64'h30000000C000000,
     64'hA601000004000000,
     64'h3000000006C6F72,
     64'h746E6F6382010000,
     64'h800000003000000,
     64'h10000000000102,
     64'h2E01000008000000,
     64'h300000003000000,
     64'h20000001D010000,
     64'h800000003000000,
     64'h65686361,
     64'h6300306568636163,
     64'h65766973756C636E,
     64'h692C657669666973,
     64'h1B0000001D000000,
     64'h300000098010000,
     64'h3000000,
     64'h80085000000,
     64'h400000003000000,
     64'h4000078000000,
     64'h400000003000000,
     64'h20000008C010000,
     64'h400000003000000,
     64'h4000000065000000,
     64'h400000003000000,
     64'h30303030,
     64'h3130324072656C6C,
     64'h6F72746E6F632D65,
     64'h6863616301000000,
     64'h2000000006C6F72,
     64'h746E6F6382010000,
     64'h800000003000000,
     64'h10000000100000,
     64'h2E01000008000000,
     64'h300000000000030,
     64'h303031406765722D,
     64'h737365726464612D,
     64'h746F6F6201000000,
     64'h7B01000000000000,
     64'h300000000737562,
     64'h2D656C706D697300,
     64'h636F732D64726179,
     64'h706968632C726162,
     64'h2D6263751B000000,
     64'h2000000003000000,
     64'h10000000F000000,
     64'h400000003000000,
     64'h100000000000000,
     64'h400000003000000,
     64'h636F7301000000,
     64'h200000002000000,
     64'h7301000004000000,
     64'h300000000000010,
     64'h802E010000,
     64'h800000003000000,
     64'h79726F6D656D,
     64'hA600000007000000,
     64'h300000000303030,
     64'h3030303038407972,
     64'h6F6D656D01000000,
     64'h200000003000000,
     64'h7301000004000000,
     64'h300000000000000,
     64'h64656C6261736964,
     64'h3C01000009000000,
     64'h300000000000100,
     64'h82E010000,
     64'h800000003000000,
     64'h79726F6D656D,
     64'hA600000007000000,
     64'h300000000003030,
     64'h3030303038407972,
     64'h6F6D656D01000000,
     64'h200000000000030,
     64'h666974682C626375,
     64'h1B0000000A000000,
     64'h300000000000000,
     64'h6669746801000000,
     64'h200000002000000,
     64'h200000004000000,
     64'h7301000004000000,
     64'h30000005E010000,
     64'h3000000,
     64'h63746E692D75,
     64'h70632C7663736972,
     64'h1B0000000F000000,
     64'h300000001000000,
     64'h4D01000004000000,
     64'h300000000000000,
     64'h72656C6C6F72746E,
     64'h6F632D7470757272,
     64'h65746E6901000000,
     64'h4301000000000000,
     64'h300000020A10700,
     64'h4000000004000000,
     64'h300000000000000,
     64'h79616B6F3C010000,
     64'h500000003000000,
     64'h73627A5F,
     64'h62627A5F61627A5F,
     64'h68667A5F64343665,
     64'h767A5F6234323031,
     64'h6C767A5F6D706869,
     64'h7A5F6965636E6566,
     64'h697A5F727363697A,
     64'h7662636466616D69,
     64'h3436767232010000,
     64'h4100000003000000,
     64'h2E010000,
     64'h400000003000000,
     64'h10000001D010000,
     64'h400000003000000,
     64'h393376732C76,
     64'h6373697214010000,
     64'hB00000003000000,
     64'h2000000009010000,
     64'h400000003000000,
     64'h1000000FE000000,
     64'h400000003000000,
     64'h800000F1000000,
     64'h400000003000000,
     64'h40000000E4000000,
     64'h400000003000000,
     64'h40000000D1000000,
     64'h400000003000000,
     64'hB2000000,
     64'h400000003000000,
     64'h757063A6000000,
     64'h400000003000000,
     64'h200000009B000000,
     64'h400000003000000,
     64'h100000090000000,
     64'h400000003000000,
     64'h40000083000000,
     64'h400000003000000,
     64'h4000000076000000,
     64'h400000003000000,
     64'h4000000063000000,
     64'h400000003000000,
     64'h7663736972,
     64'h656C7474756873,
     64'h2C7261622D626375,
     64'h1B00000016000000,
     64'h300000000000000,
     64'h5300000004000000,
     64'h300000000000030,
     64'h4075706301000000,
     64'h20A1070040000000,
     64'h400000003000000,
     64'hF000000,
     64'h400000003000000,
     64'h100000000000000,
     64'h400000003000000,
     64'h73757063,
     64'h100000002000000,
     64'h30303030,
     64'h32303031406C6169,
     64'h7265732F636F732F,
     64'h3400000015000000,
     64'h300000000006E65,
     64'h736F686301000000,
     64'h200000000000000,
     64'h3030303032303031,
     64'h406C61697265732F,
     64'h636F732F2C000000,
     64'h1500000003000000,
     64'h73657361696C61,
     64'h100000000000000,
     64'h6472617970696863,
     64'h2C7261622D626375,
     64'h2600000011000000,
     64'h300000000000000,
     64'h7665642D64726179,
     64'h706968632C726162,
     64'h2D6263751B000000,
     64'h1500000003000000,
     64'h10000000F000000,
     64'h400000003000000,
     64'h100000000000000,
     64'h400000003000000,
     64'h1000000,
     64'h0,
     64'h0,
     64'h640B00003A020000,
     64'h10000000,
     64'h1100000028000000,
     64'h9C0B000038000000,
     64'hD60D0000EDFE0DD0,
     64'h1330200073,
     64'h3006307308000613,
     64'h185859300000597,
     64'hF140257334151073,
     64'h5350300001537,
     64'h5A02300B505B3,
     64'h251513FE029EE3,
     64'h5A283F81FF06F,
     64'h0,
     64'h0,
     64'h2C0006F,
     64'hFE069AE3FFC62683,
     64'h46061300D62023,
     64'h10069300458613,
     64'h380006F00050463,
     64'hF1402573020005B7,
     64'hFFDFF06F,
     64'h1050007330052073,
     64'h3045107300800513,
     64'h3445307322200513,
     64'h3030107300028863,
     64'h12F2934122D293,
     64'h301022F330551073,
     64'h405051300000517};	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:57:47]
  TLMonitor_59 monitor (	// @[generators/rocket-chip/src/main/scala/tilelink/Nodes.scala:27:25]
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (auto_in_d_ready),
    .io_in_a_valid        (auto_in_a_valid),
    .io_in_a_bits_opcode  (auto_in_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_a_bits_param),
    .io_in_a_bits_size    (auto_in_a_bits_size),
    .io_in_a_bits_source  (auto_in_a_bits_source),
    .io_in_a_bits_address (auto_in_a_bits_address),
    .io_in_a_bits_mask    (auto_in_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_a_bits_corrupt),
    .io_in_d_ready        (auto_in_d_ready),
    .io_in_d_valid        (auto_in_a_valid),
    .io_in_d_bits_size    (auto_in_a_bits_size),
    .io_in_d_bits_source  (auto_in_a_bits_source)
  );
  assign auto_in_a_ready = auto_in_d_ready;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:41:9]
  assign auto_in_d_valid = auto_in_a_valid;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:41:9]
  assign auto_in_d_bits_size = auto_in_a_bits_size;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:41:9]
  assign auto_in_d_bits_source = auto_in_a_bits_source;	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:41:9]
  assign auto_in_d_bits_data = (|(auto_in_a_bits_address[15:12])) ? 64'h0 : _GEN[auto_in_a_bits_address[11:3]];	// @[generators/rocket-chip/src/main/scala/devices/tilelink/BootROM.scala:41:9, :50:22, :55:34, :56:64, :57:{47,53}]
endmodule

