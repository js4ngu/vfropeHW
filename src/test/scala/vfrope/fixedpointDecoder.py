
def hex_to_fixed(hex_val, total_bits, fractional_bits):
    # Convert the hexadecimal value to an integer
    int_val = int(hex_val, 16)

    # If the number is signed, handle negative values
    if int_val >= 2**(total_bits - 1):  # Check if the sign bit is set
        int_val -= 2**total_bits  # Convert to negative by subtracting 2^total_bits

    # Divide by 2^fractional_bits to get the decimal value
    fixed_point_value = int_val / 2**fractional_bits
    return fixed_point_value

def main():
    TOTAL_BITS = 32    # Total number of bits in the fixed-point representation
    FRACTIONAL_BITS = 28  # Number of fractional bits
    LUT_RES = 12
    hex_val = ['0x00030000000']
    for i in list(hex_val):
        fixed_point_value = hex_to_fixed(i, FRACTIONAL_BITS + LUT_RES + 1, FRACTIONAL_BITS)
        print(f"Fixed-point {i} in decimal (4094, m_i_norm_1): {fixed_point_value}")

    hex_val = ['0x1921fb56']
    for i in list(hex_val):
        fixed_point_value = hex_to_fixed(i, TOTAL_BITS, FRACTIONAL_BITS)
        print(f"Fixed-point {i} in decimal (pi, theta_2): {fixed_point_value}")


    hex_val = ['0x007da9e8a780000000', '0x001921fb568000000']
    for i in list(hex_val):
        fixed_point_value = hex_to_fixed(i, TOTAL_BITS + FRACTIONAL_BITS + LUT_RES + 1, 2*FRACTIONAL_BITS)
        print(f"Fixed-point {i} in decimal (4094 * pi = 12867.9635091, m_theta_i_2): {fixed_point_value}")

    hex_val = ['0x007da9e8a78000000', '0x001921fb568000000']
    for i in list(hex_val):
        fixed_point_value = hex_to_fixed(i, TOTAL_BITS + FRACTIONAL_BITS + 1, 2*FRACTIONAL_BITS)
        print(f"Fixed-point {i} in decimal (4094 * pi = 12867.9635091, m_theta_i_2): {fixed_point_value}")

    hex_val = ['0x048000000']
    for i in list(hex_val):
        fixed_point_value = hex_to_fixed(i, TOTAL_BITS, FRACTIONAL_BITS)
        print(f"Fixed-point {i} in decimal (4094 * pi % 2pi = 0 , normaized_m_theta_i_2): {fixed_point_value}")

main()