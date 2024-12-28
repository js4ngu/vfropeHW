# Generate Verilog code
doit:
	sbt run

# Run the test
test:
	sbt test

# 삼각함수 관련
SinCosLUT:
	sbt "testOnly vfrope.SinCosLUTTest"
SinCosLUTsmall:
	sbt "testOnly vfrope.SinCosLUT2Test -- -DwriteVcd=1"
SinCosLUTseq:
	sbt "testOnly vfrope.FP32rSinCosSeqInputTest -- -DwriteVcd=1"
dualPortSinCosLUT:
	sbt "testOnly vfrope.dualPortSinCosLUTest -- -DwriteVcd=1"
multiPortSinCosLUT:
	sbt "testOnly vfrope.multiPortSinCosModuleTest -- -DwriteVcd=1"
multiPortSinCosLUTV2:
	sbt "testOnly vfrope.multiPortSinCosModuleTestV2 -- -DwriteVcd=1"


#실수연산 관련
pyFP:
	python /home/jongsang/vfropeHW/src/test/scala/vfrope/FP.py
FPadd:
	sbt "testOnly vfrope.FP32AdderTest"
FPsub:
	sbt "testOnly vfrope.FP32SubTest"
FPMult:
	sbt "testOnly vfrope.FP32MultiplierTest"
Int322FP:
	sbt "testOnly vfrope.Int32ToFP32Test"
Int642FP:
	sbt "testOnly vfrope.Int64ToFP32Test"
FP322Int:
	sbt "testOnly vfrope.FP32toINT32Test"
FPdiv:
	sbt "testOnly vfrope.FP32DivPOW2Test"
FP32Truncate:
	sbt "testOnly vfrope.FP32TruncateTest"
FPdivINT:
	sbt "testOnly vfrope.FP32DivPOW2INTTest"
FMAtest:
	sbt "testOnly vfrope.FMATest"
repeaterTest:
	sbt "testOnly vfrope.SerialDataRepeaterTest -- -DwriteVcd=1"

#RoPE모듈관련
RoPEModule_Int:
	sbt "testOnly vfrope.RoPEModuleIntTester"
RoPEfrontCoreTest:
	sbt "testOnly vfrope.RoPEfrontCoreTest"
RoPEbackCoreTest:
	sbt "testOnly vfrope.RoPEBackCoreTest"
RoPECoreInnerTest:
	sbt "testOnly vfrope.RoPEcoreInnerLUTtest"

#FP32 RoPE 관련
FP32angle:
	sbt "testOnly vfrope.FP32radianCaclulatorTest"
FP32angleVCD:
	sbt "testOnly vfrope.FP32radianCaclulatorTest -- -DwriteVcd=1"
FP32angleSeq:
	sbt "testOnly vfrope.FP32radCaclSeqInputTest -- -DwriteVcd=1"
FP32radianV2:
	sbt "testOnly vfrope.FP32radCaclSeqInputTestV2 -- -DwriteVcd=1"

FP32core:
	sbt "testOnly vfrope.FP32RoPEcoreTest"
FP32coreSeq:
	sbt "testOnly vfrope.FP32RoPEcoreSeqInputTest -- -DwriteVcd=1"
FP32RoPE:
	sbt "testOnly vfrope.FP32RoPEmoduleTest"
FP32RoPEVCD:
	sbt "testOnly vfrope.FP32RoPEmoduleTest -- -DwriteVcd=1"
dualPortSinCosModule:
	sbt "testOnly vfrope.dualPortSinCosModuleTest -- -DwriteVcd=1"
FP32smallRoPE:
	sbt "testOnly vfrope.FP32smallRoPEmoduleTest -- -DwriteVcd=1"
FP32smallRoPE2:
	sbt "testOnly vfrope.FP32smallRoPEmoduleTest2 -- -DwriteVcd=1"
multiLaneRoPE:
	sbt "testOnly vfrope.multiLaneRoPEmoduleTestV2 -- -DwriteVcd=1"




#FMA
RoPEFMA:
	sbt "testOnly vfrope.RoPEFMATest -- -DwriteVcd=1"


# 베릴로그 변환
veliog2lane:
	sbt "runMain vfrope.FP32RoPE2LaneWoROPEcoreTop"
veliog4lane:
	sbt "runMain vfrope.FP32RoPE4LaneWoROPEcoreTop"
veliog8lane:
	sbt "runMain vfrope.FP32RoPE8LaneWoROPEcoreTop"
veliog16lane:
	sbt "runMain vfrope.FP32RoPE16LaneWoROPEcoreTop"

# 파이썬
pyRoPEcore:
	python /home/jongsang/vfropeHW/src/test/scala/vfrope/RoPEcore.py

clean:
	git clean -fd

