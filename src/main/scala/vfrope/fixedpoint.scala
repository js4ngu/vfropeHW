package vfrope

import chisel3._
import chisel3.experimental.FixedPoint
import chisel3.util.Cat

class FixedPointAdder(width: Int, binaryPoint: Int) extends Module {
  val io = IO(new Bundle {
    val a = Input(FixedPoint(width.W, binaryPoint.BP))
    val b = Input(FixedPoint(width.W, binaryPoint.BP))
    val out = Output(FixedPoint((width+1).W, binaryPoint.BP))
  })
  
  io.out := io.a + io.b
}

class FixedPointMultiplier(width: Int, binaryPoint: Int) extends Module {
  val io = IO(new Bundle {
    val a = Input(FixedPoint(width.W, binaryPoint.BP))
    val b = Input(FixedPoint(width.W, binaryPoint.BP))
    val out = Output(FixedPoint((2*width).W, (2*binaryPoint).BP))
  })
  
  io.out := io.a * io.b
}