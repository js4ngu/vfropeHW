package vfrope

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class RoPEModuleTester extends AnyFlatSpec with ChiselScalatestTester {
  "RoPEModule" should "work" in {
    test(new RoPEModule(width = 8)) { dut =>
      dut.io.m.poke(2.U)
      dut.io.theta.poke(1.U)
      dut.io.i.poke(1.U)
      dut.clock.step(1)
      dut.io.out.expect(2.U)
    }
  }
}
