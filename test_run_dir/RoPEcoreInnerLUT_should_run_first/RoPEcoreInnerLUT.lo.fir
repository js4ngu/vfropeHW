FIRRTL version 1.1.0
circuit RoPEcoreInnerLUT :
  module RoPEfrontCore :
    input clock : Clock
    input reset : UInt<1>
    input io_x1 : SInt<32>
    input io_x2 : SInt<32>
    input io_theta : SInt<32>
    input io_m : UInt<32>
    input io_i : UInt<32>
    input io_inEN : UInt<1>
    output io_m_theta_i : SInt<32>
    output io_x1hat : SInt<32>
    output io_x2hat : SInt<32>

    node _m_i_temp1_1_T = mul(io_m, io_i) @[RoPE-fixedpoint.scala 28:28]
    node m_i_temp1_1 = bits(_m_i_temp1_1_T, 11, 0) @[RoPE-fixedpoint.scala 28:34]
    node _m_i_norm_1_T = asSInt(m_i_temp1_1) @[RoPE-fixedpoint.scala 29:47]
    node m_i_norm_1 = shl(_m_i_norm_1_T, 28) @[RoPE-fixedpoint.scala 29:64]
    node _m_theta_i_2_T = mul(m_i_norm_1, io_theta) @[RoPE-fixedpoint.scala 32:35]
    node m_theta_i_2 = _m_theta_i_2_T @[RoPE-fixedpoint.scala 32:60]
    node _signBit_T = asSInt(m_theta_i_2) @[RoPE-fixedpoint.scala 33:31]
    node signBit = head(_signBit_T, 1) @[RoPE-fixedpoint.scala 33:42]
    node _reduceFraction_T = asUInt(m_theta_i_2) @[RoPE-fixedpoint.scala 34:44]
    node _reduceFraction_T_1 = bits(_reduceFraction_T, 56, 28) @[RoPE-fixedpoint.scala 34:46]
    node reduceFraction = asSInt(_reduceFraction_T_1) @[RoPE-fixedpoint.scala 34:99]
    node _combinedUInt_T = asUInt(reduceFraction) @[RoPE-fixedpoint.scala 38:78]
    node combinedUInt_hi = cat(signBit, UInt<2>("h0")) @[Cat.scala 33:92]
    node combinedUInt = cat(combinedUInt_hi, _combinedUInt_T) @[Cat.scala 33:92]
    node _io_m_theta_i_T = asSInt(combinedUInt) @[RoPE-fixedpoint.scala 40:46]
    node _io_m_theta_i_T_1 = asSInt(UInt<1>("h0")) @[RoPE-fixedpoint.scala 45:40]
    node _GEN_0 = mux(io_inEN, _io_m_theta_i_T, _io_m_theta_i_T_1) @[RoPE-fixedpoint.scala 19:17 40:18 45:19]
    node _GEN_1 = mux(io_inEN, io_x1, asSInt(UInt<1>("h0"))) @[RoPE-fixedpoint.scala 19:17 41:14 46:19]
    node _GEN_2 = mux(io_inEN, io_x2, asSInt(UInt<1>("h0"))) @[RoPE-fixedpoint.scala 19:17 42:14 47:19]
    node _T = asUInt(io_x1hat) @[RoPE-fixedpoint.scala 49:87]
    node _T_1 = asUInt(io_x2hat) @[RoPE-fixedpoint.scala 49:122]
    node _T_2 = asUInt(io_m_theta_i) @[RoPE-fixedpoint.scala 49:161]
    node _T_3 = asUInt(reset) @[RoPE-fixedpoint.scala 49:9]
    node _T_4 = eq(_T_3, UInt<1>("h0")) @[RoPE-fixedpoint.scala 49:9]
    io_m_theta_i <= _GEN_0
    io_x1hat <= _GEN_1
    io_x2hat <= _GEN_2
    printf(clock, and(and(UInt<1>("h1"), _T_4), UInt<1>("h1")), "Final Output - io.x1hat, io.x2hat, io.m_theta_i : 0x%x, 0x%x, 0x%x\n", _T, _T_1, _T_2) : printf @[RoPE-fixedpoint.scala 49:9]

  module SinCosLUT :
    input clock : Clock
    input reset : UInt<1>
    input io_inEN : UInt<1>
    input io_x1 : SInt<32>
    input io_x2 : SInt<32>
    input io_angle : SInt<32>
    output io_sin : SInt<32>
    output io_cos : SInt<32>
    output io_x1hat : SInt<32>
    output io_x2hat : SInt<32>

    node _angle_scaled_T = mul(io_angle, asSInt(UInt<60>("h70000000"))) @[sincosLUT.scala 71:38]
    node angle_scaled = asUInt(_angle_scaled_T) @[sincosLUT.scala 71:60]
    node angle_scaled_int = bits(angle_scaled, 87, 56) @[sincosLUT.scala 72:44]
    node _io_sin_T = bits(angle_scaled_int, 3, 0)
    node sinLUT_0 = asSInt(UInt<32>("h0")) @[sincosLUT.scala 66:{29,29}]
    node _GEN_0 = validif(eq(UInt<1>("h0"), _io_sin_T), sinLUT_0) @[sincosLUT.scala 79:{16,16}]
    node sinLUT_1 = asSInt(UInt<32>("h6f13013")) @[sincosLUT.scala 66:{29,29}]
    node _GEN_1 = mux(eq(UInt<1>("h1"), _io_sin_T), sinLUT_1, _GEN_0) @[sincosLUT.scala 79:{16,16}]
    node sinLUT_2 = asSInt(UInt<32>("hc8261bb")) @[sincosLUT.scala 66:{29,29}]
    node _GEN_2 = mux(eq(UInt<2>("h2"), _io_sin_T), sinLUT_2, _GEN_1) @[sincosLUT.scala 79:{16,16}]
    node sinLUT_3 = asSInt(UInt<32>("hf994e03")) @[sincosLUT.scala 66:{29,29}]
    node _GEN_3 = mux(eq(UInt<2>("h3"), _io_sin_T), sinLUT_3, _GEN_2) @[sincosLUT.scala 79:{16,16}]
    node sinLUT_4 = asSInt(UInt<32>("hf994e03")) @[sincosLUT.scala 66:{29,29}]
    node _GEN_4 = mux(eq(UInt<3>("h4"), _io_sin_T), sinLUT_4, _GEN_3) @[sincosLUT.scala 79:{16,16}]
    node sinLUT_5 = asSInt(UInt<32>("hc8261bb")) @[sincosLUT.scala 66:{29,29}]
    node _GEN_5 = mux(eq(UInt<3>("h5"), _io_sin_T), sinLUT_5, _GEN_4) @[sincosLUT.scala 79:{16,16}]
    node sinLUT_6 = asSInt(UInt<32>("h6f13013")) @[sincosLUT.scala 66:{29,29}]
    node _GEN_6 = mux(eq(UInt<3>("h6"), _io_sin_T), sinLUT_6, _GEN_5) @[sincosLUT.scala 79:{16,16}]
    node sinLUT_7 = asSInt(UInt<32>("h0")) @[sincosLUT.scala 66:{29,29}]
    node _GEN_7 = mux(eq(UInt<3>("h7"), _io_sin_T), sinLUT_7, _GEN_6) @[sincosLUT.scala 79:{16,16}]
    node sinLUT_8 = asSInt(UInt<32>("hf90ecfed")) @[sincosLUT.scala 66:{29,29}]
    node _GEN_8 = mux(eq(UInt<4>("h8"), _io_sin_T), sinLUT_8, _GEN_7) @[sincosLUT.scala 79:{16,16}]
    node sinLUT_9 = asSInt(UInt<32>("hf37d9e45")) @[sincosLUT.scala 66:{29,29}]
    node _GEN_9 = mux(eq(UInt<4>("h9"), _io_sin_T), sinLUT_9, _GEN_8) @[sincosLUT.scala 79:{16,16}]
    node sinLUT_10 = asSInt(UInt<32>("hf066b1fd")) @[sincosLUT.scala 66:{29,29}]
    node _GEN_10 = mux(eq(UInt<4>("ha"), _io_sin_T), sinLUT_10, _GEN_9) @[sincosLUT.scala 79:{16,16}]
    node sinLUT_11 = asSInt(UInt<32>("hf066b1fd")) @[sincosLUT.scala 66:{29,29}]
    node _GEN_11 = mux(eq(UInt<4>("hb"), _io_sin_T), sinLUT_11, _GEN_10) @[sincosLUT.scala 79:{16,16}]
    node sinLUT_12 = asSInt(UInt<32>("hf37d9e45")) @[sincosLUT.scala 66:{29,29}]
    node _GEN_12 = mux(eq(UInt<4>("hc"), _io_sin_T), sinLUT_12, _GEN_11) @[sincosLUT.scala 79:{16,16}]
    node sinLUT_13 = asSInt(UInt<32>("hf90ecfed")) @[sincosLUT.scala 66:{29,29}]
    node _GEN_13 = mux(eq(UInt<4>("hd"), _io_sin_T), sinLUT_13, _GEN_12) @[sincosLUT.scala 79:{16,16}]
    node _io_cos_T = bits(angle_scaled_int, 3, 0)
    node cosLUT_0 = asSInt(UInt<32>("h10000000")) @[sincosLUT.scala 67:{29,29}]
    node _GEN_14 = validif(eq(UInt<1>("h0"), _io_cos_T), cosLUT_0) @[sincosLUT.scala 80:{16,16}]
    node cosLUT_1 = asSInt(UInt<32>("he6a5e55")) @[sincosLUT.scala 67:{29,29}]
    node _GEN_15 = mux(eq(UInt<1>("h1"), _io_cos_T), cosLUT_1, _GEN_14) @[sincosLUT.scala 80:{16,16}]
    node cosLUT_2 = asSInt(UInt<32>("h9f9d071")) @[sincosLUT.scala 67:{29,29}]
    node _GEN_16 = mux(eq(UInt<2>("h2"), _io_cos_T), cosLUT_2, _GEN_15) @[sincosLUT.scala 80:{16,16}]
    node cosLUT_3 = asSInt(UInt<32>("h38f721c")) @[sincosLUT.scala 67:{29,29}]
    node _GEN_17 = mux(eq(UInt<2>("h3"), _io_cos_T), cosLUT_3, _GEN_16) @[sincosLUT.scala 80:{16,16}]
    node cosLUT_4 = asSInt(UInt<32>("hfc708de4")) @[sincosLUT.scala 67:{29,29}]
    node _GEN_18 = mux(eq(UInt<3>("h4"), _io_cos_T), cosLUT_4, _GEN_17) @[sincosLUT.scala 80:{16,16}]
    node cosLUT_5 = asSInt(UInt<32>("hf6062f8f")) @[sincosLUT.scala 67:{29,29}]
    node _GEN_19 = mux(eq(UInt<3>("h5"), _io_cos_T), cosLUT_5, _GEN_18) @[sincosLUT.scala 80:{16,16}]
    node cosLUT_6 = asSInt(UInt<32>("hf195a1ab")) @[sincosLUT.scala 67:{29,29}]
    node _GEN_20 = mux(eq(UInt<3>("h6"), _io_cos_T), cosLUT_6, _GEN_19) @[sincosLUT.scala 80:{16,16}]
    node cosLUT_7 = asSInt(UInt<32>("hf0000000")) @[sincosLUT.scala 67:{29,29}]
    node _GEN_21 = mux(eq(UInt<3>("h7"), _io_cos_T), cosLUT_7, _GEN_20) @[sincosLUT.scala 80:{16,16}]
    node cosLUT_8 = asSInt(UInt<32>("hf195a1ab")) @[sincosLUT.scala 67:{29,29}]
    node _GEN_22 = mux(eq(UInt<4>("h8"), _io_cos_T), cosLUT_8, _GEN_21) @[sincosLUT.scala 80:{16,16}]
    node cosLUT_9 = asSInt(UInt<32>("hf6062f8f")) @[sincosLUT.scala 67:{29,29}]
    node _GEN_23 = mux(eq(UInt<4>("h9"), _io_cos_T), cosLUT_9, _GEN_22) @[sincosLUT.scala 80:{16,16}]
    node cosLUT_10 = asSInt(UInt<32>("hfc708de4")) @[sincosLUT.scala 67:{29,29}]
    node _GEN_24 = mux(eq(UInt<4>("ha"), _io_cos_T), cosLUT_10, _GEN_23) @[sincosLUT.scala 80:{16,16}]
    node cosLUT_11 = asSInt(UInt<32>("h38f721c")) @[sincosLUT.scala 67:{29,29}]
    node _GEN_25 = mux(eq(UInt<4>("hb"), _io_cos_T), cosLUT_11, _GEN_24) @[sincosLUT.scala 80:{16,16}]
    node cosLUT_12 = asSInt(UInt<32>("h9f9d071")) @[sincosLUT.scala 67:{29,29}]
    node _GEN_26 = mux(eq(UInt<4>("hc"), _io_cos_T), cosLUT_12, _GEN_25) @[sincosLUT.scala 80:{16,16}]
    node cosLUT_13 = asSInt(UInt<32>("he6a5e55")) @[sincosLUT.scala 67:{29,29}]
    node _GEN_27 = mux(eq(UInt<4>("hd"), _io_cos_T), cosLUT_13, _GEN_26) @[sincosLUT.scala 80:{16,16}]
    node _io_sin_T_1 = asSInt(UInt<1>("h0")) @[sincosLUT.scala 84:39]
    node _io_cos_T_1 = asSInt(UInt<1>("h0")) @[sincosLUT.scala 85:39]
    node _sinLUT_io_sin_T = _GEN_13 @[sincosLUT.scala 79:16]
    node _GEN_28 = mux(io_inEN, _sinLUT_io_sin_T, _io_sin_T_1) @[sincosLUT.scala 61:19 79:16 84:18]
    node _cosLUT_io_cos_T = _GEN_27 @[sincosLUT.scala 80:16]
    node _GEN_29 = mux(io_inEN, _cosLUT_io_cos_T, _io_cos_T_1) @[sincosLUT.scala 61:19 80:16 85:18]
    node _GEN_30 = mux(io_inEN, io_x1, asSInt(UInt<1>("h0"))) @[sincosLUT.scala 61:19 81:18 86:18]
    node _GEN_31 = mux(io_inEN, io_x2, asSInt(UInt<1>("h0"))) @[sincosLUT.scala 61:19 82:18 87:18]
    io_sin <= _GEN_28
    io_cos <= _GEN_29
    io_x1hat <= _GEN_30
    io_x2hat <= _GEN_31

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

    node _x1_fixed_T = shl(io_x1, 28) @[RoPE-fixedpoint.scala 64:27]
    node x1_fixed = asSInt(_x1_fixed_T) @[RoPE-fixedpoint.scala 64:55]
    node _x2_fixed_T = shl(io_x2, 28) @[RoPE-fixedpoint.scala 65:27]
    node x2_fixed = asSInt(_x2_fixed_T) @[RoPE-fixedpoint.scala 65:55]
    node x1_sin = mul(x1_fixed, io_sin) @[RoPE-fixedpoint.scala 68:27]
    node x1_cos = mul(x1_fixed, io_cos) @[RoPE-fixedpoint.scala 69:27]
    node x2_sin = mul(x2_fixed, io_sin) @[RoPE-fixedpoint.scala 70:27]
    node x2_cos = mul(x2_fixed, io_cos) @[RoPE-fixedpoint.scala 71:27]
    node _x1_hat_T = sub(x1_cos, x2_sin) @[RoPE-fixedpoint.scala 74:25]
    node _x1_hat_T_1 = tail(_x1_hat_T, 1) @[RoPE-fixedpoint.scala 74:25]
    node x1_hat = asSInt(_x1_hat_T_1) @[RoPE-fixedpoint.scala 74:25]
    node _x2_hat_T = add(x2_cos, x1_sin) @[RoPE-fixedpoint.scala 75:25]
    node _x2_hat_T_1 = tail(_x2_hat_T, 1) @[RoPE-fixedpoint.scala 75:25]
    node x2_hat = asSInt(_x2_hat_T_1) @[RoPE-fixedpoint.scala 75:25]
    node _io_x1hat_T = asSInt(asSInt(UInt<1>("h0"))) @[RoPE-fixedpoint.scala 81:35]
    node _io_x2hat_T = asSInt(asSInt(UInt<1>("h0"))) @[RoPE-fixedpoint.scala 82:35]
    node _GEN_0 = mux(io_inEN, x1_hat, shl(_io_x1hat_T, 28)) @[RoPE-fixedpoint.scala 62:17 78:14 81:14]
    node _GEN_1 = mux(io_inEN, x2_hat, shl(_io_x2hat_T, 28)) @[RoPE-fixedpoint.scala 62:17 79:14 82:14]
    node _T = asUInt(io_x1hat) @[RoPE-fixedpoint.scala 84:73]
    node _T_1 = asUInt(io_x2hat) @[RoPE-fixedpoint.scala 84:108]
    node _T_2 = asUInt(reset) @[RoPE-fixedpoint.scala 84:9]
    node _T_3 = eq(_T_2, UInt<1>("h0")) @[RoPE-fixedpoint.scala 84:9]
    io_x1hat <= asSInt(bits(shr(_GEN_0, 28), 59, 0))
    io_x2hat <= asSInt(bits(shr(_GEN_1, 28), 59, 0))
    printf(clock, and(and(UInt<1>("h1"), _T_3), UInt<1>("h1")), "Final Output - io.x1hat, io.x2hat : 0x%x, 0x%x\n", _T, _T_1) : printf @[RoPE-fixedpoint.scala 84:9]

  module RoPEcoreInnerLUT :
    input clock : Clock
    input reset : UInt<1>
    input io_inEN : UInt<1>
    input io_x1 : SInt<32>
    input io_x2 : SInt<32>
    input io_theta : SInt<32>
    input io_m : UInt<32>
    input io_i : UInt<32>

    inst FrontCore of RoPEfrontCore @[RoPE-fixedpoint.scala 115:27]
    inst SinCosLUT of SinCosLUT @[RoPE-fixedpoint.scala 128:27]
    inst BackCore of RoPEBackCore @[RoPE-fixedpoint.scala 147:27]
    node _T = bits(reset, 0, 0) @[RoPE-fixedpoint.scala 99:11]
    node _T_1 = eq(_T, UInt<1>("h0")) @[RoPE-fixedpoint.scala 99:11]
    reg X1_0 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), X1_0) @[RoPE-fixedpoint.scala 100:28]
    reg X2_0 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), X2_0) @[RoPE-fixedpoint.scala 101:28]
    reg X1hat_0 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), X1hat_0) @[RoPE-fixedpoint.scala 102:28]
    reg X2hat_0 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), X2hat_0) @[RoPE-fixedpoint.scala 103:28]
    reg inM : UInt<32>, clock with :
      reset => (UInt<1>("h0"), inM) @[RoPE-fixedpoint.scala 104:28]
    reg inI : UInt<32>, clock with :
      reset => (UInt<1>("h0"), inI) @[RoPE-fixedpoint.scala 105:28]
    reg inTheta : SInt<32>, clock with :
      reset => (UInt<1>("h0"), inTheta) @[RoPE-fixedpoint.scala 106:28]
    reg m_theta_i : SInt<32>, clock with :
      reset => (UInt<1>("h0"), m_theta_i) @[RoPE-fixedpoint.scala 107:28]
    node _T_2 = asUInt(m_theta_i) @[RoPE-fixedpoint.scala 126:64]
    node _T_3 = bits(reset, 0, 0) @[RoPE-fixedpoint.scala 126:11]
    node _T_4 = eq(_T_3, UInt<1>("h0")) @[RoPE-fixedpoint.scala 126:11]
    reg sin : SInt<32>, clock with :
      reset => (UInt<1>("h0"), sin) @[RoPE-fixedpoint.scala 129:28]
    reg cos : SInt<32>, clock with :
      reset => (UInt<1>("h0"), cos) @[RoPE-fixedpoint.scala 130:28]
    reg X1_1 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), X1_1) @[RoPE-fixedpoint.scala 131:28]
    reg X2_1 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), X2_1) @[RoPE-fixedpoint.scala 132:28]
    reg X1hat_1 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), X1hat_1) @[RoPE-fixedpoint.scala 133:28]
    reg X2hat_1 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), X2hat_1) @[RoPE-fixedpoint.scala 134:28]
    node _T_5 = asUInt(sin) @[RoPE-fixedpoint.scala 145:56]
    node _T_6 = asUInt(cos) @[RoPE-fixedpoint.scala 145:85]
    node _T_7 = bits(reset, 0, 0) @[RoPE-fixedpoint.scala 145:11]
    node _T_8 = eq(_T_7, UInt<1>("h0")) @[RoPE-fixedpoint.scala 145:11]
    reg X1hat_2 : SInt<60>, clock with :
      reset => (UInt<1>("h0"), X1hat_2) @[RoPE-fixedpoint.scala 148:28]
    reg X2hat_2 : SInt<60>, clock with :
      reset => (UInt<1>("h0"), X2hat_2) @[RoPE-fixedpoint.scala 149:28]
    node _T_9 = asUInt(X1hat_2) @[RoPE-fixedpoint.scala 158:44]
    node _T_10 = asUInt(X2hat_2) @[RoPE-fixedpoint.scala 158:75]
    node _T_11 = bits(reset, 0, 0) @[RoPE-fixedpoint.scala 158:11]
    node _T_12 = eq(_T_11, UInt<1>("h0")) @[RoPE-fixedpoint.scala 158:11]
    X1_0 <= mux(reset, asSInt(UInt<32>("h0")), io_x1) @[RoPE-fixedpoint.scala 100:{28,28} 109:15]
    X2_0 <= mux(reset, asSInt(UInt<32>("h0")), io_x2) @[RoPE-fixedpoint.scala 101:{28,28} 110:15]
    X1hat_0 <= mux(reset, asSInt(UInt<32>("h0")), FrontCore.io_x1hat) @[RoPE-fixedpoint.scala 102:{28,28} 123:25]
    X2hat_0 <= mux(reset, asSInt(UInt<32>("h0")), FrontCore.io_x2hat) @[RoPE-fixedpoint.scala 103:{28,28} 124:25]
    inM <= mux(reset, UInt<32>("h0"), io_m) @[RoPE-fixedpoint.scala 104:{28,28} 111:15]
    inI <= mux(reset, UInt<32>("h0"), io_i) @[RoPE-fixedpoint.scala 105:{28,28} 112:15]
    inTheta <= mux(reset, asSInt(UInt<32>("h0")), io_theta) @[RoPE-fixedpoint.scala 106:{28,28} 113:15]
    m_theta_i <= mux(reset, asSInt(UInt<32>("h0")), FrontCore.io_m_theta_i) @[RoPE-fixedpoint.scala 107:{28,28} 122:25]
    FrontCore.clock <= clock
    FrontCore.reset <= reset
    FrontCore.io_x1 <= X1_0 @[RoPE-fixedpoint.scala 117:25]
    FrontCore.io_x2 <= X2_0 @[RoPE-fixedpoint.scala 118:25]
    FrontCore.io_theta <= inTheta @[RoPE-fixedpoint.scala 121:25]
    FrontCore.io_m <= inM @[RoPE-fixedpoint.scala 119:25]
    FrontCore.io_i <= inI @[RoPE-fixedpoint.scala 120:25]
    FrontCore.io_inEN <= io_inEN @[RoPE-fixedpoint.scala 116:25]
    SinCosLUT.clock <= clock
    SinCosLUT.reset <= reset
    SinCosLUT.io_inEN <= io_inEN @[RoPE-fixedpoint.scala 136:25]
    SinCosLUT.io_x1 <= X1hat_0 @[RoPE-fixedpoint.scala 138:25]
    SinCosLUT.io_x2 <= X2hat_0 @[RoPE-fixedpoint.scala 139:25]
    SinCosLUT.io_angle <= m_theta_i @[RoPE-fixedpoint.scala 137:25]
    sin <= mux(reset, asSInt(UInt<32>("h0")), SinCosLUT.io_sin) @[RoPE-fixedpoint.scala 129:{28,28} 140:25]
    cos <= mux(reset, asSInt(UInt<32>("h0")), SinCosLUT.io_cos) @[RoPE-fixedpoint.scala 130:{28,28} 141:25]
    X1_1 <= mux(reset, asSInt(UInt<32>("h0")), X1_1) @[RoPE-fixedpoint.scala 131:{28,28,28}]
    X2_1 <= mux(reset, asSInt(UInt<32>("h0")), X2_1) @[RoPE-fixedpoint.scala 132:{28,28,28}]
    X1hat_1 <= mux(reset, asSInt(UInt<32>("h0")), SinCosLUT.io_x1hat) @[RoPE-fixedpoint.scala 133:{28,28} 142:25]
    X2hat_1 <= mux(reset, asSInt(UInt<32>("h0")), SinCosLUT.io_x2hat) @[RoPE-fixedpoint.scala 134:{28,28} 143:25]
    BackCore.clock <= clock
    BackCore.reset <= reset
    BackCore.io_x1 <= X1hat_1 @[RoPE-fixedpoint.scala 152:23]
    BackCore.io_x2 <= X2hat_1 @[RoPE-fixedpoint.scala 153:23]
    BackCore.io_sin <= sin @[RoPE-fixedpoint.scala 154:23]
    BackCore.io_cos <= cos @[RoPE-fixedpoint.scala 155:23]
    BackCore.io_inEN <= io_inEN @[RoPE-fixedpoint.scala 151:23]
    X1hat_2 <= mux(reset, asSInt(UInt<60>("h0")), BackCore.io_x1hat) @[RoPE-fixedpoint.scala 148:{28,28} 156:23]
    X2hat_2 <= mux(reset, asSInt(UInt<60>("h0")), BackCore.io_x2hat) @[RoPE-fixedpoint.scala 149:{28,28} 157:23]
    printf(clock, and(and(and(UInt<1>("h1"), io_inEN), _T_1), UInt<1>("h1")), "\n==== Cycle update ====\n") : printf @[RoPE-fixedpoint.scala 99:11]
    printf(clock, and(and(and(UInt<1>("h1"), io_inEN), _T_4), UInt<1>("h1")), "m_theta_i, x1, x2 : %x %x %x\n", _T_2, X1hat_0, X2hat_0) : printf_1 @[RoPE-fixedpoint.scala 126:11]
    printf(clock, and(and(and(UInt<1>("h1"), io_inEN), _T_8), UInt<1>("h1")), "sin, cos, x1, x2: %x %x %x %x\n", _T_5, _T_6, X1hat_1, X2hat_1) : printf_2 @[RoPE-fixedpoint.scala 145:11]
    printf(clock, and(and(and(UInt<1>("h1"), io_inEN), _T_12), UInt<1>("h1")), "x1, x2: %x %x\n", _T_9, _T_10) : printf_3 @[RoPE-fixedpoint.scala 158:11]
