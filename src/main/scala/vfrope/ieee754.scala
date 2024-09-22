package vfrope

import chisel3._
import chisel3.util._
import chisel3.experimental.FixedPoint  // This is necessary to use FixedPoint in Chisel

class Int32ToFP32 extends Module { //검증됨
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
}

class FP32Adder extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(32.W))  // IEEE 754 input 1
    val b = Input(UInt(32.W))  // IEEE 754 input 2
    val result = Output(UInt(32.W))  // IEEE 754 output result
  })

  // Step 1: Extract sign, exponent, and mantissa for both inputs
  val signA = io.a(31)
  val exponentA = io.a(30, 23)
  val mantissaA = Cat(1.U(1.W), io.a(22, 0))  // implicit leading 1

  val signB = io.b(31)
  val exponentB = io.b(30, 23)
  val mantissaB = Cat(1.U(1.W), io.b(22, 0))  // implicit leading 1

  // Debug: Print the extracted components
  //printf(p"Input A: 0x${Hexadecimal(io.a)}\n")
  //printf(p"Input B: 0x${Hexadecimal(io.b)}\n")
  //printf(p"Sign A:  $signA, Exponent A:  $exponentA, Mantissa A:  $mantissaA\n")
  //printf(p"Sign B:  $signB, Exponent B:  $exponentB, Mantissa B:  $mantissaB\n")

  // Step 2: Compare exponents and align mantissas
  val exponentDiff = (exponentA - exponentB).asSInt
  val shiftAmount = Mux(exponentDiff > 0.S, exponentDiff.asUInt, (-exponentDiff).asUInt)

  // Shift mantissas based on the exponent difference
  val shiftedMantissaA = Mux(exponentDiff > 0.S, mantissaA, mantissaA >> shiftAmount)
  val shiftedMantissaB = Mux(exponentDiff > 0.S, mantissaB >> shiftAmount, mantissaB)

  // Debug: Print shifted mantissas and exponent difference
  //printf(p"Exponent Difference: $exponentDiff\n")
  //printf(p"Shifted Mantissa A:  $shiftedMantissaA\n")
  //printf(p"Shifted Mantissa B:  $shiftedMantissaB\n")

  // Determine final exponent
  val finalExponent = Mux(exponentDiff > 0.S, exponentA, exponentB)
  //printf(p"Final Exponent before normalization:  $finalExponent\n")

  // Step 3: Add or subtract mantissas based on signs
  val mantissaSum = Mux(signA === signB, shiftedMantissaA + shiftedMantissaB, 
                        Mux(shiftedMantissaA >= shiftedMantissaB, shiftedMantissaA - shiftedMantissaB, shiftedMantissaB - shiftedMantissaA))

  // Adjust the result sign based on the larger mantissa
  val resultSign = Mux(signA === signB, signA, Mux(shiftedMantissaA >= shiftedMantissaB, signA, signB))

  // Debug: Print the mantissa sum and result sign
  //printf(p"Mantissa Sum:  $mantissaSum\n")
  //printf(p"Result Sign:  $resultSign\n")

  // Step 4: Normalize the result and add guard bits for rounding
  val mantissaSumExtended = Cat(mantissaSum, 0.U(2.W)) // Add two guard bits
  val normalizationNeeded = mantissaSumExtended(25) // 24th 비트에서 overflow 확인
  val normalizedMantissa = Mux(normalizationNeeded, mantissaSumExtended(24, 2), mantissaSumExtended(23, 1))
  val finalExponentNormalized = finalExponent // 지수는 그대로 유지

  // Debug: Print normalization-related values
  //printf(p"\nmantissaSumExtended:  $mantissaSumExtended\n")
  //printf(p"Normalization Needed:  $normalizationNeeded\n")
  //printf(p"Normalized Mantissa:  $normalizedMantissa\n")
  //printf(p"Final Exponent (Normalized):  $finalExponentNormalized\n")

  // Step 5: Reassemble the final floating-point result
  val finalExponentBits = finalExponentNormalized(7, 0)  // 지수 8비트 (7:0)
  val finalMantissaBits = normalizedMantissa(22, 0)  // 가수 23비트 (22:0)

  io.result := Cat(resultSign, finalExponentBits, finalMantissaBits)  // 부호, 지수, 가수를 결합
  
  // Debug: Print the final result
  //printf(p"\nresultSign:  $resultSign\n")
  //printf(p"finalExponentBits:  $finalExponentBits\n")
  //printf(p"finalMantissaBits:  $finalMantissaBits\n")
  //printf(p"Result: 0x${Hexadecimal(io.result)}\n")
}

class IEEE754ToFixed(width: Int, binaryPoint: Int) extends Module { //작동
  val io = IO(new Bundle {
    val ieeeInput = Input(UInt(32.W)) // IEEE 754 single-precision (32-bit)
    val fixedOutput = Output(FixedPoint(width.W, binaryPoint.BP))
  })

  // Extract sign, exponent, and mantissa
  val sign = io.ieeeInput(31)
  val exponent = io.ieeeInput(30, 23).zext
  val mantissa = Cat(1.U(1.W), io.ieeeInput(22, 0)) // Leading 1 in normalized form

  // Calculate the shift amount
  val shift = exponent.asSInt - 127.S + binaryPoint.S - 23.S

  // Perform the shift
  val shiftedMantissa = Mux(shift >= 0.S, 
                            mantissa << shift.asUInt, 
                            mantissa >> (-shift).asUInt)

  // Convert mantissa to fixed point, and apply the sign
  val fixedValue = (shiftedMantissa.asFixedPoint(binaryPoint.BP) * 
                    Mux(sign === 1.U, -1.F(width.W, binaryPoint.BP), 1.F(width.W, binaryPoint.BP)))

  io.fixedOutput := fixedValue
}
/*

class FixedToIEEE754(width: Int, binaryPoint: Int) extends Module {
  val io = IO(new Bundle {
    val fixedInput = Input(FixedPoint(width.W, binaryPoint.BP))
    val ieeeOutput = Output(UInt(32.W)) // IEEE 754 single-precision (32-bit)
  })

  // Step 1: Extract the sign
  val sign = io.fixedInput(width - 1)
  val absVal = Mux(sign === 1.U, -io.fixedInput, io.fixedInput)

  // Step 2: Find the MSB position of the absolute value
  val absUInt = absVal.asUInt
  val msbPos = PriorityEncoder(Reverse(absUInt))

  // Step 3: Calculate the exponent
  val exponent = Wire(UInt(8.W))
  val expBias = 127.U
  val normalizedExp = msbPos.asUInt - binaryPoint.U

  // Print statement to debug exponent calculations
  printf(p"DEBUG: absVal = 0x${Hexadecimal(absUInt)}, msbPos = $msbPos, normalizedExp = $normalizedExp\n")

  exponent := normalizedExp + expBias

  // Additional debug print to check the final exponent
  printf(p"DEBUG: Exponent (with bias): 0x${Hexadecimal(exponent)}\n")

  // Step 4: Normalize mantissa by shifting based on msbPos
  val mantissaShift = (absUInt << (31.U - msbPos))(width - 2, 0)
  val mantissa = mantissaShift(22, 0) // IEEE754 single precision mantissa is 23 bits

  // Step 5: Assemble the IEEE 754 output
  val ieeeOutput = Cat(sign, exponent, mantissa)
  
  // Output the result
  io.ieeeOutput := ieeeOutput

  // Debug prints for other components
  printf(p"Input: 0x${Hexadecimal(io.fixedInput.asUInt)}, Sign: $sign\n")
  printf(p"AbsVal: 0x${Hexadecimal(absUInt)}, MSB: $msbPos\n")
  printf(p"Exponent: 0x${Hexadecimal(exponent)}\n")
  printf(p"Mantissa: 0x${Hexadecimal(mantissa)}\n")
  printf(p"IEEE754 Output: 0x${Hexadecimal(ieeeOutput)}\n")
}
*/


class FixedToIEEE754(width: Int, binaryPoint: Int) extends Module {
  val io = IO(new Bundle {
    val fixedInput = Input(FixedPoint(width.W, binaryPoint.BP))
    val ieeeOutput = Output(UInt(32.W)) // IEEE 754 single-precision (32-bit)
  })

  // Step 1: Extract the sign
  val sign = io.fixedInput(width - 1)
  val absVal = Mux(sign === 1.U, -io.fixedInput, io.fixedInput)

  // Debug prints
  printf(p"Input: 0x${Hexadecimal(io.fixedInput.asUInt)}, Sign: $sign\n")
  printf(p"Abs  : 0x${Hexadecimal(absVal.asUInt)}\n")

  // Step 2: Find the MSB position of the absolute value
  val absUInt = absVal.asUInt
  val msbPos = width.U - PriorityEncoder(Reverse(absUInt)) - 1.U // Adjusted MSB detection logic

  // Print statement to debug exponent calculation at the beginning
  printf(p"DEBUG START: Input = 0x${Hexadecimal(io.fixedInput.asUInt)}, AbsVal = 0x${Hexadecimal(absUInt)}, MSB Position = $msbPos\n")

  // Step 3: Calculate the exponent using signed arithmetic
  val normalizedExp = Wire(SInt(16.W)) // Use sufficient width to prevent overflow
  normalizedExp := msbPos.asSInt - binaryPoint.S + 1.S

  // Print statement to debug exponent calculations
  printf(p"DEBUG: msbPos = $msbPos, normalizedExp = $normalizedExp\n")

  // Calculate final exponent with bias
  val exp = Wire(UInt(8.W))
  exp := (normalizedExp + 127.S).asUInt

  // Additional debug print to check the final exponent
  printf(p"DEBUG: Final Exponent (with bias): 0x${Hexadecimal(exp)}\n")

  // Step 4: Normalize mantissa by shifting based on msbPos
  val mantissaShift = absUInt << (31.U - msbPos) // Adjust shift amount
  val mantissa = mantissaShift(width - 2, width - 25) // Extract 23 bits for mantissa

  // Debug prints for mantissa
  printf(p"DEBUG: Mantissa Shifted: 0x${Hexadecimal(mantissaShift.asUInt)}, Mantissa: 0x${Hexadecimal(mantissa)}\n")

  // Step 5: Assemble the IEEE 754 output
  val IEEE754 = Cat(sign, exp, mantissa)
  
  // Output the result
  io.ieeeOutput := IEEE754

  // Final debug prints
  printf(p"IEEE754 Expected (0x40dc7ae1) : 0x${Hexadecimal(IEEE754)} ${Binary(IEEE754)}\n")
}
