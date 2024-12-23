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

module MulAddRecFNToRaw_preMul_e5_s11(	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7]
  input  [1:0]  io_op,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  input  [16:0] io_a,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  input  [16:0] io_b,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  input  [16:0] io_c,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  output [10:0] io_mulAddA,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  output [10:0] io_mulAddB,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  output [21:0] io_mulAddC,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  output        io_toPostMul_isSigNaNAny,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  output        io_toPostMul_isNaNAOrB,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  output        io_toPostMul_isInfA,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  output        io_toPostMul_isZeroA,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  output        io_toPostMul_isInfB,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  output        io_toPostMul_isZeroB,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  output        io_toPostMul_signProd,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  output        io_toPostMul_isNaNC,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  output        io_toPostMul_isInfC,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  output        io_toPostMul_isZeroC,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  output [6:0]  io_toPostMul_sExpSum,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  output        io_toPostMul_doSubMags,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  output        io_toPostMul_CIsDominant,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  output [3:0]  io_toPostMul_CDom_CAlignDist,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  output [12:0] io_toPostMul_highAlignedSigC,	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
  output        io_toPostMul_bit0AlignedSigC	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:74:16]
);

  wire        rawA_isNaN = (&(io_a[15:14])) & io_a[13];	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :53:{28,53}, :56:{33,41}]
  wire        rawB_isNaN = (&(io_b[15:14])) & io_b[13];	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :53:{28,53}, :56:{33,41}]
  wire        rawC_isNaN = (&(io_c[15:14])) & io_c[13];	// @[generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :53:{28,53}, :56:{33,41}]
  wire        signProd = io_a[16] ^ io_b[16] ^ io_op[1];	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:97:{42,49}, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:59:25]
  wire [7:0]  _sExpAlignedProd_T_1 = {2'h0, io_a[15:10]} + {2'h0, io_b[15:10]} - 8'h12;	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:100:{19,32}, :122:68, :130:11, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21]
  wire        doSubMags = signProd ^ io_c[16] ^ io_op[0];	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:97:42, :102:{42,49}, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:59:25]
  wire [7:0]  _sNatCAlignDist_T = _sExpAlignedProd_T_1 - {2'h0, io_c[15:10]};	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:100:32, :106:42, :122:68, :130:11, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21]
  wire        isMinCAlign = ~(|(io_a[15:13])) | ~(|(io_b[15:13])) | $signed(_sNatCAlignDist_T) < 8'sh0;	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:106:42, :108:{50,69}, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :52:{28,53}]
  wire        CIsDominant = (|(io_c[15:13])) & (isMinCAlign | _sNatCAlignDist_T[6:0] < 7'hC);	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:106:42, :107:42, :108:50, :110:{23,39,60}, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :52:{28,53}]
  wire [5:0]  CAlignDist = isMinCAlign ? 6'h0 : _sNatCAlignDist_T[6:0] < 7'h23 ? _sNatCAlignDist_T[5:0] : 6'h23;	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:106:42, :107:42, :108:50, :112:12, :114:{16,34}, :115:33]
  wire [38:0] mainAlignedSigC = $signed($signed({doSubMags ? {1'h1, ~(|(io_c[15:13])), ~(io_c[9:0])} : {1'h0, |(io_c[15:13]), io_c[9:0]}, {27{doSubMags}}}) >>> CAlignDist);	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:102:42, :108:69, :112:12, :120:{13,25,46,53,100}, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :52:{28,53}, :61:{44,49}]
  wire [16:0] reduced4CExtra_shift = $signed(17'sh10000 >>> CAlignDist[5:2]);	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:112:12, :124:28, generators/hardfloat/hardfloat/src/main/scala/primitives.scala:76:56]
  wire [1:0]  _GEN = {|(io_c[7:4]), |(io_c[3:0])} & {reduced4CExtra_shift[8], reduced4CExtra_shift[9]};	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:122:68, generators/hardfloat/hardfloat/src/main/scala/primitives.scala:76:56, :77:20, :78:22, :120:{33,54}]
  assign io_mulAddA = {|(io_a[15:13]), io_a[9:0]};	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7, :141:16, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :52:{28,53}, :61:49]
  assign io_mulAddB = {|(io_b[15:13]), io_b[9:0]};	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7, :142:16, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :52:{28,53}, :61:49]
  assign io_mulAddC = mainAlignedSigC[24:3];	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7, :120:100, :143:30]
  assign io_toPostMul_isSigNaNAny = rawA_isNaN & ~(io_a[9]) | rawB_isNaN & ~(io_b[9]) | rawC_isNaN & ~(io_c[9]);	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7, :146:58, generators/hardfloat/hardfloat/src/main/scala/common.scala:82:{46,49,56}, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:56:33]
  assign io_toPostMul_isNaNAOrB = rawA_isNaN | rawB_isNaN;	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7, :148:42, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:56:33]
  assign io_toPostMul_isInfA = (&(io_a[15:14])) & ~(io_a[13]);	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :53:{28,53}, :56:41, :57:{33,36}]
  assign io_toPostMul_isZeroA = ~(|(io_a[15:13]));	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :52:{28,53}]
  assign io_toPostMul_isInfB = (&(io_b[15:14])) & ~(io_b[13]);	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :53:{28,53}, :56:41, :57:{33,36}]
  assign io_toPostMul_isZeroB = ~(|(io_b[15:13]));	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :52:{28,53}]
  assign io_toPostMul_signProd = signProd;	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7, :97:42]
  assign io_toPostMul_isNaNC = rawC_isNaN;	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:56:33]
  assign io_toPostMul_isInfC = (&(io_c[15:14])) & ~(io_c[13]);	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :53:{28,53}, :56:41, :57:{33,36}]
  assign io_toPostMul_isZeroC = ~(|(io_c[15:13]));	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21, :52:{28,53}]
  assign io_toPostMul_sExpSum = CIsDominant ? {1'h0, io_c[15:10]} : _sExpAlignedProd_T_1[6:0] - 7'hB;	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7, :100:32, :108:69, :110:23, :158:{12,53}, generators/hardfloat/hardfloat/src/main/scala/rawFloatFromRecFN.scala:51:21]
  assign io_toPostMul_doSubMags = doSubMags;	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7, :102:42]
  assign io_toPostMul_CIsDominant = CIsDominant;	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7, :110:23]
  assign io_toPostMul_CDom_CAlignDist = CAlignDist[3:0];	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7, :112:12, :161:47]
  assign io_toPostMul_highAlignedSigC = mainAlignedSigC[37:25];	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7, :120:100, :163:20]
  assign io_toPostMul_bit0AlignedSigC = doSubMags ? (&(mainAlignedSigC[2:0])) & ~(|_GEN) : (|(mainAlignedSigC[2:0])) | (|_GEN);	// @[generators/hardfloat/hardfloat/src/main/scala/MulAddRecFN.scala:71:7, :102:42, :120:100, :122:68, :130:11, :133:16, :134:{32,39,44,47}, :135:{39,44}]
endmodule

