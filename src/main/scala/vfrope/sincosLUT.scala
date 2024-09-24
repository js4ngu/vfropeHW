package vfrope

import chisel3._
import chisel3.experimental.FixedPoint
import chisel3.util.{log2Ceil, switch, is}

class SinCosLUTINT(width:Int) extends Module {
    val io = IO(new Bundle {
        val angle = Input(UInt(width.W))   // Input angle in discrete steps (e.g., 0 to 255)
        val sinOut = Output(SInt(width.W)) // Output sine value
        val cosOut = Output(SInt(width.W)) // Output cosine value
    })
    //LUT에 정의된 데이터는 수동으로 수정해줘야함...
    val sinLUT = VecInit(Seq(
        0.S, 3.S, 6.S, 9.S, 12.S, 16.S, 19.S, 22.S, 25.S, 28.S, 31.S, 34.S, 37.S, 40.S, 43.S, 46.S, 49.S, 52.S, 54.S, 57.S,
        60.S, 63.S, 66.S, 68.S, 71.S, 73.S, 76.S, 78.S, 81.S, 83.S, 86.S, 88.S, 90.S, 92.S, 94.S, 96.S, 98.S, 100.S, 102.S, 104.S,
        106.S, 108.S, 109.S, 111.S, 112.S, 114.S, 115.S, 116.S, 118.S, 119.S, 120.S, 121.S, 122.S, 123.S, 123.S, 124.S, 125.S, 125.S, 126.S, 126.S,
        126.S, 127.S, 127.S, 127.S, 127.S, 127.S, 127.S, 127.S, 126.S, 126.S, 125.S, 125.S, 124.S, 124.S, 123.S, 122.S, 121.S, 120.S, 119.S, 118.S,
        117.S, 116.S, 114.S, 113.S, 112.S, 110.S, 108.S, 107.S, 105.S, 103.S, 101.S, 99.S, 97.S, 95.S, 93.S, 91.S, 89.S, 87.S, 84.S, 82.S,
        80.S, 77.S, 75.S, 72.S, 69.S, 67.S, 64.S, 61.S, 59.S, 56.S, 53.S, 50.S, 47.S, 44.S, 41.S, 39.S, 36.S, 32.S, 29.S, 26.S,
        23.S, 20.S, 17.S, 14.S, 11.S, 8.S, 5.S, 2.S, -2.S, -5.S, -8.S, -11.S, -14.S, -17.S, -20.S, -23.S, -26.S, -29.S, -32.S, -36.S,
        -39.S, -41.S, -44.S, -47.S, -50.S, -53.S, -56.S, -59.S, -61.S, -64.S, -67.S, -69.S, -72.S, -75.S, -77.S, -80.S, -82.S, -84.S, -87.S, -89.S,
        -91.S, -93.S, -95.S, -97.S, -99.S, -101.S, -103.S, -105.S, -107.S, -108.S, -110.S, -112.S, -113.S, -114.S, -116.S, -117.S, -118.S, -119.S, -120.S, -121.S,
        -122.S, -123.S, -124.S, -124.S, -125.S, -125.S, -126.S, -126.S, -127.S, -127.S, -127.S, -127.S, -127.S, -127.S, -127.S, -126.S, -126.S, -126.S, -125.S, -125.S,
        -124.S, -123.S, -123.S, -122.S, -121.S, -120.S, -119.S, -118.S, -116.S, -115.S, -114.S, -112.S, -111.S, -109.S, -108.S, -106.S, -104.S, -102.S, -100.S, -98.S,
        -96.S, -94.S, -92.S, -90.S, -88.S, -86.S, -83.S, -81.S, -78.S, -76.S, -73.S, -71.S, -68.S, -66.S, -63.S, -60.S, -57.S, -54.S, -52.S, -49.S,
        -46.S, -43.S, -40.S, -37.S, -34.S, -31.S, -28.S, -25.S, -22.S, -19.S, -16.S, -12.S, -9.S, -6.S, -3.S, 0.S
    ))
    
    val cosLUT = VecInit(Seq(
        127.S, 127.S, 127.S, 127.S, 126.S, 126.S, 126.S, 125.S, 125.S, 124.S, 123.S, 122.S, 121.S, 121.S, 120.S, 118.S, 117.S, 116.S, 115.S, 113.S,
        112.S, 110.S, 109.S, 107.S, 105.S, 104.S, 102.S, 100.S, 98.S, 96.S, 94.S, 92.S, 90.S, 87.S, 85.S, 83.S, 80.S, 78.S, 75.S, 73.S,
        70.S, 68.S, 65.S, 62.S, 59.S, 57.S, 54.S, 51.S, 48.S, 45.S, 42.S, 39.S, 36.S, 33.S, 30.S, 27.S, 24.S, 21.S, 18.S, 15.S,
        12.S, 9.S, 5.S, 2.S, -1.S, -4.S, -7.S, -10.S, -13.S, -16.S, -19.S, -23.S, -26.S, -29.S, -32.S, -35.S, -38.S, -41.S, -44.S, -47.S,
        -50.S, -52.S, -55.S, -58.S, -61.S, -63.S, -66.S, -69.S, -71.S, -74.S, -77.S, -79.S, -81.S, -84.S, -86.S, -88.S, -91.S, -93.S, -95.S, -97.S,
        -99.S, -101.S, -103.S, -105.S, -106.S, -108.S, -110.S, -111.S, -113.S, -114.S, -115.S, -117.S, -118.S, -119.S, -120.S, -121.S, -122.S, -123.S, -124.S, -124.S,
        -125.S, -125.S, -126.S, -126.S, -127.S, -127.S, -127.S, -127.S, -127.S, -127.S, -127.S, -127.S, -126.S, -126.S, -125.S, -125.S, -124.S, -124.S, -123.S, -122.S,
        -121.S, -120.S, -119.S, -118.S, -117.S, -115.S, -114.S, -113.S, -111.S, -110.S, -108.S, -106.S, -105.S, -103.S, -101.S, -99.S, -97.S, -95.S, -93.S, -91.S,
        -88.S, -86.S, -84.S, -81.S, -79.S, -77.S, -74.S, -71.S, -69.S, -66.S, -64.S, -61.S, -58.S, -55.S, -52.S, -50.S, -47.S, -44.S, -41.S, -38.S,
        -35.S, -32.S, -29.S, -26.S, -23.S, -19.S, -16.S, -13.S, -10.S, -7.S, -4.S, -1.S, 2.S, 5.S, 9.S, 12.S, 15.S, 18.S, 21.S, 24.S,
        27.S, 30.S, 33.S, 36.S, 39.S, 42.S, 45.S, 48.S, 51.S, 54.S, 57.S, 59.S, 62.S, 65.S, 68.S, 70.S, 73.S, 75.S, 78.S, 80.S,
        83.S, 85.S, 87.S, 90.S, 92.S, 94.S, 96.S, 98.S, 100.S, 102.S, 104.S, 105.S, 107.S, 109.S, 110.S, 112.S, 113.S, 115.S, 116.S, 117.S,
        118.S, 120.S, 121.S, 121.S, 122.S, 123.S, 124.S, 125.S, 125.S, 126.S, 126.S, 126.S, 127.S, 127.S, 127.S, 127.S
    ))

    io.sinOut := sinLUT(io.angle)
    io.cosOut := cosLUT(io.angle)
}


class SinCosLUT(LutSize: Int, LutSizeHEX: Int) extends Module {
    val io = IO(new Bundle {
        val angle = Input(UInt(32.W)) // Input angle in discrete steps (e.g., 0 to 255)
        //val sinOut = Output(UInt(32.W)) // Output sine value
        //val cosOut = Output(UInt(32.W)) // Output cosine value
    })

    val FP32Mult   = Module(new FP32Multiplier())
    FP32Mult.io.a := io.angle
    FP32Mult.io.b := LutSizeHEX.U
    val FP32Index  = FP32Mult.io.result

    val FP32Truncate       = Module(new FP32Truncate())
    FP32Truncate.io.in    := FP32Index
    val FP32TruncateIndex  = FP32Truncate.io.out

    val FP32toINT32         = Module(new FP32toINT32())
    FP32toINT32.io.ieee754 := FP32TruncateIndex
    val cosIndex            = FP32toINT32.io.int32
    val sinIndex            = (cosIndex + (1.U << (LutSize.U - 4.U)).asSInt)(LutSize - 1, 0) // LutSize를 SInt로 변환
    printf(p"Angle: ${io.angle}, LutSizeHEX: ${LutSizeHEX.U}, FP32Index: ${FP32Index}, FP32TruncateIndex: ${FP32TruncateIndex}, cosIndex: ${cosIndex}, sinIndex: ${sinIndex}\n")
}
