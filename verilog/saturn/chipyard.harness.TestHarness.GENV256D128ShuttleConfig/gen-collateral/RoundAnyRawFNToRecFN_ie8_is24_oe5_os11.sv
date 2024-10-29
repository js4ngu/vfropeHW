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

module RoundAnyRawFNToRecFN_ie8_is24_oe5_os11(	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:48:5]
  input         io_invalidExc,	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
  input         io_in_isNaN,	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
  input         io_in_isInf,	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
  input         io_in_isZero,	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
  input         io_in_sign,	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
  input  [9:0]  io_in_sExp,	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
  input  [24:0] io_in_sig,	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
  input  [2:0]  io_roundingMode,	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
  output [16:0] io_out	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
);

  wire        roundingMode_near_even = io_roundingMode == 3'h0;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:90:53]
  wire        roundingMode_odd = io_roundingMode == 3'h6;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:95:53]
  wire        roundMagUp = io_roundingMode == 3'h2 & io_in_sign | io_roundingMode == 3'h3 & ~io_in_sign;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:92:53, :93:53, :98:{27,42,63,66}, :196:50]
  wire [10:0] sAdjustedExp = {io_in_sExp[9], io_in_sExp} - 11'hE0;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:110:24]
  wire [64:0] roundMask_shift = $signed(65'sh10000000000000000 >>> ~(sAdjustedExp[5:0]));	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:110:24, :156:37, generators/hardfloat/hardfloat/src/main/scala/primitives.scala:52:21, :76:56]
  wire [1:0]  _GEN = {roundMask_shift[10], roundMask_shift[11]};	// @[generators/hardfloat/hardfloat/src/main/scala/primitives.scala:76:56, :77:20, :78:22]
  wire [12:0] _GEN_0 = {1'h1, ~(roundMask_shift[7]), ~(roundMask_shift[8]), ~(roundMask_shift[9]), ~_GEN, ~(roundMask_shift[12]), ~(roundMask_shift[13]), ~(roundMask_shift[14]), ~(roundMask_shift[15]), ~(roundMask_shift[16]), ~(roundMask_shift[17]), ~(roundMask_shift[18])};	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:162:53, :163:28, :174:49, generators/hardfloat/hardfloat/src/main/scala/primitives.scala:76:56, :77:20, :78:22]
  wire [12:0] _GEN_1 = {roundMask_shift[7], roundMask_shift[8], roundMask_shift[9], roundMask_shift[10], roundMask_shift[11], roundMask_shift[12], roundMask_shift[13], roundMask_shift[14], roundMask_shift[15], roundMask_shift[16], roundMask_shift[17], roundMask_shift[18], 1'h1};	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:159:42, :174:49, generators/hardfloat/hardfloat/src/main/scala/primitives.scala:76:56, :77:20, :78:22]
  wire [12:0] _roundPosBit_T = io_in_sig[24:12] & _GEN_0 & _GEN_1;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:116:23, :159:42, :162:53, :164:40]
  wire [12:0] _anyRoundExtra_T = {io_in_sig[23:12], |(io_in_sig[11:0])} & _GEN_1;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:116:66, :117:{26,60}, :159:42, :165:42]
  wire        anyRound = (|_roundPosBit_T) | (|_anyRoundExtra_T);	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:164:{40,56}, :165:{42,62}, :166:36]
  wire        _overflow_roundMagUp_T = roundingMode_near_even | io_roundingMode == 3'h4;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:90:53, :94:53, :169:38]
  wire [12:0] roundedSig = _overflow_roundMagUp_T & (|_roundPosBit_T) | roundMagUp & anyRound ? {1'h0, io_in_sig[24] | roundMask_shift[7], io_in_sig[23] | roundMask_shift[8], io_in_sig[22] | roundMask_shift[9], io_in_sig[21:20] | _GEN, io_in_sig[19] | roundMask_shift[12], io_in_sig[18] | roundMask_shift[13], io_in_sig[17] | roundMask_shift[14], io_in_sig[16] | roundMask_shift[15], io_in_sig[15] | roundMask_shift[16], io_in_sig[14] | roundMask_shift[17], io_in_sig[13] | roundMask_shift[18]} + 13'h1 & ~(roundingMode_near_even & (|_roundPosBit_T) & ~(|_anyRoundExtra_T) ? {roundMask_shift[7], roundMask_shift[8], roundMask_shift[9], roundMask_shift[10], roundMask_shift[11], roundMask_shift[12], roundMask_shift[13], roundMask_shift[14], roundMask_shift[15], roundMask_shift[16], roundMask_shift[17], roundMask_shift[18], 1'h1} : 13'h0) : {1'h0, io_in_sig[24:13] & {~(roundMask_shift[7]), ~(roundMask_shift[8]), ~(roundMask_shift[9]), ~_GEN, ~(roundMask_shift[12]), ~(roundMask_shift[13]), ~(roundMask_shift[14]), ~(roundMask_shift[15]), ~(roundMask_shift[16]), ~(roundMask_shift[17]), ~(roundMask_shift[18])}} | (roundingMode_odd & anyRound ? _GEN_0 & _GEN_1 : 13'h0);	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16, :90:53, :95:53, :98:42, :159:42, :162:53, :163:{28,46}, :164:{40,56}, :165:{42,62}, :166:36, :169:{38,67}, :170:31, :171:29, :173:16, :174:{32,49,57}, :175:{21,25,64}, :176:30, :177:35, :180:{30,43,47}, :181:{24,42,67}, generators/hardfloat/hardfloat/src/main/scala/primitives.scala:76:56, :77:20, :78:22]
  wire [11:0] sRoundedExp = {sAdjustedExp[10], sAdjustedExp} + {10'h0, roundedSig[12:11]};	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:110:24, :173:16, :185:{40,54}, :284:13]
  wire        common_totalUnderflow = $signed(sRoundedExp) < 12'sh8;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:185:40, :200:31]
  wire        isNaNOut = io_invalidExc | io_in_isNaN;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:235:34]
  wire        commonCase = ~isNaNOut & ~io_in_isInf & ~io_in_isZero;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:235:34, :237:{22,36,61,64}]
  wire        overflow = commonCase & $signed(sRoundedExp[11:4]) > 8'sh2;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:185:40, :196:{30,50}, :237:61, :238:32]
  wire        overflow_roundMagUp = _overflow_roundMagUp_T | roundMagUp;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:98:42, :169:38, :243:60]
  wire        pegMinNonzeroMagOut = commonCase & common_totalUnderflow & (roundMagUp | roundingMode_odd);	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:95:53, :98:42, :200:31, :237:61, :245:{45,60}]
  wire        pegMaxFiniteMagOut = overflow & ~overflow_roundMagUp;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:238:32, :243:60, :246:{39,42}]
  wire        notNaN_isInfOut = io_in_isInf | overflow & overflow_roundMagUp;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:238:32, :243:60, :248:{32,45}]
  assign io_out = {~isNaNOut & io_in_sign, sRoundedExp[5:0] & ~(io_in_isZero | common_totalUnderflow ? 6'h38 : 6'h0) & ~(pegMinNonzeroMagOut ? 6'h37 : 6'h0) & {1'h1, ~pegMaxFiniteMagOut, 4'hF} & {2'h3, ~notNaN_isInfOut, 3'h7} | {2'h0, pegMinNonzeroMagOut, 3'h0} | (pegMaxFiniteMagOut ? 6'h2F : 6'h0) | (notNaN_isInfOut ? 6'h30 : 6'h0) | (isNaNOut ? 6'h38 : 6'h0), (isNaNOut | io_in_isZero | common_totalUnderflow ? {isNaNOut, 9'h0} : roundedSig[9:0]) | {10{pegMaxFiniteMagOut}}};	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:48:5, :90:53, :159:42, :173:16, :174:49, :185:40, :187:37, :191:27, :200:31, :235:34, :245:45, :246:39, :248:32, :250:22, :253:{14,18,32}, :257:{14,18}, :258:19, :261:{14,18}, :264:17, :265:{14,18}, :269:16, :273:16, :277:{16,73}, :278:16, :280:{12,38}, :281:16, :283:11, :284:13, :286:33]
endmodule
