package vfrope
import chisel3._
import chisel3.util._
import hardfloat._

class fmaROPE extends Module {
  val io = IO(new Bundle {
    val ENin  = Input(Bool())
    val ENout = Output(Bool())
    val xIn   = Input(Vec(2, UInt(32.W)))
    val sinIn = Input(UInt(32.W))
    val cosIn = Input(UInt(32.W))
    val xOut  = Output(Vec(2, UInt(32.W)))
  })

  // Two FMA instances
  val fmaUnits = Seq.fill(2)(Module(new FMA))

  // Pipeline stage valid flags
  val stage1Valid = RegInit(false.B)
  val stage2Valid = RegInit(false.B)
  val stage2WaitCycle = RegInit(0.U(2.W))
  val outputValid = RegInit(false.B)

  // Pipeline registers
  val xInReg = Reg(Vec(2, UInt(32.W)))
  val sinReg = Reg(UInt(32.W))
  val cosReg = Reg(UInt(32.W))
  val stage1Results = Reg(Vec(2, UInt(32.W)))  // x0cos, x1cos 저장
  val outputReg = Reg(Vec(2, UInt(32.W)))

  // Default values for FMA units
  fmaUnits.foreach { fma =>
    fma.io.op := 0.U
    fma.io.a := 0.U
    fma.io.b := 0.U
    fma.io.c := 0.U
    fma.io.validin := false.B
  }

  // Connect output signals
  io.ENout := outputValid
  io.xOut := outputReg

  // Stage 1 control logic
  when(!stage1Valid) {
    when(io.ENin) {
      xInReg := io.xIn
      sinReg := io.sinIn
      cosReg := io.cosIn
      stage1Valid := true.B
    }
  }.otherwise {
    // Stage 1 FMA operations
    fmaUnits(0).io.op := 0.U
    fmaUnits(0).io.a := xInReg(0)
    fmaUnits(0).io.b := cosReg
    fmaUnits(0).io.c := 0.U
    fmaUnits(0).io.validin := true.B

    fmaUnits(1).io.op := 0.U
    fmaUnits(1).io.a := xInReg(1)
    fmaUnits(1).io.b := cosReg
    fmaUnits(1).io.c := 0.U
    fmaUnits(1).io.validin := true.B

    when(fmaUnits(0).io.validout && fmaUnits(1).io.validout) {
      stage1Results(0) := fmaUnits(0).io.out
      stage1Results(1) := fmaUnits(1).io.out
      stage1Valid := false.B
      stage2Valid := true.B
      stage2WaitCycle := 0.U
    }
  }

  // Stage 2 control logic
  when(stage2Valid) {
    // Stage 2 FMA operations
    fmaUnits(0).io.op := 2.U  // subtract
    fmaUnits(0).io.a := xInReg(1)
    fmaUnits(0).io.b := sinReg
    fmaUnits(0).io.c := stage1Results(0)
    fmaUnits(0).io.validin := true.B

    fmaUnits(1).io.op := 0.U  // add
    fmaUnits(1).io.a := xInReg(0)
    fmaUnits(1).io.b := sinReg
    fmaUnits(1).io.c := stage1Results(1)
    fmaUnits(1).io.validin := true.B

    when(fmaUnits(0).io.validout && fmaUnits(1).io.validout) {
      when(stage2WaitCycle === 2.U) {
        outputReg(0) := fmaUnits(0).io.out
        outputReg(1) := fmaUnits(1).io.out
        outputValid := true.B
        stage2Valid := false.B
      }.otherwise {
        stage2WaitCycle := stage2WaitCycle + 1.U
      }
    }
  }
  // Reset output valid flag when new input starts
  when(io.ENin) {
    outputValid := false.B
    outputReg(0) := 0.U
    outputReg(1) := 0.U
  }
}
