import math
import struct

def float_to_hex(f):
    return hex(struct.unpack('<I', struct.pack('<f', f))[0])

def hex_to_float(h):
    return struct.unpack('!f', bytes.fromhex(h[2:]))[0]


def float_to_ieee754_single_precision_hex(num):
    packed = struct.pack('>f', num)
    return ''.join(f'{byte:02x}' for byte in packed)

def Uint32toIEEE754(a):
    res = float_to_ieee754_single_precision_hex(a)
    print("\t",a," = ",res)

def ieee754_single_precision_hex_to_float(hex_string):
    packed = bytes.fromhex(hex_string)
    num = struct.unpack('>f', packed)[0]
    return num

def IEEE754toUint32(hex_string):
    res = ieee754_single_precision_hex_to_float(hex_string)
    print("\t",hex_string, " = ", res)

def RoPE(x1, x2, sin_theta, cos_theta):
    # Intermediate calculations
    x1_sin = x1 * sin_theta
    x2_sin = x2 * sin_theta
    x1_cos = x1 * cos_theta
    x2_cos = x2 * cos_theta
    
    # Final calculations
    x1_prime = x1_cos - x2_sin
    x2_prime = x2_cos + x1_sin
    
    # Print intermediate results
    print("\nInput")
    print(f"x1: {x1} (hex: {float_to_hex(x1)})")
    print(f"x2: {x2} (hex: {float_to_hex(x2)})")
    print(f"sin: {sin_theta} (hex: {float_to_hex(sin_theta)})")
    print(f"cos: {cos_theta} (hex: {float_to_hex(cos_theta)})")


    print("\nIntermediate Results:")
    print(f"x1*sin: {x1_sin} (hex: {float_to_hex(x1_sin)})")
    print(f"x2*sin: {x2_sin} (hex: {float_to_hex(x2_sin)})")
    print(f"x1*cos: {x1_cos} (hex: {float_to_hex(x1_cos)})")
    print(f"x2*cos: {x2_cos} (hex: {float_to_hex(x2_cos)})")
    
    # Print final results
    print("\nFinal Results:")
    print(f"x1*cos - x2*sin: {x1_prime} (hex: {float_to_hex(x1_prime)})")
    print(f"x2*cos + x1*sin: {x2_prime} (hex: {float_to_hex(x2_prime)})")

    return x1_prime, x2_prime

def main():
    testcase = [
        [1,2, 1, 0],
        [3,4, 0,-1],
        [5,6,-1, 0],
        [7,8, 0, 1],
    ]

    for test in testcase:
        print("\n\nNEW CASE")
        x1, x2, sin, cos = test
        RoPE(x1, x2, sin, cos)

main()