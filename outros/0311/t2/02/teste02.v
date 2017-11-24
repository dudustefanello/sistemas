module teste02(input CLOCK_50,
					output [7:0] LEDG,
					output [9:0] LEDR);

	reg [64:0] counter = 0;
	reg lg0 = 0;
	reg lg1 = 1;
	reg lg2 = 2;
	reg lg3 = 3;
	reg lg4 = 4;
	reg lg5 = 5;
	reg lg6 = 6;
	reg lg7 = 7;
	
	assign LEDG[7] = lg7;
	assign LEDG[6] = lg6;
	assign LEDG[5] = lg5;
	assign LEDG[4] = lg4;
	assign LEDG[3] = lg3;
	assign LEDG[2] = lg2;
	assign LEDG[1] = lg1;
	assign LEDG[0] = lg0;

	always @(posedge CLOCK_50) begin
		if(counter == 00000000) begin
			lg7 <= ~lg7;
			counter <= counter + 1;
		end
		if(counter == 20000000) begin
			lg6 <= ~lg6;
			counter <= counter + 1;
		end
		if(counter == 40000000) begin
			lg5 <= ~lg5;
			counter <= counter + 1;
		end
		if(counter == 60000000) begin
			lg4 <= ~lg4;
			counter <= counter + 1;
		end
		if(counter == 80000000) begin
			lg3 <= ~lg3;
			counter <= counter + 1;
		end
		if(counter == 100000000) begin
			lg2 <= ~lg2;
			counter <= counter + 1;
		end
		else if(counter == 120000000) begin
			lg1 <= ~lg1;
			counter <= counter + 1;
		end
		else if(counter == 1400000000) begin
			lg0 <= ~lg0;
			counter <= 0;
		end
		else begin
			counter <= counter + 1;
		end
	end

endmodule