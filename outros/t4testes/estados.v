module op1(
		input [11:0] ya,
		input [11:0] yb,
		input [11:0] x,
		output [24:0] r
	);

	assign r = (ya - yb) * x;

endmodule	

module op2(
		input [11:0] ya,
		input [11:0] yb,
		input [11:0] x,
		input [24:0] t1,
		output [25:0] r
	);
	wire signed [24:0] fio;

	op1 calculo1(ya, yb, x, fio);

	assign r = fio + t1;

endmodule

module op3(
		input [11:0] ya,
		input [11:0] yb,
		input [11:0] x,
		input [25:0] t1,
		output [24:0] r
	);
	wire signed [24:0] fio;

	op1 calculo1(ya, yb, x, fio);

	assign r = fio + t1;

endmodule

module area(
		input [11:0] p1x,
		input [11:0] p1y,
		input [11:0] p2x,
		input [11:0] p2y,
		input [11:0] p3x,
		input [11:0] p3y,
		output [73:0] t4
	);
	
	reg [24:0] rt4;
	reg [24:0] t1;
	reg [25:0] t2;
	reg [24:0] t3;

	wire signed [24:0] f1;
	wire signed [25:0] f2;
	wire signed [24:0] f3;

	assign t4 = rt4;
	assign f1 = t1;
	assign f2 = t2;
	assign f3 = t3;

	op1 calculo1(p2y, p3y, p1x, f1);
	op2 calculo2(p3y, p1y, p2x, f1, f2);
	op3 calculo3(p3y, p1y, p2x, f2, f3);

	always @(posedge t3) begin
		if (t3 < 0) begin
			rt4 = t3 * (-1);
		end
		else begin
			rt4 = t3;
		end
	end

endmodule

module main(
		input [11:0] p1x,
		input [11:0] p1y,
		input [11:0] p2x,
		input [11:0] p2y,
		input [11:0] p3x,
		input [11:0] p3y,
		input [11:0] ptx,
		input [11:0] pty,
		output saida
	);

	wire signed [73:0] s1;
	wire signed [73:0] s2;
	wire signed [73:0] s3;
	wire signed [73:0] s4;

	reg rsaida;
	reg [73:0] r1;
	reg [73:0] r2;
	reg [73:0] r3;
	reg [73:0] r4;

	assign saida = rsaida;
	assign s1 = r1;
	assign s2 = r2;
	assign s3 = r3;
	assign s4 = r4;

	assign p1x = 2;
	assign p1y = 23;
	assign p2x = 1;
	assign p2y = 25;
	assign p3x = 6;
	assign p3y = 25;
	assign ptx = 5;
	assign pty = 23;

	area area1(p1x, p1y, p2x, p2y, p3x, p3y, s1);
	area area2(p1x, p1y, p2x, p2y, ptx, pty, s2);
	area area3(p2x, p2y, p3x, p3y, ptx, pty, s3);
	area area4(p3x, p3y, p1x, p1y, ptx, pty, s4);

	always @(posedge s4) begin
		if (s1 == s2 + s3 + s4) begin
			rsaida = 1;
		end
		else begin
			rsaida = 0;
		end
	end

	initial begin
    	$dumpvars(0, main);
	    #500;
	    $finish;
  	end

endmodule

