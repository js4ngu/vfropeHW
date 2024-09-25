package vfrope

import chisel3._
import chisel3.experimental.FixedPoint
import chisel3.util.{log2Ceil, switch, is}

class IndexCalculator(LutSize: Int, LutHalfSizeHEX: Int, SinCosOffset : Int) extends Module {
    val io = IO(new Bundle {
        val EN       = Input(Bool())
        val angle    = Input(UInt(32.W))
        val cosIndex = Output(UInt(32.W))
        val sinIndex = Output(UInt(32.W))
        val ENout    = Output(Bool())
    })

    val FP32Mult = Module(new FP32Multiplier())
    FP32Mult.io.a := io.angle
    FP32Mult.io.b := LutHalfSizeHEX.U
    val FP32Index = FP32Mult.io.result

    val FP32Truncate = Module(new FP32Truncate())
    FP32Truncate.io.in := FP32Index
    val FP32TruncateIndex = FP32Truncate.io.out

    val FP32toINT32 = Module(new FP32toINT32())
    FP32toINT32.io.ieee754 := FP32TruncateIndex
    val cosIndex = FP32toINT32.io.int32.asUInt                 
    val sinIndex = (cosIndex - SinCosOffset.U)(LutSize - 1, 0) //비트 슬라이싱으로 범위제한 추가

    io.cosIndex := Mux(io.EN, cosIndex, 0.U(32.W))
    io.sinIndex := Mux(io.EN, sinIndex, 0.U(32.W))
    io.ENout    := Mux(io.EN, io.EN, 0.B)
    //printf(p"Angle: ${io.angle}, FP32TruncateIndex: ${FP32TruncateIndex}, cosIndex: ${io.cosIndex}, sinIndex: ${io.sinIndex}\n")
}

class SinCosLUT(LutSize: Int, LutHalfSizeHEX: Int, SinCosOffset: Int) extends Module {
  val io = IO(new Bundle {
    val x      = Input(Vec(2, UInt(32.W)))
    val EN     = Input(Bool())
    val angle  = Input(UInt(32.W))
    val sinOut = Output(UInt(32.W))
    val cosOut = Output(UInt(32.W))
    val ENout  = Output(Bool())
    val xFWD   = Output(Vec(2, UInt(32.W)))
  })

  val indexCalculator = Module(new IndexCalculator(LutSize, LutHalfSizeHEX, SinCosOffset))
  val lutModule = Module(new CosLUT())

  indexCalculator.io.EN := io.EN
  indexCalculator.io.angle := io.angle

  lutModule.io.cosIndex := indexCalculator.io.cosIndex
  lutModule.io.sinIndex := indexCalculator.io.sinIndex
  lutModule.io.EN := indexCalculator.io.ENout

  io.xFWD(0) := Mux(lutModule.io.ENout, io.x(0), 0.U(32.W))
  io.xFWD(1) := Mux(lutModule.io.ENout, io.x(1), 0.U(32.W))

  io.cosOut := Mux(lutModule.io.ENout, lutModule.io.cosOut, 0.U(32.W))
  io.sinOut := Mux(lutModule.io.ENout, lutModule.io.sinOut, 0.U(32.W))
  io.ENout  := Mux(lutModule.io.ENout, lutModule.io.ENout, 0.B)
}
