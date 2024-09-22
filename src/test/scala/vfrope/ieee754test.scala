package vfrope

import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import chisel3._
import chisel3.experimental.FixedPoint  // This is necessary to use FixedPoint in Chisel


class Int32ToFP32Test extends AnyFlatSpec with ChiselScalatestTester {
  "Int32ToFP32" should "convert integer to IEEE 754" in {
    test(new Int32ToFP32()) { dut =>
      val testCases = Seq(
        (-49551, "c7346c00"),
        (0, "00000000"),
        (12345, "4640e400"),
        (-1, "bf800000"),
        (2147483647, "4f000000"),
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

// OK
class FP32MultiplierTest extends AnyFlatSpec with ChiselScalatestTester {
  "FP32Multiplier" should "multiply IEEE 754 floating point numbers" in {
    test(new FP32Multiplier()) { dut =>
      val testCases = Seq(
        ("3fc00000", "40100000", "40580000"), // 1.5 * 2.25 = 3.375
        ("bfc00000", "40100000", "c0580000"), // -1.5 * 2.25 = -3.375
        ("3fc00000", "c0100000", "c0580000"), // 1.5 * -2.25 = -3.375
        ("bfc00000", "c0100000", "40580000"), // -1.5 * -2.25 = 3.375
        ("3f800000", "3f800000", "3f800000"), // 1.0 * 1.0 = 1.0
        ("40000000", "40400000", "40c00000"), // 2.0 * 3.0 = 6.0
        ("c0000000", "40400000", "c0c00000"), // -2.0 * 3.0 = -6.0
        ("c0000000", "c0400000", "40c00000")  // -2.0 * -3.0 = 6.0
      )

      for ((aHex, bHex, expectedHex) <- testCases) {
        dut.io.a.poke(BigInt(aHex, 16).U)
        dut.io.b.poke(BigInt(bHex, 16).U)
        dut.clock.step()
        val result = dut.io.y.peek().litValue.toString(16)
        println(f"A: 0x$aHex, B: 0x$bHex, Expected: 0x$expectedHex, Result: 0x$result")
        assert(result == expectedHex, s"Failed for inputs A: 0x$aHex, B: 0x$bHex")
      }
    }
  }
}

class FP32AdderTest extends AnyFlatSpec with ChiselScalatestTester {
  "FP32Adder" should "add IEEE 754 floating point numbers" in {
    test(new FP32Adder()) { dut =>
      val testCases = Seq(
        ("41be0000", "42b8cccd", "42e84ccd"), // 23.75 + 92.4 = 116.15
        ("c1be0000", "42b8cccd", "42894ccd"), // -23.75 + 92.4 = 68.65
        ("41be0000", "c2b8cccd", "c2894ccd"), // 23.75 + -92.4 = -68.65
        ("c1be0000", "c2b8cccd", "c2e84ccd"), // -23.75 + -92.4 = -116.15
        ("3f800000", "40000000", "40400000"), // 1.0 + 2.0 = 3.0
        ("bf800000", "40000000", "3f800000"), // -1.0 + 2.0 = 1.0
        ("3f800000", "c0000000", "bf800000"), // 1.0 + -2.0 = -1.0
        ("bf800000", "c0000000", "c0400000")  // -1.0 + -2.0 = -3.0
      )

      for ((aHex, bHex, expectedHex) <- testCases) {
        dut.io.a.poke(BigInt(aHex, 16).U)
        dut.io.b.poke(BigInt(bHex, 16).U)
        dut.clock.step()
        val result = dut.io.result.peek().litValue.toString(16)
        println(f"A: 0x$aHex, B: 0x$bHex, Expected: 0x$expectedHex, Result: 0x$result")
        assert(result == expectedHex, s"Failed for inputs A: 0x$aHex, B: 0x$bHex")
      }
    }
  }
}


/*
class FixedToIEEE754Test extends AnyFlatSpec with ChiselScalatestTester {
  "Fixed to IEEE 754" should "work correctly" in {
    test(new FixedToIEEE754(32, 28)) { dut =>
      // Use a smaller value that fits within 32 bits
      dut.io.fixedInput.poke(6.89.F(32.W, 28.BP))
      dut.clock.step() // Simulate one clock cycle
      println(s"IEEE 754 Output: 0x${dut.io.ieeeOutput.peek().litValue.toString(16)}")
    }
  }
}

class IEEE754ToFixedTest extends AnyFlatSpec with ChiselScalatestTester { // OK
  "IEEE 754 to Fixed" should "work correctly" in {
    test(new IEEE754ToFixed(32, 28)) { dut =>
      dut.io.ieeeInput.poke("h3fc00000".U) // IEEE 754 representation of 1.5
      dut.clock.step(1) // Simulate one clock cycle
      println(s"Fixed Output: ${dut.io.fixedOutput.peek().litValue}")
    }
  }
}

class ConversionTestSuite extends AnyFlatSpec with ChiselScalatestTester {
  "Fixed to IEEE 754 and IEEE 754 to Fixed" should "work correctly" in {
    // Test Fixed to IEEE 754 conversion
    test(new FixedToIEEE754(32, 28)) { dut =>
      val testCases = Seq(
        (3.5, "40600000")
      )

      for ((fixedVal, expectedIeee) <- testCases) {
        dut.io.fixedInput.poke(fixedVal.F(32.W, 28.BP))
        dut.clock.step(1)
        val ieeeOutput = dut.io.ieeeOutput.peek().litValue.toString(16)
        println(s"Fixed Input: $fixedVal -> IEEE 754 Output: 0x$ieeeOutput (expected: 0x$expectedIeee)")
      }
    }

    // Test IEEE 754 to Fixed conversion
    test(new IEEE754ToFixed(32, 28)) { dut =>
      val testCases = Seq(
        ("40600000", 3.5)
      )

      for ((ieeeVal, expectedFixed) <- testCases) {
        dut.io.ieeeInput.poke(s"h$ieeeVal".U)
        dut.clock.step(1)
        val fixedOutput = dut.io.fixedOutput.peek().litValue.toDouble / (1 << 28)
        println(s"IEEE 754 Input: 0x$ieeeVal -> Fixed Output: $fixedOutput (expected: $expectedFixed)")
      }
    }
  }
}
*/