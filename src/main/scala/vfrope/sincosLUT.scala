package vfrope

import chisel3._
import chisel3.experimental.FixedPoint
import chisel3.util.{log2Ceil, switch, is}

class IndexCalculator(LutSize: Int, LutHalfSizeHEX: Int, SinCosOffset : Int) extends Module {
    val io = IO(new Bundle {
        val angle = Input(UInt(32.W))
        val cosIndex = Output(UInt(32.W))
        val sinIndex = Output(UInt(32.W))
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
    val sinIndex = (cosIndex + SinCosOffset.U)(LutSize - 1, 0) //비트 슬라이싱으로 범위제한 추가

    io.cosIndex := cosIndex
    io.sinIndex := sinIndex

    printf(p"Angle: ${io.angle}, FP32TruncateIndex: ${FP32TruncateIndex}, cosIndex: ${io.cosIndex}, sinIndex: ${io.sinIndex}\n")
}

class SinCosLUT(LutSize: Int, LutHalfSizeHEX: Int, SinCosOffset: Int) extends Module {
  val io = IO(new Bundle {
    val angle = Input(UInt(32.W))
    val sinOut = Output(UInt(32.W))
    val cosOut = Output(UInt(32.W))
  })

  val indexCalculator = Module(new IndexCalculator(LutSize, LutHalfSizeHEX, SinCosOffset))
  val lutModule = Module(new CosLUT())

  indexCalculator.io.angle := io.angle

  lutModule.io.cosIndex := indexCalculator.io.cosIndex
  lutModule.io.sinIndex := indexCalculator.io.sinIndex

  io.cosOut := lutModule.io.cosOut
  io.sinOut := lutModule.io.sinOut
}
