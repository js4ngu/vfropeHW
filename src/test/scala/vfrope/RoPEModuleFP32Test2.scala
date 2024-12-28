package vfrope
import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class FP32radCaclSeqInputTestV2 extends AnyFlatSpec with ChiselScalatestTester {
  "FP32angleCaclulatorTest" should "Seq Input : Test throughput" in {
    test(new FP32radianCaclulatorV2(LutSize = 12, LutHalfSizeHEX = 0x45000000, Index = 0))
    .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      case class TestCase(resMode: String, x1: String, x2: String, m: String, baseIndex: String, expected: String)
      
      val testCases = Seq(
        //TestCase("1", "100", "100", "1", "1", "1"),
        //TestCase("1", "100", "100", "355", "153", "1067"),
        TestCase("1", "100", "100", "4000", "3", "3808"),
        //TestCase("1", "100", "100", "4096", "1", "0")
      )
      
      for (test <- testCases) {
        dut.io.ResMode.poke(BigInt(test.resMode, 16).U)
        dut.io.x(0).poke(BigInt(test.x1).U)
        dut.io.x(1).poke(BigInt(test.x2).U)
        dut.io.m.poke(BigInt(test.m).U)
        dut.io.baseIndex.poke(BigInt(test.baseIndex).U)
        dut.io.EN.poke(true.B)
        
        dut.clock.step()
        dut.io.EN.poke(false.B)
        dut.clock.step()  // Wait for pipeline
        
        // Verify output
        //dut.io.out.expect(BigInt(test.expected).U)
        //dut.io.ENout.expect(true.B)
        //dut.io.xFWD(0).expect(BigInt(test.x1).U)
        //dut.io.xFWD(1).expect(BigInt(test.x2).U)
      }
      dut.clock.step(10)  // Wait for pipeline~
    }
  }
}

class multiLaneRoPEmoduleTestV2 extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "multiLaneRoPEmodule"
  it should "calculate angles correctly" in {
    test(new multiLaneRoPEmoduleV2(N = 2, Index = 0, LutSize = 12, LutHalfSizeHEX = 0x45000000, doublePi = 4096, OneAndHalfPi = 3072, Pi = 2048, halfPi = 1024))
      .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      
      val testCases = Seq(
        ("3F800000", "40000000",  10,  1,  512, "40400000", "40800000",  10,  2, 512, "RoPE Test #1 for Paper"),
        ("40A00000", "40C00000",  10,  3,  512, "40E00000", "41000000",  10,  4, 512, "RoPE Test #2 for Paper"),
      )
      val delay = 0

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

