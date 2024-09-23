import math
import struct
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
    x1_prime = x1 * cos_theta - x2 * sin_theta
    x2_prime = x2 * cos_theta + x1 * sin_theta
    print("INPUT")
    print("x1", end='')  # No newline added after 'Hello'
    Uint32toIEEE754(x1)
    print("x2", end='')  # No newline added after 'Hello'
    Uint32toIEEE754(x2)
    print("sin_theta", end='')  # No newline added after 'Hello'
    Uint32toIEEE754(sin_theta)
    print("cos_theta", end='')  # No newline added after 'Hello'
    Uint32toIEEE754(cos_theta)
    print("RESULT")
    print("x1_prime", end='')  # No newline added after 'Hello'
    Uint32toIEEE754(x1_prime)
    print("x2_prime", end='')  # No newline added after 'Hello'
    Uint32toIEEE754(x2_prime)

    return x1_prime, x2_prime

def main():
    testcase = [
        [1,1,1,1],
        [2,2,2,2]
    ]

    for test in testcase:
        print("\n\nNEW CASE")
        x1, x2, sin, cos = test
        RoPE(x1, x2, sin, cos)

main()