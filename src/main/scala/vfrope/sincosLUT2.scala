package vfrope

import chisel3._
import chisel3.util._

class smallIndexCalculator2(LutSize: Int, LutHalfSizeHEX: Int, doublePi: Int, OneAndHalfPi : Int, Pi : Int, halfPi : Int) extends Module {
    val io = IO(new Bundle {
        val x        = Input(Vec(2, UInt(32.W)))
        val EN       = Input(Bool())
        val angle    = Input(UInt(32.W))
        val cosIndex = Output(UInt(32.W))
        val sinIndex = Output(UInt(32.W))
        val cosSign  = Output(Bool())  // 주석 처리됨
        val sinSign  = Output(Bool())  // 주석 처리됨
        val ENout    = Output(Bool())
        val xFWD     = Output(Vec(2, UInt(32.W)))
    })
    //파이프라인 레지스터 정의
    val stage1Reg      = RegInit(0.U(32.W))
    val stage2Reg      = RegInit(VecInit(Seq.fill(2)(0.U(32.W))))
    val stage3Reg      = RegInit(VecInit(Seq.fill(4)(0.U(32.W))))
    stage1Reg := io.angle

    //EN 파이프라이닝
    val x0Reg = RegInit(VecInit(Seq.fill(3)(0.U(32.W))))
    val x1Reg = RegInit(VecInit(Seq.fill(3)(0.U(32.W))))
    x0Reg(0) := io.x(0)
    x0Reg(1) := x0Reg(0)
    x0Reg(2) := x0Reg(1)

    x1Reg(0) := io.x(1)
    x1Reg(1) := x1Reg(0)
    x1Reg(2) := x1Reg(1)

    val ENReg = RegInit(VecInit(Seq.fill(3)(false.B)))
    ENReg(0) := io.EN
    ENReg(1) := ENReg(0)
    ENReg(2) := ENReg(1)

    //stage2
    val FP32Mult       = Module(new FP32Multiplier())
    val FP32toINT32    = Module(new FP32toINT32())

    FP32Mult.io.a := stage1Reg
    FP32Mult.io.b := LutHalfSizeHEX.U
    val FP32Index  = FP32Mult.io.result

    FP32toINT32.io.ieee754 := FP32Index
    stage2Reg(0)           := FP32toINT32.io.int32.asUInt
    stage2Reg(1)           := (FP32toINT32.io.int32.asUInt + halfPi.U)(LutSize - 1, 0)

    //stage3
    val decoder = Module(new decoder(LutSize, doublePi, OneAndHalfPi, Pi, halfPi))
    decoder.io.cosIndex1 := stage2Reg(0)
    decoder.io.sinIndex1 := stage2Reg(1)
    stage3Reg(0) := decoder.io.cosIndex2
    stage3Reg(1) := decoder.io.sinIndex2
    stage3Reg(2) := decoder.io.cosSign
    stage3Reg(3) := decoder.io.sinSign

    //output
    io.cosIndex := Mux(ENReg(2), stage3Reg(0), 0.U)
    io.sinIndex := Mux(ENReg(2), stage3Reg(1), 0.U)
    io.cosSign  := Mux(ENReg(2), stage3Reg(2), 0.B) 
    io.sinSign  := Mux(ENReg(2), stage3Reg(3), 0.B)
    io.xFWD(0)  := Mux(ENReg(2), x0Reg(2),     0.U)
    io.xFWD(1)  := Mux(ENReg(2), x1Reg(2),     0.U)

    io.ENout    := ENReg(2)
}

class decoder(LutSize: Int, doublePi: Int, OneAndHalfPi : Int, Pi : Int, halfPi : Int) extends Module {
    val io = IO(new Bundle {
        val cosIndex1 = Input(UInt(32.W))
        val sinIndex1 = Input(UInt(32.W))
        val cosIndex2 = Output(UInt(32.W))
        val sinIndex2 = Output(UInt(32.W))
        val cosSign   = Output(Bool())
        val sinSign   = Output(Bool())
    })

    val cosIndexWire = Wire(UInt(32.W))
    val sinIndexWire = Wire(UInt(32.W))
    val cosSignWire = Wire(Bool())
    val sinSignWire = Wire(Bool())

    when(io.cosIndex1 <= halfPi.U) {
        cosIndexWire := io.cosIndex1
        cosSignWire  := false.B      
    }.elsewhen(io.cosIndex1 <= Pi.U) {
        cosIndexWire := Pi.U - io.cosIndex1
        cosSignWire  := true.B   
    }.elsewhen(io.cosIndex1 <= OneAndHalfPi.U) {
        cosIndexWire := io.cosIndex1 - Pi.U
        cosSignWire  := true.B  
    }.otherwise {
        cosIndexWire := doublePi.U - io.cosIndex1
        cosSignWire  := false.B  
    }

    when(io.sinIndex1 <= halfPi.U) {
        sinIndexWire := io.sinIndex1
        sinSignWire  := true.B      
    }.elsewhen(io.sinIndex1 <= Pi.U) {
        sinIndexWire := Pi.U - io.sinIndex1
        sinSignWire  := false.B    
    }.elsewhen(io.sinIndex1 <= OneAndHalfPi.U) {
        sinIndexWire := io.sinIndex1 - Pi.U
        sinSignWire  := false.B            
    }.otherwise {
        sinIndexWire := doublePi.U - io.sinIndex1
        sinSignWire  := true.B 
    }

    io.cosIndex2 := cosIndexWire
    io.sinIndex2 := sinIndexWire
    io.cosSign   := cosSignWire
    io.sinSign   := sinSignWire
}

class encoder() extends Module {
    val io = IO(new Bundle {
        val cosIn    = Input(UInt(32.W))
        val sinIn    = Input(UInt(32.W))
        val cosSign  = Input(Bool())
        val sinSign  = Input(Bool())
        val cosOut   = Output(UInt(32.W))
        val sinOut   = Output(UInt(32.W))

    })

  io.cosOut := Cat(io.cosSign ^ io.sinIn(31), io.cosIn(30, 0)) // 여기서 cos,sin sign 비트 CAT해서 반영
  io.sinOut := Cat(io.sinSign ^ io.sinIn(31), io.sinIn(30, 0)) // 여기서 cos,sin sign 비트 CAT해서 반영
}


class dualPortSinCosLUT(LutSize: Int, LutHalfSizeHEX: Int, doublePi: Int, OneAndHalfPi : Int, Pi : Int, halfPi : Int) extends Module {
    val io = IO(new Bundle {
        val x      = Input(Vec(2, UInt(32.W)))
        val EN     = Input(Bool())
        val angle  = Input(UInt(32.W))
        
        val sinOut = Output(UInt(32.W))
        val cosOut = Output(UInt(32.W))
        val ENout  = Output(Bool())
        val xFWD   = Output(Vec(2, UInt(32.W)))
    })
    // 먼저 모든 모듈을 초기화합니다
    val indexCalculator = Module(new smallIndexCalculator2(LutSize, LutHalfSizeHEX, doublePi, OneAndHalfPi, Pi, halfPi))
    val lutModule       = Module(new dualPortCOSlut())
    val encoder         = Module(new encoder())

    //파이프라인 레지스터 정의
    val stage2Reg      = RegInit(VecInit(Seq.fill(4)(0.U(32.W))))
    val stage3Reg      = RegInit(VecInit(Seq.fill(2)(0.U(32.W))))

    //FWD
    val x0Reg = RegInit(VecInit(Seq.fill(2)(0.U(32.W))))
    val x1Reg = RegInit(VecInit(Seq.fill(2)(0.U(32.W))))
    val ENReg = RegInit(VecInit(Seq.fill(2)(false.B)))

    indexCalculator.io.angle       := io.angle
    indexCalculator.io.x(0)        := io.x(0) 
    indexCalculator.io.x(1)        := io.x(1) 
    indexCalculator.io.EN          := io.EN

    lutModule.io.cosIndex          := indexCalculator.io.cosIndex
    lutModule.io.sinIndex          := indexCalculator.io.sinIndex
    lutModule.io.x(0)              := indexCalculator.io.xFWD(0)
    lutModule.io.x(1)              := indexCalculator.io.xFWD(1)
    lutModule.io.sign(0)           := indexCalculator.io.cosSign
    lutModule.io.sign(1)           := indexCalculator.io.sinSign
    lutModule.io.EN                := indexCalculator.io.ENout

    stage2Reg(0) := lutModule.io.cosOut
    stage2Reg(1) := lutModule.io.sinOut
    stage2Reg(2) := lutModule.io.signFWD(0)
    stage2Reg(3) := lutModule.io.signFWD(1)
    x0Reg(0)     := lutModule.io.xFWD(0)
    x1Reg(0)     := lutModule.io.xFWD(1)
    ENReg(0)     := lutModule.io.ENout

    encoder.io.cosIn   := stage2Reg(0)
    encoder.io.sinIn   := stage2Reg(1)
    encoder.io.cosSign := stage2Reg(2)
    encoder.io.sinSign := stage2Reg(3)

    stage3Reg(0) := encoder.io.cosOut
    stage3Reg(1) := encoder.io.sinOut
    x0Reg(1)     := x0Reg(0)
    x1Reg(1)     := x1Reg(0)
    ENReg(1)     := ENReg(0)

    //output
    io.cosOut   := Mux(ENReg(1), stage3Reg(0), 0.U)
    io.sinOut   := Mux(ENReg(1), stage3Reg(1), 0.U) 
    io.xFWD(0)  := Mux(ENReg(1), x0Reg(1),     0.U)
    io.xFWD(1)  := Mux(ENReg(1), x1Reg(1),     0.U)
    io.ENout    := ENReg(1)
}
