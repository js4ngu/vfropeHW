package vfrope

import chisel3._
import chisel3.experimental.FixedPoint
import chisel3.util._

class RoPE_core_FP32 extends Module {
  val io = IO(new Bundle {
    val theta = Input(FixedPoint(32.W, 22.BP))
    val m     = Input(UInt(32.W))
    val i     = Input(UInt(32.W))
  })

  // stage0
  val theta_0 = RegInit(0.F(32.W, 22.BP))
  val m_0     = RegInit(0.U(32.W))
  val i_0     = RegInit(0.U(32.W))
  printf(p"Stage 0 : Read Input\n\n")
  theta_0 := io.theta
  m_0     := io.m
  i_0     := io.i

  printf(p"Stage 1 : Cacl M_theta_1\n")
  val m_theta_i_1 = RegInit(0.F(32.W, 22.BP))
  val m_i_temp_1  = Wire(UInt(32.W))  // Use Wire to declare temporary hardware signal
  m_i_temp_1 := (m_0 * i_0)(9, 0) << 22.U
  m_theta_i_1 := m_i_temp_1.asFixedPoint(22.BP) * theta_0
  printf(p"Stage 1 - m_i_temp: ${m_i_temp_1}\n")
  printf(p"Stage 1 - m_theta_i (asUInt in hex): 0x${Hexadecimal(m_theta_i_1.asUInt)}\n\n")  // Print m_theta_i_1 in hex
}
