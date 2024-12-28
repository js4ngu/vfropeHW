package vfrope

import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import java.lang.Float

class RoPEFMATest extends AnyFlatSpec with ChiselScalatestTester {
  "RoPEFMA" should "pass pipeline test cases" in {
    test(new fmaROPE).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // Multiple test cases for pipeline testing
      val testCases = Seq(
        // x1,        x2,        sin,       cos,       expected_x0, expected_x1
        ("3f800000", "40000000", "3e4ccccd", "3f4ccccd", "00000000", "41000000"), // Case 1: First input
        //("40000000", "40400000", "3e4ccccd", "3f4ccccd", "00000000", "41100000"), // Case 2: Second input
        //("40400000", "40800000", "3e4ccccd", "3f4ccccd", "00000000", "41200000")  // Case 3: Third input
      )

      println("\nStarting Pipeline Test...")
      println("=====================================================================================")

      // Input all test cases in consecutive cycles
      for (((x1, x2, sin, cos, expected_x0, expected_x1), i) <- testCases.zipWithIndex) {
        // Print current test case
        val xIn0 = Float.intBitsToFloat(BigInt(x1, 16).toInt)
        val xIn1 = Float.intBitsToFloat(BigInt(x2, 16).toInt)
        val sinIn = Float.intBitsToFloat(BigInt(sin, 16).toInt)
        val cosIn = Float.intBitsToFloat(BigInt(cos, 16).toInt)
        
        println(s"\nTest Case ${i + 1}:")
        println(f"Inputs -> xIn(0): $xIn0%.6f, xIn(1): $xIn1%.6f, sinIn: $sinIn%.6f, cosIn: $cosIn%.6f")

        // Apply inputs
        dut.io.ENin.poke(true.B)
        dut.io.xIn(0).poke(BigInt(x1, 16).U)
        dut.io.xIn(1).poke(BigInt(x2, 16).U)
        dut.io.sinIn.poke(BigInt(sin, 16).U)
        dut.io.cosIn.poke(BigInt(cos, 16).U)

        // Step one clock cycle
        dut.clock.step(1)

        // Check if any outputs are valid
        if (dut.io.ENout.peek().litToBoolean) {
          val xOut0 = Float.intBitsToFloat(dut.io.xOut(0).peek().litValue.toInt)
          val xOut1 = Float.intBitsToFloat(dut.io.xOut(1).peek().litValue.toInt)
          println(f"Got output -> xOut(0): $xOut0%.6f, xOut(1): $xOut1%.6f")
        }
      }

      // Continue stepping until we get all outputs
      var remaining_outputs = testCases.length
      var cycles = 0
      val max_cycles = 20  // Maximum cycles to wait

      while (remaining_outputs > 0 && cycles < max_cycles) {
        dut.io.ENin.poke(false.B)
        dut.clock.step(1)
        cycles += 1

        if (dut.io.ENout.peek().litToBoolean) {
          val xOut0 = Float.intBitsToFloat(dut.io.xOut(0).peek().litValue.toInt)
          val xOut1 = Float.intBitsToFloat(dut.io.xOut(1).peek().litValue.toInt)
          println(f"Got output -> xOut(0): $xOut0%.6f, xOut(1): $xOut1%.6f")
          remaining_outputs -= 1
        }
      }

      println("\nTest completed after " + cycles + " additional cycles")
      println("=====================================================================================")
    }
  }
}