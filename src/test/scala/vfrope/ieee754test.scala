package vfrope

import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import chisel3._

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
            println(s"-23.75 + 92.4 = 68.65 expected 42894ccd : 0x${dut.io.result.peek().litValue.toString(16)}") // 얘 안됨

            dut.io.a.poke(0x41be0000.U) // 1.5
            dut.io.b.poke(BigInt("c2b8cccd", 16).U) // -2.25
            dut.clock.step()
            println(s"23.75 + -92.4 = -68.65 expected c2894ccd : 0x${dut.io.result.peek().litValue.toString(16)}") // 얘 안됨

            dut.io.a.poke(BigInt("c1be0000", 16).U) // -1.5
            dut.io.b.poke(BigInt("c2b8cccd", 16).U) // -2.25
            dut.clock.step()
            println(s"-23.75 + -92.4 = -116.15 expected c2e84ccd : 0x${dut.io.result.peek().litValue.toString(16)}") //얘도 OK
        }
    }
}
