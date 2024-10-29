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

module TLFragmenter_TileResetSetter(	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9]
  input         clock,	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9]
  input         reset,	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9]
  output        auto_anon_in_a_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_anon_in_a_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]  auto_anon_in_a_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]  auto_anon_in_a_bits_param,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]  auto_anon_in_a_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [7:0]  auto_anon_in_a_bits_source,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [20:0] auto_anon_in_a_bits_address,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [7:0]  auto_anon_in_a_bits_mask,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_anon_in_a_bits_corrupt,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_anon_in_d_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output        auto_anon_in_d_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [2:0]  auto_anon_in_d_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [2:0]  auto_anon_in_d_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [7:0]  auto_anon_in_d_bits_source,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_anon_out_a_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output        auto_anon_out_a_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [2:0]  auto_anon_out_a_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [2:0]  auto_anon_out_a_bits_param,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [1:0]  auto_anon_out_a_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [11:0] auto_anon_out_a_bits_source,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [20:0] auto_anon_out_a_bits_address,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output [7:0]  auto_anon_out_a_bits_mask,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output        auto_anon_out_a_bits_corrupt,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  output        auto_anon_out_d_ready,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input         auto_anon_out_d_valid,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [2:0]  auto_anon_out_d_bits_opcode,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [1:0]  auto_anon_out_d_bits_size,	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
  input  [11:0] auto_anon_out_d_bits_source	// @[generators/diplomacy/diplomacy/src/diplomacy/lazymodule/LazyModuleImp.scala:107:25]
);

  wire        _repeater_io_full;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:274:30]
  wire        _repeater_io_enq_ready;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:274:30]
  wire        _repeater_io_deq_valid;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:274:30]
  wire [2:0]  _repeater_io_deq_bits_opcode;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:274:30]
  wire [2:0]  _repeater_io_deq_bits_size;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:274:30]
  wire [7:0]  _repeater_io_deq_bits_source;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:274:30]
  wire [20:0] _repeater_io_deq_bits_address;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:274:30]
  wire [7:0]  _repeater_io_deq_bits_mask;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:274:30]
  reg  [2:0]  acknum;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:201:29]
  reg  [2:0]  dOrig;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:202:24]
  reg         dToggle;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:203:30]
  wire        dFirst = acknum == 3'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:201:29, :205:29]
  wire [5:0]  _dsizeOH1_T = 6'h7 << auto_anon_out_d_bits_size;	// @[generators/rocket-chip/src/main/scala/util/package.scala:243:71]
  wire [2:0]  _GEN = ~(auto_anon_out_d_bits_source[2:0]);	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:204:41, generators/rocket-chip/src/main/scala/util/package.scala:241:49]
  wire [2:0]  dFirst_size_hi = auto_anon_out_d_bits_source[2:0] & {1'h1, _GEN[2:1]};	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9, :204:41, generators/rocket-chip/src/main/scala/util/package.scala:241:{47,49}, src/main/scala/chisel3/util/OneHot.scala:30:18]
  wire [2:0]  _dFirst_size_T_8 = {1'h0, dFirst_size_hi[2:1]} | ~(_dsizeOH1_T[2:0]) & {_GEN[0], _dsizeOH1_T[2:1]};	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9, generators/rocket-chip/src/main/scala/util/package.scala:241:{47,49}, :243:{46,71,76}, src/main/scala/chisel3/util/OneHot.scala:30:18, :31:18, :32:28]
  wire [2:0]  dFirst_size = {|dFirst_size_hi, |(_dFirst_size_T_8[2:1]), _dFirst_size_T_8[2] | _dFirst_size_T_8[0]};	// @[generators/rocket-chip/src/main/scala/util/package.scala:241:47, src/main/scala/chisel3/util/OneHot.scala:30:18, :31:18, :32:{10,14,28}]
  wire        drop = ~(auto_anon_out_d_bits_opcode[0]) & (|(auto_anon_out_d_bits_source[2:0]));	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:106:36, generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:204:41, :206:30, :234:{20,30}]
  wire        anonOut_d_ready = auto_anon_in_d_ready | drop;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:234:30, :235:35]
  wire        anonIn_d_valid = auto_anon_out_d_valid & ~drop;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:234:30, :236:{36,39}]
  wire [2:0]  anonIn_d_bits_size = dFirst ? dFirst_size : dOrig;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:202:24, :205:29, :239:32, src/main/scala/chisel3/util/OneHot.scala:32:10]
  wire [12:0] _aOrigOH1_T = 13'h3F << _repeater_io_deq_bits_size;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:274:30, generators/rocket-chip/src/main/scala/util/package.scala:243:71]
  reg  [2:0]  gennum;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:303:29]
  wire        aFirst = gennum == 3'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:201:29, :303:29, :304:29]
  wire [2:0]  _old_gennum1_T_1 = gennum - 3'h1;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:303:29, :305:79]
  wire [2:0]  aFragnum = aFirst ? ~(_aOrigOH1_T[5:3]) : _old_gennum1_T_1;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:304:29, :305:{30,79}, generators/rocket-chip/src/main/scala/util/package.scala:243:{46,71,76}]
  reg         aToggle_r;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:309:54]
  `ifndef SYNTHESIS	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:321:16]
    always @(posedge clock) begin	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:321:16]
      if (~reset & ~(~_repeater_io_full | _repeater_io_deq_bits_opcode[2])) begin	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:92:37, generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:274:30, :321:{16,17,35}]
        if (`ASSERT_VERBOSE_COND_)	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:321:16]
          $error("Assertion failed\n    at Fragmenter.scala:321 assert (!repeater.io.full || !aHasData)\n");	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:321:16]
        if (`STOP_COND_)	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:321:16]
          $fatal;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:321:16]
      end
      if (~reset & ~(~_repeater_io_full | (&_repeater_io_deq_bits_mask))) begin	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:274:30, :321:{16,17}, :324:{16,35,53}]
        if (`ASSERT_VERBOSE_COND_)	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:324:16]
          $error("Assertion failed\n    at Fragmenter.scala:324 assert (!repeater.io.full || in_a.bits.mask === fullMask)\n");	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:324:16]
        if (`STOP_COND_)	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:324:16]
          $fatal;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:324:16]
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire        _GEN_0 = anonOut_d_ready & auto_anon_out_d_valid;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:235:35, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  wire        _GEN_1 = _GEN_0 & dFirst;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:202:24, :205:29, :220:27, :222:25, :223:19, src/main/scala/chisel3/util/Decoupled.scala:51:35]
  always @(posedge clock) begin	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9]
    if (reset) begin	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9]
      acknum <= 3'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:201:29]
      dToggle <= 1'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9, :203:30]
      gennum <= 3'h0;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:201:29, :303:29]
    end
    else begin	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9]
      if (_GEN_0) begin	// @[src/main/scala/chisel3/util/Decoupled.scala:51:35]
        if (dFirst)	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:205:29]
          acknum <= auto_anon_out_d_bits_source[2:0];	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:201:29, :204:41]
        else	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:205:29]
          acknum <= acknum - {2'h0, auto_anon_out_d_bits_opcode[0] | (&auto_anon_out_d_bits_size)};	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:106:36, generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:201:29, :216:{32,56}, :221:55, src/main/scala/chisel3/util/OneHot.scala:65:12]
      end
      if (_GEN_1)	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:202:24, :220:27, :222:25, :223:19]
        dToggle <= auto_anon_out_d_bits_source[3];	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:203:30, :224:41]
      if (auto_anon_out_a_ready & _repeater_io_deq_valid) begin	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:274:30, src/main/scala/chisel3/util/Decoupled.scala:51:35]
        if (aFirst)	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:304:29]
          gennum <= ~(_aOrigOH1_T[5:3]);	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:303:29, generators/rocket-chip/src/main/scala/util/package.scala:243:{46,71,76}]
        else	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:304:29]
          gennum <= _old_gennum1_T_1;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:303:29, :305:79]
      end
    end
    if (_GEN_1)	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:202:24, :220:27, :222:25, :223:19]
      dOrig <= dFirst_size;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:202:24, src/main/scala/chisel3/util/OneHot.scala:32:10]
    if (aFirst)	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:304:29]
      aToggle_r <= dToggle;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:203:30, :309:54]
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9]
    `ifdef FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9]
      `FIRRTL_BEFORE_INITIAL	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9]
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:0];	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9]
    initial begin	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9]
      `ifdef INIT_RANDOM_PROLOG_	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9]
        `INIT_RANDOM_PROLOG_	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9]
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9]
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9]
        acknum = _RANDOM[/*Zero width*/ 1'b0][2:0];	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9, :201:29]
        dOrig = _RANDOM[/*Zero width*/ 1'b0][5:3];	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9, :201:29, :202:24]
        dToggle = _RANDOM[/*Zero width*/ 1'b0][6];	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9, :201:29, :203:30]
        gennum = _RANDOM[/*Zero width*/ 1'b0][9:7];	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9, :201:29, :303:29]
        aToggle_r = _RANDOM[/*Zero width*/ 1'b0][10];	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9, :201:29, :309:54]
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9]
      `FIRRTL_AFTER_INITIAL	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9]
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_70 monitor (	// @[generators/rocket-chip/src/main/scala/tilelink/Nodes.scala:27:25]
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (_repeater_io_enq_ready),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:274:30]
    .io_in_a_valid        (auto_anon_in_a_valid),
    .io_in_a_bits_opcode  (auto_anon_in_a_bits_opcode),
    .io_in_a_bits_param   (auto_anon_in_a_bits_param),
    .io_in_a_bits_size    (auto_anon_in_a_bits_size),
    .io_in_a_bits_source  (auto_anon_in_a_bits_source),
    .io_in_a_bits_address (auto_anon_in_a_bits_address),
    .io_in_a_bits_mask    (auto_anon_in_a_bits_mask),
    .io_in_a_bits_corrupt (auto_anon_in_a_bits_corrupt),
    .io_in_d_ready        (auto_anon_in_d_ready),
    .io_in_d_valid        (anonIn_d_valid),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:236:36]
    .io_in_d_bits_opcode  (auto_anon_out_d_bits_opcode),
    .io_in_d_bits_size    (anonIn_d_bits_size),	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:239:32]
    .io_in_d_bits_source  (auto_anon_out_d_bits_source[11:4])	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:238:47]
  );
  Repeater_TLBundleA_a21d64s8k1z3u repeater (	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:274:30]
    .clock               (clock),
    .reset               (reset),
    .io_repeat           (_repeater_io_deq_bits_opcode[2] & (|aFragnum)),	// @[generators/rocket-chip/src/main/scala/tilelink/Edges.scala:92:37, generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:274:30, :305:30, :314:{41,53}]
    .io_full             (_repeater_io_full),
    .io_enq_ready        (_repeater_io_enq_ready),
    .io_enq_valid        (auto_anon_in_a_valid),
    .io_enq_bits_opcode  (auto_anon_in_a_bits_opcode),
    .io_enq_bits_param   (auto_anon_in_a_bits_param),
    .io_enq_bits_size    (auto_anon_in_a_bits_size),
    .io_enq_bits_source  (auto_anon_in_a_bits_source),
    .io_enq_bits_address (auto_anon_in_a_bits_address),
    .io_enq_bits_mask    (auto_anon_in_a_bits_mask),
    .io_enq_bits_corrupt (auto_anon_in_a_bits_corrupt),
    .io_deq_ready        (auto_anon_out_a_ready),
    .io_deq_valid        (_repeater_io_deq_valid),
    .io_deq_bits_opcode  (_repeater_io_deq_bits_opcode),
    .io_deq_bits_param   (auto_anon_out_a_bits_param),
    .io_deq_bits_size    (_repeater_io_deq_bits_size),
    .io_deq_bits_source  (_repeater_io_deq_bits_source),
    .io_deq_bits_address (_repeater_io_deq_bits_address),
    .io_deq_bits_mask    (_repeater_io_deq_bits_mask),
    .io_deq_bits_corrupt (auto_anon_out_a_bits_corrupt)
  );
  assign auto_anon_in_a_ready = _repeater_io_enq_ready;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9, :274:30]
  assign auto_anon_in_d_valid = anonIn_d_valid;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9, :236:36]
  assign auto_anon_in_d_bits_opcode = auto_anon_out_d_bits_opcode;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9]
  assign auto_anon_in_d_bits_size = anonIn_d_bits_size;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9, :239:32]
  assign auto_anon_in_d_bits_source = auto_anon_out_d_bits_source[11:4];	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9, :238:47]
  assign auto_anon_out_a_valid = _repeater_io_deq_valid;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9, :274:30]
  assign auto_anon_out_a_bits_opcode = _repeater_io_deq_bits_opcode;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9, :274:30]
  assign auto_anon_out_a_bits_size = _repeater_io_deq_bits_size[2] ? 2'h3 : _repeater_io_deq_bits_size[1:0];	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9, :274:30, :297:{24,31}, src/main/scala/chisel3/util/OneHot.scala:65:12]
  assign auto_anon_out_a_bits_source = {_repeater_io_deq_bits_source, ~(aFirst ? dToggle : aToggle_r), aFragnum};	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9, :203:30, :274:30, :304:29, :305:30, :309:{23,27,54}, :317:33]
  assign auto_anon_out_a_bits_address = {_repeater_io_deq_bits_address[20:6], _repeater_io_deq_bits_address[5:0] | {~(aFragnum | _aOrigOH1_T[5:3]), 3'h0}};	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9, :201:29, :274:30, :305:30, :316:{49,51,88,111}, generators/rocket-chip/src/main/scala/util/package.scala:243:{71,76}]
  assign auto_anon_out_a_bits_mask = _repeater_io_full ? 8'hFF : auto_anon_in_a_bits_mask;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9, :274:30, :324:53, :325:31]
  assign auto_anon_out_d_ready = anonOut_d_ready;	// @[generators/rocket-chip/src/main/scala/tilelink/Fragmenter.scala:92:9, :235:35]
endmodule
