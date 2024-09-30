package vfrope

import chisel3._
import chisel3.util._

class IndexCalculator(LutSize: Int, LutHalfSizeHEX: Int, SinCosOffset: Int) extends Module {
    val io = IO(new Bundle {
        val EN       = Input(Bool())
        val angle    = Input(UInt(32.W))
        val cosIndex = Output(UInt(32.W))
        val sinIndex = Output(UInt(32.W))
        val cosSign  = Output(Bool())  // 주석 처리됨
        val sinSign  = Output(Bool())  // 주석 처리됨
        val ENout    = Output(Bool())
    })

    // 필요한 모듈들 (정의되어 있다고 가정)
    val FP32Mult       = Module(new FP32Multiplier())
    val FP32Truncate   = Module(new FP32Truncate())
    val FP32toINT32    = Module(new FP32toINT32())

    FP32Mult.io.a := io.angle
    FP32Mult.io.b := LutHalfSizeHEX.U
    val FP32Index = FP32Mult.io.result

    FP32Truncate.io.in := FP32Index
    val FP32TruncateIndex = FP32Truncate.io.out

    FP32toINT32.io.ieee754 := FP32TruncateIndex
    val index = FP32toINT32.io.int32.asUInt

    // 상수들 정의
    val doublePi     = Wire(UInt(32.W))
    val OneAngHalfPi = Wire(UInt(32.W))
    val Pi           = Wire(UInt(32.W))
    val halfPi       = Wire(UInt(32.W))

    doublePi     := 4096.U
    OneAngHalfPi := 3072.U
    Pi           := 2048.U
    halfPi       := 1024.U

    val cosIndexWire = Wire(UInt(32.W))
    val sinIndexWire = Wire(UInt(32.W))
    val cosSignWire  = Wire(Bool())  // 주석 처리됨
    val sinSignWire  = Wire(Bool())  // 주석 처리됨

    // 조건에 따른 인덱스 계산
    when(index < halfPi) {
        cosIndexWire := index
        sinIndexWire := index
        cosSignWire  := 0.B      
        sinSignWire  := 0.B      
    }.elsewhen(index < Pi) {
        cosIndexWire := Pi - index
        sinIndexWire := Pi - index
        cosSignWire  := 1.B   
        sinSignWire  := 0.B    
    }.elsewhen(index < OneAngHalfPi) {
        cosIndexWire := index - Pi
        sinIndexWire := index - Pi
        cosSignWire  := 1.B  
        sinSignWire  := 1.B  
    }.otherwise {
        cosIndexWire := doublePi - index
        sinIndexWire := doublePi - index
        cosSignWire  := 0.B  
        sinSignWire  := 1.B 
    }

    // EN 신호에 따라 출력 설정
    io.cosIndex := Mux(io.EN, cosIndexWire, 0.U)
    io.sinIndex := Mux(io.EN, sinIndexWire, 0.U)
    io.cosSign  := Mux(io.EN, cosSignWire, 0.B) 
    io.sinSign  := Mux(io.EN, sinSignWire, 0.B) 
    io.ENout    := io.EN
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

  io.cosOut := Mux(lutModule.io.ENout, Cat(indexCalculator.io.cosSign, lutModule.io.cosOut(30, 0)), 0.U(32.W)) // 여기서 cos,sin sign 비트 CAT해서 반영
  io.sinOut := Mux(lutModule.io.ENout, Cat(indexCalculator.io.sinSign, lutModule.io.sinOut(30, 0)), 0.U(32.W)) // 여기서 cos,sin sign 비트 CAT해서 반영
  io.ENout  := Mux(lutModule.io.ENout, lutModule.io.ENout, 0.B)
}
