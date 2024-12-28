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

  // State definitions
  object State extends ChiselEnum {
    val sIdle, sStage1, sStage2 = Value
  }
  import State._
  val state = RegInit(State.sIdle)

  // Pipeline registers
  val xInReg = Reg(Vec(2, UInt(32.W)))
  val sinReg = Reg(UInt(32.W))
  val cosReg = Reg(UInt(32.W))
  val stage1Results = Reg(Vec(2, UInt(32.W)))  // x0cos, x1cos 저장
  val outputReg = Reg(Vec(2, UInt(32.W)))

  // Default values
  fmaUnits.foreach { fma =>
    fma.io.op := 0.U
    fma.io.a := 0.U
    fma.io.b := 0.U
    fma.io.c := 0.U
    fma.io.validin := false.B
  }

  io.ENout := false.B
  io.xOut := outputReg

  // State machine
  switch(state) {
    is(State.sIdle) {
      when(io.ENin) {
        xInReg := io.xIn
        sinReg := io.sinIn
        cosReg := io.cosIn
        state := State.sStage1
      }
    }

    is(State.sStage1) {
      // Configure FMAs for cos multiplication
      // FMA0: x0*cos
      fmaUnits(0).io.op := 0.U
      fmaUnits(0).io.a := xInReg(0)
      fmaUnits(0).io.b := cosReg
      fmaUnits(0).io.c := 0.U
      fmaUnits(0).io.validin := true.B

      // FMA1: x1*cos
      fmaUnits(1).io.op := 0.U
      fmaUnits(1).io.a := xInReg(1)
      fmaUnits(1).io.b := cosReg
      fmaUnits(1).io.c := 0.U
      fmaUnits(1).io.validin := true.B

      when(fmaUnits(0).io.validout && fmaUnits(1).io.validout) {
        stage1Results(0) := fmaUnits(0).io.out
        stage1Results(1) := fmaUnits(1).io.out
        state := State.sStage2
      }
    }

    is(State.sStage2) {
      // x0' = x0cos - x1sin
      fmaUnits(0).io.op := 2.U  // subtract
      fmaUnits(0).io.a := xInReg(1)
      fmaUnits(0).io.b := sinReg
      fmaUnits(0).io.c := stage1Results(0)
      fmaUnits(0).io.validin := true.B

      // x1' = x1cos + x0sin
      fmaUnits(1).io.op := 0.U  // add
      fmaUnits(1).io.a := xInReg(0)
      fmaUnits(1).io.b := sinReg
      fmaUnits(1).io.c := stage1Results(1)
      fmaUnits(1).io.validin := true.B

      when(fmaUnits(0).io.validout && fmaUnits(1).io.validout) {
        outputReg(0) := fmaUnits(0).io.out
        outputReg(1) := fmaUnits(1).io.out
        io.ENout := true.B
        state := State.sIdle
      }
    }
  }
}


