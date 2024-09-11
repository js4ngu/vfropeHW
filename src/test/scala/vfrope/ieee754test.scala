package vfrope

import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import chisel3._

class Int32ToIEEE754Test extends AnyFlatSpec with ChiselScalatestTester {
    "Int32ToIEEE754" should "convert integer to IEEE 754" in {
        test(new Int32ToIEEE754()) { dut =>
            dut.io.inInt.poke(-15.S) // 0x41700000
            dut.clock.step()
            println(s"Result: 0x${dut.io.outIEEE.peek().litValue.toString(16)}")
        }
    }
}
