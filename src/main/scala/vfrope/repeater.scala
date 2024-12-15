package vfrope

import chisel3._
import chisel3.util._

class SerialDataRepeater extends Module {
  val io = IO(new Bundle {
    val xIn   = Input(Vec(2, UInt(32.W)))
    val sinIn = Input(UInt(32.W))
    val cosIn = Input(UInt(32.W))

    val xOut   = Output(Vec(2, UInt(32.W)))
    val sinOut = Output(UInt(32.W))
    val cosOut = Output(UInt(32.W))
  })

  val counter     = RegInit(0.U(1.W))
  val stored_data = RegInit(VecInit(Seq.fill(2)(0.U(32.W))))
  val cos_Reg     = RegInit(0.U(32.W))
  val sin_Reg     = RegInit(VecInit(Seq.fill(2)(0.U(32.W))))

  counter := ~counter
  when (counter === 0.U) {
    stored_data(0) := io.xIn(0)
    stored_data(1) := io.xIn(1)
  }
  cos_Reg    := io.cosIn
  sin_Reg(0) := io.sinIn
  sin_Reg(1) := sin_Reg(0)

  io.cosOut  := cos_Reg
  io.sinOut  := sin_Reg(1)
  io.xOut(0) := stored_data(0)
  io.xOut(1) := stored_data(1)
}