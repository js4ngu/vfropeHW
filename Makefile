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
FixedpointDecoder:
	python /home/jongsang/vfropeHW/src/test/scala/vfrope/fixedpointDecoder.py

RoPEcoreTest:
	sbt "testOnly vfrope.RoPEcoreTest"

#RoPE모듈관련
RoPEModule_Int:
	sbt "testOnly vfrope.RoPEModuleIntTester"

clean:
	git clean -fd

