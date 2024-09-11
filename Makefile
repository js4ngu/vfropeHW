# Generate Verilog code
doit:
	sbt run

# Run the test
test:
	sbt test

LutGen:
	python /home/jongsang/vfropeHW/src/main/scala/vfrope/LutGen.py

32Ieee754:
	python /home/jongsang/vfropeHW/src/test/scala/vfrope/32bit-ieee754.py

SinCosLUT:
	sbt "testOnly vfrope.SinCosLUTTest"

FixedPoint:
	sbt "testOnly vfrope.CombinedTestSuite"

RoPEModule_Int:
	sbt "testOnly vfrope.RoPEModuleIntTester"

clean:
	git clean -fd

