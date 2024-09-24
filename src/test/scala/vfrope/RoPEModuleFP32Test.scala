package vfrope
import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class FP32angleCaclulatorTest extends AnyFlatSpec with ChiselScalatestTester {
  "FP32angleCaclulatorTest" should "work for various test cases" in {
    test(new FP32angleCaclulator(LutSize = 12)) { dut =>
      val testCases = Seq(
        ("3F800000",  2,   1, BigInt("40000000", 16).U),  // theta = 1, m = 2, i = 1
        ("447A0000", 51, 100, BigInt("43F00000", 16).U)  // theta = 1000, m = 51, i = 100
      )

      for ((theta, m, i, expected) <- testCases) {
        dut.io.theta.poke(BigInt(theta, 16).U)
        dut.io.m.poke(m.U)
        dut.io.i.poke(i.U)
        dut.io.EN.poke(1.B)
        dut.clock.step(1)
        dut.io.EN.poke(0.B)
        dut.clock.step(10)
        dut.io.out.expect(expected)
        dut.clock.step(2)
        println("------------------------------------------------------")
      }
    }
  }
}

class FP32RoPEcoreTest extends AnyFlatSpec with ChiselScalatestTester {
  "FP32RoPEcoreTest" should "FP32RoPEcoreTest" in {
    test(new FP32RoPEcore()) { dut =>
      val testCases = Seq(
        ("3F800000", "3F800000", "3F800000", "3F800000", "00000000", "40000000"),
        ("40000000", "40000000", "40000000", "40000000", "00000000", "41000000")
      )

      for ((x1, x2, sin, cos, x2hat, x1hat) <- testCases) {
        dut.io.x(0).poke(BigInt(x1, 16).U)
        dut.io.x(1).poke(BigInt(x2, 16).U)

        dut.io.sin.poke(BigInt(sin, 16).U)
        dut.io.cos.poke(BigInt(cos, 16).U)
        dut.io.EN.poke(1.B)
        dut.clock.step(1)
        dut.io.EN.poke(0.B)
        dut.clock.step(3)
      }
    }
  }
}
