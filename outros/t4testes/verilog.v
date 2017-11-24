module sign(					//Declara as entradas e saídas da função sign
		input [10:0] p1x,
		input [10:0] p1y,
		input [10:0] p2x,
		input [10:0] p2y,
		input [10:0] p3x,
		input [10:0] p3y,
		output [24:0] s
	);
	
	wire signed [11:0] t1;		//declarados fios com sinal
	wire signed [11:0] t2;
	wire signed [11:0] t3;

	wire signed [22:0] m1;		
	wire signed [22:0] m2;
	wire signed [22:0] m3;
	
	wire signed [23:0] t4;

	assign t1 = p2x - p3x;		//amarrados fios nas saídas de somadores e multiplicadores
	assign t2 = p3y - p1y;
	assign t3 = p1y - p2y;

	assign m1 = t1 * p1x;		
	assign m2 = t2 * p2x;
	assign m3 = t3 * p3x;

	assign t4 = m1 * m2;
	
	assign s = t4 * m3;

endmodule

module triangle(				//declara as entradas e saídas da função triangle
		input [10:0] ptx,
		input [10:0] pty,
		input [10:0] p1x,
		input [10:0] p1y,
		input [10:0] p2x,
		input [10:0] p2y,
		input [10:0] p3x,
		input [10:0] p3y,
		output inside
	);

	wire signed [24:0] s1;		//declara fios da função
	wire signed [24:0] s2;
	wire signed [24:0] s3;
	wire signed [24:0] s4;
	wire signed [26:0] soma1;
	wire signed [26:0] soma2;

	sign S1(ptx, pty, p1x, p1y, p2x, p2y, s1);	//chama a função sign para casa um dos triangulos
	sign S2(ptx, pty, p2x, p2y, p3x, p3y, s2);
	sign S3(ptx, pty, p3x, p3y, p1x, p1y, s3);
	sign S4(p1x, p1y, p2x, p2y, p3x, p3y, s4);

	assign soma1 = s1 + s2;
	assign soma2 = soma1 + s3;
	assign inside = soma2 == s4;

endmodule

module test(
	);

	wire sinal;
	reg [10:0] ptx;
	reg [10:0] pty;
	reg [10:0] p1x;
	reg [10:0] p1y;
	reg [10:0] p2x;
	reg [10:0] p2y;
	reg [10:0] p3x;
	reg [10:0] p3y;

	triangle A(
		ptx,
		pty,
		p1x,
		p1y,
		p2x,
		p2y,
		p3x,
		p3y,
		sinal
	);

	initial begin
		$dumpvars(0, sinal);
		
		#1;
		ptx <=  5;
		pty <= 23;
		p1x <=  2;
		p1y <= 23;
		p2x <=  1;
		p2y <= 25;
		p3x <=  6;
		p3y <= 25;

		#2;
		ptx <= 11;
		pty <= 23;
		p1x <= 10;
		p1y <= 22;
		p2x <= 10;
		p2y <= 25;
		p3x <= 13;
		p3y <= 22;

		#3;
		ptx <=  7;
		pty <= 18;
		p1x <=  5;
		p1y <= 16;
		p2x <=  4;
		p2y <= 21;
		p3x <=  9;
		p3y <= 19;

		#4;
		ptx <= 16;
		pty <= 16;
		p1x <= 10;
		p1y <= 12;
		p2x <= 13;
		p2y <= 19;
		p3x <= 18;
		p3y <= 13;

		#5;
		ptx <= 17;
		pty <=  6;
		p1x <=  1;
		p1y <=  6;
		p2x <=  4;
		p2y <= 14;
		p3x <= 17;
		p3y <=  5;

		#6
		$finish;

	end

endmodule