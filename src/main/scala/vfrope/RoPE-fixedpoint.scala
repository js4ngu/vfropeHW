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
    val x1hat     = Output(SInt(width.W))
    val x2hat     = Output(SInt(width.W))
  })

  // stage0: 입력값 저장 및 연산 준비
  val theta_0 = io.theta
  val m_0     = io.m
  val i_0     = io.i
  val x1_0    = io.x1
  val x2_0    = io.x2

  // stage1: m * i 연산 및 고정소수점 변환
  val m_i_temp1_1 = (m_0 * i_0)(LutRes-1, 0)
  val m_i_norm_1  = m_i_temp1_1.asFixedPoint(binaryPoint.BP) << binaryPoint

  // stage2: theta와 m_i_norm 곱셈 및 소수점 비트 설정
  val m_theta_i_2 = (m_i_norm_1 * theta_0).setBinaryPoint(2 * binaryPoint)
  val signBit = m_theta_i_2.asSInt.head(1)  // 부호 비트 추출
  val reduceFraction = m_theta_i_2.asUInt()(binaryPoint + binaryPoint, binaryPoint).asFixedPoint(binaryPoint.BP)

  // 최종 결과 생성 (부호 비트와 고정 소수점 결합)
  val paddingSize = width - reduceFraction.getWidth - 1
  val combinedUInt = Cat(signBit, 0.U(paddingSize.W), reduceFraction.asUInt())

  io.m_theta_i := combinedUInt.asFixedPoint(binaryPoint.BP)
  io.x1hat := x1_0
  io.x2hat := x2_0
  // printf(p"Final Output - io.x1hat, io.x2hat, io.m_theta_i : 0x${Hexadecimal(io.x1hat.asUInt)}, 0x${Hexadecimal(io.x2hat.asUInt)}, 0x${Hexadecimal(io.m_theta_i.asUInt)}\n")
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

  // 입력값 처리 및 고정소수점 변환
  val x1_fixed = (io.x1 << binaryPoint).asFixedPoint(binaryPoint.BP)
  val x2_fixed = (io.x2 << binaryPoint).asFixedPoint(binaryPoint.BP)

  // x1과 x2에 sin, cos 연산
  val x1_sin = x1_fixed * io.sin
  val x1_cos = x1_fixed * io.cos
  val x2_sin = x2_fixed * io.sin
  val x2_cos = x2_fixed * io.cos

  // 최종 결과 계산
  val x1_hat = x1_cos - x2_sin
  val x2_hat = x2_cos + x1_sin

  // 출력값 설정
  io.x1hat := x1_hat
  io.x2hat := x2_hat

  printf(p"Final Output - io.x1hat, io.x2hat : 0x${Hexadecimal(io.x1hat.asUInt)}, 0x${Hexadecimal(io.x2hat.asUInt)}\n")
}



class RoPEcoreInnerLUT(width: Int, binaryPoint: Int, LutSize: Int) extends Module { // Module 상속
  val io = IO(new Bundle {
    val x1        = Input(SInt(width.W))
    val x2        = Input(SInt(width.W))
    val theta     = Input(FixedPoint(width.W, binaryPoint.BP))
    val m         = Input(UInt(width.W))
    val i         = Input(UInt(width.W))
  })

  val inX1      = RegInit(0.S(width.W))
  val inX2      = RegInit(0.S(width.W))
  val inM       = RegInit(0.U(width.W))
  val inI       = RegInit(0.U(width.W))
  val inTheta   = RegInit(0.F(width.W, binaryPoint.BP))  // FixedPoint initialization
  val m_theta_i = RegInit(0.F(width.W, binaryPoint.BP))  // FixedPoint initialization

  inX1    := io.x1
  inX2    := io.x2
  inM     := io.m
  inI     := io.i
  inTheta := io.theta

  val FrontCore = Module(new RoPEfrontCore(width, binaryPoint, LutSize))
  FrontCore.io.x1     := inX1
  FrontCore.io.x2     := inX1
  FrontCore.io.m      := inM
  FrontCore.io.i      := inI
  FrontCore.io.theta  := inTheta
  m_theta_i           := FrontCore.io.m_theta_i 

  printf(p"m_theta_i: ${Hexadecimal(m_theta_i.asUInt())}\n")

  val SinCosLUT = Module(new SinCosLUT(width, binaryPoint, LutSize))
  val sin   = RegInit(0.F(width.W, binaryPoint.BP))  // FixedPoint initialization
  val cos   = RegInit(0.F(width.W, binaryPoint.BP))  // FixedPoint initialization
  SinCosLUT.io.angle  := m_theta_i
  sin                 := SinCosLUT.io.sin
  cos                 := SinCosLUT.io.cos
  printf(p"sin, cos : ${Hexadecimal(sin.asUInt())} ${Hexadecimal(cos.asUInt())}\n")

}
