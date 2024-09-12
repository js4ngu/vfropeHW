package vfrope

import chisel3._
import chisel3.util._

class Int32ToIEEE754 extends Module {
  val io = IO(new Bundle {
    val inInt = Input(SInt(32.W))
    val outIEEE = Output(UInt(32.W)) // IEEE 754 형식의 결과 출력
  })

  // 부호 비트 설정
  val sign = io.inInt(31)
  val absVal = Mux(sign === 1.U, -io.inInt, io.inInt).asUInt()

  // Find the leading one position and adjust in one step
  val LeadingOne = 31.U - PriorityEncoder(Reverse(absVal))

  // Corrected normalized mantissa calculation (combined in one step)
  val normalizedMantissa = (absVal << (23.U - LeadingOne))(22, 0) // Shift and extract 23 bits mantissa in one step

  // Corrected exponent calculation (combined in one step)
  val biasedExponent = (LeadingOne +& 127.U)(7, 0)  // Calculate biased exponent in one line

  // Final IEEE 754 representation
  val outIEEE = Cat(sign, biasedExponent, normalizedMantissa)

  // Assign the result to the IO output
  io.outIEEE := outIEEE
}


class FP32Multiplier extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(32.W))
    val b = Input(UInt(32.W))
    val y = Output(UInt(32.W))
  })

  // 부호 비트 추출
  val sign_a = io.a(31)
  val sign_b = io.b(31)
  val sign_y = sign_a ^ sign_b

  // 지수 비트 추출
  val exp_a = io.a(30, 23)
  val exp_b = io.b(30, 23)

  // 가수 비트 추출 (숨겨진 1 추가)
  val frac_a = Cat(1.U(1.W), io.a(22, 0))
  val frac_b = Cat(1.U(1.W), io.b(22, 0))

  // 지수 덧셈
  val exp_y = exp_a +& exp_b -& 127.U

  // 가수 곱셈
  val frac_y = frac_a * frac_b

  // 정규화 및 반올림
  val normalized_frac = Mux(frac_y(47), frac_y(46, 24), frac_y(45, 23))
  val rounded_frac = normalized_frac + (normalized_frac(0) & normalized_frac(1))

  // 최종 결과 조합
  val exp_final = Mux(frac_y(47), exp_y + 1.U, exp_y)(7, 0)
  io.y := Cat(sign_y, exp_final, rounded_frac(22, 0))

  // Debug prints
  /*
  printf("\n\nInput a: 0x%x\n", io.a)
  printf("Input b: 0x%x\n", io.b)
  printf("sign_a: %d, sign_b: %d, sign_y: %d\n", sign_a, sign_b, sign_y)
  printf("exp_a: %d, exp_b: %d, exp_y: %d\n", exp_a, exp_b, exp_y)
  printf("frac_a: 0x%x, frac_b: 0x%x\n", frac_a, frac_b)
  printf("frac_y: 0x%x\n", frac_y)
  printf("normalized_frac: 0x%x\n", normalized_frac)
  printf("rounded_frac: 0x%x\n", rounded_frac)
  printf("exp_final: %d\n", exp_final)
  printf("Output y: 0x%x\n", io.y)
  */
}

