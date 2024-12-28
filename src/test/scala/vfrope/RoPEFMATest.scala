package vfrope

import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import java.lang.Float

class RoPEFMATest extends AnyFlatSpec with ChiselScalatestTester {
  "RoPEFMA" should "pass test cases" in {
    test(new fmaROPE).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val testCases = Seq(
        ("3f800000", "40000000", "3e4ccccd", "3f4ccccd", "00000000", "41000000")
        // Add more test cases as needed
      )

      // Test each case
      for ((x1, x2, sin, cos, x2hat, x1hat) <- testCases) {
        // Initial input
        dut.io.ENin.poke(true.B)
        dut.io.xIn(0).poke(BigInt(x1, 16).U)
        dut.io.xIn(1).poke(BigInt(x2, 16).U)
        dut.io.sinIn.poke(BigInt(sin, 16).U)
        dut.io.cosIn.poke(BigInt(cos, 16).U)

        // Print input values
        val xIn0 = Float.intBitsToFloat(BigInt(x1, 16).toInt)
        val xIn1 = Float.intBitsToFloat(BigInt(x2, 16).toInt)
        val sinIn = Float.intBitsToFloat(BigInt(sin, 16).toInt)
        val cosIn = Float.intBitsToFloat(BigInt(cos, 16).toInt)
        
        println("=====================================================================================")
        println(f"Inputs -> xIn(0): $xIn0%.6f, xIn(1): $xIn1%.6f, sinIn: $sinIn%.6f, cosIn: $cosIn%.6f")

        // Wait for pipeline stages
        var cycles = 0
        while (!dut.io.ENout.peek().litToBoolean && cycles < 10) {
          dut.clock.step(1)
          cycles += 1
        }

        // When output is valid, check results
        if (dut.io.ENout.peek().litToBoolean) {
          val xOut0 = Float.intBitsToFloat(dut.io.xOut(0).peek().litValue.toInt)
          val xOut1 = Float.intBitsToFloat(dut.io.xOut(1).peek().litValue.toInt)
          println(f"Outputs -> xOut(0): $xOut0%.6f, xOut(1): $xOut1%.6f")
        }

        // Reset ENin and wait a few cycles
        dut.io.ENin.poke(false.B)
        dut.clock.step(5)
      }
    }
  }
}