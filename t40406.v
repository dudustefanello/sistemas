module test_ponto(
	input clk,
	input [10:0] p1x,
	input [10:0] p1y,
	input [10:0] p2x,
	input [10:0] p2y,
	input [10:0] p3x,
	input [10:0] p3y,
	output reg [23:0] s,
	output reg valid
	);

	reg [1:0] state = 0;
	reg [10:0] a, b, c;
	reg [20:0] t1, t2, t3;
	wire signed [20:0] ts;
	wire signed [21:0] t4;

	assign ts = (a - b) * c;
	assign t4 = t1 + t2;

	always @(posedge clk) begin
		case (state)
			0: 	begin
 					$display("a0");
					state <= 1;
					a <= p2y;
					b <= p3y;
					c <= p1x;
				end
			1: 	begin
 					$display("a1");
					state <= 2;
					t1 <= ts;
					a <= p2y;
					b <= p1y;
					c <= p2x;
				end
			2:	begin
 					$display("a2");
					state <= 3;
					t2 <= ts;
					a <= p1y;
					b <= p2y;
					c <= p3x;
				end
			3:	begin
 					$display("a3");
					state <= 4;
					s <= t4 + t3;
				end
			4:	begin
 					$display("a4");
					s = (s < 0) ? ~s + 1 : s;
					valid <= 1;
					state <= 5;
				end 
			5: 	begin
					state <= 0;
				end
		endcase
	end
endmodule

module main(
	input [10:0] p1x,
	input [10:0] p1y,
	input [10:0] p2x,
	input [10:0] p2y,
	input [10:0] p3x,
	input [10:0] p3y,
	input [10:0] ptx,
	input [10:0] pty,
	output reg s 
	);

	assign p1x = 1;
	assign p1y = 6;
	assign p2x = 4;
	assign p2y = 14;
	assign p3x = 17;
	assign p3y = 5;
	assign ptx = 7;
	assign pty = 8;

	reg signed [10:0] UMx, UMy, DOISx, DOISy, TRESx, TRESy;
	reg clk;
	reg signed [3:0] state = 0;
	reg signed [23:0] A1, A2, A3, A4;
	wire signed [23:0] AS;
	reg signed [24:0] a, b, c;
	wire signed [24:0] soma1;
	wire signed [25:0] soma2;

	test_ponto A(clk, UMx, UMy, DOISx, DOISy, TRESx, TRESy, AS, valid);

	assign soma1 = a + b;

	always #1 clk = ~clk;

	always @(posedge clk) begin
		case (state)
			0:	begin
 					$display("b0");
					state <= (valid) ? 1 : state;
					UMx <= p1x;
					UMy <= p1y;
					DOISx <= p2x;
					DOISy <= p2y;
					TRESx <= p3x;
					TRESy <= p3y;
				end
			1:	begin
 					$display("b1");
					state <= (valid) ? 2 : state;
					A1 <= AS;
					UMx <= p1x;
					UMy <= p1y;
					DOISx <= p2x;
					DOISy <= p2y;
					TRESx <= ptx;
					TRESy <= pty;
				end
			2:	begin
 					$display("b2");
					state <= (valid) ? 3 : state;
					A2 <= AS;
					UMx <= p2x;
					UMy <= p2y;
					DOISx <= p3x;
					DOISy <= p3y;
					TRESx <= ptx;
					TRESy <= pty;
				end
			3:	begin
 					$display("b3");
					state <= (valid) ? 4 : state;
					A3 <= AS;
					UMx <= p3x;
					UMy <= p3y;
					DOISx <= p1x;
					DOISy <= p1y;
					TRESx <= ptx;
					TRESy <= pty;
				end
			4:	begin
 					$display("b4");
					state <= 5;
					A4 <= AS;
				end
			5:	begin
 					$display("b5");
					state <= 6;
					a <= A2;
					b <= A3;
 				end
 			6:	begin
 					$display("b6");
 					state <= 7;
 					a <= soma1;
 					b <= A4;
 				end
 			7:	begin
 					$display("b7");
 					state <= 8;
 					s <= (soma1 == A1) ? 1 : 0;
 				end
 			8:	begin
 					$display("b8%d", s);
 				end
		endcase
	end

	initial begin
	    clk <= 0;
	    $display("%d", s);
	    #500;
	    $finish;
  	end
endmodule