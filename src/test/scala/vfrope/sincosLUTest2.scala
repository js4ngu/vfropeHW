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

class dualPortIndexCalculatorTest extends AnyFlatSpec with ChiselScalatestTester {
  "dualPortIndexCalculatorTest" should "Seq Input : Test throughput" in {
    test(new dualPortIndexCalculator(LutSize = 12, LutHalfSizeHEX = 0x45000000, doublePi = 4096, OneAndHalfPi = 3072, Pi = 2048, halfPi = 1024))
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
        dut.io.x(0).poke(1.U)
        dut.io.x(1).poke(2.U)
        dut.io.angle.poke(angle.U)
        dut.io.EN.poke(true.B)
        dut.clock.step(1)
        dut.io.EN.poke(false.B)
        dut.clock.step(delay)
      }
      dut.io.angle.poke("h40000000".U)
      dut.io.EN.poke(true.B)
      dut.clock.step(15)

    } 
  }
}


class dualPortSinCosModuleTest extends AnyFlatSpec with ChiselScalatestTester {
  "dualPortSinCosModuleTest" should "Seq Input : Test throughput" in {
    test(new dualPortSinCosModule(LutSize = 12, LutHalfSizeHEX = 0x45000000, doublePi = 4096, OneAndHalfPi = 3072, Pi = 2048, halfPi = 1024))
    .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val anglesToTest = Seq((0, 1, "h00000000"),   // 0
                             (1, 2, "h3DCCCCCD"),
                             (2, 3, "h3E4CCCCD"),
                             (3, 4, "h3E800000"),   //0.25
                             (4, 5, "h3E99999A"),
                             (5, 6, "h3ECCCCCD"),
                             (6, 7, "h3F000000"),   // 0.5
                             (7, 8, "h3F19999A"),
                             (8, 9, "h3F333333"),
                             (9, 0, "h3F400000"),   // 0.75
                             (0, 1, "h3F4CCCCD"),
                             (1, 2, "h3F666666"),
                             (2, 3, "h3F800000"),   // 1
                             (3, 4, "h3F8CCCCD"),
                             (4, 5, "h3F99999A"),
                             (5, 6, "h3FA00000"),   // 1.25
                             (6, 7, "h3FA66666"),
                             (7, 8, "h3FB33333"),
                             (8, 9, "h3FC00000"),   // 1.5
                             (9, 0, "h3FCCCCCD"),
                             (0, 1, "h3FD9999A"),
                             (1, 2, "h3FE00000"),   // 1.75
                             (2, 3, "h3FE66666"),
                             (3, 4, "h3FF33333"),
                             (4, 5, "h40000000"),   // 2
                            )      
      val delay = 0

      for ((a,b,angle) <- anglesToTest) {
        dut.io.x(0).poke(a.U)
        dut.io.x(1).poke(b.U)
        dut.io.angle.poke(angle.U)
        dut.io.EN.poke(true.B)
        dut.clock.step(1)
        dut.io.EN.poke(false.B)
        dut.clock.step(delay)
      }
      dut.io.angle.poke("h40000000".U)
      dut.io.x(0).poke(99.U)
      dut.io.x(1).poke(99.U)
      dut.io.EN.poke(false.B)
      dut.clock.step(15)
    } 
  }
}

