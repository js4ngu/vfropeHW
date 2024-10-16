package vfrope
import chisel3._
import chisel3.util._
class FP32radianCaclulator(LutSize: Int, LutHalfSizeHEX: Int, Index : Int) extends Module { // index 인포메이션
    val io = IO(new Bundle {
        val x           = Input(Vec(2, UInt(32.W)))
        val EN          = Input(Bool())
        val m           = Input(UInt(32.W))
        val baseIndex   = Input(UInt(32.W))  // Changed from 'i' to 'baseIndex'        
        val TwoDivD       = Input(UInt(32.W))
        val out         = Output(UInt(32.W))
        val ENout       = Output(Bool())
        val xFWD        = Output(Vec(2, UInt(32.W)))
    })
    
    // 파이프라인 레지스터
    val stage1Reg = RegNext(VecInit(io.x(0), io.x(1), io.TwoDivD, (io.m * (io.baseIndex + Index.U)).asUInt)) // 추후에 m * (i+n) 으로 수정

    val stage2Reg = RegInit(VecInit(Seq.fill(4)(0.U(32.W))))
    val stage3Reg = RegInit(VecInit(Seq.fill(3)(0.U(32.W))))
    val stage4Reg = RegInit(VecInit(Seq.fill(3)(0.U(32.W))))
    val stage5Reg = RegInit(VecInit(Seq.fill(4)(0.U(32.W))))
    val stage6Reg = RegInit(VecInit(Seq.fill(3)(0.U(32.W))))
    val enReg = RegInit(VecInit(Seq.fill(6)(false.B)))

    // EN 신호 전파
    enReg(0) := io.EN
    for (i <- 1 until 6) {
        enReg(i) := enReg(i-1)
    }

    // sclae value theta(2/d) / theta(2/4096) = d / 4096 = scale
    // Stage 1: mi 계산 (이미 stage1Reg에서 수행됨)

    // Stage 2: Int64ToFP32 변환
    val Int64ToFP32 = Module(new Int64ToFP32())
    Int64ToFP32.io.inInt := stage1Reg(3).asSInt
    stage2Reg := VecInit(stage1Reg(0), stage1Reg(1), stage1Reg(2), Int64ToFP32.io.outIEEE)

    // Stage 3: m_theta_i 계산
    val FP32Mult0 = Module(new FP32Multiplier())
    FP32Mult0.io.a := stage2Reg(3)  // miFP32
    FP32Mult0.io.b := stage2Reg(2)  // TwoDivD
    stage3Reg := VecInit(stage2Reg(0), stage2Reg(1), FP32Mult0.io.result)
    
    // Stage 4: 나눗셈
    val FP32DivPOW2 = Module(new FP32DivPOW2INT())
    FP32DivPOW2.io.a := stage3Reg(2)  // m_theta_i
    //FP32DivPOW2.io.a := Mux(enReg(2), stage3Reg(2), 0.U)  // m_theta_i
    FP32DivPOW2.io.x := 1.U
    stage4Reg := VecInit(stage3Reg(0), stage3Reg(1), FP32DivPOW2.io.result)

    // Stage 5: modVal 계산
    val FP32Mult1 = Module(new FP32Multiplier())
    FP32Mult1.io.a := stage4Reg(2)  // quotient
    FP32Mult1.io.b := 0x40000000.U  // 2
    stage5Reg := VecInit(stage4Reg(0), stage4Reg(1), stage3Reg(2), FP32Mult1.io.result)

    // Add a new register to delay m_theta_i
    val delayedMThetaI = RegInit(0.U(32.W))
    delayedMThetaI := stage5Reg(2)

    // Stage 6: 최종 결과 계산
    val FP32Sub = Module(new FP32Sub())
    //FP32Sub.io.a := stage5Reg(2)  // m_theta_i
    FP32Sub.io.a := delayedMThetaI  // Use the delayed m_theta_i
    FP32Sub.io.b := stage5Reg(3)  // modVal
    stage6Reg := VecInit(stage5Reg(0), stage5Reg(1), FP32Sub.io.result)

    // 출력
    io.out     := Mux(enReg(5), stage6Reg(2), 0.U)
    io.xFWD(0) := Mux(enReg(5), stage6Reg(0), 0.U)
    io.xFWD(1) := Mux(enReg(5), stage6Reg(1), 0.U)
    io.ENout   := enReg(5)

    // 디버그 출력 (필요시 주석 해제)
    /*
    printf(p"Debug: EN=${io.EN}, stage1EN=${enReg(0)}, ..., stage6EN=${enReg(5)}\n")
    printf(p"Debug: x1=${io.x(0)}, x2=${io.x(1)}, TwoDivD=${io.TwoDivD}, m=${io.m}, i=${io.i}\n")
    printf(p"Debug: out=${io.out}, xFWD1=${io.xFWD(0)}, xFWD2=${io.xFWD(1)}, ENout=${io.ENout}\n")
    */
}

class FP32RoPEcore() extends Module {
    val io = IO(new Bundle {
        val EN      = Input(Bool())
        val x       = Input(Vec(2, UInt(32.W)))
        val sin     = Input(UInt(32.W))
        val cos     = Input(UInt(32.W))
        val xhat    = Output(Vec(2, UInt(32.W)))
        val ENout   = Output(Bool())
    })
    
    // 파이프라인 레지스터
    val stage1Reg = RegNext(VecInit(io.x(0), io.x(1), io.sin, io.cos))
    val stage2Reg = RegNext(VecInit(Seq.fill(4)(0.U(32.W))))
    val stage3Reg = RegInit(VecInit(Seq.fill(2)(0.U(32.W))))
    val enReg = RegInit(VecInit(Seq.fill(3)(false.B)))

    // EN 신호 전파
    enReg(0) := io.EN
    enReg(1) := enReg(0)
    enReg(2) := enReg(1)

    // Stage 1: 곱셈
    val FP32Mult0 = Module(new FP32Multiplier())
    FP32Mult0.io.a := stage1Reg(0) // x(0)
    FP32Mult0.io.b := stage1Reg(2) // sin

    val FP32Mult1 = Module(new FP32Multiplier())
    FP32Mult1.io.a := stage1Reg(1) // x(1)
    FP32Mult1.io.b := stage1Reg(2) // sin

    val FP32Mult2 = Module(new FP32Multiplier())
    FP32Mult2.io.a := stage1Reg(0) // x(0)
    FP32Mult2.io.b := stage1Reg(3) // cos

    val FP32Mult3 = Module(new FP32Multiplier())
    FP32Mult3.io.a := stage1Reg(1) // x(1)
    FP32Mult3.io.b := stage1Reg(3) // cos

    // Stage 2: 곱셈 결과 저장
    stage2Reg := VecInit(
        FP32Mult0.io.result, // x1sin
        FP32Mult1.io.result, // x2sin
        FP32Mult2.io.result, // x1cos
        FP32Mult3.io.result  // x2cos
    )

    // Stage 3: 덧셈과 뺄셈
    val FP32Sub = Module(new FP32Sub())
    FP32Sub.io.a := stage2Reg(2) // x1cos
    FP32Sub.io.b := stage2Reg(1) // x2sin

    val FP32add = Module(new FP32Adder())
    FP32add.io.a := stage2Reg(3) // x2cos
    FP32add.io.b := stage2Reg(0) // x1sin

    stage3Reg := VecInit(FP32Sub.io.result, FP32add.io.result)

    // 최종 출력
    io.xhat(0) := Mux(enReg(2), stage3Reg(0), 0.U)
    io.xhat(1) := Mux(enReg(2), stage3Reg(1), 0.U)
    io.ENout := enReg(2)

    // 디버그 출력 (필요시 주석 해제)
    /*
    printf(p"Debug: EN=${io.EN}, stage1EN=${enReg(0)}, stage2EN=${enReg(1)}, stage3EN=${enReg(2)}\n")
    printf(p"Debug: x1=${io.x(0)}, x2=${io.x(1)}, sin=${io.sin}, cos=${io.cos}\n")
    printf(p"Debug: xhat1=${io.xhat(0)}, xhat2=${io.xhat(1)}, ENout=${io.ENout}\n")
    */
}

class FP32RoPEmodule(LutSize: Int, LutHalfSizeHEX: Int, Index : Int) extends Module {
    val io = IO(new Bundle {
        val x       = Input(Vec(2, UInt(32.W)))
        val EN      = Input(Bool())
        val m       = Input(UInt(32.W))
        val baseIndex   = Input(UInt(32.W))  // Changed from 'i' to 'baseIndex'
        val TwoDivD   = Input(UInt(32.W))
        val xhat    = Output(Vec(2, UInt(32.W)))
        val valid   = Output(Bool())
    })
    
    // 필요한 모듈 선언   
    val RadCacl   = Module(new FP32radianCaclulator(LutSize, LutHalfSizeHEX, Index))
    val SinCosLut = Module(new SinCosLUT(LutSize, LutHalfSizeHEX))
    val RoPEcore  = Module(new FP32RoPEcore())

    // 파이프라인 레지스터와 EN 신호
    val stage1Reg = RegInit(VecInit(Seq.fill(6)(0.U(32.W))))
    val stage1EN  = RegInit(false.B)
    val stage2Reg = RegInit(VecInit(Seq.fill(4)(0.U(32.W))))
    val stage2EN  = RegInit(false.B)
    val stage3Reg = RegInit(VecInit(Seq.fill(5)(0.U(32.W))))
    val stage3EN  = RegInit(false.B)

    // stage1 입력
    when(io.EN) {
        stage1Reg(0) := io.x(0)
        stage1Reg(1) := io.x(1)
        stage1Reg(2) := io.m
        stage1Reg(3) := io.baseIndex  // Changed from 'io.i' to 'io.baseIndex'
        stage1Reg(4) := io.TwoDivD
        stage1EN     := true.B
    }.otherwise {
        stage1EN     := false.B
    }

    // stage1
    RadCacl.io.EN           := stage1EN
    RadCacl.io.x(0)         := stage1Reg(0)
    RadCacl.io.x(1)         := stage1Reg(1)
    RadCacl.io.m            := stage1Reg(2)
    RadCacl.io.baseIndex    := stage1Reg(3)
    RadCacl.io.TwoDivD        := stage1Reg(4)

    // stage2 입력
    stage2Reg(0) := RadCacl.io.xFWD(0)
    stage2Reg(1) := RadCacl.io.xFWD(1)
    stage2Reg(2) := RadCacl.io.out
    stage2EN     := RadCacl.io.ENout

    // stage2
    SinCosLut.io.EN     := stage2EN
    SinCosLut.io.angle  := stage2Reg(2)
    SinCosLut.io.x(0)   := stage2Reg(0)
    SinCosLut.io.x(1)   := stage2Reg(1)

    // stage3 입력
    stage3Reg(0) := SinCosLut.io.xFWD(0)
    stage3Reg(1) := SinCosLut.io.xFWD(1)
    stage3Reg(2) := SinCosLut.io.sinOut
    stage3Reg(3) := SinCosLut.io.cosOut
    stage3EN     := SinCosLut.io.ENout

    // stage3
    RoPEcore.io.EN      := stage3EN
    RoPEcore.io.x(0)    := stage3Reg(0)
    RoPEcore.io.x(1)    := stage3Reg(1)
    RoPEcore.io.sin     := stage3Reg(2)
    RoPEcore.io.cos     := stage3Reg(3)

    // 출력
    val outputReg = RegNext(VecInit(RoPEcore.io.xhat(0), RoPEcore.io.xhat(1)))
    val validReg  = RegNext(RoPEcore.io.ENout)

    io.xhat(0) := outputReg(0)
    io.xhat(1) := outputReg(1)
    io.valid   := validReg
    /*
    // 디버그 출력 (파이프라인 단계별 출력)
    printf(s"--------RadCacl (Stage 1 Output)---------\n")
    printf(s"[EN] x0, x1, Rad             : [%b] %d, %d, %d\n", RadCacl.io.ENout, RadCacl.io.xFWD(0), RadCacl.io.xFWD(1), RadCacl.io.out)
    
    printf(s"-------SinCosLut (Stage 2 Output)--------\n")
    printf(s"[EN] x0, x1, Sin, Cos        : [%b] %d, %d, %d, %d\n", SinCosLut.io.ENout, SinCosLut.io.xFWD(0), SinCosLut.io.xFWD(1), SinCosLut.io.sinOut, SinCosLut.io.cosOut)
    
    printf(s"--------RoPEcore (Stage 3 Output)--------\n")
    printf(s"[EN] x0, x1, xhat0, xhat1    : [%b] %d, %d, %d, %d\n", RoPEcore.io.ENout, RoPEcore.io.x(0), RoPEcore.io.x(1), RoPEcore.io.xhat(0), RoPEcore.io.xhat(1))
    
    printf(s"--------Final Output--------\n")
    printf(s"[Valid] xhat0, xhat1         : [%b] %d, %d\n", io.valid, io.xhat(0), io.xhat(1))
    printf(s"#############################\n")

    // Additional debug output
    printf(s"Debug: stage1EN = %b, stage2EN = %b, stage3EN = %b\n", stage1EN, stage2EN, stage3EN)
    printf(s"Debug: RoPEcore.io.ENout = %b, validReg = %b\n", RoPEcore.io.ENout, validReg)
    */
}

class FP32smallRoPEmodule(Index : Int, LutSize : Int, LutHalfSizeHEX : Int, doublePi : Int, OneAndHalfPi : Int, Pi : Int, halfPi : Int) extends Module {
    val io = IO(new Bundle {
        val x       = Input(Vec(2, UInt(32.W)))
        val EN      = Input(Bool())
        val m       = Input(UInt(32.W))
        val baseIndex   = Input(UInt(32.W))  // Changed from 'i' to 'baseIndex'
        val TwoDivD   = Input(UInt(32.W))
        val xhat    = Output(Vec(2, UInt(32.W)))
        val valid   = Output(Bool())
    })
    
    // 필요한 모듈 선언   
    val RadCacl   = Module(new FP32radianCaclulator(LutSize, LutHalfSizeHEX, Index))
    val SinCosLut = Module(new dualPortSinCosLUT(LutSize, LutHalfSizeHEX, doublePi, OneAndHalfPi, Pi, halfPi))
    val RoPEcore  = Module(new FP32RoPEcore())

    // 파이프라인 레지스터와 EN 신호
    val stage1Reg = RegInit(VecInit(Seq.fill(6)(0.U(32.W))))
    val stage1EN  = RegInit(false.B)
    val stage2Reg = RegInit(VecInit(Seq.fill(4)(0.U(32.W))))
    val stage2EN  = RegInit(false.B)
    val stage3Reg = RegInit(VecInit(Seq.fill(5)(0.U(32.W))))
    val stage3EN  = RegInit(false.B)

    // stage1 입력
    when(io.EN) {
        stage1Reg(0) := io.x(0)
        stage1Reg(1) := io.x(1)
        stage1Reg(2) := io.m
        stage1Reg(3) := io.baseIndex  // Changed from 'io.i' to 'io.baseIndex'
        stage1Reg(4) := io.TwoDivD
        stage1EN     := true.B
    }.otherwise {
        stage1EN     := false.B
    }

    // stage1
    RadCacl.io.EN           := stage1EN
    RadCacl.io.x(0)         := stage1Reg(0)
    RadCacl.io.x(1)         := stage1Reg(1)
    RadCacl.io.m            := stage1Reg(2)
    RadCacl.io.baseIndex    := stage1Reg(3)
    RadCacl.io.TwoDivD        := stage1Reg(4)

    // stage2 입력
    stage2Reg(0) := RadCacl.io.xFWD(0)
    stage2Reg(1) := RadCacl.io.xFWD(1)
    stage2Reg(2) := RadCacl.io.out
    stage2EN     := RadCacl.io.ENout

    // stage2
    SinCosLut.io.EN     := stage2EN
    SinCosLut.io.angle  := stage2Reg(2)
    SinCosLut.io.x(0)   := stage2Reg(0)
    SinCosLut.io.x(1)   := stage2Reg(1)

    // stage3 입력
    stage3Reg(0) := SinCosLut.io.xFWD(0)
    stage3Reg(1) := SinCosLut.io.xFWD(1)
    stage3Reg(2) := SinCosLut.io.sinOut
    stage3Reg(3) := SinCosLut.io.cosOut
    stage3EN     := SinCosLut.io.ENout

    // stage3
    RoPEcore.io.EN      := stage3EN
    RoPEcore.io.x(0)    := stage3Reg(0)
    RoPEcore.io.x(1)    := stage3Reg(1)
    RoPEcore.io.sin     := stage3Reg(2)
    RoPEcore.io.cos     := stage3Reg(3)

    // 출력
    val outputReg = RegNext(VecInit(RoPEcore.io.xhat(0), RoPEcore.io.xhat(1)))
    val validReg  = RegNext(RoPEcore.io.ENout)

    io.xhat(0) := outputReg(0)
    io.xhat(1) := outputReg(1)
    io.valid   := validReg
}
