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
        // x1,        x2,        sin,       cos
        ("3f800000", "40000000", "3e4ccccd", "3f4ccccd"),  // Case 1: 1.0, 2.0
        ("40000000", "40400000", "3e4ccccd", "3f4ccccd"),  // Case 2: 2.0, 3.0
        ("40400000", "40800000", "3e4ccccd", "3f4ccccd"),  // Case 3: 3.0, 4.0
        ("40800000", "40a00000", "3e4ccccd", "3f4ccccd")   // Case 4: 4.0, 5.0
      )

      println("\nStarting Pipeline Test with 2-cycle intervals...")
      println("=====================================================================================")

      // Track outputs and cycles
      var outputCount = 0
      var cycleCount = 0
      val outputs = scala.collection.mutable.ArrayBuffer[(Float, Float)]()

      // Process all test cases
      for ((x1, x2, sin, cos) <- testCases) {
        // Print current input
        val xIn0 = Float.intBitsToFloat(BigInt(x1, 16).toInt)
        val xIn1 = Float.intBitsToFloat(BigInt(x2, 16).toInt)
        val sinIn = Float.intBitsToFloat(BigInt(sin, 16).toInt)
        val cosIn = Float.intBitsToFloat(BigInt(cos, 16).toInt)
        
        println(s"\nCycle $cycleCount")
        println(f"Sending input -> xIn(0): $xIn0%.6f, xIn(1): $xIn1%.6f, sinIn: $sinIn%.6f, cosIn: $cosIn%.6f")

        // Apply inputs
        dut.io.ENin.poke(true.B)
        dut.io.xIn(0).poke(BigInt(x1, 16).U)
        dut.io.xIn(1).poke(BigInt(x2, 16).U)
        dut.io.sinIn.poke(BigInt(sin, 16).U)
        dut.io.cosIn.poke(BigInt(cos, 16).U)
        
        // Step one clock
        dut.clock.step(1)
        cycleCount += 1
        
        // Deassert ENin and wait one more clock
        dut.io.ENin.poke(false.B)
        dut.io.xIn(0).poke(0.U)
        dut.io.xIn(1).poke(0.U)
        dut.io.sinIn.poke(0.U)
        dut.io.cosIn.poke(0.U)
        dut.clock.step(7)
        cycleCount += 7

        // Check for any valid outputs
        if (dut.io.ENout.peek().litToBoolean) {
          val xOut0 = Float.intBitsToFloat(dut.io.xOut(0).peek().litValue.toInt)
          val xOut1 = Float.intBitsToFloat(dut.io.xOut(1).peek().litValue.toInt)
          outputs.append((xOut0, xOut1))
          outputCount += 1
          println(f"Got output ${outputCount} -> xOut(0): $xOut0%.6f, xOut(1): $xOut1%.6f")
        }
      }

      // Continue stepping until we get all outputs
      val maxAdditionalCycles = 20
      var additionalCycles = 0
      while (outputCount < testCases.length && additionalCycles < maxAdditionalCycles) {
        dut.clock.step(1)
        cycleCount += 1
        additionalCycles += 1

        if (dut.io.ENout.peek().litToBoolean) {
          val xOut0 = Float.intBitsToFloat(dut.io.xOut(0).peek().litValue.toInt)
          val xOut1 = Float.intBitsToFloat(dut.io.xOut(1).peek().litValue.toInt)
          outputs.append((xOut0, xOut1))
          outputCount += 1
          println(f"\nGot output ${outputCount} -> xOut(0): $xOut0%.6f, xOut(1): $xOut1%.6f")
        }
      }

      println("\nTest Summary:")
      println(s"Total inputs processed: ${testCases.length}")
      println(s"Total outputs received: ${outputs.length}")
      println(s"Total cycles taken: $cycleCount")
      println("=====================================================================================")
    }
  }
}