package vfrope

import chisel3._
import chisel3.experimental.FixedPoint
import chisel3.util.{log2Ceil, switch, is}

class DualPortMemory(width: Int, depth: Int) extends Module {
  val io = IO(new Bundle {
    val writeAddr = Input(UInt(log2Ceil(depth).W))
    val writeData = Input(UInt(width.W))
    val writeEnable = Input(Bool())
    
    val readAddr1 = Input(UInt(log2Ceil(depth).W))
    val readData1 = Output(UInt(width.W))
    
    val readAddr2 = Input(UInt(log2Ceil(depth).W))
    val readData2 = Output(UInt(width.W))
  })

  val mem = SyncReadMem(depth, UInt(width.W))

  when(io.writeEnable) {
    mem.write(io.writeAddr, io.writeData)
  }

  io.readData1 := mem.read(io.readAddr1)
  io.readData2 := mem.read(io.readAddr2)
}

class dualPortCOSlut() extends Module {
    val io = IO(new Bundle {
        val EN        = Input(Bool())
        val x         = Input(Vec(2, UInt(32.W)))
        val cosIndex  = Input(UInt(32.W))
        val sinIndex  = Input(UInt(32.W))
        val sign      = Input(Vec(2, Bool()))

        val sinOut    = Output(UInt(32.W))
        val cosOut    = Output(UInt(32.W))
        val ENout     = Output(Bool())
        val xFWD      = Output(Vec(2, UInt(32.W)))
        val signFWD   = Output(Vec(2, Bool()))
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
    val cosLUTValues = cosLUTBank0 ++ cosLUTBank1 ++ cosLUTBank2 ++ cosLUTBank3
    val cosLUT = SyncReadMem(cosLUTValues.length, UInt(32.W))

    // 메모리 초기화
    when (reset.asBool) {
        cosLUTValues.zipWithIndex.foreach { case (value, index) =>
            cosLUT.write(index.U, value)
        }
    }
    val cosTemp   = RegInit(VecInit(Seq.fill(2)(0.U(32.W))))
    val sinTemp   = RegInit((0.U(32.W)))

    val ENReg = RegInit(VecInit(Seq.fill(2)(false.B)))
    ENReg(0) := io.EN
    ENReg(1) := ENReg(0)

    // 듀얼 포트 읽기
    cosTemp(0)  := cosLUT.read(io.cosIndex)
    cosTemp(1)  := cosTemp(0)

    sinTemp     := cosLUT.read(io.sinIndex)

    io.ENout      := ENReg(1)
    io.cosOut     := Mux(ENReg(1), cosTemp(1), 0.U(32.W))
    io.sinOut     := Mux(ENReg(1), sinTemp,    0.U(32.W))
    io.xFWD(0)    := Mux(ENReg(1), io.x(0),    0.U(32.W))
    io.xFWD(1)    := Mux(ENReg(1), io.x(1),    0.U(32.W))
    io.signFWD(0) := Mux(ENReg(1), io.sign(0), 0.U(32.W)) // cos
    io.signFWD(1) := Mux(ENReg(1), io.sign(1), 0.U(32.W)) // sin
}