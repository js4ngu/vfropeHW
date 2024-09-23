package vfrope
import chisel3._
import chisel3.util._

class FP32angleCaclulator(LutSize : Int) extends Module {
    val io = IO(new Bundle {
        val m       = Input(UInt(32.W))
        val i       = Input(UInt(32.W))
        val theta   = Input(UInt(32.W))
    })
    //setup pipe
    val thetaFP32 = RegInit(VecInit(Seq.fill(3)(0.U(32.W))))

    //Stage 1
    printf(s"\n=== UPDATE CYCLE ===\n\n")

    thetaFP32(0) := io.theta
    printf(s"theta : %d, %d, %d\n", thetaFP32(0), thetaFP32(1), thetaFP32(2))

    val mi = RegInit(0.S(32.W))
    mi     := Cat(0.U((32-LutSize).W),(io.m * io.i)(LutSize - 1,0)).asSInt
    printf(s"m, i, mi : %d, %d, %d\n", io.m, io.i, mi)
    
    //Stage 2
    thetaFP32(1) := RegNext(thetaFP32(0))
    thetaFP32(2) := RegNext(thetaFP32(1))

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
    val m_theta_i_norm = Wire(UInt(32.W))
    val modMask = (1.U(32.W) << (LutSize - 1)) - 1.U
    m_theta_i_norm := m_theta_i & modMask
    printf(s"modMask, m_theta_i_norm : %d, %d\n", modMask, m_theta_i_norm)
}
