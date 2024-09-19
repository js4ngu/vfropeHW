import struct

def float_to_ieee754_single_precision_hex(num):
    packed = struct.pack('>f', num)
    return ''.join(f'{byte:02x}' for byte in packed)

def Uint32toIEEE754(a):
    res = float_to_ieee754_single_precision_hex(a)
    print("=== UINT32 to IEEE754")
    print(a," = ",res)

def ieee754_single_precision_hex_to_float(hex_string):
    packed = bytes.fromhex(hex_string)
    num = struct.unpack('>f', packed)[0]
    return num

def IEEE754toUint32(hex_string):
    res = ieee754_single_precision_hex_to_float(hex_string)
    print("=== IEEE754 to UINT32")
    print(hex_string, " = ", res)


def FP32ADD(a,b):
    FP32_a = float_to_ieee754_single_precision_hex(a)
    FP32_b = float_to_ieee754_single_precision_hex(b)
    FP32_res = float_to_ieee754_single_precision_hex(a+b)
    print("\n=== FP32 ADDER ===")
    print(f'{a} + {b} = {a+b}')
    print(f'{FP32_a} + {FP32_b} = {FP32_res}')

def FP32MULT(a,b):
    FP32_a = float_to_ieee754_single_precision_hex(a)
    FP32_b = float_to_ieee754_single_precision_hex(b)
    FP32_res = float_to_ieee754_single_precision_hex(a*b)
    print("\n=== FP32 MULT ===")
    print(f'{a} * {b} = {a*b}')
    print(f'{FP32_a} * {FP32_b} = {FP32_res}')



def main():
    a = 1.5
    '''
    b = 92.4
    FP32ADD(a,b)
    FP32ADD(-a,b)
    FP32ADD(a,-b)
    FP32ADD(-a,-b)
    '''
    Uint32toIEEE754(a)

main()