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

object FP32RoPE4LaneTop extends App {
  (new ChiselStage).emitVerilog(new multiLaneRoPEmodule(N = 2, Index = 0, LutSize = 12, LutHalfSizeHEX = 0x45000000, doublePi = 4096, OneAndHalfPi = 3072, Pi = 2048, halfPi = 1024))
}

object FP32RoPE8LaneTop extends App {
  (new ChiselStage).emitVerilog(new multiLaneRoPEmodule(N = 4, Index = 0, LutSize = 12, LutHalfSizeHEX = 0x45000000, doublePi = 4096, OneAndHalfPi = 3072, Pi = 2048, halfPi = 1024))
}

object FP32RoPE16LaneTop extends App {
  (new ChiselStage).emitVerilog(new multiLaneRoPEmodule(N = 8, Index = 0, LutSize = 12, LutHalfSizeHEX = 0x45000000, doublePi = 4096, OneAndHalfPi = 3072, Pi = 2048, halfPi = 1024))
}



// V2
object FP32RoPE2LaneV2Top extends App {
  (new ChiselStage).emitVerilog(new multiLaneRoPEmoduleV2(N = 1, Index = 0, LutSize = 12, LutHalfSizeHEX = 0x45000000, doublePi = 4096, OneAndHalfPi = 3072, Pi = 2048, halfPi = 1024))
}

object FP32RoPE4LaneV2Top extends App {
  (new ChiselStage).emitVerilog(new multiLaneRoPEmoduleV2(N = 2, Index = 0, LutSize = 12, LutHalfSizeHEX = 0x45000000, doublePi = 4096, OneAndHalfPi = 3072, Pi = 2048, halfPi = 1024))
}

object FP32RoPE8LaneV2Top extends App {
  (new ChiselStage).emitVerilog(new multiLaneRoPEmoduleV2(N = 4, Index = 0, LutSize = 12, LutHalfSizeHEX = 0x45000000, doublePi = 4096, OneAndHalfPi = 3072, Pi = 2048, halfPi = 1024))
}

object FP32RoPE16LaneV2Top extends App {
  (new ChiselStage).emitVerilog(new multiLaneRoPEmoduleV2(N = 8, Index = 0, LutSize = 12, LutHalfSizeHEX = 0x45000000, doublePi = 4096, OneAndHalfPi = 3072, Pi = 2048, halfPi = 1024))
}