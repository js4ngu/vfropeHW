package vfrope

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import chisel3.experimental.FixedPoint

class RoPEfrontCoreTest extends AnyFlatSpec with ChiselScalatestTester {
  "RoPE_core_FP32" should "run first" in {
    test(new RoPEfrontCore(32, 28, 12)) { dut =>
      val testCases = Seq(
        (1, 1, 1.5,  1,   3),
        (1, 1, 2.0, 10,  81),
        (1, 1, 2.5, 10,  81),
        (1, 1, 2.25, 10, 81),
        (1, 1,  1.9,  1,  1)
        //차라리 instruction에서 pi를 빼고 넣어주면 어떰? 말된다. 그럼 하드웨어 레벨에서 계산하기 쉬워짐 -> code 수정 불가피
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
        dut.clock.step()
      }
    }
  }
}

class RoPEBackCoreTest extends AnyFlatSpec with ChiselScalatestTester {
  "RoPE_core_FP32" should "run first" in {
    test(new RoPEBackCore(32, 28)) { dut =>
      val testCases = Seq(
        (10, 10, -1, 1),
        (10, 10, -1, 2)
      )
      for ((x1, x2, sin, cos) <- testCases) {
        println(s"===== TEST CASE ====")
        println(s"x1, x2, sin, cos = $x1, $x2, $sin, $cos")
        dut.io.x1.poke(x1.S)  // Poke m as UInt
        dut.io.x2.poke(x2.S)  // Poke i as UInt
        dut.io.sin.poke(FixedPoint.fromDouble(sin, 32.W, 28.BP))  // Increased width to accommodate theta
        dut.io.cos.poke(FixedPoint.fromDouble(cos, 32.W, 28.BP))  // Increased width to accommodate theta

        // Step the clock to simulate one cycle
        dut.clock.step()
      }
    }
  }
}

class RoPEcoreInnerLUTtest extends AnyFlatSpec with ChiselScalatestTester {
  "RoPEcoreInnerLUT" should "run first" in {
    test(new RoPEcoreInnerLUT(32, 28, 12)) { dut =>
      val testCases = Seq(
        (1, 1, 1.5,  1,   3)/*,
        (1, 1, 2.0, 10,  81),
        (1, 1, 2.5, 10,  81),
        (1, 1, 2.25, 10, 81),
        (1, 1,  1.9,  1,  1)*/
        //차라리 instruction에서 pi를 빼고 넣어주면 어떰? 말된다. 그럼 하드웨어 레벨에서 계산하기 쉬워짐 -> code 수정 불가피
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
        dut.clock.step(2)
      }
    }
  }
}
