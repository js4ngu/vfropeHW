package vfrope

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class SerialDataRepeaterTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "SerialDataRepeater"
  
  it should "repeat each input for two clock cycles" in {
    test(new SerialDataRepeater).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val inputs = Seq(
        (1, 2, 10, 20),
        (3, 4,  9, 19),
        (5, 6,  8, 18),
        (7, 8,  7, 17),
        (9, 10, 6, 16)
      )
      
      for ((in0, in1, cos, sin) <- inputs) {
        // 데이터 입력 클럭
        dut.io.xIn(0).poke(in0.U)
        dut.io.xIn(1).poke(in1.U)
        dut.io.cosIn.poke(cos.U)
        dut.io.sinIn.poke(sin.U)
        dut.clock.step(1)
        
        // 유휴 클럭
        dut.io.xIn(0).poke(0.U)
        dut.io.xIn(1).poke(0.U)
        dut.io.cosIn.poke(0.U)
        dut.io.sinIn.poke(0.U)

        dut.clock.step(1)
      }
      
      dut.clock.step(2)
    }
  }
}