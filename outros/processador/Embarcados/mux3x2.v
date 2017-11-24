//-----------------------------------
//		MULTIPLEX
//-----------------------------------
`timescale 10 ns/100 ps

module mux3x2
#(
	parameter DATA_WIDTH 	= 16,
	parameter SEL_WIDTH     = 2
)
(
	a_i,
	b_i, 
	c_i, 
	sel_i,
	d_o
);

input wire [ DATA_WIDTH - 1:0 ] a_i;
input wire [ DATA_WIDTH - 1:0 ] b_i;
input wire [ DATA_WIDTH - 1:0 ] c_i;
input wire [ SEL_WIDTH - 1:0  ] sel_i;
output reg [ DATA_WIDTH - 1:0 ] d_o;

always @(	a_i or b_i or c_i or sel_i )
begin
	if ( sel_i == 2'b00 )
		d_o <= a_i;
	else
	if ( sel_i == 2'b01 )
		d_o <= b_i;
	else
	if ( sel_i == 2'b10 )
		d_o <= c_i;
	else
		d_o <= c_i;
end

endmodule
