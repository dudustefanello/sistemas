//----------------------------------------
// 	ACCUMULATOR
//----------------------------------------
`timescale 10 ns/100 ps

module acc
#( 
  parameter DATASIZE = 16 
)
(
	clock_i,
	nreset_i,
	data_i,
	ena_i,
	data_o
);

input wire                  clock_i;
input wire                  nreset_i;
input wire                  ena_i;
input wire [ DATASIZE-1:0 ] data_i;
output reg [ DATASIZE-1:0 ] data_o;

always @(posedge clock_i or negedge nreset_i)
begin
	if (nreset_i == 1'b0)
		data_o <= 'b0;
	else
		if (ena_i == 1'b1)
			data_o <= data_i;
end

endmodule
