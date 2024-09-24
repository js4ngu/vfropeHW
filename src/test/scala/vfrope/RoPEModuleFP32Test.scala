package vfrope
import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class FP32angleCaclulatorTest extends AnyFlatSpec with ChiselScalatestTester {
  "RoPEModule" should "work" in {
    test(new FP32angleCaclulator(LutSize = 12)) { dut =>
      val theta = "3F800000" // 1
      dut.io.theta.poke(BigInt(theta, 16).U)
      dut.io.m.poke(2.U)
      dut.io.i.poke(1.U)
      dut.io.EN.poke(1.B)
      dut.clock.step(1)
      dut.io.EN.poke(0.B)
      dut.clock.step(11)
    }
  }
  "RoPEModule Test #2" should "work" in {
    test(new FP32angleCaclulator(LutSize = 12)) { dut =>
      val theta = "447A0000" // 1000
      dut.io.theta.poke(BigInt(theta, 16).U)
      dut.io.m.poke(51.U)  //51
      dut.io.i.poke(100.U)  //100 mi expect 1004 : 여기까지는 나오는 최종 mod 과정 즉 fpdiv과정에서 몫에 소수점이 붙어있는 문제가 발생함
      dut.io.EN.poke(1.B)
      dut.clock.step(1)
      dut.io.EN.poke(0.B)
      dut.clock.step(12)
      //expect 480 43F00000
    }
  }
}

class FP32RoPEcoreTest extends AnyFlatSpec with ChiselScalatestTester {
  "FP32RoPEcoreTest" should "FP32RoPEcoreTest" in {
    test(new FP32RoPEcore()) { dut =>
      val testCases = Seq(
        ("3F800000", "3F800000", "3F800000", "3F800000", "00000000", "40000000"),
        ("40000000", "40000000", "40000000", "40000000", "00000000", "41000000")
      )

      for ((x1, x2, sin, cos, x2hat, x1hat) <- testCases) {
        dut.io.x(0).poke(BigInt(x1, 16).U)
        dut.io.x(1).poke(BigInt(x2, 16).U)

        dut.io.sin.poke(BigInt(sin, 16).U)
        dut.io.cos.poke(BigInt(cos, 16).U)
        dut.io.EN.poke(1.B)
        dut.clock.step(1)
        dut.io.EN.poke(0.B)
        dut.clock.step(3)
      }
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
