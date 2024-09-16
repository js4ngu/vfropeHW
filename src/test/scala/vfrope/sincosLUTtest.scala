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

/*
class SinCosLUTTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "SinCosLUT"

  it should "calculate sin and cos correctly for various angles" in {
    test(new SinCosLUT(lutSize = 1024)) { dut =>
      def toFixedPoint(d: Double): BigInt = {
        val scaled = (d * (1L << 22)).round
        if (scaled >= 0) scaled else scaled + (1L << 32)
      }

      def fromFixedPoint(bits: BigInt): Double = {
        val signed = if (bits >= (1L << 31)) bits - (1L << 32) else bits
        signed.toDouble / (1L << 22)
      }

      def approxEqual(a: Double, b: Double, tolerance: Double = 0.01): Boolean = {
        (a - b).abs < tolerance
      }

      val testAngles = Seq( 0, 2* math.Pi/8, 2* math.Pi/7, 2* math.Pi/6,
                               2* math.Pi/5, 2* math.Pi/4, 2* math.Pi/3,
                               2* math.Pi/2, 2* math.Pi)

      for (angle <- testAngles) {
        val fixedAngle = toFixedPoint(angle)
        dut.io.angle.poke(FixedPoint.fromBigInt(fixedAngle, 32.W, 22.BP))
        dut.clock.step()
        
        val sinResult = fromFixedPoint(dut.io.sin.peek().litValue)
        val cosResult = fromFixedPoint(dut.io.cos.peek().litValue)
        
        val expectedSin = math.sin(angle)
        val expectedCos = math.cos(angle)
        
        println(f"Angle: $angle%.4f, Sin: $sinResult%.4f (expected: $expectedSin%.4f), Cos: $cosResult%.4f (expected: $expectedCos%.4f)")
      }
    }
  }
}
*/