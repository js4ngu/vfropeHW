package vfrope

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import chisel3.experimental.FixedPoint
import chisel3.util.Cat

class FixedPointArithmeticTest extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "FixedPointAdder"

  it should "correctly add fixed point numbers" in {
    test(new FixedPointAdder(16, 8)) { c =>
      def fp(n: Double): BigInt = BigInt((n * (1 << 8)).round.toInt)

      val testCases = Seq(
        (1.5, 2.25, 3.75),
        (-1.5, 2.25, 0.75),
        (3.25, -1.75, 1.5),
        (-2.5, -1.75, -4.25)
      )

      for ((a, b, expected) <- testCases) {
        c.io.a.poke(FixedPoint.fromDouble(a, 16.W, 8.BP))
        c.io.b.poke(FixedPoint.fromDouble(b, 16.W, 8.BP))
        c.clock.step()
        c.io.out.expect(FixedPoint.fromDouble(expected, 17.W, 8.BP))
      }
    }
  }

  behavior of "FixedPointMultiplier"

  it should "correctly multiply fixed point numbers" in {
    test(new FixedPointMultiplier(16, 8)) { c =>
      def fp(n: Double): BigInt = BigInt((n * (1 << 8)).round.toInt)

      val testCases = Seq(
        (1.5, 2.25, 3.375),
        (-1.5, 2.25, -3.375),
        (3.25, -1.75, -5.6875),
        (-2.5, -1.75, 4.375)
      )

      for ((a, b, expected) <- testCases) {
        c.io.a.poke(FixedPoint.fromDouble(a, 16.W, 8.BP))
        c.io.b.poke(FixedPoint.fromDouble(b, 16.W, 8.BP))
        c.clock.step()
        c.io.out.expect(FixedPoint.fromDouble(expected, 32.W, 16.BP))
      }
    }
  }
}
