package vfrope
import chisel3._
import chisel3.util._

class FP32angleCaclulator(LutSize : Int) extends Module {
    val io = IO(new Bundle {
        val EN      = Input(Bool())
        val m       = Input(UInt(32.W))
        val i       = Input(UInt(32.W))
        val theta   = Input(UInt(32.W))
        val out     = Output(UInt(32.W))
        val ENout   = Output(Bool())
    })
    printf(s"\n=== UPDATE CYCLE ===\n\n")

    //setup pipe
    val ENReg     = RegInit(VecInit(Seq.fill(6)(0.B)))
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

    printf(s"theta : %d, %d, %d\n", thetaFP32(0), thetaFP32(1), thetaFP32(2))   //ok
    printf(s"EN    : %d, %d, %d, %d, %d, %d\n\n", ENReg(0), ENReg(1), ENReg(2), ENReg(3), ENReg(4), ENReg(5))   //ok

    //Stage 1
    val mi = RegInit(0.S(32.W))
    mi     := Cat(0.U((32-LutSize).W),(io.m * io.i)(LutSize - 1,0)).asSInt
    printf(s"m, i, mi : %d, %d, %d\n", io.m, io.i, mi)  //ok
    
    //Stage 2
    val Int32ToFP32 = Module(new Int32ToFP32())
    val miFP32      = RegInit(0.U(32.W))
    Int32ToFP32.io.inInt    := mi
    miFP32                  := Int32ToFP32.io.outIEEE
    printf(s"mi, miFP32 : %d, %d\n", mi, miFP32) //ok

    //Stage 3
    val m_theta_i   = RegInit(0.U(32.W))
    val FP32Mult    = Module(new FP32Multiplier())
    FP32Mult.io.a   := miFP32
    FP32Mult.io.b   := thetaFP32(2)
    m_theta_i       := FP32Mult.io.result

    printf(s"thetaFP32, miFP32, m_theta_i : %d, %d, %d\n", thetaFP32(2), miFP32, m_theta_i) //OK

    //Stage 4
    val quotient       = RegInit(0.U(32.W))
    val FP32DivPOW2    = Module(new FP32DivPOW2())
    FP32DivPOW2.io.a  := m_theta_i
    FP32DivPOW2.io.x  := (LutSize - 1).U
    quotient          := FP32DivPOW2.io.result

    val Int32ToFP32_2 = Module(new Int32ToFP32())
    val lutFP32        = RegInit(0.U(32.W))
    Int32ToFP32_2.io.inInt   := LutSize.asSInt
    lutFP32                  := Int32ToFP32_2.io.outIEEE
    printf(s"quotient, lutFP32 : %d %d\n", quotient, lutFP32) // 여기서 몫이 소수점으로 나옴.

    //Stage 5
    val modVal       = RegInit(0.U(32.W))
    val FP32Mult2    = Module(new FP32Multiplier())
    FP32Mult2.io.a   := quotient
    FP32Mult2.io.b   := lutFP32
    modVal           := FP32Mult2.io.result
    printf(s"quotient, lutFP32, modVal : %d %d %d\n", quotient, lutFP32, modVal) // ok

    //stage 6
    val FP32Sub    = Module(new FP32Sub())
    FP32Sub.io.a   := m_theta_i // m theta i 
    FP32Sub.io.b   := modVal
    io.out         := Mux(ENReg(5),FP32Sub.io.result,0.U(32.W))
    io.ENout       := Mux(ENReg(5),ENReg(5), 0.B)
    printf(s"(EN) m_theta_i - modVal = Output : (%b) %d - %d = %d\n",io.ENout, m_theta_i,  modVal, io.out)
}
