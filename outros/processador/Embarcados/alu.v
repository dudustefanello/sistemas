//------------------------------------------
//		PC COUNTER
//------------------------------------------
`timescale 10 ns/100 ps

module alu
#( 
	parameter DATA_WIDTH 	= 16,
	parameter SEL_OPERATION = 3
) 
(
	dataa_i,
	datab_i,
	sel_i,
	data_o
);

localparam _sum = 3'b000,
			     _sub = 3'b001,
			     _not = 3'b010,
			     _and = 3'b011,
			     _or  = 3'b100,
			     _xor = 3'b101,
			     _sll = 3'b110,
			     _srl = 3'b111;

input wire  [ DATA_WIDTH-1:0  ]  dataa_i;   // data A - 16 bits data A to operations
input wire  [ DATA_WIDTH-1:0  ]  datab_i;   // data B - 16 bits data B to operations
input wire  [ SEL_OPERATION-1:0 ]  sel_i;	   // selector - OR/AND/SUM/SUB/SLR/SLL operations
output reg  [ DATA_WIDTH-1:0 ]   data_o;    // data OUT - output operation result

always @(dataa_i or datab_i or sel_i)
begin
		case( sel_i )
			_sum: 
					data_o = dataa_i + datab_i;
			_sub:
					data_o = dataa_i - datab_i;
			_not:
					data_o = ~dataa_i;
			_and:
					data_o = dataa_i & datab_i;
			_or:
					data_o = dataa_i | datab_i;
			_xor:
					data_o = dataa_i ^ datab_i;
			_sll:
					data_o = dataa_i << datab_i;
			_srl:
					data_o = dataa_i >> datab_i;
		endcase
end

endmodule
