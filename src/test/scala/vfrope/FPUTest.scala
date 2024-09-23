package vfrope

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import hardfloat._

class FP32AdderTest extends AnyFlatSpec with ChiselScalatestTester {
  "FP32Adder" should "add two floating-point numbers correctly" in {
    test(new FP32Adder) { dut =>
        val inputA = "3fc00000" // 1.5 in IEEE 754 format
        val inputB = "40080000" // 2.25 in IEEE 754 format
        val expectedResult = "40400000" // 3.75 in IEEE 754 format

        dut.io.a.poke(BigInt(inputA, 16).U)
        dut.io.b.poke(BigInt(inputB, 16).U)

        // Step simulation
        dut.clock.step()

        // Check the final result
        dut.io.result.expect(BigInt(expectedResult, 16).U)
    }
  }
}
