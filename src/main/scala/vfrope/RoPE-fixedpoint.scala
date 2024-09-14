package vfrope

import chisel3._
import chisel3.experimental.FixedPoint
import chisel3.util._

class RoPEcore(width: Int, binaryPoint: Int) extends Module {
  val io = IO(new Bundle {
    val theta = Input(FixedPoint(width.W, binaryPoint.BP))
    val m     = Input(UInt(width.W))
    val i     = Input(UInt(width.W))
  })

  // stage0
  val theta_0 = RegInit(0.F(width.W, binaryPoint.BP))
  val m_0     = RegInit(0.U(width.W))
  val i_0     = RegInit(0.U(width.W))
  printf(p"Stage 0 : Read Input\n")
  theta_0 := io.theta
  m_0     := io.m
  i_0     := io.i

  printf(p"Stage 1 : Caclc m_theta_i\n")
  val m_theta_i_1 = RegInit(0.F(width.W, binaryPoint.BP))
  val m_i_temp_1  = Wire(UInt(width.W))  // Use Wire to declare temporary hardware signal
  m_i_temp_1 := (m_0 * i_0)((width - binaryPoint - 1), 0) << binaryPoint.U
  m_theta_i_1 := m_i_temp_1.asFixedPoint(binaryPoint.BP) * theta_0
  printf(p"Stage 1 - m_i_temp: ${m_i_temp_1}\n")
  printf(p"Stage 1 - m_theta_i (asUInt in hex): 0x${Hexadecimal(m_theta_i_1.asUInt)}\n")  // Print m_theta_i_1 in hex
}
