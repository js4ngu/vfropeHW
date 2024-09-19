FIRRTL version 1.1.0
circuit RoPEBackCore :
  module RoPEBackCore :
    input clock : Clock
    input reset : UInt<1>
    input io_x1 : SInt<32>
    input io_x2 : SInt<32>
    input io_sin : SInt<32>
    input io_cos : SInt<32>
    input io_inEN : UInt<1>
    output io_x1hat : SInt<60>
    output io_x2hat : SInt<60>
    output io_outEN : UInt<1>

    node _x1_fixed_T = shl(io_x1, 28) @[RoPE-fixedpoint.scala 69:27]
    node x1_fixed = asSInt(_x1_fixed_T) @[RoPE-fixedpoint.scala 69:55]
    node _x2_fixed_T = shl(io_x2, 28) @[RoPE-fixedpoint.scala 70:27]
    node x2_fixed = asSInt(_x2_fixed_T) @[RoPE-fixedpoint.scala 70:55]
    node x1_sin = mul(x1_fixed, io_sin) @[RoPE-fixedpoint.scala 73:27]
    node x1_cos = mul(x1_fixed, io_cos) @[RoPE-fixedpoint.scala 74:27]
    node x2_sin = mul(x2_fixed, io_sin) @[RoPE-fixedpoint.scala 75:27]
    node x2_cos = mul(x2_fixed, io_cos) @[RoPE-fixedpoint.scala 76:27]
    node _x1_hat_T = sub(x1_cos, x2_sin) @[RoPE-fixedpoint.scala 79:25]
    node _x1_hat_T_1 = tail(_x1_hat_T, 1) @[RoPE-fixedpoint.scala 79:25]
    node x1_hat = asSInt(_x1_hat_T_1) @[RoPE-fixedpoint.scala 79:25]
    node _x2_hat_T = add(x2_cos, x1_sin) @[RoPE-fixedpoint.scala 80:25]
    node _x2_hat_T_1 = tail(_x2_hat_T, 1) @[RoPE-fixedpoint.scala 80:25]
    node x2_hat = asSInt(_x2_hat_T_1) @[RoPE-fixedpoint.scala 80:25]
    node _io_x1hat_T = asSInt(asSInt(UInt<1>("h0"))) @[RoPE-fixedpoint.scala 87:35]
    node _io_x2hat_T = asSInt(asSInt(UInt<1>("h0"))) @[RoPE-fixedpoint.scala 88:35]
    node _GEN_0 = mux(io_inEN, x1_hat, shl(_io_x1hat_T, 28)) @[RoPE-fixedpoint.scala 66:17 83:14 87:14]
    node _GEN_1 = mux(io_inEN, x2_hat, shl(_io_x2hat_T, 28)) @[RoPE-fixedpoint.scala 66:17 84:14 88:14]
    node _GEN_2 = mux(io_inEN, io_inEN, UInt<1>("h0")) @[RoPE-fixedpoint.scala 66:17 85:14 89:14]
    node _T = asUInt(io_x1hat) @[RoPE-fixedpoint.scala 91:73]
    node _T_1 = asUInt(io_x2hat) @[RoPE-fixedpoint.scala 91:108]
    node _T_2 = bits(reset, 0, 0) @[RoPE-fixedpoint.scala 91:9]
    node _T_3 = eq(_T_2, UInt<1>("h0")) @[RoPE-fixedpoint.scala 91:9]
    io_x1hat <= asSInt(bits(shr(_GEN_0, 28), 59, 0))
    io_x2hat <= asSInt(bits(shr(_GEN_1, 28), 59, 0))
    io_outEN <= _GEN_2
    printf(clock, and(and(UInt<1>("h1"), _T_3), UInt<1>("h1")), "Final Output - io.x1hat, io.x2hat : 0x%x, 0x%x\n", _T, _T_1) : printf @[RoPE-fixedpoint.scala 91:9]
