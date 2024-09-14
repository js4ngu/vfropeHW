package vfrope

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.Sequential
import chisel3.experimental.FixedPoint

// Combined Test Suite for FP16 add, FP32 add, FP16 mult, and FP32 mult
class CombinedTestSuite extends AnyFlatSpec with ChiselScalatestTester {

  "FP16 Add" should "run first" in {
    println("\n===== FP16 Add Results =====")
    test(new FPadder(16, 8)) { dut =>
      val testCases = Seq(
        (1.5, 2.25, 3.75),
        (-1.5, 2.25, 0.75),
        (3.25, -1.75, 1.5),
        (-2.5, -1.75, -4.25)
      )
      for ((a, b, expected) <- testCases) {
        dut.io.a.poke(FixedPoint.fromDouble(a, 16.W, 8.BP))
        dut.io.b.poke(FixedPoint.fromDouble(b, 16.W, 8.BP))
        dut.clock.step()

        val res = dut.io.out.peek().litValue().toDouble / (1L << 8)
        println(s"a: $a, b: $b, expected: $expected, res: $res ")
      }
    }
  }

  "FP32 Add" should "run second" in {
    println("\n===== FP32 Add Results =====")
    test(new FPadder(32, 16)) { dut =>
      val testCases = Seq(
        (1.5, 2.25, 3.75),
        (-1.5, 2.25, 0.75),
        (3.25, -1.75, 1.5),
        (-2.5, -1.75, -4.25)
      )
      for ((a, b, expected) <- testCases) {
        dut.io.a.poke(FixedPoint.fromDouble(a, 32.W, 16.BP))
        dut.io.b.poke(FixedPoint.fromDouble(b, 32.W, 16.BP))
        dut.clock.step()

        val res = dut.io.out.peek().litValue().toDouble / (1L << 16)
        println(s"a: $a, b: $b, expected: $expected, res: $res ")
      }
    }
  }

  "FP16 Mult" should "run third" in {
    println("\n===== FP16 Mult Results =====")
    test(new FPmult(16, 8)) { dut =>
      val testCases = Seq(
        (1.5, 2.25, 3.375),
        (-1.5, 2.25, -3.375),
        (3.25, -1.75, -5.6875),
        (-2.5, -1.75, 4.375)
      )
      for ((a, b, expected) <- testCases) {
        dut.io.a.poke(FixedPoint.fromDouble(a, 16.W, 8.BP))
        dut.io.b.poke(FixedPoint.fromDouble(b, 16.W, 8.BP))
        dut.clock.step()

        val res = dut.io.out.peek().litValue().toDouble / (1L << 16)
        println(s"a: $a, b: $b, expected: $expected, res: $res ")
      }
    }
  }

  "FP32 Mult" should "run fourth" in {
    println("\n===== FP32 Mult Results =====")
    test(new FPmult(32, 16)) { dut =>
      val testCases = Seq(
        (1.5, 2.25, 3.375),
        (-1.5, 2.25, -3.375),
        (3.25, -1.75, -5.6875),
        (-2.5, -1.75, 4.375)
      )
      for ((a, b, expected) <- testCases) {
        dut.io.a.poke(FixedPoint.fromDouble(a, 32.W, 16.BP))  // 32-bit input
        dut.io.b.poke(FixedPoint.fromDouble(b, 32.W, 16.BP))
        dut.clock.step()

        // Result scaling: binary point is 16 + 16 = 32
        val res = dut.io.out.peek().litValue().toDouble / (1L << 32)
        println(s"a: $a, b: $b, expected: $expected, res: $res")
      }
    }
  }
}