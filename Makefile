# Generate Verilog code
doit:
	sbt run

# Run the test
test:
	sbt test

# 삼각함수 관련
SinCosLUT:
	sbt "testOnly vfrope.SinCosLUTTest"

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
FP32core:
	sbt "testOnly vfrope.FP32RoPEcoreTest"
pyRoPE:
	python /home/jongsang/vfropeHW/src/test/scala/vfrope/RoPEcore.py

clean:
	git clean -fd

