package vfrope
import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class multiLaneFMARoPETest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "multiLaneFMARoPETest"
  it should "calculate angles correctly" in {
    test(new multiLaneFMARoPE(N = 2, Index = 0, LutSize = 12, LutHalfSizeHEX = 0x45000000, doublePi = 4096, OneAndHalfPi = 3072, Pi = 2048, halfPi = 1024))
      .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      
      val testCases = Seq(
        ("3F800000", "40000000",  10,  1,  512, "40400000", "40800000",  10,  2, 512, "RoPE Test #1 for Paper"),
        ("40A00000", "40C00000",  10,  3,  512, "40E00000", "41000000",  10,  4, 512, "RoPE Test #2 for Paper"),
      )
      val delay = 7

      for ((ax0, ax1, am, abaseIndex, aresMode, bx0, bx1, bm, bbaseIndex, bresMode, testName) <- testCases) {
        println(s"\nRunning $testName")
        
        // Lane 0 inputs
        dut.io.x(0)(0).poke(BigInt(ax0, 16).U)
        dut.io.x(0)(1).poke(BigInt(ax1, 16).U)
        dut.io.m(0).poke(am.U)
        dut.io.baseIndex(0).poke(abaseIndex.U)
        dut.io.ResMode(0).poke(aresMode.U)

        // Lane 1 inputs
        dut.io.x(1)(0).poke(BigInt(bx0, 16).U)
        dut.io.x(1)(1).poke(BigInt(bx1, 16).U)
        dut.io.m(1).poke(bm.U)
        dut.io.baseIndex(1).poke(bbaseIndex.U)
        dut.io.ResMode(1).poke(bresMode.U)

        dut.io.EN.poke(true.B)
        dut.clock.step(1)
        dut.io.EN.poke(false.B)
        dut.clock.step(delay)
      }
      dut.clock.step(20)
    }
  }
}

