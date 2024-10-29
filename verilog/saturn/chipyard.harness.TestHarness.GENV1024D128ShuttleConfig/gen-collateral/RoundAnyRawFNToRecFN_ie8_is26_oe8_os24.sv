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

module RoundAnyRawFNToRecFN_ie8_is26_oe8_os24(	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:48:5]
  input         io_invalidExc,	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
  input         io_infiniteExc,	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
  input         io_in_isNaN,	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
  input         io_in_isInf,	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
  input         io_in_isZero,	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
  input         io_in_sign,	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
  input  [9:0]  io_in_sExp,	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
  input  [26:0] io_in_sig,	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
  input  [2:0]  io_roundingMode,	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
  output [32:0] io_out,	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
  output [4:0]  io_exceptionFlags	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16]
);

  wire        roundingMode_near_even = io_roundingMode == 3'h0;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:90:53, generators/hardfloat/hardfloat/src/main/scala/primitives.scala:62:24]
  wire        roundingMode_odd = io_roundingMode == 3'h6;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:95:53]
  wire        roundMagUp = io_roundingMode == 3'h2 & io_in_sign | io_roundingMode == 3'h3 & ~io_in_sign;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:92:53, :93:53, :98:{27,42,63,66}, :196:50]
  wire [8:0]  _roundMask_T_1 = ~(io_in_sExp[8:0]);	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:156:37, generators/hardfloat/hardfloat/src/main/scala/primitives.scala:52:21]
  wire [64:0] _GEN = {59'h0, _roundMask_T_1[5:0]};	// @[generators/hardfloat/hardfloat/src/main/scala/primitives.scala:52:21, :59:26, :76:56]
  wire [64:0] roundMask_shift = $signed(65'sh10000000000000000 >>> _GEN);	// @[generators/hardfloat/hardfloat/src/main/scala/primitives.scala:76:56]
  wire [64:0] roundMask_shift_1 = $signed(65'sh10000000000000000 >>> _GEN);	// @[generators/hardfloat/hardfloat/src/main/scala/primitives.scala:76:56]
  wire [24:0] _roundMask_T_73 = _roundMask_T_1[8] ? (_roundMask_T_1[7] ? {~(_roundMask_T_1[6] ? 22'h0 : ~{roundMask_shift[42], roundMask_shift[43], roundMask_shift[44], roundMask_shift[45], roundMask_shift[46], {{roundMask_shift[47:46], roundMask_shift[49]} & 3'h5, 1'h0} | {roundMask_shift[49:48], roundMask_shift[51:50]} & 4'h5, roundMask_shift[51], roundMask_shift[52], roundMask_shift[53], roundMask_shift[54], roundMask_shift[55], roundMask_shift[56], roundMask_shift[57], roundMask_shift[58], roundMask_shift[59], roundMask_shift[60], roundMask_shift[61], roundMask_shift[62], roundMask_shift[63]}), 3'h7} : {22'h0, _roundMask_T_1[6] ? {roundMask_shift_1[0], roundMask_shift_1[1], roundMask_shift_1[2]} : 3'h0}) : 25'h0;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:220:64, generators/hardfloat/hardfloat/src/main/scala/primitives.scala:52:21, :58:25, :59:26, :62:24, :67:24, :68:58, :73:{17,21,32}, :76:56, :77:20, :78:22]
  wire        _common_underflow_T_4 = _roundMask_T_73[0] | io_in_sig[26];	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:120:57, :159:23, generators/hardfloat/hardfloat/src/main/scala/primitives.scala:62:24]
  wire [25:0] _GEN_0 = {1'h1, ~(_roundMask_T_73[24:1]), ~_common_underflow_T_4};	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16, :159:23, :162:53, :163:28, generators/hardfloat/hardfloat/src/main/scala/primitives.scala:62:24]
  wire [25:0] _GEN_1 = {_roundMask_T_73[24:1], _common_underflow_T_4, 1'h1};	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16, :159:{23,42}, generators/hardfloat/hardfloat/src/main/scala/primitives.scala:62:24]
  wire [25:0] _roundPosBit_T = io_in_sig[26:1] & _GEN_0 & _GEN_1;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16, :159:42, :162:53, :164:40]
  wire [25:0] _anyRoundExtra_T = io_in_sig[25:0] & _GEN_1;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16, :159:42, :165:42]
  wire        anyRound = (|_roundPosBit_T) | (|_anyRoundExtra_T);	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:164:{40,56}, :165:{42,62}, :166:36]
  wire        _overflow_roundMagUp_T = roundingMode_near_even | io_roundingMode == 3'h4;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:90:53, :94:53, :169:38]
  wire [25:0] roundedSig = _overflow_roundMagUp_T & (|_roundPosBit_T) | roundMagUp & anyRound ? {1'h0, io_in_sig[26:2] | {_roundMask_T_73[24:1], _common_underflow_T_4}} + 26'h1 & ~(roundingMode_near_even & (|_roundPosBit_T) & ~(|_anyRoundExtra_T) ? {_roundMask_T_73[24:1], _common_underflow_T_4, 1'h1} : 26'h0) : {1'h0, io_in_sig[26:2] & {~(_roundMask_T_73[24:1]), ~_common_underflow_T_4}} | (roundingMode_odd & anyRound ? _GEN_0 & _GEN_1 : 26'h0);	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:58:16, :90:53, :95:53, :98:42, :159:{23,42}, :162:53, :163:{28,46}, :164:{40,56}, :165:{42,62}, :166:36, :169:{38,67}, :170:31, :171:29, :173:16, :174:{32,49,57}, :175:{21,25,64}, :176:30, :177:35, :180:{30,43,47}, :181:{24,42,67}, :220:64, generators/hardfloat/hardfloat/src/main/scala/primitives.scala:62:24]
  wire [10:0] sRoundedExp = {io_in_sExp[9], io_in_sExp} + {9'h0, roundedSig[25:24]};	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:173:16, :185:{40,54}, :253:18]
  wire        common_totalUnderflow = $signed(sRoundedExp) < 11'sh6B;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:185:40, :200:31]
  wire        isNaNOut = io_invalidExc | io_in_isNaN;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:235:34]
  wire        notNaN_isSpecialInfOut = io_infiniteExc | io_in_isInf;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:236:49]
  wire        commonCase = ~isNaNOut & ~notNaN_isSpecialInfOut & ~io_in_isZero;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:235:34, :236:49, :237:{22,36,61,64}]
  wire        overflow = commonCase & $signed(sRoundedExp[10:7]) > 4'sh2;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:185:40, :196:{30,50}, :237:61, :238:32]
  wire        overflow_roundMagUp = _overflow_roundMagUp_T | roundMagUp;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:98:42, :169:38, :243:60]
  wire        pegMinNonzeroMagOut = commonCase & common_totalUnderflow & (roundMagUp | roundingMode_odd);	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:95:53, :98:42, :200:31, :237:61, :245:{45,60}]
  wire        pegMaxFiniteMagOut = overflow & ~overflow_roundMagUp;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:238:32, :243:60, :246:{39,42}]
  wire        notNaN_isInfOut = notNaN_isSpecialInfOut | overflow & overflow_roundMagUp;	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:236:49, :238:32, :243:60, :248:{32,45}]
  assign io_out = {~isNaNOut & io_in_sign, sRoundedExp[8:0] & ~(io_in_isZero | common_totalUnderflow ? 9'h1C0 : 9'h0) & ~(pegMinNonzeroMagOut ? 9'h194 : 9'h0) & {1'h1, ~pegMaxFiniteMagOut, 7'h7F} & {2'h3, ~notNaN_isInfOut, 6'h3F} | (pegMinNonzeroMagOut ? 9'h6B : 9'h0) | (pegMaxFiniteMagOut ? 9'h17F : 9'h0) | (notNaN_isInfOut ? 9'h180 : 9'h0) | (isNaNOut ? 9'h1C0 : 9'h0), (isNaNOut | io_in_isZero | common_totalUnderflow ? {isNaNOut, 22'h0} : io_in_sig[26] ? roundedSig[23:1] : roundedSig[22:0]) | {23{pegMaxFiniteMagOut}}};	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:48:5, :58:16, :120:57, :159:42, :173:16, :185:40, :187:37, :189:16, :190:27, :191:27, :200:31, :235:34, :245:45, :246:39, :248:32, :250:22, :253:{14,18,32}, :257:{14,18}, :258:19, :261:{14,18}, :264:17, :265:{14,18}, :269:16, :273:16, :277:{16,73}, :278:16, :280:{12,38}, :281:16, :283:11, :284:13, :286:33, generators/hardfloat/hardfloat/src/main/scala/primitives.scala:73:21]
  assign io_exceptionFlags = {io_invalidExc, io_infiniteExc, overflow, commonCase & (common_totalUnderflow | anyRound & io_in_sExp[9:8] != 2'h1 & (io_in_sig[26] ? _roundMask_T_73[1] : _common_underflow_T_4) & ~(~(io_in_sig[26] ? _roundMask_T_73[2] : _roundMask_T_73[1]) & (io_in_sig[26] ? roundedSig[25] : roundedSig[24]) & (|_roundPosBit_T) & (_overflow_roundMagUp_T & (io_in_sig[26] ? io_in_sig[2] : io_in_sig[1]) | roundMagUp & (io_in_sig[26] & io_in_sig[2] | (|(io_in_sig[1:0])))))), overflow | commonCase & (common_totalUnderflow | anyRound)};	// @[generators/hardfloat/hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala:48:5, :98:42, :120:57, :159:23, :164:{40,56}, :166:36, :169:38, :173:16, :200:31, :203:{16,45,61}, :205:{30,49,63,70}, :207:67, :208:46, :209:29, :211:16, :212:27, :213:27, :217:40, :220:{49,64}, :221:{30,57,76}, :222:27, :223:{34,39}, :224:49, :227:60, :230:49, :237:61, :238:32, :239:32, :240:{28,43}, :288:66, generators/hardfloat/hardfloat/src/main/scala/primitives.scala:62:24, :77:20]
endmodule

