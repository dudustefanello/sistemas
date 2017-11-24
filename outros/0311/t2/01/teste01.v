module teste01(input CLOCK_50,
					output [7:0] LEDG,
					output [9:0] LEDR);

	reg [32:0] counter = 0;
	reg lighton = 0;

	assign LEDG[7] = lighton;
	assign LEDG[6] = lighton;
	assign LEDG[5] = lighton;
	assign LEDG[4] = lighton;
	assign LEDG[3] = lighton;
	assign LEDG[2] = lighton;
	assign LEDG[1] = lighton;
	assign LEDG[0] = lighton;
	assign LEDR[9] = ~lighton;
	assign LEDR[8] = ~lighton;
	assign LEDR[7] = ~lighton;
	assign LEDR[6] = ~lighton;
	assign LEDR[5] = ~lighton;
	assign LEDR[4] = ~lighton;
	assign LEDR[3] = ~lighton;
	assign LEDR[2] = ~lighton;
	assign LEDR[1] = ~lighton;
	assign LEDR[0] = ~lighton;

	always @(posedge CLOCK_50) begin
		if(counter == 50000000) begin
			lighton <= ~lighton;
			counter <= 0;
		end
		else begin
			counter <= counter+1;
		end
	end

endmodule
