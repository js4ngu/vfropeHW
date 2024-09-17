package vfrope

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import chisel3.experimental.FixedPoint

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
  it should "calculate sin and cos correctly for various angles" in {
    test(new SinCosLUT(32,28,2048)) { dut =>
      val testAngles = Seq( 0, 256, 512, 1024, 1563, 2048)
      for (angle <- testAngles) {
        dut.io.angle.poke(angle.U)
        val sinOut = dut.io.sin.peek().litValue()
        val cosOut = dut.io.cos.peek().litValue()
        
        // Convert BigInt to Hexadecimal String
        println(f"Angle: $angle, Sin: 0x${sinOut}%x, Cos: 0x${cosOut}%x")
      }
    }
  }
}
