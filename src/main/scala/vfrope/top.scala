package vfrope

import chisel3._
import chisel3.stage.ChiselStage
import chisel3.util._

object FP32RoPEsingleTop extends App {
  val LutSize = 12
  val LutHalfSizeHEX = 0x45000000
  val Index = 0

  (new ChiselStage).emitVerilog(new FP32RoPEmodule(LutSize, LutHalfSizeHEX, Index))
}
