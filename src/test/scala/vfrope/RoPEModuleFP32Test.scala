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
    test(new FP32radianCaclulator(LutSize = 12, LutHalfSizeHEX = 0x45000000, Index = 0 ))
    .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val testCases = Seq(
        ("3A000000",    1,   1, "Test 1"),  // theta = 2/4096, m = 1,    i = 1    => 0.00048828125
        ("3A000000",  355, 153, "Test 2"),  // theta = 2/4096, m = 355,  i = 153  => 0.52099609375
        ("3A000000", 4000,   3, "Test 3"),  // theta = 2/4096, m = 4000, i = 3    => 1.859375
        ("3A000000", 4096,   1, "Test 4")   // theta = 2/4096, m = 4096, i = 4096 => 0
      )

      for ((theta, m, baseIndex, testName) <- testCases) {
        dut.io.TwoDivD.poke(BigInt(theta, 16).U)
        dut.io.x(0).poke(100.U)
        dut.io.x(1).poke(100.U)

        dut.io.m.poke(m.U)
        dut.io.baseIndex.poke(baseIndex.U)
        dut.io.EN.poke(1.B)
        dut.clock.step(1)
        dut.io.EN.poke(0.B)
        dut.clock.step(5)

        val result = dut.io.out.peek().litValue
        val floatResult = Float.intBitsToFloat(result.toInt)
        val xFWD0 = dut.io.xFWD(0).peek().litValue
        val xFWD1 = dut.io.xFWD(1).peek().litValue
        println(f"$testName Result: $floatResult%.6f xFWD0 : $xFWD0 xFWD1 : $xFWD1")

        dut.clock.step(2)
        val result2 = dut.io.out.peek().litValue
        val floatResult2 = Float.intBitsToFloat(result.toInt)
        val xFWD02 = dut.io.xFWD(0).peek().litValue
        val xFWD12 = dut.io.xFWD(1).peek().litValue
        println(f"$testName Result: $floatResult2%.6f xFWD0 : $xFWD02 xFWD1 : $xFWD12")
        println(s"------------------------")

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
        ("4581C800", "45053000", "BE1CAC08", "BF0A92A3", "c4f03f3b", "c4df9d6b"),
        //테스트 케이스 2
        ("41200000", "3F800000", "3F800000", "b9c91c6c", "c4f03f3b", "c4df9d6b")
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
  

        val EN = dut.io.ENout.peek().litValue
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
        println(f"[$EN] Result : $floatResult0%.6f \t $floatResult1%.6f")
        println(f"----------------------------------------------")
      }
    }
  }
}


class FP32RoPEmoduleTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "FP32RoPEmodule"
  it should "calculate angles correctly" in {
    test(new FP32RoPEmodule(LutSize = 12, LutHalfSizeHEX = 0x45000000, Index = 0  ))
      .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // 여기에 테스트 로직을 작성
      val testCases = Seq(
        ("3F800000", "41200000", 64, 16, "3A000000", "Test #1"), //
        ("40000000", "40A00000", 32, 8, "3A000000", "Test #2"),
        ("42C80000", "42C80000", 128, 32, "3A000000", "Test #3"),
        ("40E00000", "40400000", 96, 24, "3A000000", "Test #4"),
        ("00000000", "3F800000", 1, 1, "3A000000", "Test #5"),
        ("447A0000", "447A0000", 1024, 256, "3A000000", "Test #6"),
        ("41700000", "41A00000", 80, 20, "3A000000", "Test #7"),
        ("40800000", "41000000", 16, 4, "3A000000", "Test #8"),
        ("40400000", "41100000", 27, 9, "3A000000", "Test #9"),
        ("41300000", "41500000", 17, 19, "3A000000", "Test #10")
      )

      for ((x0, x1, m, baseIndex, theta, testName) <- testCases) {
        dut.io.x(0).poke(BigInt(x0, 16).U)
        dut.io.x(1).poke(BigInt(x1, 16).U)
        dut.io.m.poke(m.U)
        dut.io.baseIndex.poke(baseIndex.U)
        dut.io.TwoDivD.poke(BigInt(theta, 16).U)
        dut.io.EN.poke(true.B)
        dut.clock.step(1)
        dut.io.EN.poke(false.B)
        
        // Wait for the pipeline to complete
        var cycleCount = 0
        while (!dut.io.valid.peek().litToBoolean && cycleCount < 30) {
          dut.clock.step(1)
          cycleCount += 1
        }

        val valid = dut.io.valid.peek().litToBoolean
        val xhat0 = dut.io.xhat(0).peek().litValue
        val xhat1 = dut.io.xhat(1).peek().litValue
        
        println(s"$testName:")
        println(s"  Input:  x0=${Float.intBitsToFloat(BigInt(x0, 16).toInt)}, x1=${Float.intBitsToFloat(BigInt(x1, 16).toInt)}, m=$m, baseIndex=$baseIndex, theta=${Float.intBitsToFloat(BigInt(theta, 16).toInt)}")
        println(s"  Output: Valid=$valid, xhat0=${Float.intBitsToFloat(xhat0.toInt)}, xhat1=${Float.intBitsToFloat(xhat1.toInt)}")
        println(s"  Cycles taken: $cycleCount")
        println("----------------------------------------------")

        dut.io.EN.poke(false.B)
        //dut.clock.step(12)
      }
    }
  }
}


class RoPEresolitionTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "FP32RoPEmodule"
  it should "When using 2/D below the maximum resolution supported by the hardware" in {
    test(new FP32RoPEmodule(LutSize = 12, LutHalfSizeHEX = 0x45000000, Index = 0  ))
      .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // 여기에 테스트 로직을 작성
      val testCases = Seq(
        ("3F800000", "42C80000", 16, 32, "3A000000", "Test #1: 2/4096, 16, 32"),
        ("3F800000", "42C80000",  8, 32, "3A800000", "Test #2: 2/2048,  8, 32"),
        ("3F800000", "42C80000",  4, 32, "3B000000", "Test #3: 2/1024,  4, 32"),
        ("3F800000", "42C80000",  2, 32, "3B800000", "Test #4:  2/512,  2,32")
      )

      for ((x0, x1, m, baseIndex, theta, testName) <- testCases) {
        dut.io.x(0).poke(BigInt(x0, 16).U)
        dut.io.x(1).poke(BigInt(x1, 16).U)
        dut.io.m.poke(m.U)
        dut.io.baseIndex.poke(baseIndex.U)
        dut.io.TwoDivD.poke(BigInt(theta, 16).U)
        dut.io.EN.poke(true.B)
        dut.clock.step(1)
        dut.io.EN.poke(false.B)
        
        // Wait for the pipeline to complete
        var cycleCount = 0
        while (!dut.io.valid.peek().litToBoolean && cycleCount < 30) {
          dut.clock.step(1)
          cycleCount += 1
        }

        val valid = dut.io.valid.peek().litToBoolean
        val xhat0 = dut.io.xhat(0).peek().litValue
        val xhat1 = dut.io.xhat(1).peek().litValue
        
        println(s"$testName:")
        println(s"  Input:  x0=${Float.intBitsToFloat(BigInt(x0, 16).toInt)}, x1=${Float.intBitsToFloat(BigInt(x1, 16).toInt)}, m=$m, baseIndex=$baseIndex, theta=${Float.intBitsToFloat(BigInt(theta, 16).toInt)}")
        println(s"  Output: Valid=$valid, xhat0=${Float.intBitsToFloat(xhat0.toInt)}, xhat1=${Float.intBitsToFloat(xhat1.toInt)}")
        println(s"  Cycles taken: $cycleCount")
        println("----------------------------------------------")

        dut.io.EN.poke(false.B)
        //dut.clock.step(12)
      }
    }
  }
}

//Radcalc 시퀀셜 인풋 테스트코드
class FP32radCaclSeqInputTest extends AnyFlatSpec with ChiselScalatestTester {
  "FP32angleCaclulatorTest" should "Seq Input : Test throughput" in {
    test(new FP32radianCaclulator(LutSize = 12, LutHalfSizeHEX = 0x45000000, Index = 0 ))
    .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val testCases = Seq(
        // TwoDivD,    x1,   x2,    m,   baseIndex, expected output
        ("3A000000", "100", "100",   "1",      "1", "0.00048828125"),
        ("3A000000", "100", "100", "355",    "153", "0.52099609375"),
        ("3A000000", "100", "100", "4000",     "3", "1.859375"),
        ("3A000000", "100", "100", "4096",     "1", "0")
      )
      val delay = 0

      for ((twoDivD, x1, x2, m, baseIndex, _) <- testCases) {
        dut.io.TwoDivD.poke(BigInt(twoDivD, 16).U)
        dut.io.x(0).poke(BigInt(x1).U)
        dut.io.x(1).poke(BigInt(x2).U)
        dut.io.m.poke(BigInt(m).U)
        dut.io.baseIndex.poke(BigInt(baseIndex).U)
        dut.io.EN.poke(true.B)
        dut.clock.step()
        dut.io.EN.poke(false.B)
        dut.clock.step(delay)
      }

      dut.clock.step(20)
    }
  }
}


//RoPE Core 시퀀셜 인풋 테스트코드
class FP32RoPEcoreSeqInputTest extends AnyFlatSpec with ChiselScalatestTester {
  "FP32RoPEcoreSeqInputTest" should "Seq Input : Test throughput" in {
    test(new FP32RoPEcore())
    .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val testCases = Seq(
        ("3F800000", "3F800000", "3F800000", "3F800000", "00000000", "40000000"), //2,0
        ("40000000", "40000000", "40000000", "40000000", "00000000", "41000000"), //8,0
        ("431b0000", "43be8000", "3f4ac083", "3EAF1AA0", "c378bdf4", "437d0fdf")  //253,-248
      )
      val delay = 0

      for ((x1, x2, sin, cos, x2hat, x1hat) <- testCases) {
        dut.io.x(0).poke(BigInt(x1, 16).U)
        dut.io.x(1).poke(BigInt(x2, 16).U)

        dut.io.sin.poke(BigInt(sin, 16).U)
        dut.io.cos.poke(BigInt(cos, 16).U)
        dut.io.EN.poke(1.B)
        dut.clock.step()
        dut.io.EN.poke(0.B)
        dut.clock.step(delay)
      }
        dut.clock.step(10)
    }
  }
}

class FP32smallRoPEmoduleTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "FP32smallRoPEmodule"
  it should "calculate angles correctly" in {
    test(new FP32smallRoPEmodule(Index = 0, LutSize = 12, LutHalfSizeHEX = 0x45000000, doublePi = 4096, OneAndHalfPi = 3072, Pi = 2048, halfPi = 1024))
      .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // 여기에 테스트 로직을 작성
      val testCases = Seq(
        ("3F800000", "41200000", 64, 16, "3A000000", "Test #1"), //
        ("40000000", "40A00000", 32, 8, "3A000000", "Test #2"),
        ("42C80000", "42C80000", 128, 32, "3A000000", "Test #3"),
        ("40E00000", "40400000", 96, 24, "3A000000", "Test #4"),
        ("00000000", "3F800000", 1, 1, "3A000000", "Test #5"),
        ("447A0000", "447A0000", 1024, 256, "3A000000", "Test #6"),
        ("41700000", "41A00000", 80, 20, "3A000000", "Test #7"),
        ("40800000", "41000000", 16, 4, "3A000000", "Test #8"),
        ("40400000", "41100000", 27, 9, "3A000000", "Test #9"),
        ("41300000", "41500000", 17, 19, "3A000000", "Test #10")
      )
      val delay = 0

      for ((x0, x1, m, baseIndex, theta, testName) <- testCases) {
        dut.io.x(0).poke(BigInt(x0, 16).U)
        dut.io.x(1).poke(BigInt(x1, 16).U)
        dut.io.m.poke(m.U)
        dut.io.baseIndex.poke(baseIndex.U)
        dut.io.TwoDivD.poke(BigInt(theta, 16).U)
        dut.io.EN.poke(true.B)
        dut.clock.step(1)
        dut.io.EN.poke(false.B)
        dut.clock.step(delay)
      }
        dut.clock.step(20)
    }
  }
}


class FP32smallRoPEmoduleTest2 extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "FP32smallRoPEmodule"
  it should "calculate angles correctly and measure clock cycles" in {
    test(new FP32smallRoPEmodule(Index = 0, LutSize = 12, LutHalfSizeHEX = 0x45000000, doublePi = 4096, OneAndHalfPi = 3072, Pi = 2048, halfPi = 1024))
      .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      
      val testCases = Seq(
        ("3F800000", "41200000", 64, 16, "3A000000", "Test #1"),
        ("40000000", "40A00000", 32, 8, "3A000000", "Test #2"),
        ("42C80000", "42C80000", 128, 32, "3A000000", "Test #3"),
        ("40E00000", "40400000", 96, 24, "3A000000", "Test #4"),
        ("00000000", "3F800000", 1, 1, "3A000000", "Test #5"),
        ("447A0000", "447A0000", 1024, 256, "3A000000", "Test #6"),
        ("41700000", "41A00000", 80, 20, "3A000000", "Test #7"),
        ("40800000", "41000000", 16, 4, "3A000000", "Test #8"),
        ("40400000", "41100000", 27, 9, "3A000000", "Test #9"),
        ("41300000", "41500000", 17, 19, "3A000000", "Test #10")
      )

      for ((x0, x1, m, baseIndex, theta, testName) <- testCases) {
        dut.io.x(0).poke(BigInt(x0, 16).U)
        dut.io.x(1).poke(BigInt(x1, 16).U)
        dut.io.m.poke(m.U)
        dut.io.baseIndex.poke(baseIndex.U)
        dut.io.TwoDivD.poke(BigInt(theta, 16).U)
        dut.io.EN.poke(true.B)
        dut.clock.step(1)
        dut.io.EN.poke(false.B)
        
        // Wait for the pipeline to complete
        var cycleCount = 0
        while (!dut.io.valid.peek().litToBoolean && cycleCount < 30) {
          dut.clock.step(1)
          cycleCount += 1
        }

        val valid = dut.io.valid.peek().litToBoolean
        val xhat0 = dut.io.xhat(0).peek().litValue
        val xhat1 = dut.io.xhat(1).peek().litValue
        
        println(s"$testName:")
        println(s"  Input:  x0=${Float.intBitsToFloat(BigInt(x0, 16).toInt)}, x1=${Float.intBitsToFloat(BigInt(x1, 16).toInt)}, m=$m, baseIndex=$baseIndex, theta=${Float.intBitsToFloat(BigInt(theta, 16).toInt)}")
        println(s"  Output: Valid=$valid, xhat0=${Float.intBitsToFloat(xhat0.toInt)}, xhat1=${Float.intBitsToFloat(xhat1.toInt)}")
        println(s"  Cycles taken: $cycleCount")
        println("----------------------------------------------")

        // Reset for next test case
        dut.io.EN.poke(false.B)
        dut.clock.step(5)  // Add some idle cycles between tests
      }
    }
  }
}


class multiLaneRoPEmoduleTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "multiLaneRoPEmodule"
  it should "calculate angles correctly" in {
    test(new multiLaneRoPEmodule(N = 2, Index = 0, LutSize = 12, LutHalfSizeHEX = 0x45000000, doublePi = 4096, OneAndHalfPi = 3072, Pi = 2048, halfPi = 1024))
      .withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      
      val testCases = Seq(
        ("3F800000", "41200000",  64, 16,  "3A000000", "40000000", "40A00000",   32,   8, "3A000000", "Test #1"),
        ("42C80000", "42C80000", 128, 32,  "3A000000", "40E00000", "40400000",   96,  24, "3A000000", "Test #2"),
        ("00000000", "3F800000",     1, 1, "3A000000", "447A0000", "447A0000", 1024, 256, "3A000000", "Test #3"),
        ("41700000", "41A00000",   80, 20, "3A000000", "40800000", "41000000",   16,   4, "3A000000", "Test #4"),
        ("40400000", "41100000",   27,  9, "3A000000", "41300000", "41500000",   17,  19, "3A000000", "Test #5")
      )
      val delay = 0

      for ((ax0, ax1, am, abaseIndex, atheta, bx0, bx1, bm, bbaseIndex, btheta, testName) <- testCases) {
        println(s"\nRunning $testName")
        
        // Lane 0 inputs
        dut.io.x(0)(0).poke(BigInt(ax0, 16).U)
        dut.io.x(0)(1).poke(BigInt(ax1, 16).U)
        dut.io.m(0).poke(am.U)
        dut.io.baseIndex(0).poke(abaseIndex.U)
        dut.io.TwoDivD(0).poke(BigInt(atheta, 16).U)

        // Lane 1 inputs
        dut.io.x(1)(0).poke(BigInt(bx0, 16).U)
        dut.io.x(1)(1).poke(BigInt(bx1, 16).U)
        dut.io.m(1).poke(bm.U)
        dut.io.baseIndex(1).poke(bbaseIndex.U)
        dut.io.TwoDivD(1).poke(BigInt(btheta, 16).U)

        dut.io.EN.poke(true.B)
        dut.clock.step(1)
        dut.io.EN.poke(false.B)
        dut.clock.step(delay)
      }
      dut.clock.step(20)
    }
  }
}