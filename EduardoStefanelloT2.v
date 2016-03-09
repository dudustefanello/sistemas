module values(input clk, output light);

	reg [3:0] counter = 0;
	reg lighton = 0;

	assign light = lighton;

	always @(posedge clk) begin
		if(counter == 8) begin
			lighton <= ~lighton;
			counter <= 0;
		end
		else begin
			counter <= counter + 1;
		end
	end

endmodule

module test;

	reg clk;
	wire light;

	values adder(clk, light);

	always #1 clk = ~clk;

	initial begin
		$dumpvars(0, adder);
		clk <= 0;
		#200;
		$finish;
	end

endmodule
