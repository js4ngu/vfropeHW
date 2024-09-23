package vfrope
import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

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
      dut.clock.step(11)
    }
  }
  "RoPEModule Test #2" should "work" in {
    test(new FP32angleCaclulator(LutSize = 12)) { dut =>
      val theta = "447A0000" // 1000
      dut.io.theta.poke(BigInt(theta, 16).U)
      dut.io.m.poke(51.U)  //51
      dut.io.i.poke(100.U)  //100 mi expect 1004
      dut.io.EN.poke(1.B)
      dut.clock.step(1)
      dut.io.EN.poke(0.B)
      dut.clock.step(12)
      //expect 480 43F00000
    }
  }
}
