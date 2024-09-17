package vfrope

import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import chisel3._
import chisel3.experimental.FixedPoint  // This is necessary to use FixedPoint in Chisel


class Int32ToFP32Test extends AnyFlatSpec with ChiselScalatestTester {
    "Int32ToFP32" should "convert integer to IEEE 754" in {
        test(new Int32ToFP32()) { dut =>
            dut.io.inInt.poke(-15.S) // 0x41700000
            dut.clock.step()
            println(s"Result: 0x${dut.io.outIEEE.peek().litValue.toString(16)}")
        }
    }
}

class FP32MultiplierTest extends AnyFlatSpec with ChiselScalatestTester {
    "FP32Multiplier" should "convert integer to IEEE 754" in {
        test(new FP32Multiplier()) { dut =>
            // For positive numbers, you can poke directly
            dut.io.a.poke(0x3fc00000.U) // 1.5
            dut.io.b.poke(0x40100000.U) // 2.25
            dut.clock.step()
            println(s"expected 40580000 : 0x${dut.io.y.peek().litValue.toString(16)}")

            // For negative numbers, use BigInt to handle UInt interpretation correctly
            dut.io.a.poke(BigInt("bfc00000", 16).U) // -1.5
            dut.io.b.poke(0x40100000.U) // 2.25
            dut.clock.step()
            println(s"expected c0580000 : 0x${dut.io.y.peek().litValue.toString(16)}")

            dut.io.a.poke(0x3fc00000.U) // 1.5
            dut.io.b.poke(BigInt("c0100000", 16).U) // -2.25
            dut.clock.step()
            println(s"expected c0580000 : 0x${dut.io.y.peek().litValue.toString(16)}")

            dut.io.a.poke(BigInt("bfc00000", 16).U) // -1.5
            dut.io.b.poke(BigInt("c0100000", 16).U) // -2.25
            dut.clock.step()
            println(s"expected 40580000 : 0x${dut.io.y.peek().litValue.toString(16)}")
        }
    }
}

class FP32AdderTest extends AnyFlatSpec with ChiselScalatestTester {
    "FP32Adder" should "convert integer to IEEE 754" in {
        test(new FP32Adder()) { dut =>
            // For positive numbers, you can poke directly
            dut.io.a.poke(0x41be0000.U) // 1.5
            dut.io.b.poke(0x42b8cccd.U) // 2.25
            dut.clock.step()
            println(s"23.75 + 92.4 = 116.15 expected 42e84ccd : 0x${dut.io.result.peek().litValue.toString(16)}\n\n") // 얘 통과

            // For negative numbers, use BigInt to handle UInt interpretation correctly
            dut.io.a.poke(BigInt("c1be0000", 16).U) // -1.5
            dut.io.b.poke(0x42b8cccd.U) // 2.25
            dut.clock.step()
            println(s"-23.75 + 92.4 = 68.65 expected 42894ccd : 0x${dut.io.result.peek().litValue.toString(16)}\n\n") // 얘 안됨

            dut.io.a.poke(0x41be0000.U) // 1.5
            dut.io.b.poke(BigInt("c2b8cccd", 16).U) // -2.25
            dut.clock.step()
            println(s"23.75 + -92.4 = -68.65 expected c2894ccd : 0x${dut.io.result.peek().litValue.toString(16)}\n\n") // 얘 안됨

            dut.io.a.poke(BigInt("c1be0000", 16).U) // -1.5
            dut.io.b.poke(BigInt("c2b8cccd", 16).U) // -2.25
            dut.clock.step()
            println(s"-23.75 + -92.4 = -116.15 expected c2e84ccd : 0x${dut.io.result.peek().litValue.toString(16)}\n\n") //얘도 OK
        }
    }
}

class FixedToIEEE754Test extends AnyFlatSpec with ChiselScalatestTester {
  "Fixed to IEEE 754" should "work correctly" in {
    test(new FixedToIEEE754(32, 28)) { dut =>
      // Use a smaller value that fits within 32 bits
      dut.io.fixedInput.poke(1.5.F(32.W, 28.BP))
      println(s"IEEE 754 Output: 0x${dut.io.ieeeOutput.peek().litValue.toString(16)}")
    }
  }
}

class IEEE754ToFixedTest extends AnyFlatSpec with ChiselScalatestTester {
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
        (1.5, "3fc00000"),
        (-1.5, "bfc00000"),
        (0.0, "00000000"),
        (2.0, "40000000"),
        (-2.0, "c0000000"),
        (0.75, "3f400000")
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
        ("3fc00000", 1.5),
        ("bfc00000", -1.5),
        ("00000000", 0.0),
        ("40000000", 2.0),
        ("c0000000", -2.0),
        ("3f400000", 0.75)
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
