package vfrope
import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import java.lang.Float

class DualPortMemorySpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "DualPortMemory"

  it should "write and read data correctly" in {
    test(new DualPortMemory(32, 1024)) { c =>
      // Write data
      c.io.writeAddr.poke(10.U)
      c.io.writeData.poke(1234.U)
      c.io.writeEnable.poke(true.B)
      c.clock.step()
      c.io.writeEnable.poke(false.B)
      c.io.writeAddr.poke(20.U)
      c.io.writeData.poke(1000.U)
      c.io.writeEnable.poke(true.B)
      c.clock.step()
      c.io.writeEnable.poke(false.B)

      // Read from two different addresses
      c.io.readAddr1.poke(10.U)
      c.io.readAddr2.poke(20.U)
      c.clock.step()

      // Check the read data
      c.io.readData1.expect(1234.U)
      c.io.readData2.expect(1000.U)  // Assuming unwritten memory is initialized to 0
    }
  }
}

class dualPortCOSlutTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "dualPortCOSlut"

  it should "output correct cosine and sine values and generate VCD" in {
    test(new dualPortCOSlut()).withAnnotations(Seq(WriteVcdAnnotation)) { c =>
      c.io.x(0).poke(98.U)
      c.io.x(1).poke(99.U)
      c.io.sign(0).poke(true.B)
      c.io.sign(1).poke(false.B)
  
      // 테스트 시나리오 1: 0도 (인덱스 0)
      c.io.EN.poke(true.B)
      c.io.cosIndex.poke(0.U)
      c.io.sinIndex.poke(128.U)
      c.clock.step()
      c.io.EN.poke(false.B)
      c.clock.step()

      // 테스트 시나리오 2: 90도 (인덱스 256, LUT의 1/4)
      c.io.EN.poke(true.B)
      c.io.cosIndex.poke(128.U)
      c.io.sinIndex.poke(256.U)
      c.clock.step()
      c.io.EN.poke(false.B)
      c.clock.step()

      // 테스트 시나리오 2: 90도 (인덱스 256, LUT의 1/4)
      c.io.EN.poke(true.B)
      c.io.cosIndex.poke(512.U)
      c.io.sinIndex.poke(128.U)
      c.clock.step()
      c.io.EN.poke(false.B)
      c.clock.step()


      // 추가적인 클록 사이클을 진행하여 더 많은 상태 변화를 기록
      for (_ <- 0 until 10) {
        c.clock.step()
      }
    }
  }
}