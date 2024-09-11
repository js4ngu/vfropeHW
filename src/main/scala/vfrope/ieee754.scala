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
