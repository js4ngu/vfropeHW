package vfrope
import chisel3._
import chisel3.util._
import hardfloat._

class FP32Adder extends Module {
    val io = IO(new Bundle {
        val a = Input(UInt(33.W))
        val b = Input(UInt(33.W))
        val result = Output(UInt(33.W))
    })

    val adder = Module(new AddRecFN(8, 24))  // For FP32, expWidth = 8, sigWidth = 24

    adder.io.subOp := 0.B  // Ensure addition operation
    adder.io.a := io.a         // Connect first operand
    adder.io.b := io.b         // Connect second operand
    adder.io.roundingMode := 1.U // Round to nearest even
    adder.io.detectTininess := 1.U // Tininess after rounding

    io.result := adder.io.out // Output the result
}


class FP32Multiplier extends Module {
    val io = IO(new Bundle {
        val a = Input(UInt(32.W))
        val b = Input(UInt(32.W))
        val result = Output(UInt(32.W))
    })

    val mulAddRecFN = Module(new MulAddRecFN(8, 24))  // For FP32, expWidth = 8, sigWidth = 24

    mulAddRecFN.io.op := 0.U  // Set to multiplication operation
    mulAddRecFN.io.a := recFNFromFN(8, 24, io.a)
    mulAddRecFN.io.b := recFNFromFN(8, 24, io.b)
    mulAddRecFN.io.c := 0.U(33.W)  // Set to 0 for multiplication only
    mulAddRecFN.io.roundingMode := 0.U // RNE: Round to Nearest, ties to Even
    mulAddRecFN.io.detectTininess := 1.U // Tininess detected after rounding

    io.result := fNFromRecFN(8, 24, mulAddRecFN.io.out)
}

class Int32ToFP32 extends Module {
  val io = IO(new Bundle {
    val inInt = Input(SInt(32.W))
    val outIEEE = Output(UInt(32.W))
  })

  // 부호 비트 설정
  val sign = io.inInt(31)
  val absVal = Mux(io.inInt === 0.S, 0.U, Mux(sign === 1.U, (-io.inInt).asUInt(), io.inInt.asUInt()))
  val isZero = absVal === 0.U

  // LeadingOne 계산
  val LeadingOne = Mux(isZero, 0.U, PriorityEncoder(Reverse(absVal)))

  // 정규화된 가수 계산
  val shiftAmount = Mux(isZero, 0.U, LeadingOne)
  val normalizedMantissa = Mux(isZero, 0.U, (absVal << shiftAmount)(30, 8))

  // 지수 계산
  val biasedExponent = Mux(isZero, 0.U, (158.U - LeadingOne).asUInt())

  // 최종 IEEE 754 표현
  val outIEEE = Cat(sign, biasedExponent(7, 0), normalizedMantissa)

  // 결과를 IO 출력에 할당
  io.outIEEE := outIEEE
}
