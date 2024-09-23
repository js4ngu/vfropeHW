# Generate Verilog code
doit:
	sbt run

# Run the test
test:
	sbt test

# 삼각함수 관련
LutGen:
	python /home/jongsang/vfropeHW/src/main/scala/vfrope/LutGen.py

SinCosINTLUT:
	sbt "testOnly vfrope.SinCosLUTINTTest"

SinCosLUT:
	sbt "testOnly vfrope.SinCosLUTTest"

#실수연산 관련
pyFP:
	python /home/jongsang/vfropeHW/src/test/scala/vfrope/FP.py
FPadd:
	sbt "testOnly vfrope.FP32AdderTest"

#RoPE모듈관련
RoPEModule_Int:
	sbt "testOnly vfrope.RoPEModuleIntTester"
RoPEfrontCoreTest:
	sbt "testOnly vfrope.RoPEfrontCoreTest"
RoPEbackCoreTest:
	sbt "testOnly vfrope.RoPEBackCoreTest"
RoPECoreInnerTest:
	sbt "testOnly vfrope.RoPEcoreInnerLUTtest"

clean:
	git clean -fd

