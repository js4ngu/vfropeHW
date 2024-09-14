# Generate Verilog code
doit:
	sbt run

# Run the test
test:
	sbt test

# 삼각함수 관련
LutGen:
	python /home/jongsang/vfropeHW/src/main/scala/vfrope/LutGen.py

SinCosLUT:
	sbt "testOnly vfrope.SinCosLUTTest"

#실수연산 관련
32Ieee754:
	python /home/jongsang/vfropeHW/src/test/scala/vfrope/32bit-ieee754.py

RoPE_core_FP32Test:
	sbt "testOnly vfrope.RoPE_core_FP32Test"

#RoPE모듈관련
RoPEModule_Int:
	sbt "testOnly vfrope.RoPEModuleIntTester"

clean:
	git clean -fd

