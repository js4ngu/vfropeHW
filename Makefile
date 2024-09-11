# Generate Verilog code
doit:
	sbt run

# Run the test
test:
	sbt test

SinCosLUT:
	sbt "testOnly vfrope.SinCosLUTTest"

FPAddMult:
	sbt "testOnly vfrope.CombinedTestSuite"

RoPEModule_Int:
	sbt "testOnly vfrope.RoPEModuleIntTester"

clean:
	git clean -fd

