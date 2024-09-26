package vfrope
import chisel3._
import chisel3.util._

class FP32radianCaclulator(LutSize : Int, LutHalfSizeHEX : Int) extends Module {
    val io = IO(new Bundle {
        val x       = Input(Vec(2, UInt(32.W)))
        val EN      = Input(Bool())
        val m       = Input(UInt(32.W))
        val i       = Input(UInt(32.W))
        val theta   = Input(UInt(32.W))
        val out     = Output(UInt(32.W))
        val ENout   = Output(Bool())
        val xFWD    = Output(Vec(2, UInt(32.W)))
    })
    //printf(s"=== UPDATE CYCLE ===\n\n")

    //setup module vector
    val FP32Mult    = Seq.fill(2)(Module(new FP32Multiplier()))

    //setup pipe
    val ENReg    = RegInit(VecInit(Seq.fill(6)(0.B)))
    ENReg(0)    := io.EN
    ENReg(1)    := RegNext(ENReg(0))
    ENReg(2)    := RegNext(ENReg(1))
    ENReg(3)    := RegNext(ENReg(2))
    ENReg(4)    := RegNext(ENReg(3))
    ENReg(5)    := RegNext(ENReg(4))

    val thetaFP32 = RegInit(VecInit(Seq.fill(3)(0.U(32.W))))
    thetaFP32(0) := io.theta
    thetaFP32(1) := RegNext(thetaFP32(0))
    thetaFP32(2) := RegNext(thetaFP32(1))
    /*
    printf(s"theta : %d, %d, %d\n", thetaFP32(0), thetaFP32(1), thetaFP32(2))   //ok
    printf(s"EN    : %d, %d, %d, %d, %d, %d\n\n", ENReg(0), ENReg(1), ENReg(2), ENReg(3), ENReg(4), ENReg(5))   //ok
    */

    //Stage 1
    val mi = RegInit(0.S(32.W))
    mi     := (io.m * io.i).asSInt
    //printf(s"m, i, mi : %d, %d, %d\n", io.m, io.i, mi)  //ok
    
    //Stage 2
    val Int64ToFP32             = Module(new Int64ToFP32())
    val miFP32                  = RegInit(0.U(32.W))
    Int64ToFP32.io.inInt       := mi
    miFP32                     := Int64ToFP32.io.outIEEE
    //printf(s"mi, miFP32 : %d, %d\n", mi, miFP32) //ok

    //Stage 3
    val m_theta_i   = RegInit(0.U(32.W))
    FP32Mult(0).io.a   := miFP32
    FP32Mult(0).io.b   := thetaFP32(2)
    m_theta_i       := FP32Mult(0).io.result

    //printf(s"thetaFP32, miFP32, m_theta_i : %d, %d, %d\n", thetaFP32(2), miFP32, m_theta_i) //OK m theta i 1004000

    //Stage 4
    val quotient       = RegInit(0.U(32.W))
    val FP32DivPOW2    = Module(new FP32DivPOW2INT())
    FP32DivPOW2.io.a  := m_theta_i
    FP32DivPOW2.io.x  := 1.U //(LutSize - 1).U
    quotient          := FP32DivPOW2.io.result
    //printf(p"${m_theta_i} / 2 = ${quotient}\n") //490

    val lutFP32               = RegInit(0.U(32.W))
    lutFP32                  := LutHalfSizeHEX.U
    //printf(s"quotient, lutFP32 : %d %d\n", quotient, lutFP32) // 여기서 몫 490

    //Stage 5
    val modVal          = RegInit(0.U(32.W))
    FP32Mult(1).io.a   := quotient
    FP32Mult(1).io.b   := 0x40000000.U // 2^LUT한걸 해야함
    modVal             := FP32Mult(1).io.result
    //printf(s"quotient, lutFP32, modVal : %d %d %d\n", quotient, lutFP32, modVal) // modVal 5880

    //stage 6
    val FP32Sub    = Module(new FP32Sub())
    FP32Sub.io.a   := m_theta_i // m theta i 
    FP32Sub.io.b   := modVal
    io.out         := Mux(ENReg(5),FP32Sub.io.result,0.U(32.W))
    io.ENout       := Mux(ENReg(5),ENReg(5), 0.B)

    io.xFWD(0) := Mux(ENReg(5), io.x(0), 0.U(32.W))
    io.xFWD(1) := Mux(ENReg(5), io.x(1), 0.U(32.W))
}
/*
class FP32RoPEcore() extends Module {
    val io = IO(new Bundle {
        val EN      = Input(Bool())
        val x       = Input(Vec(2, UInt(32.W)))
        val sin     = Input(UInt(32.W))
        val cos     = Input(UInt(32.W))
        val xhat    = Output(Vec(2, UInt(32.W)))
        val ENout   = Output(Bool())
    })
    // setup pipe
    val ENReg    = RegInit(VecInit(Seq.fill(2)(0.B)))
    ENReg(0)    := io.EN
    ENReg(1)    := RegNext(ENReg(0))
    // printf(s"EN    : %d, %d\n", ENReg(0), ENReg(1))   //ok

    //stage1
    val x1sin = RegInit(0.U(32.W))
    val x1cos = RegInit(0.U(32.W))
    val x2sin = RegInit(0.U(32.W))
    val x2cos = RegInit(0.U(32.W))

    val FP32Mult0     = Module(new FP32Multiplier())
    FP32Mult0.io.a   := io.x(0)
    FP32Mult0.io.b   := io.sin
    x1sin            := FP32Mult0.io.result

    val FP32Mult1     = Module(new FP32Multiplier())
    FP32Mult1.io.a   := io.x(1)
    FP32Mult1.io.b   := io.sin
    x2sin            := FP32Mult1.io.result

    val FP32Mult2     = Module(new FP32Multiplier())
    FP32Mult2.io.a   := io.x(0)
    FP32Mult2.io.b   := io.cos
    x1cos            := FP32Mult2.io.result
    
    val FP32Mult3     = Module(new FP32Multiplier())
    FP32Mult3.io.a   := io.x(1)
    FP32Mult3.io.b   := io.cos
    x2cos            := FP32Mult3.io.result

    //stage2
    val FP32Sub     = Module(new FP32Sub())
    FP32Sub.io.a   := x1cos
    FP32Sub.io.b   := x2sin
    val x1cos_x2sin = FP32Sub.io.result

    val FP32add     = Module(new FP32Adder())
    FP32add.io.a   := x2cos
    FP32add.io.b   := x1sin
    val x2cos_x1sin = FP32add.io.result

    io.xhat(0)  := Mux(ENReg(1),x1cos_x2sin, 0.U(32.W))
    io.xhat(1)  := Mux(ENReg(1),x2cos_x1sin, 0.U(32.W))
    io.ENout    := Mux(ENReg(1),ENReg(1),    0.B)

    /*
    printf(s"\n=== UPDATE CYCLE ===\n\n")
    printf(s"x1, x2   : %d, %d\n", io.x(0), io.x(1))  //ok
    printf(s"sin, cos : %d, %d\n", io.sin, io.cos)  //ok
    printf(s"x1sin, x2sin, x1cos, x2cos : %d, %d,  %d, %d\n", x1sin, x2sin, x1cos, x2cos)  //ok

    printf(s"x1cos_x2sin, x2cos_x1sin : %d, %d\n", x1cos_x2sin, x2cos_x1sin )

    printf(s"[EN] x1cos-x2sin(xhat1) , x2cos+x1sin(xhat2) : [%b] %d, %d\n", ENReg(1), io.xhat(0), io.xhat(1))
    */
}
*/
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
    val stage2Reg = RegInit(VecInit(Seq.fill(4)(0.U(32.W))))
    val stage3Reg = RegInit(VecInit(Seq.fill(2)(0.U(32.W))))
    val enReg = RegInit(VecInit(Seq.fill(4)(false.B)))

    // EN 신호 전파
    enReg(0) := io.EN
    for (i <- 1 until 4) {
        enReg(i) := enReg(i-1)
    }

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

    stage2Reg := VecInit(FP32Mult0.io.result, FP32Mult1.io.result, FP32Mult2.io.result, FP32Mult3.io.result)

    // Stage 2: 덧셈과 뺄셈
    val FP32Sub = Module(new FP32Sub())
    FP32Sub.io.a := stage2Reg(2) // x1cos
    FP32Sub.io.b := stage2Reg(1) // x2sin

    val FP32add = Module(new FP32Adder())
    FP32add.io.a := stage2Reg(3) // x2cos
    FP32add.io.b := stage2Reg(0) // x1sin

    stage3Reg := VecInit(FP32Sub.io.result, FP32add.io.result)

    // 최종 출력
    io.xhat(0) := Mux(enReg(3), stage3Reg(0), 0.U)
    io.xhat(1) := Mux(enReg(3), stage3Reg(1), 0.U)
    io.ENout := enReg(3)

    // 디버그 출력
    printf(p"Debug: EN=${io.EN}, stage1EN=${enReg(0)}, stage2EN=${enReg(1)}, stage3EN=${enReg(2)}, outEN=${enReg(3)}\n")
    printf(p"Debug: x1=${io.x(0)}, x2=${io.x(1)}, sin=${io.sin}, cos=${io.cos}\n")
    printf(p"Debug: xhat1=${io.xhat(0)}, xhat2=${io.xhat(1)}, ENout=${io.ENout}\n")
}

class FP32RoPEmodule(LutSize: Int, LutHalfSizeHEX: Int, SinCosOffset: Int) extends Module {
    val io = IO(new Bundle {
        val x       = Input(Vec(2, UInt(32.W)))
        val EN      = Input(Bool())
        val m       = Input(UInt(32.W))
        val i       = Input(UInt(32.W))
        val theta   = Input(UInt(32.W))
        val xhat    = Output(Vec(2, UInt(32.W)))
        val valid   = Output(Bool())
    })
    
    // 필요한 모듈 선언   
    val RadCacl   = Module(new FP32radianCaclulator(LutSize, LutHalfSizeHEX))
    val SinCosLut = Module(new SinCosLUT(LutSize, LutHalfSizeHEX, SinCosOffset))
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
        stage1Reg(3) := io.i
        stage1Reg(4) := io.theta
        stage1EN     := true.B
    }.otherwise {
        stage1EN     := false.B
    }

    // stage1
    RadCacl.io.EN       := stage1EN
    RadCacl.io.x(0)     := stage1Reg(0)
    RadCacl.io.x(1)     := stage1Reg(1)
    RadCacl.io.m        := stage1Reg(2)
    RadCacl.io.i        := stage1Reg(3)
    RadCacl.io.theta    := stage1Reg(4)

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
}