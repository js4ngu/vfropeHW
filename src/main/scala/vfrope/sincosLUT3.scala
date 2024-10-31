package vfrope

import chisel3._
import chisel3.util._

class dualPortIndexCalculatorV2(LutSize: Int, LutHalfSizeHEX: Int, doublePi: Int, OneAndHalfPi : Int, Pi : Int, halfPi : Int) extends Module {
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
    val stage2Reg      = RegInit(VecInit(Seq.fill(4)(0.U(32.W))))
    stage1Reg := io.angle

    //EN 파이프라이닝
    val x0Reg = RegInit(VecInit(Seq.fill(2)(0.U(32.W))))
    val x1Reg = RegInit(VecInit(Seq.fill(2)(0.U(32.W))))
    val ENReg = RegInit(VecInit(Seq.fill(2)(false.B)))

    ENReg(0) := io.EN
    ENReg(1) := ENReg(0)
    x0Reg(0) := io.x(0)
    x0Reg(1) := x0Reg(0)
    x1Reg(0) := io.x(1)
    x1Reg(1) := x1Reg(0)

    val decoder = Module(new decoder(LutSize, doublePi, OneAndHalfPi, Pi, halfPi))
    decoder.io.cosIndex1 := stage1Reg
    decoder.io.sinIndex1 := (stage1Reg + halfPi.U)(LutSize - 1, 0)

    stage2Reg(0) := decoder.io.cosIndex2
    stage2Reg(1) := decoder.io.sinIndex2
    stage2Reg(2) := decoder.io.cosSign
    stage2Reg(3) := decoder.io.sinSign

    //output
    io.cosIndex := Mux(ENReg(1), stage2Reg(0), 0.U)
    io.sinIndex := Mux(ENReg(1), stage2Reg(1), 0.U)
    io.cosSign  := Mux(ENReg(1), stage2Reg(2), 0.B) 
    io.sinSign  := Mux(ENReg(1), stage2Reg(3), 0.B)
    io.xFWD(0)  := Mux(ENReg(1), x0Reg(1),     0.U)
    io.xFWD(1)  := Mux(ENReg(1), x1Reg(1),     0.U)
    io.ENout    := ENReg(1)
}

class multiPortSinCosModuleV2(N: Int, LutSize: Int, LutHalfSizeHEX: Int, doublePi: Int, OneAndHalfPi: Int, Pi: Int, halfPi: Int) extends Module {
    val io = IO(new Bundle {
        val x      = Input(Vec(N, Vec(2, UInt(32.W))))
        val EN     = Input(Bool())
        val angle  = Input(Vec(N, UInt(32.W)))
        val sinOut = Output(Vec(N, UInt(32.W)))
        val cosOut = Output(Vec(N, UInt(32.W)))
        val ENout  = Output(Bool())
        val xFWD   = Output(Vec(N, Vec(2, UInt(32.W))))
    })

    val indexCalculator = Array.fill(N) {
        Module(new dualPortIndexCalculatorV2(LutSize, LutHalfSizeHEX, doublePi, OneAndHalfPi, Pi, halfPi))
    }
    val lutModule = Module(new multiPortCOSlut(N))
    val encoder = Array.fill(N) {
        Module(new encoder())
    }

    //IO to indexCaluclator
    for (i <- 0 until N) {
        indexCalculator(i).io.EN    := io.EN
        indexCalculator(i).io.x(0)  := io.x(i)(0)
        indexCalculator(i).io.x(1)  := io.x(i)(1)
        indexCalculator(i).io.angle := io.angle(i)
    }

    //indexCaluclator to lutModule
    lutModule.io.EN                 := indexCalculator(0).io.ENout
    for (i <- 0 until N) {
        lutModule.io.x(i)(0)        := indexCalculator(i).io.xFWD(0)
        lutModule.io.x(i)(1)        := indexCalculator(i).io.xFWD(1)
        lutModule.io.cosIndex(i)    := indexCalculator(i).io.cosIndex
        lutModule.io.sinIndex(i)    := indexCalculator(i).io.sinIndex
        lutModule.io.sign(i)(0)     := indexCalculator(i).io.cosSign
        lutModule.io.sign(i)(1)     := indexCalculator(i).io.sinSign
    }

    //lutmoule to encoder
    for (i <- 0 until N) {
        encoder(i).io.EN      := lutModule.io.ENout
        encoder(i).io.x(0)    := lutModule.io.xFWD(i)(0)
        encoder(i).io.x(1)    := lutModule.io.xFWD(i)(1)
        encoder(i).io.cosIn   := lutModule.io.cosOut(i)
        encoder(i).io.sinIn   := lutModule.io.sinOut(i)
        encoder(i).io.cosSign := lutModule.io.signFWD(i)(0)
        encoder(i).io.sinSign := lutModule.io.signFWD(i)(1)
    }

    //lutmoule to io
    io.ENout          := encoder(0).io.ENout
    for (i <- 0 until N) {
        io.xFWD(i)(0) := encoder(i).io.xFWD(0)
        io.xFWD(i)(1) := encoder(i).io.xFWD(1)
        io.cosOut(i)  := encoder(i).io.cosOut
        io.sinOut(i)  := encoder(i).io.sinOut
    }
}