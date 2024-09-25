package vfrope
import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import java.lang.Float

/*
Test 1 Result: 2.000000
Test 2 Result: 480.000000
Test 3 Result: 5.161133
Test 4 Result: 0.000000
*/

class FP32radianCaclulatorTest extends AnyFlatSpec with ChiselScalatestTester {
  "FP32angleCaclulatorTest" should "calculate angles correctly" in {
    test(new FP32radianCaclulator(LutSize = 12, LutSizeHalfHEX = 0x45000000)) { dut =>
      val testCases = Seq(
        ("3A000000",    1,   1, "Test 1"),  // theta = 2/4096, m = 1,    i = 1    => 0.00048828125
        ("3A000000",  355, 153, "Test 2"),  // theta = 2/4096, m = 355,  i = 153  => 0.52099609375
        ("3A000000", 4000,   3, "Test 3"),  // theta = 2/4096, m = 4000, i = 3    => 1.859375
        ("3A000000", 4096,   1, "Test 4")   // theta = 2/4096, m = 4096, i = 4096 => 0
      )

      for ((theta, m, i, testName) <- testCases) {
        dut.io.theta.poke(BigInt(theta, 16).U)
        dut.io.m.poke(m.U)
        dut.io.i.poke(i.U)
        dut.io.EN.poke(1.B)
        dut.clock.step(1)
        dut.io.EN.poke(0.B)
        dut.clock.step(10)

        val result = dut.io.out.peek().litValue
        val floatResult = Float.intBitsToFloat(result.toInt)
        println(f"$testName Result: $floatResult%.6f")

        // You can add assertions here to check if the result is correct
        // For example:
        // assert(floatResult === expectedResult, f"$testName failed: expected $expectedResult, but got $floatResult")
      }
    }
  }
}


class FP32RoPEcoreTest extends AnyFlatSpec with ChiselScalatestTester {
  "FP32RoPEcoreTest" should "FP32RoPEcoreTest" in {
    test(new FP32RoPEcore()) { dut =>
      val testCases = Seq(
        ("3F800000", "3F800000", "3F800000", "3F800000", "00000000", "40000000"),
        ("40000000", "40000000", "40000000", "40000000", "00000000", "41000000"),
        ("431b0000", "43be8000", "3f4ac083", "3EAF1AA0", "c378bdf4", "437d0fdf"),
        //새로운 케이스
        ("4581C800", "45053000", "BE1CAC08", "3F0A92A3", "4520E0FE", "4401867c"),
        ("4581C800", "45053000", "3E1CAC08", "BF0A92A3", "c520e0fe", "c401867c"),
        ("4581C800", "45053000", "BE1CAC08", "BF0A92A3", "c4f03f3b", "c4df9d6b")

      )

      for ((x1, x2, sin, cos, x2hat, x1hat) <- testCases) {
        dut.io.x(0).poke(BigInt(x1, 16).U)
        dut.io.x(1).poke(BigInt(x2, 16).U)

        dut.io.sin.poke(BigInt(sin, 16).U)
        dut.io.cos.poke(BigInt(cos, 16).U)
        dut.io.EN.poke(1.B)
        dut.clock.step(1)
        dut.io.EN.poke(0.B)
        dut.clock.step(2)
      
        val X0 = dut.io.x(0).peek().litValue
        val X1 = dut.io.x(1).peek().litValue
        val floatX0 = Float.intBitsToFloat(X0.toInt)
        val floatX1 = Float.intBitsToFloat(X1.toInt)

        val SIN = dut.io.sin.peek().litValue
        val COS = dut.io.cos.peek().litValue
        val floatSIN = Float.intBitsToFloat(SIN.toInt)
        val floatCOS = Float.intBitsToFloat(COS.toInt)

        val result0 = dut.io.xhat(0).peek().litValue
        val result1 = dut.io.xhat(1).peek().litValue
        val floatResult0 = Float.intBitsToFloat(result0.toInt)
        val floatResult1 = Float.intBitsToFloat(result1.toInt)
        println(f"\n\nx1, x2 : $floatX0%.6f \t $floatX1%.6f")
        println(f"SIN,COS: $floatSIN%.6f \t $floatCOS%.6f")
        println(f"Result : $floatResult0%.6f \t $floatResult1%.6f")
        println(f"----------------------------------------------")
      }
    }
  }
}
