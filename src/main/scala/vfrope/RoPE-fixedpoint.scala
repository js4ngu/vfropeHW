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
    val inEN      = Input(Bool())
    val m_theta_i = Output(FixedPoint(width.W, binaryPoint.BP))
    val x1hat     = Output(SInt(width.W))
    val x2hat     = Output(SInt(width.W))
    val outEN     = Output(Bool())
  })
  when(io.inEN) {
    // stage0: 입력값 저장 및 연산 준비
    val theta_0 = io.theta
    val m_0     = io.m
    val i_0     = io.i
    val x1_0    = io.x1
    val x2_0    = io.x2
    val EN_0    = io.inEN
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
    io.outEN := EN_0
  }.otherwise {
    // Keep outputs at a default state or the last state
    io.m_theta_i  := (0.U).asFixedPoint(binaryPoint.BP)
    io.x1hat      := 0.S
    io.x2hat      := 0.S
    io.outEN      := 0.B
  }
  printf(p"Final Output - io.x1hat, io.x2hat, io.m_theta_i : 0x${Hexadecimal(io.x1hat.asUInt)}, 0x${Hexadecimal(io.x2hat.asUInt)}, 0x${Hexadecimal(io.m_theta_i.asUInt)}, 0x${Hexadecimal(io.outEN.asUInt)}\n")
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

  //printf(p"Final Output - io.x1hat, io.x2hat : 0x${Hexadecimal(io.x1hat.asUInt)}, 0x${Hexadecimal(io.x2hat.asUInt)}\n")
}



class RoPEcoreInnerLUT(width: Int, binaryPoint: Int, LutSize: Int) extends Module { // Module 상속
  val io = IO(new Bundle {
    val x1        = Input(SInt(width.W))
    val x2        = Input(SInt(width.W))
    val theta     = Input(FixedPoint(width.W, binaryPoint.BP))
    val m         = Input(UInt(width.W))
    val i         = Input(UInt(width.W))
  })
  printf(p"\n==== Cycle update ====\n")
  //추후에 Enable 신호 FWD 하는 방식으로 제어하게 개선
  val X1_0      = RegInit(0.S(width.W))
  val X2_0      = RegInit(0.S(width.W))
  val X1hat_0   = RegInit(0.S(width.W))
  val X2hat_0   = RegInit(0.S(width.W))
  val inM       = RegInit(0.U(width.W))
  val inI       = RegInit(0.U(width.W))
  val inTheta   = RegInit(0.F(width.W, binaryPoint.BP))  // FixedPoint initialization
  val m_theta_i = RegInit(0.F(width.W, binaryPoint.BP))  // FixedPoint initialization

  X1_0    := io.x1
  X2_0    := io.x2
  inM     := io.m
  inI     := io.i
  inTheta := io.theta

  val FrontCore = Module(new RoPEfrontCore(width, binaryPoint, LutSize))
  FrontCore.io.x1     := X1_0
  FrontCore.io.x2     := X2_0
  FrontCore.io.m      := inM
  FrontCore.io.i      := inI
  FrontCore.io.theta  := inTheta
  m_theta_i           := FrontCore.io.m_theta_i 
  X1hat_0             := FrontCore.io.x1hat
  X2hat_0             := FrontCore.io.x2hat

  printf(p"m_theta_i, x1, x2 : ${Hexadecimal(m_theta_i.asUInt())} ${Hexadecimal(X1hat_0)} ${Hexadecimal(X2hat_0)}\n")

  val SinCosLUT = Module(new SinCosLUT(width, binaryPoint, (2^LutSize)))
  val sin       = RegInit(0.F(width.W, binaryPoint.BP))  // FixedPoint initialization
  val cos       = RegInit(0.F(width.W, binaryPoint.BP))  // FixedPoint initialization
  val X1_1      = RegInit(0.S(width.W))
  val X2_1      = RegInit(0.S(width.W))
  val X1hat_1   = RegInit(0.S(width.W))
  val X2hat_1   = RegInit(0.S(width.W))

  SinCosLUT.io.angle  := m_theta_i
  SinCosLUT.io.x1     := X1hat_0
  SinCosLUT.io.x2     := X2hat_0
  sin                 := SinCosLUT.io.sin
  cos                 := SinCosLUT.io.cos
  X1hat_1             := SinCosLUT.io.x1hat
  X2hat_1             := SinCosLUT.io.x2hat

  printf(p"sin, cos, x1, x2: ${Hexadecimal(sin.asUInt())} ${Hexadecimal(cos.asUInt())} ${Hexadecimal(X1hat_1)} ${Hexadecimal(X2hat_1)}\n")

  val BackCore = Module(new RoPEBackCore(width, binaryPoint))
  val X1hat_2   = RegInit(FixedPoint.fromDouble(0.0, (width + binaryPoint).W, binaryPoint.BP))
  val X2hat_2   = RegInit(FixedPoint.fromDouble(0.0, (width + binaryPoint).W, binaryPoint.BP))
  BackCore.io.x1  := X1hat_1
  BackCore.io.x2  := X2hat_1
  BackCore.io.sin := sin
  BackCore.io.cos := cos
  X1hat_2         := BackCore.io.x1hat
  X2hat_2         := BackCore.io.x2hat
  printf(p"x1, x2: ${Hexadecimal(X1hat_2.asUInt)} ${Hexadecimal(X2hat_2.asUInt)}\n")
}
