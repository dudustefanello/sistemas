module mult(input clk, e,
			input [5:0] a, b,
			output wire [11:0] c);
	
	wire [11:0] total;
	reg [2:0] count;
	assign c = total;

	assign total[count] = {a[count], 
						   a[count],
						   a[count], 
						   a[count], 
						   a[count], 
						   a[count]} & b;

	always #1 clk = !clk;

	always @(posedge clk) begin
		cout = count == 5 ? 0 : count + 1;
	end

	initial begin
		clk = 0;
		#10;
		$display("oi %d", c);
	end
endmodule