//------------------------------------------
//		PC COUNTER
//------------------------------------------
`timescale 10 ns/100 ps

module alupc 
#(
	parameter ADDRRAM_WIDTH = 10
)
(
	dataa_i,
	data_o
);

input wire [(ADDRRAM_WIDTH-1):0] dataa_i;
output wire [(ADDRRAM_WIDTH-1):0] data_o;

assign data_o = dataa_i + 1'b1;

endmodule
