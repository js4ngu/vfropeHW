package vfrope

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class FMATest extends AnyFlatSpec with ChiselScalatestTester {

 // IEEE-754 float to UInt 변환 함수  
 def floatToUInt(f: Float): BigInt = {
   BigInt(java.lang.Float.floatToRawIntBits(f)) & 0xffffffffL
 }

 // UInt to IEEE-754 float 변환 함수
 def uintToFloat(u: BigInt): Float = {
   java.lang.Float.intBitsToFloat(u.toInt)
 }

 behavior of "FMA"

 it should "perform correct FMA operations for all op types" in {
   test(new FMA) { dut =>
     val a = 1.0f
     val b = 2.0f  
     val c = 3.0f

     // 테스트 케이스: (op, 기대값)
     val testCases = Seq(
       (0, (a * b) + c),     // (1.0 * 2.0) + 3.0 = 5.0
       (1, (a * b) - c),     // (1.0 * 2.0) - 3.0 = -1.0
       (2, -(a * b) + c),    // -(1.0 * 2.0) + 3.0 = 1.0
       (3, -(a * b) - c)     // -(1.0 * 2.0) - 3.0 = -5.0
     )

     for ((op, expected) <- testCases) {
       // 입력 설정
       dut.io.validin.poke(true.B)
       dut.io.a.poke(floatToUInt(a).U)
       dut.io.b.poke(floatToUInt(b).U)
       dut.io.c.poke(floatToUInt(c).U)
       dut.io.op.poke(op.U)

       // 파이프라인 지연 대기 (2단계 파이프라인)
       dut.clock.step(3)

       // 결과 검증
       dut.io.validout.expect(true.B)
       
       val result = uintToFloat(dut.io.out.peek().litValue)
       println(s"Op=$op:")
       println(s"Expected: $expected")
       println(s"Got: $result")
       println("------------------------")

       // 부동소수점 비교시 오차 허용
       assert(Math.abs(result - expected) < 1e-6f, 
         s"For op=$op: Expected $expected but got $result")
     }
   }
 }
}

class RoPEFMATest extends AnyFlatSpec with ChiselScalatestTester {

  def floatToUInt(f: Float): BigInt = {
    BigInt(java.lang.Float.floatToRawIntBits(f)) & 0xffffffffL
  }

  def uintToFloat(u: BigInt): Float = {
    java.lang.Float.intBitsToFloat(u.toInt)
  }

  behavior of "RoPEFMA"

  it should "process continuous inputs correctly" in {
    test(new RoPEFMA) { dut =>
      // 테스트 입력값들
      val inputs = Seq(
        (1.0f, 1.0f),  // (xa, xb) for cycle 1
        (2.0f, 2.0f),  // (xa, xb) for cycle 2
        (3.0f, 3.0f)   // (xa, xb) for cycle 3
      )

      // sin(θ) = 1.0, cos(θ) = 1.0
      val sin = floatToUInt(1.0f)
      val cos = floatToUInt(1.0f)

      // 예상되는 결과값 계산
      def expectedResults(xa: Float, xb: Float): (Float, Float) = {
        val xhat_a = xb * 1.0f + xa * 1.0f  // xb×cos + xa×sin
        val xhat_b = xa * 1.0f - xb * 1.0f  // xa×cos - xb×sin
        (xhat_a, xhat_b)
      }

      // Clock cycle counter
      var cycle = 0

      // Process each input
      for ((xa, xb) <- inputs) {
        dut.io.xa.poke(floatToUInt(xa).U)
        dut.io.xb.poke(floatToUInt(xb).U)
        dut.io.sin.poke(sin.U)
        dut.io.cos.poke(cos.U)
        dut.io.en.poke(true.B)

        // Expected results for current input
        val (expected_a, expected_b) = expectedResults(xa, xb)
        
        dut.clock.step()
        cycle += 1

        // After pipeline delay, check results
        if (cycle >= 2) {
          println(s"\nInput Cycle ${cycle-2}:")
          println(s"Input: xa=$xa, xb=$xb")
          
          if (dut.io.valid.peek().litValue == 1) {
            val result_a = uintToFloat(dut.io.xhat_a.peek().litValue)
            val result_b = uintToFloat(dut.io.xhat_b.peek().litValue)
            
            println(s"Expected: xhat_a=$expected_a, xhat_b=$expected_b")
            println(s"Got: xhat_a=$result_a, xhat_b=$result_b")
            
            // Compare with tolerance due to floating point arithmetic
            assert(Math.abs(result_a - expected_a) < 1e-6f, 
                   s"xhat_a mismatch: expected $expected_a, got $result_a")
            assert(Math.abs(result_b - expected_b) < 1e-6f, 
                   s"xhat_b mismatch: expected $expected_b, got $result_b")
          }
        }
      }

      // Run a few more cycles to get remaining results
      for (_ <- 0 until 2) {
        dut.clock.step()
        cycle += 1
        
        if (cycle >= 2) {
          println(s"\nFinal Results Cycle ${cycle-2}:")
          if (dut.io.valid.peek().litValue == 1) {
            val result_a = uintToFloat(dut.io.xhat_a.peek().litValue)
            val result_b = uintToFloat(dut.io.xhat_b.peek().litValue)
            println(s"Got: xhat_a=$result_a, xhat_b=$result_b")
          }
        }
      }
    }
  }
}
