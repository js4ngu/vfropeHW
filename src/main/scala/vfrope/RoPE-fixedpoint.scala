package vfrope

import chisel3._
import chisel3.experimental.FixedPoint
import chisel3.util._

class RoPEfrontCore(width: Int, binaryPoint: Int, LutRes: Int) extends Module {
  val io = IO(new Bundle {
    val x1        = Input(SInt(width.W))
    val x2        = Input(SInt(width.W))
    val theta     = Input(FixedPoint(width.W, binaryPoint.BP))
    val m         = Input(UInt(width.W))
    val i         = Input(UInt(width.W))
    val m_theta_i = Output(FixedPoint(width.W, binaryPoint.BP))
  })
  printf(p"\n=== Update Cycle ====\n")

  // stage0
  val theta_0 = RegInit(0.F(width.W, binaryPoint.BP))
  val m_0     = RegInit(0.U(width.W))
  val i_0     = RegInit(0.U(width.W))
  val x1_0    = RegInit(0.S(width.W))
  val x2_0    = RegInit(0.S(width.W))

  //printf(p"Stage 0 : Read Input\n")
  //printf(p"Stage 0 - x_1, x_2, m_0, i_0, theta_0 : ${x1_0}, ${x2_0}, ${m_0}, ${i_0}, 0x${Hexadecimal(theta_0.asUInt)}\n")
  theta_0 := io.theta
  m_0     := io.m
  i_0     := io.i
  x1_0    := io.x1
  x2_0    := io.x2

  //printf(p"\nStage 1 : Normailzie m_i\n")
  val m_i_norm_1  = RegInit(0.F((binaryPoint + LutRes).W, binaryPoint.BP))
  val x1_1        = RegInit(0.S(width.W))
  val x2_1        = RegInit(0.S(width.W))
  val theta_1     = RegInit(0.F(width.W, binaryPoint.BP))

  x1_1    := x1_0
  x2_1    := x1_0
  theta_1 := theta_0
  val m_i_temp1_1 = ((m_0 * i_0)(LutRes-1, 0))
  m_i_norm_1  := m_i_temp1_1.asFixedPoint(binaryPoint.BP) << binaryPoint // 모듈러 4096
  //printf(p"Stage 1 - x_1, x_2,theta                        :   ${x1_1}, ${x2_1}, 0x${Hexadecimal(theta_1.asUInt)}\n")
  //printf(p"Stage 1 - m X i % LUT resolution                :   ${m_i_temp1_1}}\n") //ok
  //printf(p"Stage 1 - m X i fixed point      (asUInt in hex): 0x${Hexadecimal(m_i_norm_1.asUInt)}\n")  // 4094 확인
  //여끼가지는 맞음 mi가 resoultion 보다 크게 나오면 한 바퀴 도는거라 mod 해준거랑 같음.


  // Step 2: Normailzie m_theta_i - 곱셈 결과 소수점 비트 고려
  val theta_2               = RegInit(0.F(width.W, binaryPoint.BP))
  val normaized_m_theta_i_2 = RegInit(0.F(width.W, binaryPoint.BP))
  val x1_2                  = RegInit(0.S(width.W))
  val x2_2                  = RegInit(0.S(width.W))

  theta_2 := theta_1
  x1_2    := x1_1
  x2_2    := x1_1
  val m_theta_i_2 = (m_i_norm_1 * theta_2).setBinaryPoint(2 * binaryPoint)  // 소수점 위치 설정
  val signBit = m_theta_i_2.asSInt.head(1)  // 부호 비트 추출
  val reduceFraction = m_theta_i_2.asUInt()(binaryPoint + binaryPoint, binaryPoint).asFixedPoint(binaryPoint.BP)
  val paddingSize    = width - reduceFraction.getWidth - 1
  val combinedUInt = Cat(signBit, 0.U(paddingSize.W), reduceFraction.asUInt())
  normaized_m_theta_i_2 := combinedUInt.asFixedPoint(binaryPoint.BP)
  printf(p"Stage 2 - normaized_m_theta_i_2                 : 0x${Hexadecimal(normaized_m_theta_i_2.asUInt)}\n")

  io.m_theta_i := normaized_m_theta_i_2
}


class RoPEBackCore(width: Int, binaryPoint: Int) extends Module {
  val io = IO(new Bundle {
    val x1   = Input(SInt(width.W))
    val x2   = Input(SInt(width.W))
    val sin  = Input(FixedPoint((width).W, binaryPoint.BP))
    val cos  = Input(FixedPoint((width).W, binaryPoint.BP))
    val x1hat= Output(FixedPoint((width + binaryPoint).W, binaryPoint.BP))
    val x2hat= Output(FixedPoint((width + binaryPoint).W, binaryPoint.BP))
  })
  printf(p"\n=== Update Cycle ====\n")

  // stage0
  val x1_0    = RegInit(0.S(width.W))
  val x2_0    = RegInit(0.S(width.W))
  val sin_0   = RegInit(0.F((width).W, binaryPoint.BP))
  val cos_0   = RegInit(0.F((width).W, binaryPoint.BP))

  printf(p"Stage 0 : Read Input\n")
  x1_0    := io.x1
  x2_0    := io.x2
  sin_0   := io.sin
  cos_0   := io.cos
  printf(p"Stage 0 - x_1, x_2, sin_0, cos_0 : ${x1_0}, ${x2_0}, 0x${Hexadecimal(sin_0.asUInt)} , 0x${Hexadecimal(cos_0.asUInt)}\n")

  // stage1
  printf(p"Stage 1 : Cacl each comp\n")
  val x1_1       = RegInit(0.S(width.W))
  val x2_1       = RegInit(0.S(width.W))
  val sin_1      = RegInit(0.F(width.W, binaryPoint.BP))
  val cos_1      = RegInit(0.F(width.W, binaryPoint.BP))
  val x1_sin_1   = RegInit(0.F((width + binaryPoint).W, binaryPoint.BP))
  val x1_cos_1   = RegInit(0.F((width + binaryPoint).W, binaryPoint.BP))
  val x2_sin_1   = RegInit(0.F((width + binaryPoint).W, binaryPoint.BP))
  val x2_cos_1   = RegInit(0.F((width + binaryPoint).W, binaryPoint.BP))

  x1_1 := x1_0
  x2_1 := x2_0
  sin_1 := sin_0
  cos_1 := cos_0

  val x1_1_fixed = (x1_1 << binaryPoint).asFixedPoint(binaryPoint.BP)
  val x2_1_fixed = (x2_1 << binaryPoint).asFixedPoint(binaryPoint.BP)
  printf(p"Stage 1 - sin_1, cos_1           : 0x${Hexadecimal(sin_1.asSInt)} , 0x${Hexadecimal(cos_1.asSInt)}\n")
  printf(p"Stage 1 - x1_1_fixed, x1_2_fixed : 0x${Hexadecimal(x1_1_fixed.asUInt)} , 0x${Hexadecimal(x2_1_fixed.asUInt)}\n")
  printf(p"Stage 1 - x1/2_1_fixed Size      : ${x1_1_fixed.getWidth} , ${x2_1_fixed.getWidth}\n")

  x1_sin_1 := x1_1_fixed * sin_1 // -10
  x1_cos_1 := x1_1_fixed * cos_1 // 10
  x2_sin_1 := x2_1_fixed * sin_1 // -10
  x2_cos_1 := x2_1_fixed * cos_1 // 10
  printf(p"Stage 1 - x1_sin_1, x1_cos_1 : 0x${Hexadecimal(x1_sin_1.asUInt)} , 0x${Hexadecimal(x1_cos_1.asUInt)}\n")
  printf(p"Stage 1 - x2_sin_1, x2_cos_1 : 0x${Hexadecimal(x2_sin_1.asUInt)} , 0x${Hexadecimal(x2_cos_1.asUInt)}\n")
  printf(p"Stage 1 - x1/2_sin/cos_1 Size: ${x1_sin_1.getWidth} , ${x1_cos_1.getWidth}, ${x2_sin_1.getWidth} , ${x2_cos_1.getWidth}\n")

  val x1_hat_2   = RegInit(0.F((width + binaryPoint).W, binaryPoint.BP))
  val x2_hat_2   = RegInit(0.F((width + binaryPoint).W, binaryPoint.BP))

  x1_hat_2 := x1_cos_1 - x2_sin_1
  x2_hat_2 := x2_cos_1 + x1_sin_1
  printf(p"Stage 1 - x1_hat_2, x2_hat_1 : 0x${Hexadecimal(x1_hat_2.asUInt)} , 0x${Hexadecimal(x2_hat_2.asUInt)}\n")

  io.x1hat := x1_hat_2
  io.x2hat := x2_hat_2
  printf(p"Stage 1 - io.x1hat, io.x2hat : 0x${Hexadecimal(io.x1hat.asUInt)} , 0x${Hexadecimal(io.x2hat.asUInt)}\n")

}