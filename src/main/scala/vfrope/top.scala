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

object FP32smallRoPEsingleTop extends App {
  (new ChiselStage).emitVerilog(new FP32smallRoPEmodule(Index = 0, LutSize = 12, LutHalfSizeHEX = 0x45000000, doublePi = 4096, OneAndHalfPi = 3072, Pi = 2048, halfPi = 1024))
}
