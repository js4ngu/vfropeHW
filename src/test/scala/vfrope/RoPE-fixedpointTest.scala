package vfrope

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import chisel3.experimental.FixedPoint

class RoPE_core_FP32Test extends AnyFlatSpec with ChiselScalatestTester {
  "RoPE_core_FP32" should "run first" in {
    test(new RoPEcore(32, 22)) { dut =>
      val testCases = Seq(
        (1.5, 25, 4)
      )
      for ((theta, m, i) <- testCases) {
        println(s"===== TEST CASE ====")
        println(s"Poking values: theta = $theta, m = $m, i = $i")
        dut.io.theta.poke(FixedPoint.fromDouble(theta, 32.W, 22.BP))  // Increased width to accommodate theta
        dut.io.m.poke(m.U)  // Poke m as UInt
        dut.io.i.poke(i.U)  // Poke i as UInt

        // Step the clock to simulate one cycle
        dut.clock.step(3)
      }
    }
  }
}
