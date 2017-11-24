//-------------------------------------
//		SIGNAL EXTENSION
//-------------------------------------
`timescale 10 ns/100 ps

module ext
#(
	parameter DATASIZE     = 16,
	parameter OPERANDSIZE  = 11
)
(
	dataa_i,
	dataext_o
);

input wire [ OPERANDSIZE - 1:0 ] dataa_i;
output reg [ DATASIZE - 1:0 ]    dataext_o;

localparam DIF = DATASIZE - OPERANDSIZE; // FILL ONLY THE DIFERENCE

always @( dataa_i )
begin
	dataext_o = { {DIF{1'b0}}, dataa_i };
end

endmodule
