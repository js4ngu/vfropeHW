TOTAL_BITS = 32       # Total number of bits in the fixed-point representation
FRACTIONAL_BITS = 22  # Number of fractional bits

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
    hex_val = ['16800000']
    for i in list(hex_val):
        fixed_point_value = hex_to_fixed(i, TOTAL_BITS, FRACTIONAL_BITS)
        print(f"Fixed-point {i} in decimal: {fixed_point_value}")

main()