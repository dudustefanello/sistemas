all:
	g++ pointGenerator.cpp
	./a.out > input.in

	g++ pointTester.cpp
	./a.out < input.in > cppOutput.out

	iverilog trianguleMain.v
	./a.out

	diff cppOutput.out verilogOutput.out
