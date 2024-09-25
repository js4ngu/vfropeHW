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


class FP32RoPEmodule(LutSize : Int, LutHalfSizeHEX : Int, SinCosOffset: Int) extends Module {
    val io = IO(new Bundle {
        val x       = Input(Vec(2, UInt(32.W)))
        val EN      = Input(Bool())
        val m       = Input(UInt(32.W))
        val i       = Input(UInt(32.W))
        val theta   = Input(UInt(32.W))
        val xhat    = Output(Vec(2, UInt(32.W)))
    })
    //필요한 모듈 선언   
    val RadCacl   = Module(new FP32radianCaclulator(LutSize, LutHalfSizeHEX))
    val SinCosLut = Module(new SinCosLUT(LutSize, LutHalfSizeHEX, SinCosOffset))
    val RoPEcore  = Module(new FP32RoPEcore())

    //stage1
    RadCacl.io.EN       := io.EN
    RadCacl.io.x(0)     := io.x(0)
    RadCacl.io.x(1)     := io.x(1)
    RadCacl.io.m        := io.m
    RadCacl.io.i        := io.i
    RadCacl.io.theta    := io.theta

    //stage2
    SinCosLut.io.EN     := RadCacl.io.ENout
    SinCosLut.io.angle  := RadCacl.io.out
    SinCosLut.io.x(0)   := RadCacl.io.xFWD(0)
    SinCosLut.io.x(1)   := RadCacl.io.xFWD(1)

    //stage3
    RoPEcore.io.EN      := SinCosLut.io.ENout
    RoPEcore.io.x(0)    := SinCosLut.io.xFWD(0)
    RoPEcore.io.x(1)    := SinCosLut.io.xFWD(1)
    RoPEcore.io.sin     := SinCosLut.io.sinOut
    RoPEcore.io.cos     := SinCosLut.io.cosOut    
}
