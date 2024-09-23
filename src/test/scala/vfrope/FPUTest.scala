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
