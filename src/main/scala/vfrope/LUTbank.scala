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

class SinCosLUTbank() extends Module {
    val io = IO(new Bundle {
        val EN        = Input(Bool())
        val cosIndex  = Input(UInt(32.W))
        val sinIndex  = Input(UInt(32.W))
        val sinOut    = Output(UInt(32.W))
        val cosOut    = Output(UInt(32.W))
        val ENout     = Output(Bool())
    })
val sinLUTBank0 = VecInit(Seq(
        "h00000000".U, "h3ac91c67".U, "h3b491c58".U, "h3b96d52e".U, "h3bc91c1a".U, "h3bfb62e6".U, "h3c16d4c6".U, "h3c2ff801".U, "h3c491b21".U, "h3c623e23".U,
        "h3c7b6101".U, "h3c8a41dc".U, "h3c96d323".U, "h3ca36452".U, "h3caff568".U, "h3cbc8663".U, "h3cc91741".U, "h3cd5a7ff".U, "h3ce2389d".U, "h3ceec918".U,
        "h3cfb596e".U, "h3d03f4cf".U, "h3d0a3cd2".U, "h3d1084c0".U, "h3d16cc97".U, "h3d1d1458".U, "h3d235c00".U, "h3d29a38f".U, "h3d2feb04".U, "h3d36325d".U,
        "h3d3c799b".U, "h3d42c0bb".U, "h3d4907bd".U, "h3d4f4ea1".U, "h3d559564".U, "h3d5bdc07".U, "h3d622287".U, "h3d6868e5".U, "h3d6eaf1e".U, "h3d74f533".U,
        "h3d7b3b22".U, "h3d80c075".U, "h3d83e346".U, "h3d870602".U, "h3d8a28a9".U, "h3d8d4b3b".U, "h3d906db7".U, "h3d93901c".U, "h3d96b26b".U, "h3d99d4a3".U,
        "h3d9cf6c3".U, "h3da018cb".U, "h3da33aba".U, "h3da65c90".U, "h3da97e4c".U, "h3dac9fee".U, "h3dafc176".U, "h3db2e2e2".U, "h3db60433".U, "h3db92567".U,
        "h3dbc467f".U, "h3dbf677a".U, "h3dc28858".U, "h3dc5a917".U, "h3dc8c9b8".U, "h3dcbea3a".U, "h3dcf0a9d".U, "h3dd22adf".U, "h3dd54b01".U, "h3dd86b03".U,
        "h3ddb8ae3".U, "h3ddeaaa1".U, "h3de1ca3c".U, "h3de4e9b5".U, "h3de8090a".U, "h3deb283c".U, "h3dee474a".U, "h3df16632".U, "h3df484f6".U, "h3df7a393".U,
        "h3dfac20b".U, "h3dfde05b".U, "h3e007f43".U, "h3e020e43".U, "h3e039d30".U, "h3e052c09".U, "h3e06bacd".U, "h3e08497c".U, "h3e09d817".U, "h3e0b669c".U,
        "h3e0cf50b".U, "h3e0e8365".U, "h3e1011a8".U, "h3e119fd6".U, "h3e132ded".U, "h3e14bbed".U, "h3e1649d7".U, "h3e17d7a9".U, "h3e196564".U, "h3e1af307".U,
        "h3e1c8092".U, "h3e1e0e05".U, "h3e1f9b60".U, "h3e2128a2".U, "h3e22b5cb".U, "h3e2442db".U, "h3e25cfd2".U, "h3e275caf".U, "h3e28e972".U, "h3e2a761b".U,
        "h3e2c02aa".U, "h3e2d8f1f".U, "h3e2f1b78".U, "h3e30a7b7".U, "h3e3233da".U, "h3e33bfe2".U, "h3e354bce".U, "h3e36d79e".U, "h3e386352".U, "h3e39eeea".U,
        "h3e3b7a65".U, "h3e3d05c3".U, "h3e3e9103".U, "h3e401c27".U, "h3e41a72c".U, "h3e433214".U, "h3e44bcde".U, "h3e464789".U, "h3e47d216".U, "h3e495c84".U,
        "h3e4ae6d3".U, "h3e4c7102".U, "h3e4dfb12".U, "h3e4f8502".U, "h3e510ed3".U, "h3e529882".U, "h3e542212".U, "h3e55ab81".U, "h3e5734ce".U, "h3e58bdfb".U,
        "h3e5a4706".U, "h3e5bcfef".U, "h3e5d58b7".U, "h3e5ee15c".U, "h3e6069df".U, "h3e61f240".U, "h3e637a7d".U, "h3e650298".U, "h3e668a8f".U, "h3e681262".U,
        "h3e699a12".U, "h3e6b219d".U, "h3e6ca905".U, "h3e6e3048".U, "h3e6fb766".U, "h3e713e5f".U, "h3e72c533".U, "h3e744be1".U, "h3e75d26a".U, "h3e7758cd".U,
        "h3e78df09".U, "h3e7a6520".U, "h3e7beb0f".U, "h3e7d70d8".U, "h3e7ef67a".U, "h3e803dfa".U, "h3e8100a3".U, "h3e81c339".U, "h3e8285ba".U, "h3e834828".U,
        "h3e840a81".U, "h3e84ccc5".U, "h3e858ef6".U, "h3e865111".U, "h3e871318".U, "h3e87d50a".U, "h3e8896e7".U, "h3e8958af".U, "h3e8a1a62".U, "h3e8adbff".U,
        "h3e8b9d88".U, "h3e8c5efa".U, "h3e8d2057".U, "h3e8de19e".U, "h3e8ea2cf".U, "h3e8f63ea".U, "h3e9024ef".U, "h3e90e5de".U, "h3e91a6b7".U, "h3e926779".U,
        "h3e932824".U, "h3e93e8b9".U, "h3e94a937".U, "h3e95699e".U, "h3e9629ee".U, "h3e96ea26".U, "h3e97aa48".U, "h3e986a52".U, "h3e992a45".U, "h3e99ea1f".U,
        "h3e9aa9e3".U, "h3e9b698e".U, "h3e9c2921".U, "h3e9ce89c".U, "h3e9da7ff".U, "h3e9e674a".U, "h3e9f267c".U, "h3e9fe596".U, "h3ea0a497".U, "h3ea1637f".U,
        "h3ea2224f".U, "h3ea2e105".U, "h3ea39fa2".U, "h3ea45e26".U, "h3ea51c91".U, "h3ea5dae2".U, "h3ea69919".U, "h3ea75737".U, "h3ea8153b".U, "h3ea8d325".U,
        "h3ea990f5".U, "h3eaa4eab".U, "h3eab0c47".U, "h3eabc9c8".U, "h3eac872f".U, "h3ead447b".U, "h3eae01ac".U, "h3eaebec3".U, "h3eaf7bbe".U, "h3eb0389e".U,
        "h3eb0f564".U, "h3eb1b20e".U, "h3eb26e9c".U, "h3eb32b0f".U, "h3eb3e767".U, "h3eb4a3a2".U, "h3eb55fc2".U, "h3eb61bc6".U, "h3eb6d7ad".U, "h3eb79379".U,
        "h3eb84f28".U, "h3eb90abb".U, "h3eb9c631".U, "h3eba818a".U, "h3ebb3cc7".U, "h3ebbf7e7".U, "h3ebcb2ea".U, "h3ebd6dcf".U, "h3ebe2898".U, "h3ebee343".U,
        "h3ebf9dd1".U, "h3ec05841".U, "h3ec11293".U, "h3ec1ccc8".U, "h3ec286df".U, "h3ec340d7".U
))

val sinLUTBank1 = VecInit(Seq(
        "h3ec3fab2".U, "h3ec4b46e".U, "h3ec56e0c".U, "h3ec6278c".U, "h3ec6e0ed".U, "h3ec79a2f".U, "h3ec85353".U, "h3ec90c57".U, "h3ec9c53d".U, "h3eca7e03".U,
        "h3ecb36ab".U, "h3ecbef33".U, "h3ecca79b".U, "h3ecd5fe4".U, "h3ece180d".U, "h3eced016".U, "h3ecf8800".U, "h3ed03fc9".U, "h3ed0f772".U, "h3ed1aefb".U,
        "h3ed26664".U, "h3ed31dac".U, "h3ed3d4d4".U, "h3ed48bdb".U, "h3ed542c1".U, "h3ed5f986".U, "h3ed6b02b".U, "h3ed766ae".U, "h3ed81d10".U, "h3ed8d350".U,
        "h3ed9896f".U, "h3eda3f6d".U, "h3edaf549".U, "h3edbab03".U, "h3edc609b".U, "h3edd1611".U, "h3eddcb65".U, "h3ede8097".U, "h3edf35a7".U, "h3edfea94".U,
        "h3ee09f5e".U, "h3ee15406".U, "h3ee2088b".U, "h3ee2bced".U, "h3ee3712d".U, "h3ee42549".U, "h3ee4d942".U, "h3ee58d18".U, "h3ee640ca".U, "h3ee6f459".U,
        "h3ee7a7c4".U, "h3ee85b0b".U, "h3ee90e2e".U, "h3ee9c12e".U, "h3eea7409".U, "h3eeb26c1".U, "h3eebd954".U, "h3eec8bc2".U, "h3eed3e0d".U, "h3eedf032".U,
        "h3eeea233".U, "h3eef540f".U, "h3ef005c6".U, "h3ef0b758".U, "h3ef168c5".U, "h3ef21a0d".U, "h3ef2cb2f".U, "h3ef37c2c".U, "h3ef42d03".U, "h3ef4ddb5".U,
        "h3ef58e40".U, "h3ef63ea6".U, "h3ef6eee6".U, "h3ef79f00".U, "h3ef84ef4".U, "h3ef8fec1".U, "h3ef9ae68".U, "h3efa5de8".U, "h3efb0d42".U, "h3efbbc75".U,
        "h3efc6b81".U, "h3efd1a67".U, "h3efdc925".U, "h3efe77bc".U, "h3eff262c".U, "h3effd474".U, "h3f00414a".U, "h3f009847".U, "h3f00ef30".U, "h3f014605".U,
        "h3f019cc6".U, "h3f01f373".U, "h3f024a0c".U, "h3f02a091".U, "h3f02f701".U, "h3f034d5e".U, "h3f03a3a6".U, "h3f03f9da".U, "h3f044ffa".U, "h3f04a605".U,
        "h3f04fbfc".U, "h3f0551de".U, "h3f05a7ab".U, "h3f05fd64".U, "h3f065309".U, "h3f06a898".U, "h3f06fe13".U, "h3f075379".U, "h3f07a8ca".U, "h3f07fe06".U,
        "h3f08532d".U, "h3f08a83f".U, "h3f08fd3d".U, "h3f095224".U, "h3f09a6f7".U, "h3f09fbb5".U, "h3f0a505d".U, "h3f0aa4f0".U, "h3f0af96d".U, "h3f0b4dd5".U,
        "h3f0ba228".U, "h3f0bf665".U, "h3f0c4a8c".U, "h3f0c9e9e".U, "h3f0cf29a".U, "h3f0d4680".U, "h3f0d9a51".U, "h3f0dee0c".U, "h3f0e41b0".U, "h3f0e953f".U,
        "h3f0ee8b8".U, "h3f0f3c1b".U, "h3f0f8f67".U, "h3f0fe29e".U, "h3f1035be".U, "h3f1088c8".U, "h3f10dbbc".U, "h3f112e9a".U, "h3f118161".U, "h3f11d411".U,
        "h3f1226ab".U, "h3f12792f".U, "h3f12cb9c".U, "h3f131df2".U, "h3f137032".U, "h3f13c25a".U, "h3f14146c".U, "h3f146668".U, "h3f14b84c".U, "h3f150a19".U,
        "h3f155bd0".U, "h3f15ad6f".U, "h3f15fef7".U, "h3f165068".U, "h3f16a1c2".U, "h3f16f305".U, "h3f174430".U, "h3f179544".U, "h3f17e641".U, "h3f183726".U,
        "h3f1887f4".U, "h3f18d8aa".U, "h3f192948".U, "h3f1979cf".U, "h3f19ca3f".U, "h3f1a1a96".U, "h3f1a6ad6".U, "h3f1abafe".U, "h3f1b0b0e".U, "h3f1b5b06".U,
        "h3f1baae6".U, "h3f1bfaaf".U, "h3f1c4a5f".U, "h3f1c99f7".U, "h3f1ce977".U, "h3f1d38de".U, "h3f1d882e".U, "h3f1dd765".U, "h3f1e2683".U, "h3f1e758a".U,
        "h3f1ec477".U, "h3f1f134d".U, "h3f1f620a".U, "h3f1fb0ae".U, "h3f1fff39".U, "h3f204dac".U, "h3f209c06".U, "h3f20ea48".U, "h3f213870".U, "h3f218680".U,
        "h3f21d477".U, "h3f222255".U, "h3f227019".U, "h3f22bdc5".U, "h3f230b58".U, "h3f2358d1".U, "h3f23a631".U, "h3f23f378".U, "h3f2440a6".U, "h3f248dbb".U,
        "h3f24dab6".U, "h3f252797".U, "h3f25745f".U, "h3f25c10e".U, "h3f260da3".U, "h3f265a1e".U, "h3f26a680".U, "h3f26f2c8".U, "h3f273ef6".U, "h3f278b0a".U,
        "h3f27d705".U, "h3f2822e5".U, "h3f286eac".U, "h3f28ba59".U, "h3f2905ec".U, "h3f295164".U, "h3f299cc3".U, "h3f29e807".U, "h3f2a3331".U, "h3f2a7e41".U,
        "h3f2ac936".U, "h3f2b1412".U, "h3f2b5ed2".U, "h3f2ba979".U, "h3f2bf405".U, "h3f2c3e76".U, "h3f2c88cd".U, "h3f2cd309".U, "h3f2d1d2a".U, "h3f2d6731".U,
        "h3f2db11d".U, "h3f2dfaee".U, "h3f2e44a5".U, "h3f2e8e40".U, "h3f2ed7c1".U, "h3f2f2126".U, "h3f2f6a71".U, "h3f2fb3a0".U, "h3f2ffcb5".U, "h3f3045ae".U,
        "h3f308e8c".U, "h3f30d74f".U, "h3f311ff6".U, "h3f316883".U, "h3f31b0f3".U, "h3f31f949".U, "h3f324183".U, "h3f3289a1".U, "h3f32d1a4".U, "h3f33198b".U,
        "h3f336157".U, "h3f33a907".U, "h3f33f09b".U, "h3f343814".U, "h3f347f70".U, "h3f34c6b1".U
))

val sinLUTBank2 = VecInit(Seq(
        "h3f350dd6".U, "h3f3554df".U, "h3f359bcc".U, "h3f35e29d".U, "h3f362952".U, "h3f366feb".U, "h3f36b668".U, "h3f36fcc8".U, "h3f37430d".U, "h3f378935".U,
        "h3f37cf40".U, "h3f381530".U, "h3f385b03".U, "h3f38a0b9".U, "h3f38e653".U, "h3f392bd1".U, "h3f397132".U, "h3f39b676".U, "h3f39fb9e".U, "h3f3a40a9".U,
        "h3f3a8597".U, "h3f3aca68".U, "h3f3b0f1d".U, "h3f3b53b5".U, "h3f3b982f".U, "h3f3bdc8d".U, "h3f3c20ce".U, "h3f3c64f2".U, "h3f3ca8f9".U, "h3f3cece3".U,
        "h3f3d30af".U, "h3f3d745f".U, "h3f3db7f1".U, "h3f3dfb66".U, "h3f3e3ebd".U, "h3f3e81f7".U, "h3f3ec514".U, "h3f3f0814".U, "h3f3f4af6".U, "h3f3f8dba".U,
        "h3f3fd061".U, "h3f4012ea".U, "h3f405556".U, "h3f4097a4".U, "h3f40d9d4".U, "h3f411be6".U, "h3f415ddb".U, "h3f419fb2".U, "h3f41e16b".U, "h3f422306".U,
        "h3f426483".U, "h3f42a5e2".U, "h3f42e723".U, "h3f432846".U, "h3f43694b".U, "h3f43aa32".U, "h3f43eafa".U, "h3f442ba5".U, "h3f446c31".U, "h3f44ac9f".U,
        "h3f44ecee".U, "h3f452d1f".U, "h3f456d32".U, "h3f45ad26".U, "h3f45ecfc".U, "h3f462cb3".U, "h3f466c4b".U, "h3f46abc5".U, "h3f46eb20".U, "h3f472a5d".U,
        "h3f47697b".U, "h3f47a87a".U, "h3f47e75a".U, "h3f48261c".U, "h3f4864be".U, "h3f48a342".U, "h3f48e1a7".U, "h3f491fec".U, "h3f495e13".U, "h3f499c1a".U,
        "h3f49da03".U, "h3f4a17cc".U, "h3f4a5576".U, "h3f4a9301".U, "h3f4ad06d".U, "h3f4b0dba".U, "h3f4b4ae7".U, "h3f4b87f4".U, "h3f4bc4e3".U, "h3f4c01b1".U,
        "h3f4c3e61".U, "h3f4c7af1".U, "h3f4cb761".U, "h3f4cf3b2".U, "h3f4d2fe3".U, "h3f4d6bf4".U, "h3f4da7e6".U, "h3f4de3b8".U, "h3f4e1f6a".U, "h3f4e5afd".U,
        "h3f4e9670".U, "h3f4ed1c2".U, "h3f4f0cf5".U, "h3f4f4808".U, "h3f4f82fb".U, "h3f4fbdce".U, "h3f4ff881".U, "h3f503313".U, "h3f506d86".U, "h3f50a7d9".U,
        "h3f50e20b".U, "h3f511c1d".U, "h3f51560f".U, "h3f518fe0".U, "h3f51c991".U, "h3f520322".U, "h3f523c93".U, "h3f5275e3".U, "h3f52af12".U, "h3f52e821".U,
        "h3f532110".U, "h3f5359dd".U, "h3f53928b".U, "h3f53cb17".U, "h3f540383".U, "h3f543bce".U, "h3f5473f9".U, "h3f54ac03".U, "h3f54e3ec".U, "h3f551bb4".U,
        "h3f55535b".U, "h3f558ae1".U, "h3f55c246".U, "h3f55f98b".U, "h3f5630ae".U, "h3f5667b0".U, "h3f569e91".U, "h3f56d551".U, "h3f570bf0".U, "h3f57426e".U,
        "h3f5778cb".U, "h3f57af06".U, "h3f57e520".U, "h3f581b19".U, "h3f5850f0".U, "h3f5886a6".U, "h3f58bc3b".U, "h3f58f1ae".U, "h3f5926ff".U, "h3f595c30".U,
        "h3f59913e".U, "h3f59c62b".U, "h3f59faf7".U, "h3f5a2fa0".U, "h3f5a6429".U, "h3f5a988f".U, "h3f5accd4".U, "h3f5b00f7".U, "h3f5b34f8".U, "h3f5b68d7".U,
        "h3f5b9c95".U, "h3f5bd031".U, "h3f5c03aa".U, "h3f5c3702".U, "h3f5c6a38".U, "h3f5c9d4c".U, "h3f5cd03d".U, "h3f5d030d".U, "h3f5d35bb".U, "h3f5d6846".U,
        "h3f5d9aaf".U, "h3f5dccf7".U, "h3f5dff1b".U, "h3f5e311e".U, "h3f5e62fe".U, "h3f5e94bc".U, "h3f5ec658".U, "h3f5ef7d1".U, "h3f5f2928".U, "h3f5f5a5d".U,
        "h3f5f8b6f".U, "h3f5fbc5e".U, "h3f5fed2b".U, "h3f601dd6".U, "h3f604e5e".U, "h3f607ec3".U, "h3f60af06".U, "h3f60df26".U, "h3f610f23".U, "h3f613efe".U,
        "h3f616eb5".U, "h3f619e4a".U, "h3f61cdbd".U, "h3f61fd0c".U, "h3f622c39".U, "h3f625b42".U, "h3f628a29".U, "h3f62b8ed".U, "h3f62e78d".U, "h3f63160b".U,
        "h3f634466".U, "h3f63729e".U, "h3f63a0b2".U, "h3f63cea4".U, "h3f63fc72".U, "h3f642a1d".U, "h3f6457a5".U, "h3f64850a".U, "h3f64b24b".U, "h3f64df69".U,
        "h3f650c64".U, "h3f65393b".U, "h3f6565f0".U, "h3f659280".U, "h3f65beee".U, "h3f65eb37".U, "h3f66175e".U, "h3f664361".U, "h3f666f40".U, "h3f669afc".U,
        "h3f66c694".U, "h3f66f209".U, "h3f671d5a".U, "h3f674887".U, "h3f677391".U, "h3f679e77".U, "h3f67c939".U, "h3f67f3d7".U, "h3f681e52".U, "h3f6848a9".U,
        "h3f6872dc".U, "h3f689ceb".U, "h3f68c6d6".U, "h3f68f09e".U, "h3f691a41".U, "h3f6943c0".U, "h3f696d1c".U, "h3f699653".U, "h3f69bf67".U, "h3f69e856".U,
        "h3f6a1121".U, "h3f6a39c8".U, "h3f6a624b".U, "h3f6a8aaa".U, "h3f6ab2e5".U, "h3f6adafb".U, "h3f6b02ed".U, "h3f6b2abb".U, "h3f6b5265".U, "h3f6b79ea".U,
        "h3f6ba14b".U, "h3f6bc888".U, "h3f6befa0".U, "h3f6c1694".U, "h3f6c3d63".U, "h3f6c640e".U
))

val sinLUTBank3 = VecInit(Seq(
        "h3f6c8a95".U, "h3f6cb0f7".U, "h3f6cd734".U, "h3f6cfd4d".U, "h3f6d2342".U, "h3f6d4912".U, "h3f6d6ebd".U, "h3f6d9443".U, "h3f6db9a5".U, "h3f6ddee3".U,
        "h3f6e03fb".U, "h3f6e28ef".U, "h3f6e4dbe".U, "h3f6e7268".U, "h3f6e96ee".U, "h3f6ebb4e".U, "h3f6edf8a".U, "h3f6f03a1".U, "h3f6f2793".U, "h3f6f4b61".U,
        "h3f6f6f09".U, "h3f6f928c".U, "h3f6fb5eb".U, "h3f6fd924".U, "h3f6ffc39".U, "h3f701f28".U, "h3f7041f2".U, "h3f706498".U, "h3f708718".U, "h3f70a973".U,
        "h3f70cba9".U, "h3f70edba".U, "h3f710fa5".U, "h3f71316c".U, "h3f71530d".U, "h3f717489".U, "h3f7195e0".U, "h3f71b711".U, "h3f71d81d".U, "h3f71f904".U,
        "h3f7219c6".U, "h3f723a62".U, "h3f725ad9".U, "h3f727b2a".U, "h3f729b56".U, "h3f72bb5c".U, "h3f72db3e".U, "h3f72faf9".U, "h3f731a8f".U, "h3f733a00".U,
        "h3f73594b".U, "h3f737871".U, "h3f739771".U, "h3f73b64b".U, "h3f73d500".U, "h3f73f38f".U, "h3f7411f9".U, "h3f74303c".U, "h3f744e5b".U, "h3f746c53".U,
        "h3f748a26".U, "h3f74a7d3".U, "h3f74c55a".U, "h3f74e2bc".U, "h3f74fff8".U, "h3f751d0e".U, "h3f7539fe".U, "h3f7556c8".U, "h3f75736d".U, "h3f758feb".U,
        "h3f75ac44".U, "h3f75c877".U, "h3f75e484".U, "h3f76006b".U, "h3f761c2c".U, "h3f7637c7".U, "h3f76533c".U, "h3f766e8b".U, "h3f7689b4".U, "h3f76a4b7".U,
        "h3f76bf94".U, "h3f76da4b".U, "h3f76f4db".U, "h3f770f46".U, "h3f77298b".U, "h3f7743a9".U, "h3f775da1".U, "h3f777773".U, "h3f77911f".U, "h3f77aaa5".U,
        "h3f77c405".U, "h3f77dd3e".U, "h3f77f651".U, "h3f780f3e".U, "h3f782804".U, "h3f7840a4".U, "h3f78591e".U, "h3f787172".U, "h3f78899f".U, "h3f78a1a6".U,
        "h3f78b987".U, "h3f78d141".U, "h3f78e8d5".U, "h3f790042".U, "h3f791789".U, "h3f792eaa".U, "h3f7945a4".U, "h3f795c77".U, "h3f797325".U, "h3f7989ab".U,
        "h3f79a00b".U, "h3f79b645".U, "h3f79cc58".U, "h3f79e245".U, "h3f79f80b".U, "h3f7a0daa".U, "h3f7a2323".U, "h3f7a3876".U, "h3f7a4da1".U, "h3f7a62a6".U,
        "h3f7a7785".U, "h3f7a8c3d".U, "h3f7aa0ce".U, "h3f7ab538".U, "h3f7ac97c".U, "h3f7add99".U, "h3f7af190".U, "h3f7b055f".U, "h3f7b1908".U, "h3f7b2c8a".U,
        "h3f7b3fe6".U, "h3f7b531b".U, "h3f7b6628".U, "h3f7b7910".U, "h3f7b8bd0".U, "h3f7b9e69".U, "h3f7bb0dc".U, "h3f7bc328".U, "h3f7bd54d".U, "h3f7be74b".U,
        "h3f7bf922".U, "h3f7c0ad3".U, "h3f7c1c5c".U, "h3f7c2dbf".U, "h3f7c3efb".U, "h3f7c5010".U, "h3f7c60fd".U, "h3f7c71c4".U, "h3f7c8264".U, "h3f7c92dd".U,
        "h3f7ca32f".U, "h3f7cb35b".U, "h3f7cc35f".U, "h3f7cd33c".U, "h3f7ce2f2".U, "h3f7cf281".U, "h3f7d01e9".U, "h3f7d112a".U, "h3f7d2044".U, "h3f7d2f37".U,
        "h3f7d3e03".U, "h3f7d4ca8".U, "h3f7d5b25".U, "h3f7d697c".U, "h3f7d77ab".U, "h3f7d85b4".U, "h3f7d9395".U, "h3f7da14f".U, "h3f7daee2".U, "h3f7dbc4e".U,
        "h3f7dc993".U, "h3f7dd6b0".U, "h3f7de3a7".U, "h3f7df076".U, "h3f7dfd1e".U, "h3f7e099f".U, "h3f7e15f9".U, "h3f7e222b".U, "h3f7e2e36".U, "h3f7e3a1b".U,
        "h3f7e45d7".U, "h3f7e516d".U, "h3f7e5cdb".U, "h3f7e6822".U, "h3f7e7342".U, "h3f7e7e3b".U, "h3f7e890c".U, "h3f7e93b6".U, "h3f7e9e39".U, "h3f7ea895".U,
        "h3f7eb2c9".U, "h3f7ebcd6".U, "h3f7ec6bb".U, "h3f7ed07a".U, "h3f7eda11".U, "h3f7ee380".U, "h3f7eecc9".U, "h3f7ef5ea".U, "h3f7efee3".U, "h3f7f07b6".U,
        "h3f7f1061".U, "h3f7f18e4".U, "h3f7f2141".U, "h3f7f2976".U, "h3f7f3183".U, "h3f7f3969".U, "h3f7f4128".U, "h3f7f48c0".U, "h3f7f5030".U, "h3f7f5778".U,
        "h3f7f5e99".U, "h3f7f6593".U, "h3f7f6c66".U, "h3f7f7311".U, "h3f7f7994".U, "h3f7f7ff0".U, "h3f7f8625".U, "h3f7f8c33".U, "h3f7f9219".U, "h3f7f97d7".U,
        "h3f7f9d6e".U, "h3f7fa2de".U, "h3f7fa826".U, "h3f7fad47".U, "h3f7fb240".U, "h3f7fb712".U, "h3f7fbbbc".U, "h3f7fc03f".U, "h3f7fc49a".U, "h3f7fc8ce".U,
        "h3f7fccdb".U, "h3f7fd0c0".U, "h3f7fd47e".U, "h3f7fd814".U, "h3f7fdb82".U, "h3f7fdeca".U, "h3f7fe1e9".U, "h3f7fe4e2".U, "h3f7fe7b2".U, "h3f7fea5c".U,
        "h3f7fecdd".U, "h3f7fef38".U, "h3f7ff16a".U, "h3f7ff376".U, "h3f7ff559".U, "h3f7ff716".U, "h3f7ff8ab".U, "h3f7ffa18".U, "h3f7ffb5e".U, "h3f7ffc7c".U,
        "h3f7ffd73".U, "h3f7ffe42".U, "h3f7ffeea".U, "h3f7fff6b".U, "h3f7fffc4".U, "h3f7ffff5".U, "h3f800000".U
))

val cosLUTBank0 = VecInit(Seq(
        "h3f800000".U, "h3f7fffec".U, "h3f7fffb1".U, "h3f7fff4e".U, "h3f7ffec4".U, "h3f7ffe12".U, "h3f7ffd39".U, "h3f7ffc38".U, "h3f7ffb10".U, "h3f7ff9c0".U,
        "h3f7ff849".U, "h3f7ff6aa".U, "h3f7ff4e4".U, "h3f7ff2f7".U, "h3f7ff0e1".U, "h3f7feea5".U, "h3f7fec41".U, "h3f7fe9b5".U, "h3f7fe702".U, "h3f7fe427".U,
        "h3f7fe125".U, "h3f7fddfc".U, "h3f7fdaaa".U, "h3f7fd732".U, "h3f7fd392".U, "h3f7fcfca".U, "h3f7fcbdc".U, "h3f7fc7c5".U, "h3f7fc387".U, "h3f7fbf22".U,
        "h3f7fba95".U, "h3f7fb5e1".U, "h3f7fb105".U, "h3f7fac02".U, "h3f7fa6d8".U, "h3f7fa185".U, "h3f7f9c0c".U, "h3f7f966b".U, "h3f7f90a3".U, "h3f7f8ab3".U,
        "h3f7f849c".U, "h3f7f7e5d".U, "h3f7f77f7".U, "h3f7f716a".U, "h3f7f6ab5".U, "h3f7f63d8".U, "h3f7f5cd5".U, "h3f7f55aa".U, "h3f7f4e57".U, "h3f7f46dd".U,
        "h3f7f3f3c".U, "h3f7f3773".U, "h3f7f2f83".U, "h3f7f276c".U, "h3f7f1f2d".U, "h3f7f16c7".U, "h3f7f0e3a".U, "h3f7f0585".U, "h3f7efca9".U, "h3f7ef3a5".U,
        "h3f7eea7a".U, "h3f7ee128".U, "h3f7ed7af".U, "h3f7ece0e".U, "h3f7ec446".U, "h3f7eba56".U, "h3f7eb03f".U, "h3f7ea601".U, "h3f7e9b9c".U, "h3f7e9110".U,
        "h3f7e865c".U, "h3f7e7b80".U, "h3f7e707e".U, "h3f7e6554".U, "h3f7e5a03".U, "h3f7e4e8b".U, "h3f7e42ec".U, "h3f7e3725".U, "h3f7e2b37".U, "h3f7e1f22".U,
        "h3f7e12e6".U, "h3f7e0682".U, "h3f7df9f8".U, "h3f7ded46".U, "h3f7de06d".U, "h3f7dd36d".U, "h3f7dc645".U, "h3f7db8f7".U, "h3f7dab81".U, "h3f7d9de4".U,
        "h3f7d9020".U, "h3f7d8235".U, "h3f7d7423".U, "h3f7d65ea".U, "h3f7d5789".U, "h3f7d4902".U, "h3f7d3a53".U, "h3f7d2b7e".U, "h3f7d1c81".U, "h3f7d0d5d".U,
        "h3f7cfe13".U, "h3f7ceea1".U, "h3f7cdf08".U, "h3f7ccf48".U, "h3f7cbf61".U, "h3f7caf53".U, "h3f7c9f1f".U, "h3f7c8ec3".U, "h3f7c7e40".U, "h3f7c6d96".U,
        "h3f7c5cc6".U, "h3f7c4bce".U, "h3f7c3aaf".U, "h3f7c296a".U, "h3f7c17fe".U, "h3f7c066a".U, "h3f7bf4b0".U, "h3f7be2cf".U, "h3f7bd0c7".U, "h3f7bbe99".U,
        "h3f7bac43".U, "h3f7b99c7".U, "h3f7b8723".U, "h3f7b7459".U, "h3f7b6169".U, "h3f7b4e51".U, "h3f7b3b13".U, "h3f7b27ad".U, "h3f7b1422".U, "h3f7b006f".U,
        "h3f7aec96".U, "h3f7ad895".U, "h3f7ac46f".U, "h3f7ab021".U, "h3f7a9bad".U, "h3f7a8712".U, "h3f7a7251".U, "h3f7a5d69".U, "h3f7a485a".U, "h3f7a3325".U,
        "h3f7a1dc9".U, "h3f7a0846".U, "h3f79f29d".U, "h3f79dccd".U, "h3f79c6d7".U, "h3f79b0ba".U, "h3f799a77".U, "h3f79840d".U, "h3f796d7d".U, "h3f7956c6".U,
        "h3f793fe9".U, "h3f7928e5".U, "h3f7911bb".U, "h3f78fa6a".U, "h3f78e2f3".U, "h3f78cb56".U, "h3f78b392".U, "h3f789ba8".U, "h3f788398".U, "h3f786b61".U,
        "h3f785304".U, "h3f783a80".U, "h3f7821d6".U, "h3f780906".U, "h3f77f010".U, "h3f77d6f3".U, "h3f77bdb0".U, "h3f77a447".U, "h3f778ab8".U, "h3f777103".U,
        "h3f775727".U, "h3f773d25".U, "h3f7722fd".U, "h3f7708af".U, "h3f76ee3b".U, "h3f76d3a1".U, "h3f76b8e0".U, "h3f769dfa".U, "h3f7682ed".U, "h3f7667bb".U,
        "h3f764c62".U, "h3f7630e4".U, "h3f76153f".U, "h3f75f975".U, "h3f75dd84".U, "h3f75c16e".U, "h3f75a531".U, "h3f7588cf".U, "h3f756c47".U, "h3f754f99".U,
        "h3f7532c5".U, "h3f7515cc".U, "h3f74f8ac".U, "h3f74db67".U, "h3f74bdfc".U, "h3f74a06b".U, "h3f7482b5".U, "h3f7464d9".U, "h3f7446d7".U, "h3f7428af".U,
        "h3f740a62".U, "h3f73ebef".U, "h3f73cd56".U, "h3f73ae98".U, "h3f738fb4".U, "h3f7370ab".U, "h3f73517c".U, "h3f733227".U, "h3f7312ad".U, "h3f72f30e".U,
        "h3f72d349".U, "h3f72b35e".U, "h3f72934e".U, "h3f727319".U, "h3f7252be".U, "h3f72323e".U, "h3f721199".U, "h3f71f0ce".U, "h3f71cfde".U, "h3f71aec8".U,
        "h3f718d8d".U, "h3f716c2d".U, "h3f714aa8".U, "h3f7128fe".U, "h3f71072e".U, "h3f70e539".U, "h3f70c31f".U, "h3f70a0e0".U, "h3f707e7b".U, "h3f705bf2".U,
        "h3f703943".U, "h3f701670".U, "h3f6ff377".U, "h3f6fd059".U, "h3f6fad17".U, "h3f6f89af".U, "h3f6f6622".U, "h3f6f4271".U, "h3f6f1e9a".U, "h3f6efa9f".U,
        "h3f6ed67f".U, "h3f6eb23a".U, "h3f6e8dd0".U, "h3f6e6941".U, "h3f6e448e".U, "h3f6e1fb5".U, "h3f6dfab8".U, "h3f6dd597".U, "h3f6db050".U, "h3f6d8ae5".U,
        "h3f6d6555".U, "h3f6d3fa1".U, "h3f6d19c8".U, "h3f6cf3cb".U, "h3f6ccda8".U, "h3f6ca762".U
))

val cosLUTBank1 = VecInit(Seq(
        "h3f6c80f7".U, "h3f6c5a67".U, "h3f6c33b3".U, "h3f6c0cda".U, "h3f6be5dd".U, "h3f6bbebc".U, "h3f6b9776".U, "h3f6b700c".U, "h3f6b487e".U, "h3f6b20cb".U,
        "h3f6af8f4".U, "h3f6ad0f9".U, "h3f6aa8d9".U, "h3f6a8096".U, "h3f6a582e".U, "h3f6a2fa2".U, "h3f6a06f2".U, "h3f69de1d".U, "h3f69b525".U, "h3f698c09".U,
        "h3f6962c8".U, "h3f693964".U, "h3f690fdb".U, "h3f68e62f".U, "h3f68bc5f".U, "h3f68926b".U, "h3f686852".U, "h3f683e16".U, "h3f6813b7".U, "h3f67e933".U,
        "h3f67be8c".U, "h3f6793c1".U, "h3f6768d2".U, "h3f673dbf".U, "h3f671289".U, "h3f66e72f".U, "h3f66bbb1".U, "h3f669010".U, "h3f66644c".U, "h3f663863".U,
        "h3f660c58".U, "h3f65e028".U, "h3f65b3d6".U, "h3f65875f".U, "h3f655ac6".U, "h3f652e09".U, "h3f650129".U, "h3f64d425".U, "h3f64a6fe".U, "h3f6479b4".U,
        "h3f644c46".U, "h3f641eb5".U, "h3f63f102".U, "h3f63c32a".U, "h3f639530".U, "h3f636713".U, "h3f6338d3".U, "h3f630a6f".U, "h3f62dbe9".U, "h3f62ad3f".U,
        "h3f627e73".U, "h3f624f83".U, "h3f622071".U, "h3f61f13c".U, "h3f61c1e3".U, "h3f619268".U, "h3f6162cb".U, "h3f61330a".U, "h3f610327".U, "h3f60d321".U,
        "h3f60a2f8".U, "h3f6072ad".U, "h3f60423f".U, "h3f6011af".U, "h3f5fe0fb".U, "h3f5fb026".U, "h3f5f7f2e".U, "h3f5f4e13".U, "h3f5f1cd6".U, "h3f5eeb76".U,
        "h3f5eb9f4".U, "h3f5e8850".U, "h3f5e568a".U, "h3f5e24a1".U, "h3f5df295".U, "h3f5dc068".U, "h3f5d8e18".U, "h3f5d5ba6".U, "h3f5d2912".U, "h3f5cf65c".U,
        "h3f5cc384".U, "h3f5c908a".U, "h3f5c5d6e".U, "h3f5c2a2f".U, "h3f5bf6cf".U, "h3f5bc34d".U, "h3f5b8fa9".U, "h3f5b5be3".U, "h3f5b27fb".U, "h3f5af3f1".U,
        "h3f5abfc6".U, "h3f5a8b79".U, "h3f5a570a".U, "h3f5a2279".U, "h3f59edc7".U, "h3f59b8f3".U, "h3f5983fe".U, "h3f594ee7".U, "h3f5919ae".U, "h3f58e454".U,
        "h3f58aed9".U, "h3f58793c".U, "h3f58437d".U, "h3f580d9e".U, "h3f57d79d".U, "h3f57a17a".U, "h3f576b37".U, "h3f5734d2".U, "h3f56fe4c".U, "h3f56c7a5".U,
        "h3f5690dc".U, "h3f5659f3".U, "h3f5622e8".U, "h3f55ebbd".U, "h3f55b470".U, "h3f557d02".U, "h3f554574".U, "h3f550dc5".U, "h3f54d5f4".U, "h3f549e03".U,
        "h3f5465f1".U, "h3f542dbf".U, "h3f53f56b".U, "h3f53bcf7".U, "h3f538462".U, "h3f534bad".U, "h3f5312d7".U, "h3f52d9e0".U, "h3f52a0c9".U, "h3f526792".U,
        "h3f522e3a".U, "h3f51f4c1".U, "h3f51bb28".U, "h3f51816f".U, "h3f514795".U, "h3f510d9b".U, "h3f50d381".U, "h3f509947".U, "h3f505eec".U, "h3f502472".U,
        "h3f4fe9d7".U, "h3f4faf1c".U, "h3f4f7441".U, "h3f4f3946".U, "h3f4efe2b".U, "h3f4ec2f1".U, "h3f4e8796".U, "h3f4e4c1b".U, "h3f4e1081".U, "h3f4dd4c7".U,
        "h3f4d98ed".U, "h3f4d5cf3".U, "h3f4d20da".U, "h3f4ce4a1".U, "h3f4ca848".U, "h3f4c6bd0".U, "h3f4c2f38".U, "h3f4bf281".U, "h3f4bb5aa".U, "h3f4b78b4".U,
        "h3f4b3b9e".U, "h3f4afe69".U, "h3f4ac115".U, "h3f4a83a2".U, "h3f4a460f".U, "h3f4a085d".U, "h3f49ca8c".U, "h3f498c9c".U, "h3f494e8c".U, "h3f49105e".U,
        "h3f48d210".U, "h3f4893a4".U, "h3f485518".U, "h3f48166e".U, "h3f47d7a5".U, "h3f4798bd".U, "h3f4759b6".U, "h3f471a91".U, "h3f46db4c".U, "h3f469bea".U,
        "h3f465c68".U, "h3f461cc8".U, "h3f45dd09".U, "h3f459d2c".U, "h3f455d30".U, "h3f451d16".U, "h3f44dcdd".U, "h3f449c86".U, "h3f445c11".U, "h3f441b7d".U,
        "h3f43dacb".U, "h3f4399fb".U, "h3f43590d".U, "h3f431800".U, "h3f42d6d6".U, "h3f42958d".U, "h3f425427".U, "h3f4212a2".U, "h3f41d0ff".U, "h3f418f3f".U,
        "h3f414d61".U, "h3f410b65".U, "h3f40c94b".U, "h3f408713".U, "h3f4044be".U, "h3f40024b".U, "h3f3fbfba".U, "h3f3f7d0c".U, "h3f3f3a40".U, "h3f3ef757".U,
        "h3f3eb450".U, "h3f3e712c".U, "h3f3e2dea".U, "h3f3dea8b".U, "h3f3da70f".U, "h3f3d6376".U, "h3f3d1fbf".U, "h3f3cdbeb".U, "h3f3c97fa".U, "h3f3c53ec".U,
        "h3f3c0fc1".U, "h3f3bcb79".U, "h3f3b8713".U, "h3f3b4291".U, "h3f3afdf2".U, "h3f3ab937".U, "h3f3a745e".U, "h3f3a2f68".U, "h3f39ea56".U, "h3f39a528".U,
        "h3f395fdc".U, "h3f391a74".U, "h3f38d4ef".U, "h3f388f4e".U, "h3f384991".U, "h3f3803b7".U, "h3f37bdc0".U, "h3f3777ad".U, "h3f37317e".U, "h3f36eb33".U,
        "h3f36a4cb".U, "h3f365e48".U, "h3f3617a8".U, "h3f35d0ec".U, "h3f358a14".U, "h3f354320".U
))

val cosLUTBank2 = VecInit(Seq(
        "h3f34fc10".U, "h3f34b4e4".U, "h3f346d9c".U, "h3f342638".U, "h3f33deb9".U, "h3f33971e".U, "h3f334f67".U, "h3f330794".U, "h3f32bfa6".U, "h3f32779c".U,
        "h3f322f77".U, "h3f31e736".U, "h3f319eda".U, "h3f315662".U, "h3f310dcf".U, "h3f30c521".U, "h3f307c57".U, "h3f303372".U, "h3f2fea72".U, "h3f2fa157".U,
        "h3f2f5821".U, "h3f2f0ed0".U, "h3f2ec563".U, "h3f2e7bdc".U, "h3f2e323a".U, "h3f2de87d".U, "h3f2d9ea5".U, "h3f2d54b2".U, "h3f2d0aa5".U, "h3f2cc07c".U,
        "h3f2c763a".U, "h3f2c2bdc".U, "h3f2be164".U, "h3f2b96d2".U, "h3f2b4c25".U, "h3f2b015d".U, "h3f2ab67c".U, "h3f2a6b7f".U, "h3f2a2069".U, "h3f29d538".U,
        "h3f2989ed".U, "h3f293e88".U, "h3f28f309".U, "h3f28a770".U, "h3f285bbd".U, "h3f280ff0".U, "h3f27c409".U, "h3f277808".U, "h3f272bed".U, "h3f26dfb8".U,
        "h3f26936a".U, "h3f264702".U, "h3f25fa80".U, "h3f25ade4".U, "h3f256130".U, "h3f251461".U, "h3f24c779".U, "h3f247a78".U, "h3f242d5d".U, "h3f23e029".U,
        "h3f2392dc".U, "h3f234575".U, "h3f22f7f5".U, "h3f22aa5d".U, "h3f225cab".U, "h3f220ee0".U, "h3f21c0fc".U, "h3f2172ff".U, "h3f2124e9".U, "h3f20d6ba".U,
        "h3f208872".U, "h3f203a12".U, "h3f1feb99".U, "h3f1f9d07".U, "h3f1f4e5d".U, "h3f1eff9a".U, "h3f1eb0be".U, "h3f1e61ca".U, "h3f1e12be".U, "h3f1dc399".U,
        "h3f1d745c".U, "h3f1d2507".U, "h3f1cd599".U, "h3f1c8613".U, "h3f1c3675".U, "h3f1be6bf".U, "h3f1b96f1".U, "h3f1b470a".U, "h3f1af70c".U, "h3f1aa6f6".U,
        "h3f1a56c8".U, "h3f1a0683".U, "h3f19b625".U, "h3f1965b0".U, "h3f191523".U, "h3f18c47f".U, "h3f1873c2".U, "h3f1822ef".U, "h3f17d204".U, "h3f178101".U,
        "h3f172fe8".U, "h3f16deb6".U, "h3f168d6e".U, "h3f163c0e".U, "h3f15ea97".U, "h3f159909".U, "h3f154764".U, "h3f14f5a8".U, "h3f14a3d5".U, "h3f1451eb".U,
        "h3f13ffea".U, "h3f13add2".U, "h3f135ba4".U, "h3f13095f".U, "h3f12b703".U, "h3f126490".U, "h3f121207".U, "h3f11bf67".U, "h3f116cb1".U, "h3f1119e4".U,
        "h3f10c701".U, "h3f107408".U, "h3f1020f8".U, "h3f0fcdd2".U, "h3f0f7a96".U, "h3f0f2744".U, "h3f0ed3dc".U, "h3f0e805d".U, "h3f0e2cc9".U, "h3f0dd91f".U,
        "h3f0d855f".U, "h3f0d3189".U, "h3f0cdd9d".U, "h3f0c899c".U, "h3f0c3584".U, "h3f0be158".U, "h3f0b8d15".U, "h3f0b38bd".U, "h3f0ae450".U, "h3f0a8fcd".U,
        "h3f0a3b35".U, "h3f09e687".U, "h3f0991c4".U, "h3f093cec".U, "h3f08e7ff".U, "h3f0892fd".U, "h3f083de5".U, "h3f07e8b9".U, "h3f079378".U, "h3f073e21".U,
        "h3f06e8b6".U, "h3f069336".U, "h3f063da1".U, "h3f05e7f8".U, "h3f05923a".U, "h3f053c67".U, "h3f04e680".U, "h3f049084".U, "h3f043a74".U, "h3f03e44f".U,
        "h3f038e16".U, "h3f0337c9".U, "h3f02e167".U, "h3f028af1".U, "h3f023468".U, "h3f01ddca".U, "h3f018718".U, "h3f013052".U, "h3f00d978".U, "h3f00828a".U,
        "h3f002b88".U, "h3effa8e6".U, "h3efefa93".U, "h3efe4c1a".U, "h3efd9d79".U, "h3efceeb1".U, "h3efc3fc2".U, "h3efb90ac".U, "h3efae16f".U, "h3efa320c".U,
        "h3ef98282".U, "h3ef8d2d1".U, "h3ef822fa".U, "h3ef772fd".U, "h3ef6c2da".U, "h3ef61290".U, "h3ef56221".U, "h3ef4b18c".U, "h3ef400d1".U, "h3ef34ff0".U,
        "h3ef29eea".U, "h3ef1edbe".U, "h3ef13c6d".U, "h3ef08af7".U, "h3eefd95c".U, "h3eef279b".U, "h3eee75b6".U, "h3eedc3ac".U, "h3eed117d".U, "h3eec5f2a".U,
        "h3eebacb2".U, "h3eeafa16".U, "h3eea4756".U, "h3ee99471".U, "h3ee8e169".U, "h3ee82e3c".U, "h3ee77aec".U, "h3ee6c778".U, "h3ee613e1".U, "h3ee56025".U,
        "h3ee4ac47".U, "h3ee3f845".U, "h3ee34420".U, "h3ee28fd8".U, "h3ee1db6d".U, "h3ee126df".U, "h3ee0722f".U, "h3edfbd5c".U, "h3edf0866".U, "h3ede534e".U,
        "h3edd9e13".U, "h3edce8b7".U, "h3edc3338".U, "h3edb7d97".U, "h3edac7d5".U, "h3eda11f1".U, "h3ed95beb".U, "h3ed8a5c3".U, "h3ed7ef7a".U, "h3ed73910".U,
        "h3ed68285".U, "h3ed5cbd8".U, "h3ed5150b".U, "h3ed45e1c".U, "h3ed3a70d".U, "h3ed2efdd".U, "h3ed2388d".U, "h3ed1811c".U, "h3ed0c98b".U, "h3ed011da".U,
        "h3ecf5a08".U, "h3ecea217".U, "h3ecdea06".U, "h3ecd31d4".U, "h3ecc7984".U, "h3ecbc113".U, "h3ecb0884".U, "h3eca4fd5".U, "h3ec99706".U, "h3ec8de19".U,
        "h3ec8250d".U, "h3ec76be2".U, "h3ec6b298".U, "h3ec5f92f".U, "h3ec53fa8".U, "h3ec48602".U
))

val cosLUTBank3 = VecInit(Seq(
        "h3ec3cc3e".U, "h3ec3125c".U, "h3ec2585c".U, "h3ec19e3e".U, "h3ec0e401".U, "h3ec029a8".U, "h3ebf6f30".U, "h3ebeb49b".U, "h3ebdf9e8".U, "h3ebd3f19".U,
        "h3ebc842c".U, "h3ebbc922".U, "h3ebb0dfb".U, "h3eba52b7".U, "h3eb99756".U, "h3eb8dbd9".U, "h3eb8203f".U, "h3eb76489".U, "h3eb6a8b6".U, "h3eb5ecc7".U,
        "h3eb530bd".U, "h3eb47496".U, "h3eb3b853".U, "h3eb2fbf5".U, "h3eb23f7b".U, "h3eb182e6".U, "h3eb0c635".U, "h3eb00969".U, "h3eaf4c82".U, "h3eae8f7f".U,
        "h3eadd262".U, "h3ead152a".U, "h3eac57d7".U, "h3eab9a6a".U, "h3eaadce2".U, "h3eaa1f40".U, "h3ea96184".U, "h3ea8a3ad".U, "h3ea7e5bd".U, "h3ea727b2".U,
        "h3ea6698e".U, "h3ea5ab50".U, "h3ea4ecf8".U, "h3ea42e88".U, "h3ea36ffd".U, "h3ea2b15a".U, "h3ea1f29d".U, "h3ea133c8".U, "h3ea074d9".U, "h3e9fb5d2".U,
        "h3e9ef6b2".U, "h3e9e377a".U, "h3e9d7829".U, "h3e9cb8c0".U, "h3e9bf93f".U, "h3e9b39a5".U, "h3e9a79f4".U, "h3e99ba2b".U, "h3e98fa4a".U, "h3e983a52".U,
        "h3e977a42".U, "h3e96ba1a".U, "h3e95f9dc".U, "h3e953986".U, "h3e94791a".U, "h3e93b896".U, "h3e92f7fc".U, "h3e92374a".U, "h3e917683".U, "h3e90b5a5".U,
        "h3e8ff4b0".U, "h3e8f33a6".U, "h3e8e7285".U, "h3e8db14e".U, "h3e8cf002".U, "h3e8c2e9f".U, "h3e8b6d28".U, "h3e8aab9a".U, "h3e89e9f7".U, "h3e89283f".U,
        "h3e886672".U, "h3e87a490".U, "h3e86e298".U, "h3e86208c".U, "h3e855e6b".U, "h3e849c36".U, "h3e83d9ec".U, "h3e83178e".U, "h3e82551c".U, "h3e819295".U,
        "h3e80cffb".U, "h3e800d4d".U, "h3e7e9515".U, "h3e7d0f6a".U, "h3e7b8997".U, "h3e7a039e".U, "h3e787d7e".U, "h3e76f738".U, "h3e7570cb".U, "h3e73ea39".U,
        "h3e726381".U, "h3e70dca4".U, "h3e6f55a2".U, "h3e6dce7a".U, "h3e6c472e".U, "h3e6abfbe".U, "h3e693829".U, "h3e67b071".U, "h3e662894".U, "h3e64a094".U,
        "h3e631871".U, "h3e61902b".U, "h3e6007c2".U, "h3e5e7f36".U, "h3e5cf688".U, "h3e5b6db8".U, "h3e59e4c6".U, "h3e585bb3".U, "h3e56d27e".U, "h3e554928".U,
        "h3e53bfb1".U, "h3e52361a".U, "h3e50ac61".U, "h3e4f2289".U, "h3e4d9891".U, "h3e4c0e79".U, "h3e4a8442".U, "h3e48f9eb".U, "h3e476f76".U, "h3e45e4e1".U,
        "h3e445a2e".U, "h3e42cf5d".U, "h3e41446e".U, "h3e3fb961".U, "h3e3e2e36".U, "h3e3ca2ee".U, "h3e3b1789".U, "h3e398c07".U, "h3e380068".U, "h3e3674ad".U,
        "h3e34e8d6".U, "h3e335ce3".U, "h3e31d0d4".U, "h3e3044aa".U, "h3e2eb864".U, "h3e2d2c04".U, "h3e2b9f89".U, "h3e2a12f3".U, "h3e288644".U, "h3e26f97a".U,
        "h3e256c96".U, "h3e23df99".U, "h3e225283".U, "h3e20c553".U, "h3e1f380b".U, "h3e1daaaa".U, "h3e1c1d31".U, "h3e1a8fa0".U, "h3e1901f7".U, "h3e177436".U,
        "h3e15e65e".U, "h3e14586f".U, "h3e12ca69".U, "h3e113c4d".U, "h3e0fae1a".U, "h3e0e1fd0".U, "h3e0c9171".U, "h3e0b02fc".U, "h3e097472".U, "h3e07e5d2".U,
        "h3e06571e".U, "h3e04c855".U, "h3e033977".U, "h3e01aa85".U, "h3e001b7f".U, "h3dfd18cb".U, "h3df9fa70".U, "h3df6dbef".U, "h3df3bd48".U, "h3df09e7b".U,
        "h3ded7f8a".U, "h3dea6073".U, "h3de74138".U, "h3de421da".U, "h3de10259".U, "h3ddde2b4".U, "h3ddac2ee".U, "h3dd7a305".U, "h3dd482fc".U, "h3dd162d2".U,
        "h3dce4287".U, "h3dcb221d".U, "h3dc80193".U, "h3dc4e0ea".U, "h3dc1c023".U, "h3dbe9f3e".U, "h3dbb7e3c".U, "h3db85d1d".U, "h3db53be1".U, "h3db21a89".U,
        "h3daef916".U, "h3dabd788".U, "h3da8b5df".U, "h3da5941d".U, "h3da27240".U, "h3d9f504b".U, "h3d9c2e3d".U, "h3d990c17".U, "h3d95e9da".U, "h3d92c785".U,
        "h3d8fa51a".U, "h3d8c8298".U, "h3d896001".U, "h3d863d55".U, "h3d831a94".U, "h3d7fef7c".U, "h3d79a9aa".U, "h3d7363b2".U, "h3d6d1d93".U, "h3d66d751".U,
        "h3d6090ea".U, "h3d5a4a61".U, "h3d5403b6".U, "h3d4dbceb".U, "h3d477600".U, "h3d412ef6".U, "h3d3ae7ce".U, "h3d34a089".U, "h3d2e5929".U, "h3d2811ad".U,
        "h3d21ca18".U, "h3d1b826a".U, "h3d153aa4".U, "h3d0ef2c6".U, "h3d08aad3".U, "h3d0262cb".U, "h3cf8355c".U, "h3ceba4fd".U, "h3cdf1479".U, "h3cd283d3".U,
        "h3cc5f30c".U, "h3cb96227".U, "h3cacd125".U, "h3ca04008".U, "h3c93aed3".U, "h3c871d87".U, "h3c75184d".U, "h3c5bf566".U, "h3c42d25c".U, "h3c29af35".U,
        "h3c108bf3".U, "h3beed136".U, "h3bbc8a61".U, "h3b8a4370".U, "h3b2ff8d1".U, "h3a96d54f".U, "h00000000".U
))
    val cosLUT = VecInit(cosLUTBank0 ++ cosLUTBank1 ++ cosLUTBank2 ++ cosLUTBank3)
    val sinLUT = VecInit(sinLUTBank0 ++ sinLUTBank1 ++ sinLUTBank2 ++ sinLUTBank3)

    io.cosOut := Mux(io.EN, cosLUT(io.cosIndex), 0.U(32.W)) 
    io.sinOut := Mux(io.EN, sinLUT(io.sinIndex), 0.U(32.W))
    io.ENout  := Mux(io.EN, io.EN, 0.B)
}

class CosLUTbank() extends Module {
    val io = IO(new Bundle {
        val EN        = Input(Bool())
        val cosIndex  = Input(UInt(32.W))
        val sinIndex  = Input(UInt(32.W))
        val sinOut    = Output(UInt(32.W))
        val cosOut    = Output(UInt(32.W))
        val ENout     = Output(Bool())
    })

val cosLUTBank0 = VecInit(Seq(
        "h3f800000".U, "h3f7fffec".U, "h3f7fffb1".U, "h3f7fff4e".U, "h3f7ffec4".U, "h3f7ffe12".U, "h3f7ffd39".U, "h3f7ffc38".U, "h3f7ffb10".U, "h3f7ff9c0".U,
        "h3f7ff849".U, "h3f7ff6aa".U, "h3f7ff4e4".U, "h3f7ff2f7".U, "h3f7ff0e1".U, "h3f7feea5".U, "h3f7fec41".U, "h3f7fe9b5".U, "h3f7fe702".U, "h3f7fe427".U,
        "h3f7fe125".U, "h3f7fddfc".U, "h3f7fdaaa".U, "h3f7fd732".U, "h3f7fd392".U, "h3f7fcfca".U, "h3f7fcbdc".U, "h3f7fc7c5".U, "h3f7fc387".U, "h3f7fbf22".U,
        "h3f7fba95".U, "h3f7fb5e1".U, "h3f7fb105".U, "h3f7fac02".U, "h3f7fa6d8".U, "h3f7fa185".U, "h3f7f9c0c".U, "h3f7f966b".U, "h3f7f90a3".U, "h3f7f8ab3".U,
        "h3f7f849c".U, "h3f7f7e5d".U, "h3f7f77f7".U, "h3f7f716a".U, "h3f7f6ab5".U, "h3f7f63d8".U, "h3f7f5cd5".U, "h3f7f55aa".U, "h3f7f4e57".U, "h3f7f46dd".U,
        "h3f7f3f3c".U, "h3f7f3773".U, "h3f7f2f83".U, "h3f7f276c".U, "h3f7f1f2d".U, "h3f7f16c7".U, "h3f7f0e3a".U, "h3f7f0585".U, "h3f7efca9".U, "h3f7ef3a5".U,
        "h3f7eea7a".U, "h3f7ee128".U, "h3f7ed7af".U, "h3f7ece0e".U, "h3f7ec446".U, "h3f7eba56".U, "h3f7eb03f".U, "h3f7ea601".U, "h3f7e9b9c".U, "h3f7e9110".U,
        "h3f7e865c".U, "h3f7e7b80".U, "h3f7e707e".U, "h3f7e6554".U, "h3f7e5a03".U, "h3f7e4e8b".U, "h3f7e42ec".U, "h3f7e3725".U, "h3f7e2b37".U, "h3f7e1f22".U,
        "h3f7e12e6".U, "h3f7e0682".U, "h3f7df9f8".U, "h3f7ded46".U, "h3f7de06d".U, "h3f7dd36d".U, "h3f7dc645".U, "h3f7db8f7".U, "h3f7dab81".U, "h3f7d9de4".U,
        "h3f7d9020".U, "h3f7d8235".U, "h3f7d7423".U, "h3f7d65ea".U, "h3f7d5789".U, "h3f7d4902".U, "h3f7d3a53".U, "h3f7d2b7e".U, "h3f7d1c81".U, "h3f7d0d5d".U,
        "h3f7cfe13".U, "h3f7ceea1".U, "h3f7cdf08".U, "h3f7ccf48".U, "h3f7cbf61".U, "h3f7caf53".U, "h3f7c9f1f".U, "h3f7c8ec3".U, "h3f7c7e40".U, "h3f7c6d96".U,
        "h3f7c5cc6".U, "h3f7c4bce".U, "h3f7c3aaf".U, "h3f7c296a".U, "h3f7c17fe".U, "h3f7c066a".U, "h3f7bf4b0".U, "h3f7be2cf".U, "h3f7bd0c7".U, "h3f7bbe99".U,
        "h3f7bac43".U, "h3f7b99c7".U, "h3f7b8723".U, "h3f7b7459".U, "h3f7b6169".U, "h3f7b4e51".U, "h3f7b3b13".U, "h3f7b27ad".U, "h3f7b1422".U, "h3f7b006f".U,
        "h3f7aec96".U, "h3f7ad895".U, "h3f7ac46f".U, "h3f7ab021".U, "h3f7a9bad".U, "h3f7a8712".U, "h3f7a7251".U, "h3f7a5d69".U, "h3f7a485a".U, "h3f7a3325".U,
        "h3f7a1dc9".U, "h3f7a0846".U, "h3f79f29d".U, "h3f79dccd".U, "h3f79c6d7".U, "h3f79b0ba".U, "h3f799a77".U, "h3f79840d".U, "h3f796d7d".U, "h3f7956c6".U,
        "h3f793fe9".U, "h3f7928e5".U, "h3f7911bb".U, "h3f78fa6a".U, "h3f78e2f3".U, "h3f78cb56".U, "h3f78b392".U, "h3f789ba8".U, "h3f788398".U, "h3f786b61".U,
        "h3f785304".U, "h3f783a80".U, "h3f7821d6".U, "h3f780906".U, "h3f77f010".U, "h3f77d6f3".U, "h3f77bdb0".U, "h3f77a447".U, "h3f778ab8".U, "h3f777103".U,
        "h3f775727".U, "h3f773d25".U, "h3f7722fd".U, "h3f7708af".U, "h3f76ee3b".U, "h3f76d3a1".U, "h3f76b8e0".U, "h3f769dfa".U, "h3f7682ed".U, "h3f7667bb".U,
        "h3f764c62".U, "h3f7630e4".U, "h3f76153f".U, "h3f75f975".U, "h3f75dd84".U, "h3f75c16e".U, "h3f75a531".U, "h3f7588cf".U, "h3f756c47".U, "h3f754f99".U,
        "h3f7532c5".U, "h3f7515cc".U, "h3f74f8ac".U, "h3f74db67".U, "h3f74bdfc".U, "h3f74a06b".U, "h3f7482b5".U, "h3f7464d9".U, "h3f7446d7".U, "h3f7428af".U,
        "h3f740a62".U, "h3f73ebef".U, "h3f73cd56".U, "h3f73ae98".U, "h3f738fb4".U, "h3f7370ab".U, "h3f73517c".U, "h3f733227".U, "h3f7312ad".U, "h3f72f30e".U,
        "h3f72d349".U, "h3f72b35e".U, "h3f72934e".U, "h3f727319".U, "h3f7252be".U, "h3f72323e".U, "h3f721199".U, "h3f71f0ce".U, "h3f71cfde".U, "h3f71aec8".U,
        "h3f718d8d".U, "h3f716c2d".U, "h3f714aa8".U, "h3f7128fe".U, "h3f71072e".U, "h3f70e539".U, "h3f70c31f".U, "h3f70a0e0".U, "h3f707e7b".U, "h3f705bf2".U,
        "h3f703943".U, "h3f701670".U, "h3f6ff377".U, "h3f6fd059".U, "h3f6fad17".U, "h3f6f89af".U, "h3f6f6622".U, "h3f6f4271".U, "h3f6f1e9a".U, "h3f6efa9f".U,
        "h3f6ed67f".U, "h3f6eb23a".U, "h3f6e8dd0".U, "h3f6e6941".U, "h3f6e448e".U, "h3f6e1fb5".U, "h3f6dfab8".U, "h3f6dd597".U, "h3f6db050".U, "h3f6d8ae5".U,
        "h3f6d6555".U, "h3f6d3fa1".U, "h3f6d19c8".U, "h3f6cf3cb".U, "h3f6ccda8".U, "h3f6ca762".U
))

val cosLUTBank1 = VecInit(Seq(
        "h3f6c80f7".U, "h3f6c5a67".U, "h3f6c33b3".U, "h3f6c0cda".U, "h3f6be5dd".U, "h3f6bbebc".U, "h3f6b9776".U, "h3f6b700c".U, "h3f6b487e".U, "h3f6b20cb".U,
        "h3f6af8f4".U, "h3f6ad0f9".U, "h3f6aa8d9".U, "h3f6a8096".U, "h3f6a582e".U, "h3f6a2fa2".U, "h3f6a06f2".U, "h3f69de1d".U, "h3f69b525".U, "h3f698c09".U,
        "h3f6962c8".U, "h3f693964".U, "h3f690fdb".U, "h3f68e62f".U, "h3f68bc5f".U, "h3f68926b".U, "h3f686852".U, "h3f683e16".U, "h3f6813b7".U, "h3f67e933".U,
        "h3f67be8c".U, "h3f6793c1".U, "h3f6768d2".U, "h3f673dbf".U, "h3f671289".U, "h3f66e72f".U, "h3f66bbb1".U, "h3f669010".U, "h3f66644c".U, "h3f663863".U,
        "h3f660c58".U, "h3f65e028".U, "h3f65b3d6".U, "h3f65875f".U, "h3f655ac6".U, "h3f652e09".U, "h3f650129".U, "h3f64d425".U, "h3f64a6fe".U, "h3f6479b4".U,
        "h3f644c46".U, "h3f641eb5".U, "h3f63f102".U, "h3f63c32a".U, "h3f639530".U, "h3f636713".U, "h3f6338d3".U, "h3f630a6f".U, "h3f62dbe9".U, "h3f62ad3f".U,
        "h3f627e73".U, "h3f624f83".U, "h3f622071".U, "h3f61f13c".U, "h3f61c1e3".U, "h3f619268".U, "h3f6162cb".U, "h3f61330a".U, "h3f610327".U, "h3f60d321".U,
        "h3f60a2f8".U, "h3f6072ad".U, "h3f60423f".U, "h3f6011af".U, "h3f5fe0fb".U, "h3f5fb026".U, "h3f5f7f2e".U, "h3f5f4e13".U, "h3f5f1cd6".U, "h3f5eeb76".U,
        "h3f5eb9f4".U, "h3f5e8850".U, "h3f5e568a".U, "h3f5e24a1".U, "h3f5df295".U, "h3f5dc068".U, "h3f5d8e18".U, "h3f5d5ba6".U, "h3f5d2912".U, "h3f5cf65c".U,
        "h3f5cc384".U, "h3f5c908a".U, "h3f5c5d6e".U, "h3f5c2a2f".U, "h3f5bf6cf".U, "h3f5bc34d".U, "h3f5b8fa9".U, "h3f5b5be3".U, "h3f5b27fb".U, "h3f5af3f1".U,
        "h3f5abfc6".U, "h3f5a8b79".U, "h3f5a570a".U, "h3f5a2279".U, "h3f59edc7".U, "h3f59b8f3".U, "h3f5983fe".U, "h3f594ee7".U, "h3f5919ae".U, "h3f58e454".U,
        "h3f58aed9".U, "h3f58793c".U, "h3f58437d".U, "h3f580d9e".U, "h3f57d79d".U, "h3f57a17a".U, "h3f576b37".U, "h3f5734d2".U, "h3f56fe4c".U, "h3f56c7a5".U,
        "h3f5690dc".U, "h3f5659f3".U, "h3f5622e8".U, "h3f55ebbd".U, "h3f55b470".U, "h3f557d02".U, "h3f554574".U, "h3f550dc5".U, "h3f54d5f4".U, "h3f549e03".U,
        "h3f5465f1".U, "h3f542dbf".U, "h3f53f56b".U, "h3f53bcf7".U, "h3f538462".U, "h3f534bad".U, "h3f5312d7".U, "h3f52d9e0".U, "h3f52a0c9".U, "h3f526792".U,
        "h3f522e3a".U, "h3f51f4c1".U, "h3f51bb28".U, "h3f51816f".U, "h3f514795".U, "h3f510d9b".U, "h3f50d381".U, "h3f509947".U, "h3f505eec".U, "h3f502472".U,
        "h3f4fe9d7".U, "h3f4faf1c".U, "h3f4f7441".U, "h3f4f3946".U, "h3f4efe2b".U, "h3f4ec2f1".U, "h3f4e8796".U, "h3f4e4c1b".U, "h3f4e1081".U, "h3f4dd4c7".U,
        "h3f4d98ed".U, "h3f4d5cf3".U, "h3f4d20da".U, "h3f4ce4a1".U, "h3f4ca848".U, "h3f4c6bd0".U, "h3f4c2f38".U, "h3f4bf281".U, "h3f4bb5aa".U, "h3f4b78b4".U,
        "h3f4b3b9e".U, "h3f4afe69".U, "h3f4ac115".U, "h3f4a83a2".U, "h3f4a460f".U, "h3f4a085d".U, "h3f49ca8c".U, "h3f498c9c".U, "h3f494e8c".U, "h3f49105e".U,
        "h3f48d210".U, "h3f4893a4".U, "h3f485518".U, "h3f48166e".U, "h3f47d7a5".U, "h3f4798bd".U, "h3f4759b6".U, "h3f471a91".U, "h3f46db4c".U, "h3f469bea".U,
        "h3f465c68".U, "h3f461cc8".U, "h3f45dd09".U, "h3f459d2c".U, "h3f455d30".U, "h3f451d16".U, "h3f44dcdd".U, "h3f449c86".U, "h3f445c11".U, "h3f441b7d".U,
        "h3f43dacb".U, "h3f4399fb".U, "h3f43590d".U, "h3f431800".U, "h3f42d6d6".U, "h3f42958d".U, "h3f425427".U, "h3f4212a2".U, "h3f41d0ff".U, "h3f418f3f".U,
        "h3f414d61".U, "h3f410b65".U, "h3f40c94b".U, "h3f408713".U, "h3f4044be".U, "h3f40024b".U, "h3f3fbfba".U, "h3f3f7d0c".U, "h3f3f3a40".U, "h3f3ef757".U,
        "h3f3eb450".U, "h3f3e712c".U, "h3f3e2dea".U, "h3f3dea8b".U, "h3f3da70f".U, "h3f3d6376".U, "h3f3d1fbf".U, "h3f3cdbeb".U, "h3f3c97fa".U, "h3f3c53ec".U,
        "h3f3c0fc1".U, "h3f3bcb79".U, "h3f3b8713".U, "h3f3b4291".U, "h3f3afdf2".U, "h3f3ab937".U, "h3f3a745e".U, "h3f3a2f68".U, "h3f39ea56".U, "h3f39a528".U,
        "h3f395fdc".U, "h3f391a74".U, "h3f38d4ef".U, "h3f388f4e".U, "h3f384991".U, "h3f3803b7".U, "h3f37bdc0".U, "h3f3777ad".U, "h3f37317e".U, "h3f36eb33".U,
        "h3f36a4cb".U, "h3f365e48".U, "h3f3617a8".U, "h3f35d0ec".U, "h3f358a14".U, "h3f354320".U
))

val cosLUTBank2 = VecInit(Seq(
        "h3f34fc10".U, "h3f34b4e4".U, "h3f346d9c".U, "h3f342638".U, "h3f33deb9".U, "h3f33971e".U, "h3f334f67".U, "h3f330794".U, "h3f32bfa6".U, "h3f32779c".U,
        "h3f322f77".U, "h3f31e736".U, "h3f319eda".U, "h3f315662".U, "h3f310dcf".U, "h3f30c521".U, "h3f307c57".U, "h3f303372".U, "h3f2fea72".U, "h3f2fa157".U,
        "h3f2f5821".U, "h3f2f0ed0".U, "h3f2ec563".U, "h3f2e7bdc".U, "h3f2e323a".U, "h3f2de87d".U, "h3f2d9ea5".U, "h3f2d54b2".U, "h3f2d0aa5".U, "h3f2cc07c".U,
        "h3f2c763a".U, "h3f2c2bdc".U, "h3f2be164".U, "h3f2b96d2".U, "h3f2b4c25".U, "h3f2b015d".U, "h3f2ab67c".U, "h3f2a6b7f".U, "h3f2a2069".U, "h3f29d538".U,
        "h3f2989ed".U, "h3f293e88".U, "h3f28f309".U, "h3f28a770".U, "h3f285bbd".U, "h3f280ff0".U, "h3f27c409".U, "h3f277808".U, "h3f272bed".U, "h3f26dfb8".U,
        "h3f26936a".U, "h3f264702".U, "h3f25fa80".U, "h3f25ade4".U, "h3f256130".U, "h3f251461".U, "h3f24c779".U, "h3f247a78".U, "h3f242d5d".U, "h3f23e029".U,
        "h3f2392dc".U, "h3f234575".U, "h3f22f7f5".U, "h3f22aa5d".U, "h3f225cab".U, "h3f220ee0".U, "h3f21c0fc".U, "h3f2172ff".U, "h3f2124e9".U, "h3f20d6ba".U,
        "h3f208872".U, "h3f203a12".U, "h3f1feb99".U, "h3f1f9d07".U, "h3f1f4e5d".U, "h3f1eff9a".U, "h3f1eb0be".U, "h3f1e61ca".U, "h3f1e12be".U, "h3f1dc399".U,
        "h3f1d745c".U, "h3f1d2507".U, "h3f1cd599".U, "h3f1c8613".U, "h3f1c3675".U, "h3f1be6bf".U, "h3f1b96f1".U, "h3f1b470a".U, "h3f1af70c".U, "h3f1aa6f6".U,
        "h3f1a56c8".U, "h3f1a0683".U, "h3f19b625".U, "h3f1965b0".U, "h3f191523".U, "h3f18c47f".U, "h3f1873c2".U, "h3f1822ef".U, "h3f17d204".U, "h3f178101".U,
        "h3f172fe8".U, "h3f16deb6".U, "h3f168d6e".U, "h3f163c0e".U, "h3f15ea97".U, "h3f159909".U, "h3f154764".U, "h3f14f5a8".U, "h3f14a3d5".U, "h3f1451eb".U,
        "h3f13ffea".U, "h3f13add2".U, "h3f135ba4".U, "h3f13095f".U, "h3f12b703".U, "h3f126490".U, "h3f121207".U, "h3f11bf67".U, "h3f116cb1".U, "h3f1119e4".U,
        "h3f10c701".U, "h3f107408".U, "h3f1020f8".U, "h3f0fcdd2".U, "h3f0f7a96".U, "h3f0f2744".U, "h3f0ed3dc".U, "h3f0e805d".U, "h3f0e2cc9".U, "h3f0dd91f".U,
        "h3f0d855f".U, "h3f0d3189".U, "h3f0cdd9d".U, "h3f0c899c".U, "h3f0c3584".U, "h3f0be158".U, "h3f0b8d15".U, "h3f0b38bd".U, "h3f0ae450".U, "h3f0a8fcd".U,
        "h3f0a3b35".U, "h3f09e687".U, "h3f0991c4".U, "h3f093cec".U, "h3f08e7ff".U, "h3f0892fd".U, "h3f083de5".U, "h3f07e8b9".U, "h3f079378".U, "h3f073e21".U,
        "h3f06e8b6".U, "h3f069336".U, "h3f063da1".U, "h3f05e7f8".U, "h3f05923a".U, "h3f053c67".U, "h3f04e680".U, "h3f049084".U, "h3f043a74".U, "h3f03e44f".U,
        "h3f038e16".U, "h3f0337c9".U, "h3f02e167".U, "h3f028af1".U, "h3f023468".U, "h3f01ddca".U, "h3f018718".U, "h3f013052".U, "h3f00d978".U, "h3f00828a".U,
        "h3f002b88".U, "h3effa8e6".U, "h3efefa93".U, "h3efe4c1a".U, "h3efd9d79".U, "h3efceeb1".U, "h3efc3fc2".U, "h3efb90ac".U, "h3efae16f".U, "h3efa320c".U,
        "h3ef98282".U, "h3ef8d2d1".U, "h3ef822fa".U, "h3ef772fd".U, "h3ef6c2da".U, "h3ef61290".U, "h3ef56221".U, "h3ef4b18c".U, "h3ef400d1".U, "h3ef34ff0".U,
        "h3ef29eea".U, "h3ef1edbe".U, "h3ef13c6d".U, "h3ef08af7".U, "h3eefd95c".U, "h3eef279b".U, "h3eee75b6".U, "h3eedc3ac".U, "h3eed117d".U, "h3eec5f2a".U,
        "h3eebacb2".U, "h3eeafa16".U, "h3eea4756".U, "h3ee99471".U, "h3ee8e169".U, "h3ee82e3c".U, "h3ee77aec".U, "h3ee6c778".U, "h3ee613e1".U, "h3ee56025".U,
        "h3ee4ac47".U, "h3ee3f845".U, "h3ee34420".U, "h3ee28fd8".U, "h3ee1db6d".U, "h3ee126df".U, "h3ee0722f".U, "h3edfbd5c".U, "h3edf0866".U, "h3ede534e".U,
        "h3edd9e13".U, "h3edce8b7".U, "h3edc3338".U, "h3edb7d97".U, "h3edac7d5".U, "h3eda11f1".U, "h3ed95beb".U, "h3ed8a5c3".U, "h3ed7ef7a".U, "h3ed73910".U,
        "h3ed68285".U, "h3ed5cbd8".U, "h3ed5150b".U, "h3ed45e1c".U, "h3ed3a70d".U, "h3ed2efdd".U, "h3ed2388d".U, "h3ed1811c".U, "h3ed0c98b".U, "h3ed011da".U,
        "h3ecf5a08".U, "h3ecea217".U, "h3ecdea06".U, "h3ecd31d4".U, "h3ecc7984".U, "h3ecbc113".U, "h3ecb0884".U, "h3eca4fd5".U, "h3ec99706".U, "h3ec8de19".U,
        "h3ec8250d".U, "h3ec76be2".U, "h3ec6b298".U, "h3ec5f92f".U, "h3ec53fa8".U, "h3ec48602".U
))

val cosLUTBank3 = VecInit(Seq(
        "h3ec3cc3e".U, "h3ec3125c".U, "h3ec2585c".U, "h3ec19e3e".U, "h3ec0e401".U, "h3ec029a8".U, "h3ebf6f30".U, "h3ebeb49b".U, "h3ebdf9e8".U, "h3ebd3f19".U,
        "h3ebc842c".U, "h3ebbc922".U, "h3ebb0dfb".U, "h3eba52b7".U, "h3eb99756".U, "h3eb8dbd9".U, "h3eb8203f".U, "h3eb76489".U, "h3eb6a8b6".U, "h3eb5ecc7".U,
        "h3eb530bd".U, "h3eb47496".U, "h3eb3b853".U, "h3eb2fbf5".U, "h3eb23f7b".U, "h3eb182e6".U, "h3eb0c635".U, "h3eb00969".U, "h3eaf4c82".U, "h3eae8f7f".U,
        "h3eadd262".U, "h3ead152a".U, "h3eac57d7".U, "h3eab9a6a".U, "h3eaadce2".U, "h3eaa1f40".U, "h3ea96184".U, "h3ea8a3ad".U, "h3ea7e5bd".U, "h3ea727b2".U,
        "h3ea6698e".U, "h3ea5ab50".U, "h3ea4ecf8".U, "h3ea42e88".U, "h3ea36ffd".U, "h3ea2b15a".U, "h3ea1f29d".U, "h3ea133c8".U, "h3ea074d9".U, "h3e9fb5d2".U,
        "h3e9ef6b2".U, "h3e9e377a".U, "h3e9d7829".U, "h3e9cb8c0".U, "h3e9bf93f".U, "h3e9b39a5".U, "h3e9a79f4".U, "h3e99ba2b".U, "h3e98fa4a".U, "h3e983a52".U,
        "h3e977a42".U, "h3e96ba1a".U, "h3e95f9dc".U, "h3e953986".U, "h3e94791a".U, "h3e93b896".U, "h3e92f7fc".U, "h3e92374a".U, "h3e917683".U, "h3e90b5a5".U,
        "h3e8ff4b0".U, "h3e8f33a6".U, "h3e8e7285".U, "h3e8db14e".U, "h3e8cf002".U, "h3e8c2e9f".U, "h3e8b6d28".U, "h3e8aab9a".U, "h3e89e9f7".U, "h3e89283f".U,
        "h3e886672".U, "h3e87a490".U, "h3e86e298".U, "h3e86208c".U, "h3e855e6b".U, "h3e849c36".U, "h3e83d9ec".U, "h3e83178e".U, "h3e82551c".U, "h3e819295".U,
        "h3e80cffb".U, "h3e800d4d".U, "h3e7e9515".U, "h3e7d0f6a".U, "h3e7b8997".U, "h3e7a039e".U, "h3e787d7e".U, "h3e76f738".U, "h3e7570cb".U, "h3e73ea39".U,
        "h3e726381".U, "h3e70dca4".U, "h3e6f55a2".U, "h3e6dce7a".U, "h3e6c472e".U, "h3e6abfbe".U, "h3e693829".U, "h3e67b071".U, "h3e662894".U, "h3e64a094".U,
        "h3e631871".U, "h3e61902b".U, "h3e6007c2".U, "h3e5e7f36".U, "h3e5cf688".U, "h3e5b6db8".U, "h3e59e4c6".U, "h3e585bb3".U, "h3e56d27e".U, "h3e554928".U,
        "h3e53bfb1".U, "h3e52361a".U, "h3e50ac61".U, "h3e4f2289".U, "h3e4d9891".U, "h3e4c0e79".U, "h3e4a8442".U, "h3e48f9eb".U, "h3e476f76".U, "h3e45e4e1".U,
        "h3e445a2e".U, "h3e42cf5d".U, "h3e41446e".U, "h3e3fb961".U, "h3e3e2e36".U, "h3e3ca2ee".U, "h3e3b1789".U, "h3e398c07".U, "h3e380068".U, "h3e3674ad".U,
        "h3e34e8d6".U, "h3e335ce3".U, "h3e31d0d4".U, "h3e3044aa".U, "h3e2eb864".U, "h3e2d2c04".U, "h3e2b9f89".U, "h3e2a12f3".U, "h3e288644".U, "h3e26f97a".U,
        "h3e256c96".U, "h3e23df99".U, "h3e225283".U, "h3e20c553".U, "h3e1f380b".U, "h3e1daaaa".U, "h3e1c1d31".U, "h3e1a8fa0".U, "h3e1901f7".U, "h3e177436".U,
        "h3e15e65e".U, "h3e14586f".U, "h3e12ca69".U, "h3e113c4d".U, "h3e0fae1a".U, "h3e0e1fd0".U, "h3e0c9171".U, "h3e0b02fc".U, "h3e097472".U, "h3e07e5d2".U,
        "h3e06571e".U, "h3e04c855".U, "h3e033977".U, "h3e01aa85".U, "h3e001b7f".U, "h3dfd18cb".U, "h3df9fa70".U, "h3df6dbef".U, "h3df3bd48".U, "h3df09e7b".U,
        "h3ded7f8a".U, "h3dea6073".U, "h3de74138".U, "h3de421da".U, "h3de10259".U, "h3ddde2b4".U, "h3ddac2ee".U, "h3dd7a305".U, "h3dd482fc".U, "h3dd162d2".U,
        "h3dce4287".U, "h3dcb221d".U, "h3dc80193".U, "h3dc4e0ea".U, "h3dc1c023".U, "h3dbe9f3e".U, "h3dbb7e3c".U, "h3db85d1d".U, "h3db53be1".U, "h3db21a89".U,
        "h3daef916".U, "h3dabd788".U, "h3da8b5df".U, "h3da5941d".U, "h3da27240".U, "h3d9f504b".U, "h3d9c2e3d".U, "h3d990c17".U, "h3d95e9da".U, "h3d92c785".U,
        "h3d8fa51a".U, "h3d8c8298".U, "h3d896001".U, "h3d863d55".U, "h3d831a94".U, "h3d7fef7c".U, "h3d79a9aa".U, "h3d7363b2".U, "h3d6d1d93".U, "h3d66d751".U,
        "h3d6090ea".U, "h3d5a4a61".U, "h3d5403b6".U, "h3d4dbceb".U, "h3d477600".U, "h3d412ef6".U, "h3d3ae7ce".U, "h3d34a089".U, "h3d2e5929".U, "h3d2811ad".U,
        "h3d21ca18".U, "h3d1b826a".U, "h3d153aa4".U, "h3d0ef2c6".U, "h3d08aad3".U, "h3d0262cb".U, "h3cf8355c".U, "h3ceba4fd".U, "h3cdf1479".U, "h3cd283d3".U,
        "h3cc5f30c".U, "h3cb96227".U, "h3cacd125".U, "h3ca04008".U, "h3c93aed3".U, "h3c871d87".U, "h3c75184d".U, "h3c5bf566".U, "h3c42d25c".U, "h3c29af35".U,
        "h3c108bf3".U, "h3beed136".U, "h3bbc8a61".U, "h3b8a4370".U, "h3b2ff8d1".U, "h3a96d54f".U, "h00000000".U
))
    val cosLUT = VecInit(cosLUTBank0 ++ cosLUTBank1 ++ cosLUTBank2 ++ cosLUTBank3)
    val ENReg = RegNext(io.EN)

    // Pipeline registers
    val sinIndexReg = RegNext(io.sinIndex)
    val sinOutReg   = cosLUT(sinIndexReg)
    val cosValueReg = cosLUT(io.cosIndex)
    val cosOutReg   = RegNext(cosValueReg)

    io.cosOut := Mux(ENReg, cosOutReg, 0.U(32.W)) 
    io.sinOut := Mux(ENReg, sinOutReg, 0.U(32.W)) 
    io.ENout  := ENReg
}
