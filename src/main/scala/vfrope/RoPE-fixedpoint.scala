package vfrope

import chisel3._
import chisel3.experimental.FixedPoint
import chisel3.util._

class RoPEfrontCore(width: Int, binaryPoint: Int) extends Module {
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

  printf(p"Stage 0 : Read Input\n")
  printf(p"Stage 0 - x_1, x_2, m_0, i_0, theta_0 : ${x1_0}, ${x2_0}, ${m_0}, ${i_0}, 0x${Hexadecimal(theta_0.asUInt)}\n")
  theta_0 := io.theta
  m_0     := io.m
  i_0     := io.i
  x1_0    := io.x1
  x2_0    := io.x2

  printf(p"\nStage 1 : Normailzie m_i\n")
  val m_i_temp_1  = Wire(UInt(width.W))  // Use Wire to declare temporary hardware signal
  val m_i_norm_1  = RegInit(0.F(width.W, binaryPoint.BP))
  val theta_1     = RegInit(0.F(width.W, binaryPoint.BP))
  val x1_1        = RegInit(0.S(width.W))
  val x2_1        = RegInit(0.S(width.W))
  val standard1   = (2*math.Pi).F(width.W, binaryPoint.BP)

  x1_1    := x1_0
  x2_1    := x1_0
  theta_1    := theta_0
  m_i_temp_1 := (m_0 * i_0)((width - binaryPoint - 1), 0) << binaryPoint.U

  val m_i_temp_fixed = m_i_temp_1.asFixedPoint(binaryPoint.BP)

  m_i_norm_1 := Mux(m_i_temp_fixed < standard1,
                    m_i_temp_fixed - standard1,
                    m_i_temp_fixed)

  printf(p"Stage 1 - x_1, x_2,theta : ${x1_1}, ${x2_1}, 0x${Hexadecimal(theta_1.asUInt)}\n")
  printf(p"Stage 1 - m_i_temp : ${m_i_temp_1}\n") //ok
  printf(p"Stage 2 - standard               (asUInt in hex): 0x${Hexadecimal(standard1.asUInt)}\n")
  printf(p"Stage 1 - m_i_temp_fixed (asUInt in hex): 0x${Hexadecimal(m_i_temp_fixed.asUInt)}\n")
  printf(p"Stage 1 - m_i_norm (asUInt in hex): 0x${Hexadecimal(m_i_norm_1.asUInt)}\n")  // 여기까지 됨


  printf(p"\nStage 2 : Normailzie m_theta_i\n")
  val theta_2               = RegInit(0.F(width.W, binaryPoint.BP))
  val m_theta_i_2           = RegInit(0.F((2*width).W, binaryPoint.BP))
  val normaized_m_theta_i_2 = RegInit(0.F((2*width).W, binaryPoint.BP))
  val x1_2                  = RegInit(0.S(width.W))
  val x2_2                  = RegInit(0.S(width.W))
  val standard2             = (2*math.Pi).F((2*width).W, binaryPoint.BP)

  theta_2 := theta_1
  x1_2    := x1_1
  x2_2    := x1_1
  m_theta_i_2 := m_i_norm_1 * theta_2
  normaized_m_theta_i_2 := Mux(m_theta_i_2 > standard2,
                               m_theta_i_2 - standard2,
                               m_theta_i_2)

  printf(p"Stage 2 - m_i_norm (asUInt in hex): 0x${Hexadecimal(m_i_norm_1.asUInt)}\n")  // 여기까지 됨
  printf(p"Stage 2 - x_1, x_2,theta : ${x1_2}, ${x2_2}, 0x${Hexadecimal(theta_2.asUInt)}\n") // OK
  printf(p"Stage 2 - m_theta_i_2            (asUInt in hex): 0x${Hexadecimal(m_theta_i_2.asUInt)}\n") // OK
  printf(p"Stage 2 - standard               (asUInt in hex): 0x${Hexadecimal(standard2.asUInt)}\n")
  printf(p"Stage 2 - normaized_m_theta_i_2  (asUInt in hex): 0x${Hexadecimal(normaized_m_theta_i_2.asUInt)}\n")

  printf(p"\nStage 3 : Output\n")
  io.m_theta_i := normaized_m_theta_i_2.asUInt()(31, 0).asFixedPoint(binaryPoint.BP)  // Convert to UInt and back to FixedPoint
  printf(p"Stage 3 - m_theta_i  (asUInt in hex): 0x${Hexadecimal(io.m_theta_i.asUInt)}\n")

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