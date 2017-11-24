module test_ponto(
	input clk,
	input [10:0] p1x,
	input [10:0] p1y,
	input [10:0] p2x,
	input [10:0] p2y,
	input [10:0] p3x,
	input [10:0] p3y,
	output reg [23:0] s
	);

	reg [4:0] state = 0;
	reg [10:0] a, b, c;
	reg [20:0] t1, t2, t3;
	wire signed [20:0] ts;
	wire signed [21:0] t4;

	assign ts = (a - b) * c;
	assign t4 = t1 + t2;

	always @(posedge clk) begin
		case (state)
			0: 	begin
					state <= 1;
					a <= p2y;
					b <= p3y;
					c <= p1x;
				end
			1: 	begin
					state <= 2;
					t1 <= ts;
					a <= p2y;
					b <= p1y;
					c <= p2x;
				end
			2:	begin
					state <= 3;
					t2 <= ts;
					a <= p1y;
					b <= p2y;
					c <= p3x;
				end
			3:	begin
					state <= 4;
					s <= t4 + t3;
				end
			default: state <= 0;
		endcase
	end
endmodule