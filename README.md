# chisel-empty

An almost empty chisel project as a starting point for hardware design.

See the `Makefile` for the hardware and test targets.

```py
import numpy as np

PRINT_LOG = 1
LUT_SIN_OUT = 0
LUT_COS_OUT = 0
SIN_COS_THETA_INFO = 0

BITS = 8
N = 2**BITS
UNIT_PER_LINE = 20

def format_values(values, units_per_line):
    formatted_lines = []
    for i in range(0, len(values), units_per_line):
        line = ", ".join([f"{val}.S" for val in values[i:i+units_per_line]]) + ","
        formatted_lines.append(line)
    return "\n".join(formatted_lines).rstrip(",")

def map_values(value):
    return np.interp(value, [-1, 1], [-(N//2 - 1), (N//2 - 1)])

def main():
    radian_array = np.linspace(0, 2 * np.pi, N)

    # Calculate sin and cos values for each radian
    sin_values = np.sin(radian_array)
    cos_values = np.cos(radian_array)

    # Map values using the specified ranges
    sin_mapped = np.array([map_values(val) for val in sin_values])
    cos_mapped = np.array([map_values(val) for val in cos_values])

    # Round and convert to integers
    sin_mapped = np.round(sin_mapped).astype(int)
    cos_mapped = np.round(cos_mapped).astype(int)

    if PRINT_LOG == 1:
        for rad, sin_val, cos_val in zip(radian_array, sin_mapped, cos_mapped):
            print(f"Radian: {rad:.4f}, Sin: {sin_val}, Cos: {cos_val}")
    
    if LUT_SIN_OUT == 1:
        print(format_values(sin_mapped, UNIT_PER_LINE))
    
    if LUT_COS_OUT == 1:
        print(format_values(cos_mapped, UNIT_PER_LINE))
    
    if SIN_COS_THETA_INFO == 1:
        theta1 = 0
        theta2 = theta1 + (N/2)
        print("cos(", theta2, ") = sin(", theta1, ") = ", np.sin(theta1), np.cos(theta2))

main()
```