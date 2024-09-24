package vfrope
import hardfloat._

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import java.lang.Float.intBitsToFloat  // Import the method explicitly

class FP32AdderTest extends AnyFlatSpec with ChiselScalatestTester {
  "FP32Adder" should "add two floating-point numbers correctly" in {
    test(new FP32Adder) { dut =>
      // IEEE 754 format for 1.5 and 2.25
      val inputA = "3fc00000"  // 1.5 in IEEE 754 format
      val inputB = "40080000"  // 2.125 in IEEE 754 format
      val expectedResult = "40680000"  // 3.625 in IEEE 754 format
                            
      // Provide inputs to the adder
      dut.io.a.poke(BigInt(inputA, 16).U)
      dut.io.b.poke(BigInt(inputB, 16).U)

      // Step the clock
      dut.clock.step()
      
      // Optionally print the internal signals
      val resultValue = dut.io.result.peek().litValue().toInt  // Convert BigInt to Int safely since it's within the 32-bit range
      println(s"inputA      : 0x$inputA = ${java.lang.Float.intBitsToFloat(Integer.parseInt(inputA, 16))}")
      println(s"inputB      : 0x$inputB = ${java.lang.Float.intBitsToFloat(Integer.parseInt(inputB, 16))}")
      println(s"Adder Result: $resultValue = 0x${resultValue.toHexString}, ${java.lang.Float.intBitsToFloat(resultValue)}")
    }
  }
}

class FP32SubTest extends AnyFlatSpec with ChiselScalatestTester {
  "FP32Sub" should "Sub two floating-point numbers correctly" in {
    test(new FP32Sub) { dut =>
      // IEEE 754 format for 1.5 and 2.25
      val inputA = "40080000"  // 2.125 in IEEE 754 format
      val inputB = "3fc00000"  // 1.5 in IEEE 754 format
      val expectedResult = "3F200000"  // 3.625 in IEEE 754 format
                            
      // Provide inputs to the adder
      dut.io.a.poke(BigInt(inputA, 16).U)
      dut.io.b.poke(BigInt(inputB, 16).U)

      // Step the clock
      dut.clock.step()
      
      // Optionally print the internal signals
      val resultValue = dut.io.result.peek().litValue().toInt  // Convert BigInt to Int safely since it's within the 32-bit range
      println(s"inputA      : 0x$inputA = ${java.lang.Float.intBitsToFloat(Integer.parseInt(inputA, 16))}")
      println(s"inputB      : 0x$inputB = ${java.lang.Float.intBitsToFloat(Integer.parseInt(inputB, 16))}")
      println(s"Sub Result: $resultValue = 0x${resultValue.toHexString}, ${java.lang.Float.intBitsToFloat(resultValue)}")
    }
  }
}


class FP32MultiplierTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "FP32Multiplier"

  it should "multiply two floating-point numbers correctly" in {
    test(new FP32Multiplier) { dut =>
      val inputA = "3fc00000"  // 1.5 in IEEE 754 format
      val inputB = "40000000"  // 2.0 in IEEE 754 format
      val expectedResult = "40400000"  // Result of 1.5 * 2.0 = 3.0

      dut.io.a.poke(BigInt(inputA, 16).U)
      dut.io.b.poke(BigInt(inputB, 16).U)

      dut.clock.step()

      val resultValue = dut.io.result.peek().litValue()
      println(s"inputA      : 0x$inputA = ${java.lang.Float.intBitsToFloat(Integer.parseInt(inputA, 16))}")
      println(s"inputB      : 0x$inputB = ${java.lang.Float.intBitsToFloat(Integer.parseInt(inputB, 16))}")
      println(s"Multiplication Result: 0x${resultValue.toInt.toHexString} = ${java.lang.Float.intBitsToFloat(resultValue.toInt)}")
      
      assert(resultValue.toInt.toHexString == expectedResult)
    }
  }
  it should "multiply to 0" in {
    test(new FP32Multiplier) { dut =>
      val inputA = "00000000"  // 1.5 in IEEE 754 format
      val inputB = "41400000"  // 2.0 in IEEE 754 format
      val expectedResult = "00000000"  // Result of 1.5 * 2.0 = 3.0

      dut.io.a.poke(BigInt(inputA, 16).U)
      dut.io.b.poke(BigInt(inputB, 16).U)

      dut.clock.step()

      val resultValue = dut.io.result.peek().litValue()
      println(s"inputA      : 0x$inputA = ${java.lang.Float.intBitsToFloat(Integer.parseInt(inputA, 16))}")
      println(s"inputB      : 0x$inputB = ${java.lang.Float.intBitsToFloat(Integer.parseInt(inputB, 16))}")
      println(s"Multiplication Result: 0x${resultValue.toInt.toHexString} = ${java.lang.Float.intBitsToFloat(resultValue.toInt)}")
      
      //assert(resultValue.toInt.toHexString == expectedResult)
    }
  }

}

class Int32ToFP32Test extends AnyFlatSpec with ChiselScalatestTester {
  "Int32ToFP32" should "convert integer to IEEE 754" in {
    test(new Int32ToFP32()) { dut =>
      val testCases = Seq(
        (-49551, "c7418f00"),
        (0, "0"),
        (12345, "4640e400"),
        (-1, "bf800000"),
        (2147483647, "4effffff"),
        (-2147483648, "cf000000")
      )

      for ((intVal, expectedHex) <- testCases) {
        dut.io.inInt.poke(intVal.S)
        dut.clock.step()
        val result = dut.io.outIEEE.peek().litValue.toString(16)
        println(f"Input: $intVal%11d, Expected: 0x$expectedHex, Result: 0x$result")
        assert(result == expectedHex, s"Failed for input $intVal")
      }
    }
  }
}

class Int64ToFP32Test extends AnyFlatSpec with ChiselScalatestTester {
  "Int64ToFP32" should "convert integer to IEEE 754" in {
    test(new Int64ToFP32()) { dut =>
      val testCases = Seq(
        (-49551L, "c7418f00"),
        (0L, "00000000"),
        (12345L, "4640e400"),
        (-1L, "bf800000"),
        (2147483647L, "4effffff"),
        (1L << 32, "4f800000"),  // 2^32
        (-(1L << 32), "cf800000") // -2^32
      )

      for ((intVal, expectedHex) <- testCases) {
        dut.io.inInt.poke(intVal.S)
        dut.clock.step()
        val result = dut.io.outIEEE.peek().litValue.toString(16).padTo(8, '0').takeRight(8)
        println(f"Input: $intVal%20d, Expected: 0x$expectedHex, Result: 0x$result")
        assert(result == expectedHex, s"Failed for input $intVal")
      }
    }
  }
}

class FP32DivPOW2Test extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "FP32DivideByPowerOfTwo"

  it should "correctly divide 4.5 by 2 to get 2.25" in {
    test(new FP32DivPOW2()) { dut =>
      // 4.5 in FP32: 0x40900000
      // Sign: 0, Exponent: 10000010 (130), Mantissa: 00100000000000000000000
      dut.io.a.poke("h40900000".U)
      dut.io.x.poke(1.U) // Divide by 2^1 = 2

      // Expected result: 2.25 in FP32: 0x40100000
      // Sign: 0, Exponent: 10000001 (129), Mantissa: 00100000000000000000000
      dut.io.result.expect("h40100000".U)
    }
  }

  it should "handle division by 1 (x = 0)" in {
    test(new FP32DivPOW2()) { dut =>
      // Use 3.14 as an example: 0x4048f5c3
      dut.io.a.poke("h4048f5c3".U)
      dut.io.x.poke(0.U) // Divide by 2^0 = 1

      // Expected result should be the same as input
      dut.io.result.expect("h4048f5c3".U)
    }
  }

  it should "handle division by 4 (x = 2)" in {
    test(new FP32DivPOW2()) { dut =>
      // Use 16.0 as an example: 0x41800000
      dut.io.a.poke("h41800000".U)
      dut.io.x.poke(2.U) // Divide by 2^2 = 4

      // Expected result: 4.0 in FP32: 0x40800000
      dut.io.result.expect("h40800000".U)
    }
  }

  it should "saturate to zero when result is less than 1" in {
    test(new FP32DivPOW2()) { dut =>
      // 0.5 in FP32: 0x3f000000
      dut.io.a.poke("h3f000000".U)
      dut.io.x.poke(1.U) // Divide by 2^1 = 2

      // Expected result: 0.0 in FP32: 0x00000000
      dut.io.result.expect("h00000000".U)
    }
  }

  it should "correctly divide by 4096 (x = 12)" in {
    test(new FP32DivPOW2()) { dut =>
      // 8192.0 in FP32: 0x46000000
      dut.io.a.poke("h46000000".U)
      dut.io.x.poke(12.U) // Divide by 2^12 = 4096

      // Expected result: 2.0 in FP32: 0x40000000
      dut.io.result.expect("h40000000".U)
    }
  }

  it should "not saturate when result is 1 or greater" in {
    test(new FP32DivPOW2()) { dut =>
      // 2.0 in FP32: 0x40000000
      dut.io.a.poke("h40000000".U)
      dut.io.x.poke(1.U) // Divide by 2^1 = 2

      // Expected result: 1.0 in FP32: 0x3f800000
      dut.io.result.expect("h3f800000".U)
    }
  }
}

class FP32TruncateTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "FP32Truncate"

  it should "truncate fractional parts correctly" in {
    test(new FP32Truncate) { dut =>
      // Test cases in raw FP32 format (using BigInt for hex values)
      val testCases = Seq(
        (BigInt("40490FDB", 16).U, BigInt("40400000", 16).U), // 3.14159 -> 3.0
        (BigInt("C0490FDB", 16).U, BigInt("C0400000", 16).U), // -3.14159 -> -3.0
        (BigInt("3F000000", 16).U, BigInt("00000000", 16).U), // 0.5 -> 0.0
        (BigInt("BF000000", 16).U, BigInt("00000000", 16).U), // -0.5 -> 0.0
        (BigInt("3FFFFFFF", 16).U, BigInt("3F800000", 16).U), // 1.99999988079 -> 1.0
        (BigInt("BFFFFFFF", 16).U, BigInt("BF800000", 16).U), // -1.99999988079 -> -1.0
        (BigInt("42C98000", 16).U, BigInt("42C80000", 16).U), // 100.75 -> 100.0
        (BigInt("C2C98000", 16).U, BigInt("C2C80000", 16).U), // -100.75 -> -100.0
        (BigInt("00000000", 16).U, BigInt("00000000", 16).U), // 0.0 -> 0.0
        (BigInt("3F800000", 16).U, BigInt("3F800000", 16).U), // 1.0 -> 1.0
        (BigInt("BF800000", 16).U, BigInt("BF800000", 16).U),  // -1.0 -> -1.0
        // 추가 테스트 케이스
        (BigInt("3F400000", 16).U, BigInt("00000000", 16).U), // 0.75 -> 0.0
        (BigInt("BF400000", 16).U, BigInt("00000000", 16).U), // -0.75 -> 0.0
        (BigInt("3DCCCCCD", 16).U, BigInt("00000000", 16).U), // 0.1 -> 0.0
        (BigInt("BDCCCCCD", 16).U, BigInt("00000000", 16).U), // -0.1 -> 0.0
        (BigInt("41200000", 16).U, BigInt("41200000", 16).U), // 10.0 -> 10.0
        (BigInt("C1200000", 16).U, BigInt("C1200000", 16).U), // -10.0 -> -10.0
        (BigInt("40000000", 16).U, BigInt("40000000", 16).U), // 2.0 -> 2.0
        (BigInt("C0000000", 16).U, BigInt("C0000000", 16).U), // -2.0 -> -2.0
        (BigInt("4B000000", 16).U, BigInt("4B000000", 16).U), // 8388608.0 -> 8388608.0 (2^23, 최소의 정확한 정수)
        (BigInt("CB000000", 16).U, BigInt("CB000000", 16).U), // -8388608.0 -> -8388608.0
        (BigInt("4B000001", 16).U, BigInt("4B000001", 16).U), // 8388609.0 -> 8388609.0 (2^23 + 1)
        (BigInt("CB000001", 16).U, BigInt("CB000001", 16).U), // -8388609.0 -> -8388609.0
        (BigInt("7F7FFFFF", 16).U, BigInt("7F7FFFFF", 16).U), // 3.4028234e38 (FLT_MAX) -> 3.4028234e38
        (BigInt("FF7FFFFF", 16).U, BigInt("FF7FFFFF", 16).U), // -3.4028234e38 (-FLT_MAX) -> -3.4028234e38
        (BigInt("00800000", 16).U, BigInt("00000000", 16).U), // 1.1754944e-38 (FLT_MIN) -> 0.0
        (BigInt("80800000", 16).U, BigInt("00000000", 16).U), // -1.1754944e-38 (-FLT_MIN) -> 0.0
        (BigInt("3F7FFFFF", 16).U, BigInt("00000000", 16).U), // 0.99999994 -> 0.0
        (BigInt("BF7FFFFF", 16).U, BigInt("00000000", 16).U), // -0.99999994 -> 0.0
        (BigInt("3F800001", 16).U, BigInt("3F800000", 16).U), // 1.00000012 -> 1.0
        (BigInt("BF800001", 16).U, BigInt("BF800000", 16).U)  // -1.00000012 -> -1.0
      )

      for ((input, expected) <- testCases) {
        println(f"Test case: input = 0x${input.litValue}%08X, expected = 0x${expected.litValue}%08X")
        dut.io.in.poke(input)
        dut.clock.step(1)
        dut.io.out.expect(expected)
        println("----------------------------------------")
      }
    }
  }
}

class FP32DivPOW2INTTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "FP32DivPOW2INT"

  it should "correctly divide and truncate FP32 numbers" in {
    test(new FP32DivPOW2INT()) { dut =>
      // Test cases in raw FP32 format (using BigInt for hex values)
      val testCases = Seq(
        (BigInt("40900000", 16).U, 1.U, BigInt("40000000", 16).U), // 4.5 / 2 = 2.0
        (BigInt("40900000", 16).U, 0.U, BigInt("40800000", 16).U), // 4.5 / 1 = 4.0
        (BigInt("41800000", 16).U, 2.U, BigInt("40800000", 16).U), // 16.0 / 4 = 4.0
        (BigInt("3F000000", 16).U, 1.U, BigInt("00000000", 16).U), // 0.5 / 2 = 0.0 (truncated)
        (BigInt("46000000", 16).U,12.U, BigInt("40000000", 16).U), // 8192.0 / 4096 = 2.0
        (BigInt("40000000", 16).U, 1.U, BigInt("3F800000", 16).U), // 2.0 / 2 = 1.0
        (BigInt("42C80000", 16).U, 3.U, BigInt("41400000", 16).U), // 100.0 / 8 = 12.0
        (BigInt("447A0000", 16).U, 8.U, BigInt("40400000", 16).U), // 1000.0 / 256 = 3.0 (truncated)
        (BigInt("40490FDB", 16).U, 2.U, BigInt("00000000", 16).U), // 3.14159 / 4 = 0.0 (truncated)
        (BigInt("C1700000", 16).U, 4.U, BigInt("00000000", 16).U), // -15.0 / 16 = -0.0 (truncated)
      )

      for ((input, x, expected) <- testCases) {
        println(f"Test case: input = 0x${input.litValue}%08X, x = $x, expected = 0x${expected.litValue}%08X")
        dut.io.a.poke(input)
        dut.io.x.poke(x)
        dut.clock.step(1)
        dut.io.result.expect(expected)
        println("----------------------------------------")
      }
    }
  }
}
