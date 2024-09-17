
def hex_to_fixed(hex_val, total_bits, fractional_bits):
    int_val = int(hex_val, 16) if hex_val[0] != '-' else -int(hex_val[1:], 16)

    # If the number is signed, handle negative values
    if int_val >= 2**(total_bits - 1):  # Check if the sign bit is set
        int_val -= 2**total_bits  # Convert to negative by subtracting 2^total_bits

    # Divide by 2^fractional_bits to get the decimal value
    fixed_point_value = int_val / 2**fractional_bits
    return fixed_point_value

def main():
    TOTAL_BITS = 32    # Total number of bits in the fixed-point representation
    FRACTIONAL_BITS = 28  # Number of fractional bits

    hex_val = ['0x08000000', '0x10000000']
    for i in list(hex_val):
        fixed_point_value = hex_to_fixed(i, TOTAL_BITS, FRACTIONAL_BITS)
        print(f"{i} in decimal : {fixed_point_value}")


main()