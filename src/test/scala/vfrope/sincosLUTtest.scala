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
    test(new SinCosLUT(32,28,4096)) { dut =>
      val testAngles = Seq( 0, 0.25, 0.5, 1.0, 1.75, 2.0)
      for (angle <- testAngles) {
        dut.io.angle.poke(FixedPoint.fromDouble(angle, 32.W, 28.BP))
        dut.io.x1.poke(90.S)
        dut.io.x2.poke(10.S)
        dut.io.inEN.poke(1.B)
        dut.clock.step()
        val sinOut = dut.io.sin.peek().litValue()
        val cosOut = dut.io.cos.peek().litValue()
        val  x1hat = dut.io.x1hat.peek().litValue()
        val  x2hat = dut.io.x2hat.peek().litValue()
        val  EN    = dut.io.outEN.peek().litValue()

        // Convert BigInt to Hexadecimal String
        println(f"Angle: $angle, Sin: ${sinOut}%x, Cos: ${cosOut}%x , x1 : ${x1hat}, x2 : ${x2hat}, EN : ${EN}")
        dut.io.inEN.poke(0.B)
        dut.clock.step()
        val sinOut1 = dut.io.sin.peek().litValue()
        val cosOut1 = dut.io.cos.peek().litValue()
        val  x1hat1 = dut.io.x1hat.peek().litValue()
        val  x2hat1 = dut.io.x2hat.peek().litValue()
        val  EN1    = dut.io.outEN.peek().litValue()

        // Convert BigInt to Hexadecimal String
        println(f"Angle: $angle, Sin: ${sinOut1}%x, Cos: ${cosOut1}%x , x1 : ${x1hat1}, x2 : ${x2hat1}, EN : ${EN1}")

      }
    }
  }
}
