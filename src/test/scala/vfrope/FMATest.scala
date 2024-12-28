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