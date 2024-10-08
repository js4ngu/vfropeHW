package vfrope

import chisel3._
import chisel3.util._

class RoPEModule_Int(width:Int) extends Module{
  val io = IO(new Bundle{
    val in    = Input(Vec(2, UInt(width.W)))
    val m     = Input(UInt(width.W))
    val theta = Input(UInt(width.W))   
    val i     = Input(UInt(width.W))
    val out = Output(Vec(2, SInt((2*width).W)))
  })
  val inReg     = RegInit(VecInit(Seq.fill(2)(0.U(width.W))))
  val outReg    = RegInit(VecInit(Seq.fill(2)(0.S(width.W))))
  val m_theta_i = RegInit(0.U(width.W))

  val sinCosLUT = Module(new SinCosLUTINT(width = 8))
  val sinVal    = RegInit(0.S(width.W))
  val cosVal    = RegInit(0.S(width.W))
  
  inReg(0)  := io.in(0)
  inReg(1)  := io.in(1)

  m_theta_i           := (io.m * io.theta * io.i) % ((2^width).U)
  sinCosLUT.io.angle  := m_theta_i
  sinVal              := sinCosLUT.io.sinOut
  cosVal              := sinCosLUT.io.cosOut
  
  outReg(0) := inReg(0) * cosVal - inReg(1) * sinVal
  outReg(1) := inReg(1) * cosVal + inReg(0) * sinVal

  io.out(0) := outReg(0)
  io.out(1) := outReg(1)
}