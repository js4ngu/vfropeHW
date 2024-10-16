package vfrope

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import chisel3.experimental.FixedPoint
import java.lang.Float

class SinCosLUTINTTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "SinCosLUT"

  it should "output correct sine and cosine values for a specific angle" in {
    test(new SinCosLUTINT(width = 8)) { dut =>
      // List of angles to test
      //val anglesToTest = Seq(0,10,20,30,40,50,60,64,70,80,90,100,110,120,127,130,140,150,160,170,180,190,200,210,220,230,240,250,255)
      val anglesToTest = Seq(0)

      // Iterate through each angle
      for (angle <- anglesToTest) {
        // Set the input angle
        dut.io.angle.poke(angle.U)

        // Step the clock
        dut.clock.step(10)

        // Capture the sine and cosine output
        val sinOut = dut.io.sinOut.peek().litValue()
        val cosOut = dut.io.cosOut.peek().litValue()

        // Print out the results for the angle
        println(s"Angle: $angle, Sin: $sinOut, Cos: $cosOut")
      }
    }
  }
}

class SinCosLUTTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "SinCosLUT"

  it should "output correct sine and cosine values for a specific angle" in {
    test(new SinCosLUT(LutSize = 12, LutHalfSizeHEX = 0x45000000)) { dut =>
      // List of angles to test
      val anglesToTest = Seq(//"h00000000",   // 0
                             //"h3E800000",   //0.25
                             "h3F000000",   // 0.5
                             //"h3F400000",   // 0.75
                             //"h3F800000",   // 1
                             //"h3FA00000",   // 1.25
                             "h3FC00000",   // 1.5
                             //"h3FE00000",   // 1.75
                             //"h40000000",   // 2
                            )
      // Iterate through each angle
      for (angle <- anglesToTest) {
        dut.io.angle.poke(angle.U)
        dut.io.EN.poke(1.B)
        dut.clock.step()
        dut.io.x(0).poke(100.U)
        dut.io.x(1).poke(100.U)

        // Capture the sine and cosine output
        val xFWD0     = dut.io.xFWD(0).peek().litValue.toInt
        val xFWD1     = dut.io.xFWD(1).peek().litValue.toInt

        val EN     = dut.io.ENout.peek().litValue.toInt
        val rad    = dut.io.angle.peek().litValue().toInt
        val sinOut = dut.io.sinOut.peek().litValue().toInt
        val cosOut = dut.io.cosOut.peek().litValue().toInt

        val floatrad    = Float.intBitsToFloat(rad)
        val floatSinOut = Float.intBitsToFloat(sinOut)
        val floatCosOut = Float.intBitsToFloat(cosOut)
  
        // Print out the results for the angle
        println(f"[$EN] rad: $floatrad%.6f, Cos: $floatCosOut%.6f, Sin: $floatSinOut%.6f")

        dut.io.EN.poke(0.B)
        dut.clock.step()
      }
    }
  }
}

class SinCosLUT2Test extends AnyFlatSpec with ChiselScalatestTester {
  "SinCosLUT2Test SEQ" should "Seq Input : Test throughput" in {
    test(new smallSinCosLUT(LutSize = 12, LutHalfSizeHEX = 0x45000000))
    .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val anglesToTest = Seq("h00000000",   // 0
                             "h3DCCCCCD",
                             "h3E4CCCCD",
                             "h3E800000",   //0.25
                             "h3E99999A",
                             "h3ECCCCCD",
                             "h3F000000",   // 0.5
                             "h3F19999A",
                             "h3F333333",
                             "h3F400000",   // 0.75
                             "h3F4CCCCD",
                             "h3F666666",
                             "h3F800000",   // 1
                             "h3F8CCCCD",
                             "h3F99999A",
                             "h3FA00000",   // 1.25
                             "h3FA66666",
                             "h3FB33333",
                             "h3FC00000",   // 1.5
                             "h3FCCCCCD",
                             "h3FD9999A",
                             "h3FE00000",   // 1.75
                             "h3FE66666",
                             "h3FF33333",
                             "h40000000",   // 2
                            )
      val delay = 0

      for (angle <- anglesToTest) {
        dut.io.angle.poke(angle.U)
        dut.io.x(0).poke(100.U)
        dut.io.x(1).poke(100.U)
        dut.io.EN.poke(true.B)
        dut.clock.step(1)
        dut.io.EN.poke(false.B)
        dut.clock.step(delay)
      }
    }
  }
}

/*
//SinCos LUT 시퀀셜 인풋 테스트코드
class FP32rSinCosSeqInputTest extends AnyFlatSpec with ChiselScalatestTester {
  "FP32rSinCosSeqInputTest" should "Seq Input : Test throughput" in {
    test(new SinCosLUT(LutSize = 12, LutHalfSizeHEX = 0x45000000))
    .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val anglesToTest = Seq("h00000000",   //0     -> (Cos,Sin) : 1.0, 0.0
                             "h3E800000",   //0.25  -> (Cos,Sin) : 0.7, 0.7
                             "h3F000000"    //0.5   -> (Cos,Sin) : 0.0, 1.0
                            )
      val delay = 0

      for (angle <- anglesToTest) {
        dut.io.angle.poke(angle.U)
        dut.io.x(0).poke(100.U)
        dut.io.x(1).poke(100.U)
        dut.io.EN.poke(true.B)
        dut.clock.step(1)
        dut.io.EN.poke(false.B)
        dut.clock.step(delay)
      }
    }
  }
}

class smallSinCosLUT2Test extends AnyFlatSpec with ChiselScalatestTester {
  "smallSinCosLUT2 SEQ" should "Seq Input : Test throughput" in {
    test(new smallSinCosLUT2(LutSize = 12, LutHalfSizeHEX = 0x45000000, doublePi = 4096, OneAndHalfPi = 3072, Pi = 2048, halfPi = 1024))
    .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val anglesToTest = Seq("h00000000",   // 0
                             "h3DCCCCCD",
                             "h3E4CCCCD",
                             "h3E800000",   //0.25
                             "h3E99999A",
                             "h3ECCCCCD",
                             "h3F000000",   // 0.5
                             "h3F19999A",
                             "h3F333333",
                             "h3F400000",   // 0.75
                             "h3F4CCCCD",
                             "h3F666666",
                             "h3F800000",   // 1
                             "h3F8CCCCD",
                             "h3F99999A",
                             "h3FA00000",   // 1.25
                             "h3FA66666",
                             "h3FB33333",
                             "h3FC00000",   // 1.5
                             "h3FCCCCCD",
                             "h3FD9999A",
                             "h3FE00000",   // 1.75
                             "h3FE66666",
                             "h3FF33333",
                             "h40000000",   // 2
                            )
      val delay = 10

      for (angle <- anglesToTest) {
        dut.io.angle.poke(angle.U)
        dut.io.x(0).poke(1.U)
        dut.io.x(1).poke(2.U)
        dut.io.EN.poke(true.B)
        dut.clock.step(1)
        dut.io.EN.poke(false.B)
        dut.clock.step(delay)
      }
    }
  }
}
*/