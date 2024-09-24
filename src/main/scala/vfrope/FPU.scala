package vfrope
import chisel3._
import chisel3.util._
import hardfloat._

class FP32Adder extends Module {
    val io = IO(new Bundle {
        val a = Input(UInt(32.W))
        val b = Input(UInt(32.W))
        val result = Output(UInt(32.W))
    })

    // Constants for FP32
    val expWidth = 8
    val sigWidth = 24

    val adder = Module(new AddRecFN(expWidth, sigWidth))

    // Convert IEEE 754 to recoded format
    val a_recoded = recFNFromFN(expWidth, sigWidth, io.a)
    val b_recoded = recFNFromFN(expWidth, sigWidth, io.b)

    // Connect inputs to adder
    adder.io.subOp := false.B  // Ensure addition operation
    adder.io.a := a_recoded
    adder.io.b := b_recoded
    adder.io.roundingMode := consts.round_near_even
    adder.io.detectTininess := consts.tininess_afterRounding

    // Convert result back to IEEE 754 format
    io.result := fNFromRecFN(expWidth, sigWidth, adder.io.out)
}

/*
class FP32Sub extends Module {
    val io = IO(new Bundle {
        val a = Input(UInt(32.W))
        val b = Input(UInt(32.W))
        val result = Output(UInt(32.W))
    })

    val adder = Module(new AddRecFN(8, 24))  // For FP32, expWidth = 8, sigWidth = 24

    adder.io.subOp := 1.B  // Ensure addition operation
    adder.io.a := io.a         // Connect first operand
    adder.io.b := io.b         // Connect second operand
    adder.io.roundingMode := 1.U // Round to nearest even
    adder.io.detectTininess := 1.U // Tininess after rounding

    io.result := adder.io.out // Output the result
}
*/
class FP32Sub extends Module {
    val io = IO(new Bundle {
        val a = Input(UInt(32.W))
        val b = Input(UInt(32.W))
        val result = Output(UInt(32.W))
    })

    // Constants for FP32
    val expWidth = 8
    val sigWidth = 24

    val adder = Module(new AddRecFN(expWidth, sigWidth))

    // Convert IEEE 754 to recoded format
    val a_recoded = recFNFromFN(expWidth, sigWidth, io.a)
    val b_recoded = recFNFromFN(expWidth, sigWidth, io.b)

    // Connect inputs to adder
    adder.io.subOp := true.B  // Set to subtraction operation
    adder.io.a := a_recoded
    adder.io.b := b_recoded
    adder.io.roundingMode := consts.round_near_even
    adder.io.detectTininess := consts.tininess_afterRounding

    // Convert result back to IEEE 754 format
    io.result := fNFromRecFN(expWidth, sigWidth, adder.io.out)
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

class Int64ToFP32 extends Module {
  val io = IO(new Bundle {
    val inInt = Input(SInt(64.W))
    val outIEEE = Output(UInt(32.W))
  })

  // 부호 비트 설정
  val sign = io.inInt(63)
  val absVal = Mux(io.inInt === 0.S, 0.U, Mux(sign === 1.U, (-io.inInt).asUInt(), io.inInt.asUInt()))
  val isZero = absVal === 0.U

  // LeadingOne 계산
  val LeadingOne = Mux(isZero, 0.U, PriorityEncoder(Reverse(absVal)))

  // 정규화된 가수 계산
  val shiftAmount = Mux(isZero, 0.U, LeadingOne)
  val normalizedMantissa = Mux(isZero, 0.U, (absVal << shiftAmount)(62, 40))

  // 지수 계산
  val biasedExponent = Mux(isZero, 0.U, (190.U - LeadingOne).asUInt())

  // 최종 IEEE 754 표현
  val outIEEE = Cat(sign, biasedExponent(7, 0), normalizedMantissa)

  // 결과를 IO 출력에 할당
  io.outIEEE := outIEEE
}

class FP32DivPOW2 extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(32.W))
    val x = Input(UInt(12.W))  // Changed from 5.W to 12.W
    val result = Output(UInt(32.W)) //몫이 소수점으로 나오면 안됨
  })

  // Extract sign, exponent, and mantissa
  val sign = io.a(31)
  val exponent = io.a(30, 23)
  val mantissa = io.a(22, 0)

  // Subtract x from the exponent
  val newExponent = exponent -& io.x

  // Check if the result is less than 0 (exponent < 127 in IEEE 754)
  val isLessThanZero = newExponent < 127.U

  // If less than zero, set to zero, otherwise use the calculated result
  val saturatedExponent = Mux(isLessThanZero, 0.U(8.W), newExponent)
  val saturatedMantissa = Mux(isLessThanZero, 0.U(23.W), mantissa)

  // Combine the parts back into an FP32 number
  io.result := Cat(0.U(1.W), saturatedExponent, saturatedMantissa)

  // Note: This implementation doesn't handle special cases like infinity and NaN
}

class FP32Truncate extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(32.W))
    val out = Output(UInt(32.W))
  })

  // FP32 형식: 1비트 부호, 8비트 지수, 23비트 가수
  val sign = io.in(31)
  val exponent = io.in(30, 23)
  val mantissa = io.in(22, 0)
  val result = Wire(UInt(32.W))
  
  when(exponent < 127.U) {
    // 절대값이 1 미만인 경우, 0으로 처리
    result := 0.U
  }.elsewhen(exponent >= 150.U) {
    // 이미 정수인 경우 (2^23 이상), 그대로 출력
    result := io.in
  }.otherwise {
    // 소수점 이하를 버림
    val shift = exponent - 127.U
    val mask = Wire(UInt(23.W))
    mask := ((1.U(23.W) << shift) - 1.U) << (23.U - shift)
    val truncated_mantissa = Wire(UInt(23.W))
    truncated_mantissa := mantissa & mask    
    result := Cat(sign, exponent, truncated_mantissa)
  }

  io.out := result
}

class FP32DivPOW2INT extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(32.W))
    val x = Input(UInt(12.W))  // Changed from 5.W to 12.W
    val result = Output(UInt(32.W)) //몫이 소수점으로 나오면 안됨
  })
  val FP32Div = Module(new FP32DivPOW2())
  FP32Div.io.a := io.a
  FP32Div.io.x := io.x

  val FP32Truncate = Module(new FP32Truncate())
  FP32Truncate.io.in := FP32Div.io.result

  io.result := FP32Truncate.io.out
}
