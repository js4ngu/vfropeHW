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
    //val m_theta_i = Output(FixedPoint(width.W, binaryPoint.BP))
  })
  printf(p"\n=== Update Cycle ====\n")

  // stage0
  val theta_0 = RegInit(0.F(width.W, binaryPoint.BP))
  val m_0     = RegInit(0.U(width.W))
  val i_0     = RegInit(0.U(width.W))
  val x1_0    = RegInit(0.S(width.W))
  val x2_0    = RegInit(0.S(width.W))

  printf(p"Stage 0 : Read Input\n")
  printf(p"Stage 0 - x_1, x_2, m_0, i_0, theta_0 : ${x1_0}, ${x2_0}, ${m_0}, ${i_0}, 0x${Hexadecimal(theta_0.asUInt)}\n")
  theta_0 := io.theta
  m_0     := io.m
  i_0     := io.i
  x1_0    := io.x1
  x2_0    := io.x2

  printf(p"\nStage 1 : Normailzie m_i\n")
  val m_i_temp1_1 = RegInit(0.U(width.W))
  val m_i_norm_1  = RegInit(0.F((binaryPoint + LutRes + 1).W, binaryPoint.BP))
  val x1_1        = RegInit(0.S(width.W))
  val x2_1        = RegInit(0.S(width.W))
  val theta_1     = RegInit(0.F(width.W, binaryPoint.BP))

  x1_1    := x1_0
  x2_1    := x1_0
  theta_1 := theta_0
  m_i_temp1_1 := ((m_0 * i_0)(LutRes-1, 0))
  m_i_norm_1  := m_i_temp1_1.asFixedPoint(binaryPoint.BP) << binaryPoint // 모듈러 4096
  printf(p"Stage 1 - x_1, x_2,theta                        :   ${x1_1}, ${x2_1}, 0x${Hexadecimal(theta_1.asUInt)}\n")
  printf(p"Stage 1 - m X i % LUT resolution                :   ${m_i_temp1_1}}\n") //ok
  printf(p"Stage 1 - m X i fixed point      (asUInt in hex): 0x${Hexadecimal(m_i_norm_1.asUInt)}\n")  // 4094 확인
  //여끼가지는 맞음 mi가 resoultion 보다 크게 나오면 한 바퀴 도는거라 mod 해준거랑 같음.


  // Step 2: Normailzie m_theta_i - 곱셈 결과 소수점 비트 고려
  val theta_2               = RegInit(0.F(width.W, binaryPoint.BP))
  val m_theta_i_2           = RegInit(0.F((width + binaryPoint + LutRes + 1).W, (2*binaryPoint).BP))  // 소수점 비트를 2배로 설정
  val normaized_m_theta_i_2 = RegInit(0.F(width.W, binaryPoint.BP))
  val x1_2                  = RegInit(0.S(width.W))
  val x2_2                  = RegInit(0.S(width.W))

  val standard              = (2*math.Pi).F((width).W, binaryPoint.BP)
  val piFixed = FixedPoint.fromDouble(math.Pi, width.W, binaryPoint.BP)

  theta_2 := theta_1
  x1_2    := x1_1
  x2_2    := x1_1

  // 곱셈 결과 소수점 비트 처리 (2*binaryPoint)로 설정
  m_theta_i_2 := (m_i_norm_1 * theta_2).setBinaryPoint(2 * binaryPoint)  // 소수점 위치 설정
  printf(p"Stage 2 - x_1, x_2,theta                        : ${x1_2}, ${x2_2}, 0x${Hexadecimal(theta_2.asUInt)}\n") // OK
  printf(p"Stage 1 - m X i fixed point      (asUInt in hex): 0x${Hexadecimal(m_i_norm_1.asUInt)}\n")  // 여기까지 됨
  printf(p"Stage 2 - m_i_norm_1 X theta     (asUInt in hex): 0x${Hexadecimal(m_theta_i_2.asUInt)}\n") // 여기까지 됨

  // 비트 슬라이싱 후 wrap-around 처리
  val temp = m_theta_i_2.asUInt((width + binaryPoint + 1), binaryPoint).asFixedPoint(binaryPoint.BP)
  val tempWithPi = temp * piFixed
  val firstWrap = Mux((tempWithPi) > standard
                      , (tempWithPi)  - standard
                      , (tempWithPi) )  // 첫 번째 wrap-around
  val secondWrap = Mux(firstWrap > standard, firstWrap - standard, firstWrap)  // 두 번째 wrap-around

  normaized_m_theta_i_2 := secondWrap.asUInt((width + binaryPoint + 1), binaryPoint).asFixedPoint(binaryPoint.BP)
  printf(p"Stage 2 - temp                   (asUInt in hex): 0x${Hexadecimal(tempWithPi.asUInt)}\n") // 여기까지 됨
  printf(p"Stage 2 - firstWrap, secondWrap  (asUInt in hex): 0x${Hexadecimal(firstWrap.asUInt)}, 0x${Hexadecimal(secondWrap.asUInt)}\n")
  printf(p"Stage 2 - normaized_m_theta_i_2  (asUInt in hex): 0x${Hexadecimal(normaized_m_theta_i_2.asUInt)}\n")
}


class RoPEBackCore(width: Int, binaryPoint: Int) extends Module {
  val io = IO(new Bundle {
    val x1   = Input(UInt(width.W))
    val x2   = Input(UInt(width.W))
    val sin  = Input(FixedPoint(width.W, (width-2).BP))
    val cos  = Input(FixedPoint(width.W, (width-2).BP))
  })
  printf(p"\n=== Update Cycle ====\n")

  // stage0
  val x1_0    = RegInit(0.U(width.W))
  val x2_0    = RegInit(0.U(width.W))
  val sin_0   = RegInit(0.F(width.W, (width-2).BP))
  val cos_0   = RegInit(0.F(width.W, (width-2).BP))

  printf(p"Stage 0 : Read Input\n")
  printf(p"Stage 0 - x_1, x_2, sin_0, cos_0 : ${x1_0}, ${x2_0}, 0x${Hexadecimal(sin_0.asUInt)} , 0x${Hexadecimal(cos_0.asUInt)}\n")
  x1_0    := io.x1
  x2_0    := io.x2
  sin_0   := io.sin
  cos_0   := io.cos

  // stage1
  printf(p"Stage 1 : Cacl each comp\n")
  val x1_1       = Wire(0.F((2 * width).W, (width-2).BP))
  val x2_1       = Wire(0.F((2 * width).W, (width-2).BP))
  val sin_1      = Wire(0.F((2 * width).W, (width-2).BP))
  val cos_1      = Wire(0.F((2 * width).W, (width-2).BP))
  val x1_sin_1   = RegInit(0.F((2 * width).W, (width-2).BP))
  val x1_cos_1   = RegInit(0.F((2 * width).W, (width-2).BP))

  // conver to Fixed point type
  x1_1  := Cat(0.U(31.W), x1_0.asUInt) 
  x2_1  := Cat(0.U(31.W), x2_0.asUInt) 
  sin_1 := Cat(0.U(31.W), x1_0.asUInt) 
  cos_1 := Cat(0.U(31.W), x2_0.asUInt) 

  printf(p"Stage 1 -  x1_1,  x2_1 : 0x${Hexadecimal(x1_1.asUInt)} , 0x${Hexadecimal(x2_1.asUInt)}\n")
  printf(p"Stage 1 - sin_1, cos_1 : 0x${Hexadecimal(sin_1.asUInt)} , 0x${Hexadecimal(cos_1.asUInt)}\n")

  /*
  val x2_sin_1   = RegInit(0.F(width.W, (width-2).BP))
  val x2_cos_1   = RegInit(0.F(width.W, (width-2).BP))

  //x1_sin_1 := x1_0 * sin_0
  //x1_cos_1 := x1_0 * cos_0
  x2_sin_1 := x2_0 * sin_0
  x2_cos_1 := x2_0 * cos_0
  */
  //printf(p"Stage 1 - x1_sin_1, x1_cos_1 : 0x${Hexadecimal(x1_sin_1.asUInt)} , 0x${Hexadecimal(x1_cos_1.asUInt)}\n")
  //printf(p"Stage 1 - x2_sin_1, x2_cos_1 : 0x${Hexadecimal(x2_sin_1.asUInt)} , 0x${Hexadecimal(x2_cos_1.asUInt)}\n")

  //stage2
}