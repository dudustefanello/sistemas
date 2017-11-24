module clock (input i_clock,
			  output o_clock);
		assign o_clock = i_clock;
endmodule

module OP1 (input [11:0] ya, yb, x,
			output[24:0] saidaOP1);
		assign saidaOP1 = (ya - yb) * x;
endmodule

module OP2 (input [24:0] op1a, op1b,
			output[25:0] saidaOP2);
		assign saidaOP2 = op1a + op1b;
endmodule

module OP3 (input [24:0] op1c,
			input [25:0] op2a,
			output[26:0] saidaOP3);
		assign saidaOP3 = op1c + op2a;
endmodule

module area (input [11:0] p1x, p1y, p2x, p2y, p3x, p3y,
	 		 output[26:0] valorArea);
		
		reg [2:0] counter;
		reg i_clock;
		wire o_clock;
		assign counter = 0;
		assign o_clock = i_clock;
		assign i_clock = 0;

		reg [24:0] op1a, op1b, op1c;
		reg [25:0] op2a;
		reg [26:0] op3a;
		
		clock Area(i_clock, o_clock);
		
		always #1 i_clock = ~o_clock;

		OP1 a(p2y, p3y, p1x, op1a);				
		OP1 b(p3y, p1y, p2x, op1b);
		OP1 c(p1y, p2y, p3x, op1c);
		OP2 a(op1a, op1b, op2a);
		OP3 a(op2a, op1c, op3a);
		
		always @(posedge i_clock) begin
			if (op3a < 0) begin
				valorArea <= (op3a * (-1));
			end
			else begin
				valorArea <= op3a;
			end
			if (counter < 8) begin
				counter <= counter + 1;
			end
		end
endmodule

module main (input [11:0] p1x, p1y, p2x, p2y, p3x, p3y, ptx, pty,
			 output sinal);

		assign p1x = 2, p1y = 23;
		assign p2x = 1, p2y = 25;
		assign p3x = 6, p3y = 25;
		assign ptx = 5, pty = 23;
		
		reg [4:0] counter;
		reg i_clock;
		wire o_clock;
		assign o_clock = i_clock;
		assign i_clock = 0;

		reg [26:0] A1, A2, A3, A4;

		clock Main(i_clock, o_clock);
		
		always #1 i_clock = ~o_clock;

		always @(posedge i_clock) begin
			if (counter == 0) begin
				area a1(p1x, p1y, p2x, p2y, p3x, p3y, A1);
			end
			else if (counter == 5) begin
				area a2(p1x, p1y, p2x, p2y, ptx, pty, A2);				
			end
			else if (counter == 10) begin
				area a3(p2x, p2y, p3x, p3y, ptx, pty, A3);				
			end
			else if (counter == 15) begin
				area a4(p3x, p3y, p1x, p1y, ptx, pty, A4);				
			end
			else if (counter == 20) begin
				sinal <= (A1 == A2 + A3 + A4);				
			end
		end
endmodule