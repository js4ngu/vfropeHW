package vfrope
import chisel3._
import chisel3.util._

class FP32angleCaclulator(LutSize : Int) extends Module {
    val io = IO(new Bundle {
        val m       = Input(UInt(32.W))
        val i       = Input(UInt(32.W))
        val theta   = Input(UInt(32.W))
        val out     = Output(UInt(32.W))

    })
    printf(s"\n=== UPDATE CYCLE ===\n\n")

    //setup pipe
    val thetaFP32 = RegInit(VecInit(Seq.fill(6)(0.U(32.W))))
    thetaFP32(0) := io.theta
    thetaFP32(1) := RegNext(thetaFP32(0))
    thetaFP32(2) := RegNext(thetaFP32(1))
    thetaFP32(4) := RegNext(thetaFP32(3))
    thetaFP32(5) := RegNext(thetaFP32(4))
    printf(s"theta : %d, %d, %d, %d, %d, %d\n", thetaFP32(0), thetaFP32(1), thetaFP32(2) , thetaFP32(3), thetaFP32(4), thetaFP32(5))

    //Stage 1
    val mi = RegInit(0.S(32.W))
    mi     := Cat(0.U((32-LutSize).W),(io.m * io.i)(LutSize - 1,0)).asSInt
    printf(s"m, i, mi : %d, %d, %d\n", io.m, io.i, mi)
    
    //Stage 2
    val Int32ToFP32 = Module(new Int32ToFP32())
    val miFP32      = RegInit(0.U(32.W))
    Int32ToFP32.io.inInt    := mi
    miFP32                  := Int32ToFP32.io.outIEEE
    printf(s"mi, miFP32 : %d, %d\n", mi, miFP32)

    //Stage 3
    val m_theta_i   = RegInit(0.U(32.W))
    val FP32Mult    = Module(new FP32Multiplier())
    FP32Mult.io.a   := miFP32
    FP32Mult.io.b   := thetaFP32(2)
    m_theta_i       := FP32Mult.io.result

    printf(s"thetaFP32, miFP32, m_theta_i : %d, %d, %d\n", thetaFP32(2), miFP32, m_theta_i)

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
    printf(s"quotient, lutFP32 : %d %d\n", quotient, lutFP32)

    //Stage 5
    val modVal       = RegInit(0.U(32.W))
    val FP32Mult2    = Module(new FP32Multiplier())
    FP32Mult2.io.a   := quotient
    FP32Mult2.io.b   := lutFP32
    modVal           := FP32Mult2.io.result
    printf(s"quotient, lutFP32, modVal : %d %d %d\n", quotient, lutFP32, modVal)

    //stage 6
    val FP32Sub    = Module(new FP32Sub())
    FP32Sub.io.a   := lutFP32
    FP32Sub.io.b   := modVal
    io.out         := FP32Sub.io.result
    printf(s"Output : %d\n", io.out)
}
