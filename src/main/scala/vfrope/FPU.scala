package vfrope

import chisel3._
import hardfloat._


class FP32Adder extends Module {
  val io = IO(new Bundle {
    val a      = Input(UInt(32.W))  // Input floating-point number in IEEE 754 format
    val b      = Input(UInt(32.W))  // Input floating-point number in IEEE 754 format
    val result = Output(UInt(32.W)) // Result in IEEE 754 format
  })

  // Create a floating-point adder for 32-bit floating-point numbers
  val adder = Module(new AddRecFN(8, 24)) // 8 exponent bits, 24 mantissa bits

  // Convert inputs to RecFN format (required by HardFloat)
  val aRecFN = Module(new INToRecFN(8, 24, 32)) // Convert input a
  val bRecFN = Module(new INToRecFN(8, 24, 32)) // Convert input b

  // Initialize inputs to RecFN conversion modules
  aRecFN.io.in := io.a
  bRecFN.io.in := io.b
  aRecFN.io.signedIn := false.B
  bRecFN.io.signedIn := false.B

  // Initialize control signals for rounding and tininess detection
  aRecFN.io.roundingMode := 0.U // Round to nearest even
  aRecFN.io.detectTininess := false.B
  bRecFN.io.roundingMode := 0.U // Round to nearest even
  bRecFN.io.detectTininess := false.B

  // Connect the inputs to the adder
  adder.io.a := aRecFN.io.out
  adder.io.b := bRecFN.io.out
  adder.io.subOp := false.B // Perform addition (set to true for subtraction)
  adder.io.roundingMode := 0.U // Round to nearest even
  adder.io.detectTininess := false.B

  // Convert the result back to IEEE 754 format
  val resultRecFN = Module(new RecFNToIN(8, 24, 32))
  resultRecFN.io.in := adder.io.out
  resultRecFN.io.roundingMode := 0.U
  resultRecFN.io.signedOut := false.B

  // Output the result
  io.result := resultRecFN.io.out

  // Print internal signals
  printf(p"Input A (IEEE 754): ${io.a}\n")
  printf(p"Input B (IEEE 754): ${io.b}\n")
  printf(p"RecFN A: ${aRecFN.io.out}\n")
  printf(p"RecFN B: ${bRecFN.io.out}\n")
  printf(p"Adder Output: ${adder.io.out}\n")
  printf(p"Final Result (IEEE 754): ${io.result}\n")
}
