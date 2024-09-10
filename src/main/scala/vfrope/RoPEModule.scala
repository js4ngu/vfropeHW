/*
 * Dummy file to start a Chisel project.
 *
 * Author: Martin Schoeberl (martin@jopdesign.com)
 * 
 */

package vfrope

import chisel3._
import chisel3.util._

class RoPEModule(width:Int) extends Module{
  val io = IO(new Bundle{
  val m     = Input(UInt(width.W))
  val theta = Input(UInt(width.W))   
  val i     = Input(UInt(width.W))   
  val out   = Output(UInt(width.W))
  })

  val m_theta_i = RegInit(0.U(width.W))
  m_theta_i := io.m * io.theta * io.i
  io.out    := m_theta_i
}