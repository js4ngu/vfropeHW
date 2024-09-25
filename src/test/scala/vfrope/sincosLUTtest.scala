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
    test(new SinCosLUT(LutSize = 12, LutHalfSizeHEX = 0x45000000, SinCosOffset = 1024)) { dut =>
      // List of angles to test
      val anglesToTest = Seq("h00000000",   // 0
                             "h3E800000",   //0.25
                             "h3F000000",   // 0.5
                             "h3F400000",   // 0.75
                             "h3F800000",   // 1
                             "h3FA00000",   // 1.25
                             "h3FC00000",   // 1.5
                             "h3FE00000",   // 1.75
                             "h40000000",   // 2
                            )
      // Iterate through each angle
      for (angle <- anglesToTest) {
        dut.io.angle.poke(angle.U)
        dut.clock.step()
        
        // Capture the sine and cosine output
        val rad    = dut.io.angle.peek().litValue().toInt
        val sinOut = dut.io.sinOut.peek().litValue().toInt
        val cosOut = dut.io.cosOut.peek().litValue().toInt

        val floatrad    = Float.intBitsToFloat(rad)
        val floatSinOut = Float.intBitsToFloat(sinOut)
        val floatCosOut = Float.intBitsToFloat(cosOut)
  
        // Print out the results for the angle
        println(f"rad: $floatrad%.6f, Cos: $floatCosOut%.6f, Sin: $floatSinOut%.6f")
        println(s"------------------------")
      }
    }
  }
}

