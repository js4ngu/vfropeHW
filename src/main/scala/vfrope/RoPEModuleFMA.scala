package vfrope
import chisel3._
import chisel3.util._

class multiLaneFMARoPE(N: Int, Index: Int, LutSize: Int, LutHalfSizeHEX: Int, doublePi: Int, OneAndHalfPi: Int, Pi: Int, halfPi: Int) extends Module {
    val io = IO(new Bundle {
        val x           = Input(Vec(N, Vec(2, UInt(32.W))))
        val EN          = Input(Bool())
        val m           = Input(Vec(N, UInt(32.W)))
        val baseIndex   = Input(Vec(N, UInt(32.W)))
        val ResMode     = Input(Vec(N, UInt(32.W)))
        val xhat        = Output(Vec(N, Vec(2, UInt(32.W))))
        val valid       = Output(UInt(32.W))
    })

    // 필요한 모듈 선언
    val RadCalc = Array.fill(N) {
        Module(new FP32radianCaclulatorV3(LutSize, LutHalfSizeHEX, Index))
    }
    val SinCosLut = Module(new multiPortSinCosModuleV2(N, LutSize, LutHalfSizeHEX, doublePi, OneAndHalfPi, Pi, halfPi))
    val RoPEcore = Array.fill(N) {
        Module(new fmaROPE())
    }

    // 파이프라인 레지스터와 EN 신호
    val stage1Reg = RegInit(VecInit(Seq.fill(N)(VecInit(Seq.fill(6)(0.U(32.W))))))
    val stage1EN  = RegInit(false.B)
    val stage2Reg = RegInit(VecInit(Seq.fill(N)(VecInit(Seq.fill(4)(0.U(32.W))))))
    val stage2EN  = RegInit(false.B)
    val stage3Reg = RegInit(VecInit(Seq.fill(N)(VecInit(Seq.fill(5)(0.U(32.W))))))
    val stage3EN  = RegInit(false.B)

    // stage1 입력
    when(io.EN) {
        for(i <- 0 until N) {
            stage1Reg(i)(0) := io.x(i)(0)
            stage1Reg(i)(1) := io.x(i)(1)
            stage1Reg(i)(2) := io.m(i)
            stage1Reg(i)(3) := io.baseIndex(i)
            stage1Reg(i)(4) := io.ResMode(i)
        }
        stage1EN := true.B
    }.otherwise {
        stage1EN := false.B
    }

    // stage1
    for(i <- 0 until N) {
        RadCalc(i).io.EN        := stage1EN
        RadCalc(i).io.x(0)      := stage1Reg(i)(0)
        RadCalc(i).io.x(1)      := stage1Reg(i)(1)
        RadCalc(i).io.m         := stage1Reg(i)(2)
        RadCalc(i).io.baseIndex := stage1Reg(i)(3)
        RadCalc(i).io.ResMode   := stage1Reg(i)(4)
    }

    // stage2 입력
    for(i <- 0 until N) {
        stage2Reg(i)(0) := RadCalc(i).io.xFWD(0)
        stage2Reg(i)(1) := RadCalc(i).io.xFWD(1)
        stage2Reg(i)(2) := RadCalc(i).io.out
    }
    stage2EN := RadCalc(0).io.ENout

    // stage2
    SinCosLut.io.EN := stage2EN
    for(i <- 0 until N) {
        SinCosLut.io.x(i)(0)  := stage2Reg(i)(0)
        SinCosLut.io.x(i)(1)  := stage2Reg(i)(1)
        SinCosLut.io.angle(i) := stage2Reg(i)(2)
    }

    // stage3 입력
    for(i <- 0 until N) {
        stage3Reg(i)(0) := SinCosLut.io.xFWD(i)(0)
        stage3Reg(i)(1) := SinCosLut.io.xFWD(i)(1)
        stage3Reg(i)(2) := SinCosLut.io.sinOut(i)
        stage3Reg(i)(3) := SinCosLut.io.cosOut(i)
    }
    stage3EN := SinCosLut.io.ENout

    // stage3
    for(i <- 0 until N) {
        RoPEcore(i).io.ENin   := stage3EN
        RoPEcore(i).io.xIn(0) := stage3Reg(i)(0)
        RoPEcore(i).io.xIn(1) := stage3Reg(i)(1)
        RoPEcore(i).io.sinIn  := stage3Reg(i)(2)
        RoPEcore(i).io.cosIn  := stage3Reg(i)(3)
    }

    // 출력
    val outputReg = RegInit(VecInit(Seq.fill(N)(VecInit(Seq.fill(2)(0.U(32.W))))))
    val validReg = RegNext(RoPEcore(0).io.ENout)

    for(i <- 0 until N) {
        outputReg(i)(0) := RoPEcore(i).io.xOut(0)
        outputReg(i)(1) := RoPEcore(i).io.xOut(1)
        io.xhat(i)(0)   := outputReg(i)(0)
        io.xhat(i)(1)   := outputReg(i)(1)
    }
    io.valid := validReg
}