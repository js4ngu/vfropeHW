package vfrope

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import chisel3.experimental.FixedPoint

class RoPEfrontCoreTest extends AnyFlatSpec with ChiselScalatestTester {
  "RoPE_core_FP32" should "run first" in {
    test(new RoPEfrontCore(32, 28)) { dut =>
      val testCases = Seq(
        (1, 1, 2*math.Pi, 4, 2)
      )
      for ((x1, x2, theta, m, i) <- testCases) {
        println(s"===== TEST CASE ====")
        println(s"x1, x2, theta = $x1, $x2, $theta, m = $m, i = $i")
        dut.io.theta.poke(FixedPoint.fromDouble(theta, 32.W, 28.BP))  // Increased width to accommodate theta
        dut.io.x1.poke(x1.S)  // Poke m as UInt
        dut.io.x2.poke(x2.S)  // Poke i as UInt
        dut.io.m.poke(m.U)  // Poke m as UInt
        dut.io.i.poke(i.U)  // Poke i as UInt

        // Step the clock to simulate one cycle
        dut.clock.step(6)
      }
    }
  }
}

/*
class RoPEBackCoreTest extends AnyFlatSpec with ChiselScalatestTester {
  "RoPE_core_FP32" should "run first" in {
    test(new RoPEBackCore(32, 30)) { dut =>
      val testCases = Seq(
        (10, 10, -1, 1)
      )
      for ((x1, x2, sin, cos) <- testCases) {
        println(s"===== TEST CASE ====")
        println(s"x1, x2, sin, cos = $x1, $x2, $sin, $cos")
        dut.io.x1.poke(x1.U)  // Poke m as UInt
        dut.io.x2.poke(x2.U)  // Poke i as UInt
        dut.io.sin.poke(FixedPoint.fromDouble(sin, 32.W, 30.BP))  // Increased width to accommodate theta
        dut.io.cos.poke(FixedPoint.fromDouble(cos, 32.W, 30.BP))  // Increased width to accommodate theta

        // Step the clock to simulate one cycle
        dut.clock.step(3)
      }
    }
  }
}
*/