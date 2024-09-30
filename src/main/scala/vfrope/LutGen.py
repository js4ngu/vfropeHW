import numpy as np
import struct

PRINT_LOG = 0
LUT_SIN_OUT = 1
LUT_COS_OUT = 0
SIN_COS_THETA_INFO = 0

BITS = 12
N = 2**BITS
UNIT_PER_LINE = 10
BANK_SIZE = 256

def float_to_hex(f):
    return f'"h{struct.unpack("<I", struct.pack("<f", f))[0]:08x}"'

def format_values(values, units_per_line):
    formatted_lines = []
    for i in range(0, len(values), units_per_line):
        line = "\t" + ", ".join([f"{val}.U" for val in values[i:i+units_per_line]]) + ","
        formatted_lines.append(line)
    return "\n".join(formatted_lines).rstrip(",")

def print_bank(values, bank_number, lut_type):
    print(f"val {lut_type.lower()}LUTBank{bank_number} = VecInit(Seq(")
    print(format_values(values, UNIT_PER_LINE))
    print("))")
    print()

def main():
    radian_array = np.linspace(0, 2 * np.pi, N)

    # Calculate sin and cos values for each radian
    sin_values = np.sin(radian_array)
    cos_values = np.cos(radian_array)

    # Convert to FP32 hex representation
    sin_hex = [float_to_hex(val) for val in sin_values]
    cos_hex = [float_to_hex(val) for val in cos_values]

    if LUT_SIN_OUT == 1:
        for i in range(0, N, BANK_SIZE):
            bank_number = i // BANK_SIZE
            print_bank(sin_hex[i:i+BANK_SIZE], bank_number, "Sin")
    
    if LUT_COS_OUT == 1:
        for i in range(0, N, BANK_SIZE):
            bank_number = i // BANK_SIZE
            print_bank(cos_hex[i:i+BANK_SIZE], bank_number, "Cos")

    if SIN_COS_THETA_INFO == 1:
        theta1 = 0
        theta2 = theta1 + (N/2)
        print(f"cos({theta2}) = sin({theta1}) = {np.sin(theta1)}, {np.cos(theta2)}")

main()