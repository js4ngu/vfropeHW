package vfrope
import hardfloat._

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

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
