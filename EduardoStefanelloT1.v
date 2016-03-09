module values(
	input i_clk,
	output o_clk
	);

	assign o_clk = i_clk;

endmodule

module test;
	reg i_clk;
	wire o_clk;

	values V(
		i_clk,
		o_clk
	);

	always #1 i_clk = ~i_clk

initial begin
	$dumpvars(0, V);
	i_clk <= 0;
	#500;
	$finish;
	
	end

endmodule