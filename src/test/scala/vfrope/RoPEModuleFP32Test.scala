package vfrope
import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import java.lang.Float

class FP32angleCaclulatorTest extends AnyFlatSpec with ChiselScalatestTester {
  "RoPEModule" should "work" in {
    test(new FP32angleCaclulator(LutSize = 12)) { dut =>
      val theta = "3F800000" // 1
      dut.io.theta.poke(BigInt(theta, 16).U)
      dut.io.m.poke(2.U)
      dut.io.i.poke(1.U)
      dut.io.EN.poke(1.B)
      dut.clock.step(1)
      dut.io.EN.poke(0.B)
      dut.clock.step(10)
      val result = dut.io.out.peek().litValue
      val floatResult = Float.intBitsToFloat(result.toInt)
      println(f"Test 1 Result: $floatResult%.6f")
    }
  }

  "RoPEModule Test #2" should "work" in {
    test(new FP32angleCaclulator(LutSize = 12)) { dut =>
      val theta = "447A0000" // 1000
      dut.io.theta.poke(BigInt(theta, 16).U)
      dut.io.m.poke(51.U)  // 51
      dut.io.i.poke(100.U) // 100
      dut.io.EN.poke(1.B)
      dut.clock.step(1)
      dut.io.EN.poke(0.B)
      dut.clock.step(10)
      val result = dut.io.out.peek().litValue
      val floatResult = Float.intBitsToFloat(result.toInt)
      println(f"Test 2 Result: $floatResult%.6f")
    }
  }

  "RoPEModule Test #3" should "work" in {
    test(new FP32angleCaclulator(LutSize = 12)) { dut =>
      val theta = "3A000000" // 2/4096
      dut.io.theta.poke(BigInt(theta, 16).U)
      dut.io.m.poke(151.U)
      dut.io.i.poke(70.U)
      dut.io.EN.poke(1.B)
      dut.clock.step(1)
      dut.io.EN.poke(0.B)
      dut.clock.step(10)
      val result = dut.io.out.peek().litValue
      val floatResult = Float.intBitsToFloat(result.toInt)
      println(f"Test 3 Result: $floatResult%.6f")
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
