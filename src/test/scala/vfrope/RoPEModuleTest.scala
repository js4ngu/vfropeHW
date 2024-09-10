package vfrope

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class RoPEModuleTester extends AnyFlatSpec with ChiselScalatestTester {
  "RoPEModule" should "work" in {
    test(new RoPEModule_Int(width = 8)) { dut =>
      dut.io.m.poke(0.U)
      dut.io.theta.poke(0.U)
      dut.io.i.poke(0.U)
      dut.io.in(0).poke(1.U)
      dut.io.in(1).poke(1.U)
      dut.clock.step(10)

      // Fetch io.out(0) and io.out(1) values and print them correctly
      val out0 = dut.io.out(0).peek().litValue()
      val out1 = dut.io.out(1).peek().litValue()

      // Use string interpolation to print values
      println(s"RoPE module out : $out0, $out1")
    }
  }
}
