//--------------------------------------
//		PROGRAM COUNTER
//--------------------------------------
`timescale 10 ns/100 ps

module pc
#(
	parameter ADDRRAM_WIDTH = 10
)
(
	clock_i,
	nreset_i,
	data_i,
	ena_i,
	data_o
);

input wire                     clock_i;
input wire                     nreset_i;
input wire                     ena_i;
input wire [ADDRRAM_WIDTH-1:0] data_i;
output reg [ADDRRAM_WIDTH-1:0] data_o; 

always @(posedge clock_i or negedge nreset_i)
begin
	if ( nreset_i == 1'b0 )
		data_o <= { ADDRRAM_WIDTH{1'b0} };
	else
		if ( ena_i == 1'b1 )
			data_o <= data_i;
end

endmodule
