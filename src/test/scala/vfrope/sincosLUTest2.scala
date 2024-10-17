package vfrope
import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import java.lang.Float

class DualPortMemorySpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "dualPortCOSlut"

  it should "generate VCD for sine and cosine calculations" in {
    test(new dualPortCOSlut()).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // Helper function to convert float to hex string
      def floatToHex(f: Float): String = {
        f"${java.lang.Float.floatToIntBits(f)}%08X".U.toString
      }

      // Test cases: (cosIndex, sinIndex, cosSign, sinSign)
      val testCases = Seq(
        (   0, 1024,  false,  true),  // 0 degrees, 90 degrees
        ( 512,  512,  false, false),  // 45 degrees, 45 degrees
        (1024,    0,   true, false),  // 90 degrees, 0 degrees
        (1536,  1536,  true,  true),  // 135 degrees, 135 degrees
        (2048,  2048, false,  true),   // 180 degrees, 180 degrees
        (512,    512,   true, false),  // 90 degrees, 0 degrees
      )

      for ((cosIndex, sinIndex, cosSign, sinSign) <- testCases) {
        dut.io.EN.poke(true.B)
        dut.io.x(0).poke(1.U)
        dut.io.x(1).poke(2.U)
        dut.io.cosIndex.poke(cosIndex.U)
        dut.io.sinIndex.poke(sinIndex.U)
        dut.io.sign(0).poke(cosSign.B)
        dut.io.sign(1).poke(sinSign.B)
        println(f"Cos($cosIndex%d): ${dut.io.cosOut.peek().litValue}%X")
        println(f"Sin($sinIndex%d): ${dut.io.sinOut.peek().litValue}%X")
        println(f"ENout: ${dut.io.ENout.peek().litToBoolean}")
        println("--------------------")
        dut.clock.step()
      }
      dut.io.EN.poke(false.B)
      dut.clock.step(10)
      println(f"EN off - Cos: ${dut.io.cosOut.peek().litValue}%X")
      println(f"EN off - Sin: ${dut.io.sinOut.peek().litValue}%X")
      println(f"EN off - ENout: ${dut.io.ENout.peek().litToBoolean}")
    }
  }
}
