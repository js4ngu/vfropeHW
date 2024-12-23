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
module vrf_64x128(	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
  input  [5:0]   R0_addr,
  input          R0_en,
  input          R0_clk,
  output [127:0] R0_data,
  input  [5:0]   R1_addr,
  input          R1_en,
  input          R1_clk,
  output [127:0] R1_data,
  input  [5:0]   R2_addr,
  input          R2_en,
  input          R2_clk,
  output [127:0] R2_data,
  input  [5:0]   W0_addr,
  input          W0_en,
  input          W0_clk,
  input  [127:0] W0_data,
  input  [127:0] W0_mask
);

  reg [127:0] Memory[0:63];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
  always @(posedge W0_clk) begin	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[0])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h0 +: 1] <= W0_data[0];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[1])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h1 +: 1] <= W0_data[1];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[2])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h2 +: 1] <= W0_data[2];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[3])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h3 +: 1] <= W0_data[3];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[4])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h4 +: 1] <= W0_data[4];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[5])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h5 +: 1] <= W0_data[5];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[6])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h6 +: 1] <= W0_data[6];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[7])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h7 +: 1] <= W0_data[7];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[8])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h8 +: 1] <= W0_data[8];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[9])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h9 +: 1] <= W0_data[9];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[10])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'hA +: 1] <= W0_data[10];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[11])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'hB +: 1] <= W0_data[11];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[12])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'hC +: 1] <= W0_data[12];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[13])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'hD +: 1] <= W0_data[13];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[14])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'hE +: 1] <= W0_data[14];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[15])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'hF +: 1] <= W0_data[15];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[16])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h10 +: 1] <= W0_data[16];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[17])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h11 +: 1] <= W0_data[17];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[18])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h12 +: 1] <= W0_data[18];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[19])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h13 +: 1] <= W0_data[19];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[20])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h14 +: 1] <= W0_data[20];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[21])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h15 +: 1] <= W0_data[21];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[22])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h16 +: 1] <= W0_data[22];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[23])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h17 +: 1] <= W0_data[23];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[24])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h18 +: 1] <= W0_data[24];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[25])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h19 +: 1] <= W0_data[25];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[26])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h1A +: 1] <= W0_data[26];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[27])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h1B +: 1] <= W0_data[27];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[28])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h1C +: 1] <= W0_data[28];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[29])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h1D +: 1] <= W0_data[29];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[30])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h1E +: 1] <= W0_data[30];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[31])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h1F +: 1] <= W0_data[31];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[32])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h20 +: 1] <= W0_data[32];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[33])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h21 +: 1] <= W0_data[33];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[34])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h22 +: 1] <= W0_data[34];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[35])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h23 +: 1] <= W0_data[35];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[36])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h24 +: 1] <= W0_data[36];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[37])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h25 +: 1] <= W0_data[37];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[38])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h26 +: 1] <= W0_data[38];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[39])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h27 +: 1] <= W0_data[39];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[40])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h28 +: 1] <= W0_data[40];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[41])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h29 +: 1] <= W0_data[41];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[42])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h2A +: 1] <= W0_data[42];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[43])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h2B +: 1] <= W0_data[43];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[44])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h2C +: 1] <= W0_data[44];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[45])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h2D +: 1] <= W0_data[45];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[46])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h2E +: 1] <= W0_data[46];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[47])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h2F +: 1] <= W0_data[47];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[48])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h30 +: 1] <= W0_data[48];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[49])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h31 +: 1] <= W0_data[49];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[50])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h32 +: 1] <= W0_data[50];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[51])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h33 +: 1] <= W0_data[51];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[52])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h34 +: 1] <= W0_data[52];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[53])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h35 +: 1] <= W0_data[53];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[54])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h36 +: 1] <= W0_data[54];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[55])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h37 +: 1] <= W0_data[55];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[56])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h38 +: 1] <= W0_data[56];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[57])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h39 +: 1] <= W0_data[57];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[58])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h3A +: 1] <= W0_data[58];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[59])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h3B +: 1] <= W0_data[59];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[60])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h3C +: 1] <= W0_data[60];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[61])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h3D +: 1] <= W0_data[61];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[62])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h3E +: 1] <= W0_data[62];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[63])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h3F +: 1] <= W0_data[63];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[64])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h40 +: 1] <= W0_data[64];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[65])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h41 +: 1] <= W0_data[65];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[66])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h42 +: 1] <= W0_data[66];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[67])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h43 +: 1] <= W0_data[67];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[68])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h44 +: 1] <= W0_data[68];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[69])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h45 +: 1] <= W0_data[69];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[70])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h46 +: 1] <= W0_data[70];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[71])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h47 +: 1] <= W0_data[71];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[72])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h48 +: 1] <= W0_data[72];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[73])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h49 +: 1] <= W0_data[73];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[74])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h4A +: 1] <= W0_data[74];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[75])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h4B +: 1] <= W0_data[75];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[76])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h4C +: 1] <= W0_data[76];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[77])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h4D +: 1] <= W0_data[77];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[78])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h4E +: 1] <= W0_data[78];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[79])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h4F +: 1] <= W0_data[79];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[80])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h50 +: 1] <= W0_data[80];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[81])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h51 +: 1] <= W0_data[81];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[82])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h52 +: 1] <= W0_data[82];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[83])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h53 +: 1] <= W0_data[83];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[84])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h54 +: 1] <= W0_data[84];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[85])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h55 +: 1] <= W0_data[85];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[86])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h56 +: 1] <= W0_data[86];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[87])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h57 +: 1] <= W0_data[87];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[88])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h58 +: 1] <= W0_data[88];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[89])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h59 +: 1] <= W0_data[89];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[90])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h5A +: 1] <= W0_data[90];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[91])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h5B +: 1] <= W0_data[91];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[92])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h5C +: 1] <= W0_data[92];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[93])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h5D +: 1] <= W0_data[93];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[94])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h5E +: 1] <= W0_data[94];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[95])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h5F +: 1] <= W0_data[95];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[96])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h60 +: 1] <= W0_data[96];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[97])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h61 +: 1] <= W0_data[97];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[98])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h62 +: 1] <= W0_data[98];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[99])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h63 +: 1] <= W0_data[99];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[100])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h64 +: 1] <= W0_data[100];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[101])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h65 +: 1] <= W0_data[101];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[102])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h66 +: 1] <= W0_data[102];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[103])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h67 +: 1] <= W0_data[103];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[104])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h68 +: 1] <= W0_data[104];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[105])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h69 +: 1] <= W0_data[105];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[106])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h6A +: 1] <= W0_data[106];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[107])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h6B +: 1] <= W0_data[107];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[108])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h6C +: 1] <= W0_data[108];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[109])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h6D +: 1] <= W0_data[109];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[110])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h6E +: 1] <= W0_data[110];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[111])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h6F +: 1] <= W0_data[111];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[112])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h70 +: 1] <= W0_data[112];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[113])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h71 +: 1] <= W0_data[113];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[114])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h72 +: 1] <= W0_data[114];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[115])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h73 +: 1] <= W0_data[115];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[116])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h74 +: 1] <= W0_data[116];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[117])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h75 +: 1] <= W0_data[117];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[118])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h76 +: 1] <= W0_data[118];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[119])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h77 +: 1] <= W0_data[119];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[120])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h78 +: 1] <= W0_data[120];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[121])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h79 +: 1] <= W0_data[121];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[122])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h7A +: 1] <= W0_data[122];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[123])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h7B +: 1] <= W0_data[123];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[124])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h7C +: 1] <= W0_data[124];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[125])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h7D +: 1] <= W0_data[125];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[126])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h7E +: 1] <= W0_data[126];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    if (W0_en & W0_mask[127])	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      Memory[W0_addr][32'h7F +: 1] <= W0_data[127];	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_MEM_	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    reg [127:0] _RANDOM_MEM;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
    initial begin	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      `INIT_RANDOM_PROLOG_	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      `ifdef RANDOMIZE_MEM_INIT	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
        for (logic [6:0] i = 7'h0; i < 7'h40; i += 7'h1) begin
          for (logic [7:0] j = 8'h0; j < 8'h80; j += 8'h20) begin
            _RANDOM_MEM[j +: 32] = `RANDOM;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
          end	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
          Memory[i[5:0]] = _RANDOM_MEM;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
        end	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
      `endif // RANDOMIZE_MEM_INIT
    end // initial
  `endif // ENABLE_INITIAL_MEM_
  assign R0_data = R0_en ? Memory[R0_addr] : 128'bx;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
  assign R1_data = R1_en ? Memory[R1_addr] : 128'bx;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
  assign R2_data = R2_en ? Memory[R2_addr] : 128'bx;	// @[generators/saturn/src/main/scala/backend/RegisterFile.scala:62:16]
endmodule

