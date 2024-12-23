package vfrope
import chisel3._
import chisel3.util._
import hardfloat._

class MulAddRecFNPipe(latency: Int, expWidth: Int, sigWidth: Int) extends Module
{
    override def desiredName = s"MulAddRecFNPipe_l${latency}_e${expWidth}_s${sigWidth}"
    require(latency<=2)

    val io = IO(new Bundle {
        val validin = Input(Bool())
        val op = Input(Bits(2.W))
        val a = Input(Bits((expWidth + sigWidth + 1).W))
        val b = Input(Bits((expWidth + sigWidth + 1).W))
        val c = Input(Bits((expWidth + sigWidth + 1).W))
        val roundingMode   = Input(UInt(3.W))
        val detectTininess = Input(UInt(1.W))
        val out = Output(Bits((expWidth + sigWidth + 1).W))
        val exceptionFlags = Output(Bits(5.W))
        val validout = Output(Bool())
    })

    //------------------------------------------------------------------------
    //------------------------------------------------------------------------

    val mulAddRecFNToRaw_preMul = Module(new hardfloat.MulAddRecFNToRaw_preMul(expWidth, sigWidth))
    val mulAddRecFNToRaw_postMul = Module(new hardfloat.MulAddRecFNToRaw_postMul(expWidth, sigWidth))

    mulAddRecFNToRaw_preMul.io.op := io.op
    mulAddRecFNToRaw_preMul.io.a  := io.a
    mulAddRecFNToRaw_preMul.io.b  := io.b
    mulAddRecFNToRaw_preMul.io.c  := io.c

    val mulAddResult =
        (mulAddRecFNToRaw_preMul.io.mulAddA *
             mulAddRecFNToRaw_preMul.io.mulAddB) +&
            mulAddRecFNToRaw_preMul.io.mulAddC

    val valid_stage0 = Wire(Bool())
    val roundingMode_stage0 = Wire(UInt(3.W))
    val detectTininess_stage0 = Wire(UInt(1.W))

    val postmul_regs = if(latency>0) 1 else 0
    mulAddRecFNToRaw_postMul.io.fromPreMul   := Pipe(io.validin, mulAddRecFNToRaw_preMul.io.toPostMul, postmul_regs).bits
    mulAddRecFNToRaw_postMul.io.mulAddResult := Pipe(io.validin, mulAddResult, postmul_regs).bits
    mulAddRecFNToRaw_postMul.io.roundingMode := Pipe(io.validin, io.roundingMode, postmul_regs).bits
    roundingMode_stage0                      := Pipe(io.validin, io.roundingMode, postmul_regs).bits
    detectTininess_stage0                    := Pipe(io.validin, io.detectTininess, postmul_regs).bits
    valid_stage0                             := Pipe(io.validin, false.B, postmul_regs).valid

    //------------------------------------------------------------------------
    //------------------------------------------------------------------------

    val roundRawFNToRecFN = Module(new hardfloat.RoundRawFNToRecFN(expWidth, sigWidth, 0))

    val round_regs = if(latency==2) 1 else 0
    roundRawFNToRecFN.io.invalidExc         := Pipe(valid_stage0, mulAddRecFNToRaw_postMul.io.invalidExc, round_regs).bits
    roundRawFNToRecFN.io.in                 := Pipe(valid_stage0, mulAddRecFNToRaw_postMul.io.rawOut, round_regs).bits
    roundRawFNToRecFN.io.roundingMode       := Pipe(valid_stage0, roundingMode_stage0, round_regs).bits
    roundRawFNToRecFN.io.detectTininess     := Pipe(valid_stage0, detectTininess_stage0, round_regs).bits
    io.validout                             := Pipe(valid_stage0, false.B, round_regs).valid

    roundRawFNToRecFN.io.infiniteExc := false.B

    io.out            := roundRawFNToRecFN.io.out
    io.exceptionFlags := roundRawFNToRecFN.io.exceptionFlags
}

class FMA extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(32.W))    // IEEE-754 32비트 입력
    val b = Input(UInt(32.W))    // IEEE-754 32비트 입력
    val c = Input(UInt(32.W))    // IEEE-754 32비트 입력
    val op = Input(UInt(2.W))    // 연산 타입
    val out = Output(UInt(32.W))  // IEEE-754 32비트 출력
    val validin = Input(Bool())
    val validout = Output(Bool())
  })

  // Constants for FP32
  val expWidth = 8
  val sigWidth = 24
  // Rounding mode constants
  val round_near_even = 0.U(3.W)
  val tininess_afterRounding = 1.U(1.W)

  // Convert IEEE-754 inputs to recoded format
  val a_recoded = recFNFromFN(expWidth, sigWidth, io.a)
  val b_recoded = recFNFromFN(expWidth, sigWidth, io.b)
  val c_recoded = recFNFromFN(expWidth, sigWidth, io.c)

  // Instantiate MulAddRecFNPipe
  val fmaPipe = Module(new MulAddRecFNPipe(2, expWidth, sigWidth))
  
  // Connect inputs
  fmaPipe.io.a := a_recoded
  fmaPipe.io.b := b_recoded
  fmaPipe.io.c := c_recoded
  fmaPipe.io.op := io.op
  fmaPipe.io.roundingMode := round_near_even
  fmaPipe.io.detectTininess := tininess_afterRounding
  fmaPipe.io.validin := io.validin

  // Convert result back to IEEE-754 format
  io.out := fNFromRecFN(expWidth, sigWidth, fmaPipe.io.out)
  io.validout := fmaPipe.io.validout
}





class RoPEFMA extends Module {
    val io = IO(new Bundle {
        val xa = Input(UInt(32.W))
        val xb = Input(UInt(32.W))
        val sin = Input(UInt(32.W))
        val cos = Input(UInt(32.W))
        val en = Input(Bool())
        
        val xhat_a = Output(UInt(32.W))
        val xhat_b = Output(UInt(32.W))
        val valid = Output(Bool())
    })
    
    // FMAs
    val fma_left = Module(new FMA())
    val fma_right = Module(new FMA())
    
    // 파이프라인 레지스터
    val stage1_reg = RegInit(VecInit(Seq.fill(4)(0.U(32.W))))  // xa, xb, sin, cos
    val stage1_valid = RegInit(false.B)
    val stage2_reg = RegInit(VecInit(Seq.fill(2)(0.U(32.W))))  // 중간 결과
    val stage2_valid = RegInit(false.B)

    // 기본값 설정
    fma_left.io.a := 0.U
    fma_left.io.b := 0.U
    fma_left.io.c := 0.U
    fma_left.io.op := 0.U
    fma_left.io.validin := false.B

    fma_right.io.a := 0.U
    fma_right.io.b := 0.U
    fma_right.io.c := 0.U
    fma_right.io.op := 0.U
    fma_right.io.validin := false.B
    
    // Stage 1: 입력 저장
    when(io.en) {
        stage1_reg(0) := io.xa
        stage1_reg(1) := io.xb
        stage1_reg(2) := io.sin
        stage1_reg(3) := io.cos
        stage1_valid := true.B
    }.otherwise {
        stage1_valid := false.B
    }
    
    // Stage 2: 첫 번째 FMA 연산
    when(stage1_valid) {
        // 왼쪽 FMA: (xa × sin) + xa
        fma_left.io.a := stage1_reg(0)  // xa
        fma_left.io.b := stage1_reg(2)  // sin
        fma_left.io.c := stage1_reg(0)  // xa
        fma_left.io.op := 0.U
        fma_left.io.validin := true.B
        
        // 오른쪽 FMA: (xb × cos) + xb
        fma_right.io.a := stage1_reg(1)  // xb
        fma_right.io.b := stage1_reg(3)  // cos
        fma_right.io.c := stage1_reg(1)  // xb
        fma_right.io.op := 0.U
        fma_right.io.validin := true.B
    }
    
    // 중간 결과 저장
    when(fma_left.io.validout && fma_right.io.validout && stage1_valid) {
        stage2_reg(0) := fma_left.io.out
        stage2_reg(1) := fma_right.io.out
        stage2_valid := true.B
    }.otherwise {
        stage2_valid := false.B
    }
    
    // Stage 3: 두 번째 FMA 연산
    when(stage2_valid) {
        // 왼쪽 FMA: (xb × cos) + prev_result
        fma_left.io.a := stage1_reg(1)   // xb
        fma_left.io.b := stage1_reg(3)   // cos
        fma_left.io.c := stage2_reg(0)   // prev result
        fma_left.io.op := 0.U
        fma_left.io.validin := true.B
        
        // 오른쪽 FMA: (xb × sin) - prev_result
        fma_right.io.a := stage1_reg(1)  // xb
        fma_right.io.b := stage1_reg(2)  // sin
        fma_right.io.c := stage2_reg(1)  // prev result
        fma_right.io.op := 1.U
        fma_right.io.validin := true.B
    }
    
    // 출력
    io.xhat_a := fma_left.io.out
    io.xhat_b := fma_right.io.out
    io.valid := stage2_valid && fma_left.io.validout && fma_right.io.validout
}
