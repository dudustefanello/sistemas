//-----------------------------------
//		MULTIPLEX
//-----------------------------------
`timescale 10 ns/100 ps

module mux2x1
#(
	parameter DATA_WIDTH 	= 16
)
(
	a_i,
	b_i, 
	c_o,
	sel
);

input wire [ DATA_WIDTH - 1:0 ] a_i;
input wire [ DATA_WIDTH - 1:0 ] b_i;
input wire                       sel;
output reg [ DATA_WIDTH - 1:0 ] c_o;

always @( a_i or b_i or sel )
begin
	if ( sel == 1'b0 )
		c_o <= a_i;
	else
		c_o <= b_i;
end

endmodule
