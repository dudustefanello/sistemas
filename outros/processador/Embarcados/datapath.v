//-----------------------------------
//		DATAPATH
//-----------------------------------
`timescale 10 ns/100 ps

module datapath 
#(
	parameter DATA_WIDTH 	= 16,
	parameter OPERAND_WIDTH = 11,
	parameter ADDRRAM_WIDTH = 10,
	parameter SEL_OPERATION = 3,
	parameter SEL_WIDTH     = 2
)
(
	clock_i,
	nreset_i,
	selA_i,
	selB_i,
	wrAccA_i,
	op_i,
	operand_i,
	dm_in_data,
	ext2pc_o,
	n_o,
	z_o,
	dm_addr_o,
	dm_out_data,
	ram_data_o
);

input wire                       clock_i; 	  // system clock_i
input wire                       nreset_i;	  // negative reset - active low
input wire [SEL_WIDTH - 1:0    ] selA_i;  	  // select mux3x2 input
input wire                       selB_i;  	  // select mux2x1 input
input wire                       wrAccA_i; 	  // set accumulator
input wire [SEL_OPERATION-1:0  ] op_i; 		  // select ULA operation
input wire [DATA_WIDTH - 1:0   ] dm_in_data;  // data from memory - RAM
input wire [OPERAND_WIDTH - 1:0] operand_i;   // operand from control

output reg 							   n_o;			  // negative signal to control
output reg 							   z_o;			  // zero signal to control
output wire [ADDRRAM_WIDTH - 1:0] ext2pc_o;	  // data to PC *** ATTENTION *** HAS ONLY 10 BITS (ADDRESS)
output wire [DATA_WIDTH - 1:0   ] dm_out_data; // acc output to data memory
output wire [OPERAND_WIDTH - 1:0] dm_addr_o;   // address to instruction memory
output wire [DATA_WIDTH - 1:0   ] ram_data_o; // acc output to data memory
	
wire wn_o;
wire wz_o;
wire [ DATA_WIDTH-1:0 		] wdata2mux3mux2;
wire [ DATA_WIDTH-1:0 		] wula2mux;
wire [ DATA_WIDTH-1:0 		] wmux2acc;	
wire [ OPERAND_WIDTH - 1:0 ] wOperand; 
wire [ DATA_WIDTH-1:0 		] wmux3mux2;
wire [ DATA_WIDTH-1:0 		] wacc2ram2ula;
wire [ DATA_WIDTH-1:0 		] wmux2alu;

assign wOperand = operand_i;
assign wdata2mux3mux2 = dm_in_data;

ext 
EXT0
(
	.dataa_i   ( wOperand ),
	.dataext_o ( wmux3mux2 )
);

mux3x2 
MUX3
(
	.a_i   ( wdata2mux3mux2 ),
	.b_i   ( wmux3mux2 		), 
	.c_i   ( wula2mux 		), 
	.sel_i ( selA_i 			),
	.d_o   ( wmux2acc 		)
);

acc 
ACC
(
	.clock_i ( clock_i      ),
	.nreset_i( nreset_i     ),
	.data_i  ( wmux2acc     ),
	.ena_i   ( wrAccA_i     ),
	.data_o  ( wacc2ram2ula )
);

mux2x1 
MUX2
(
	.a_i( wdata2mux3mux2  ),
	.b_i( wmux3mux2        ), 
	.c_o( wmux2alu      ),
	.sel( selB_i         )
);

alu 
ALU0
(
	.dataa_i   ( wacc2ram2ula ),
	.datab_i   ( wmux2alu     ),
	.sel_i     ( op_i         ),
	.data_o    ( wula2mux     )
);

assign dm_out_data = wacc2ram2ula;
assign ext2pc_o    = wmux3mux2[9:0];
assign dm_addr_o 	 = wOperand;
assign ram_data_o  = wdata2mux3mux2;


always @(posedge clock_i or negedge nreset_i)
begin
	if (nreset_i == 1'b0)
	begin
		n_o <= 1'b0;
		z_o <= 1'b0;
	end 
	else begin

		// NEGATIVE FLAG
		if (wacc2ram2ula == 16'b0000_0000_0000_0000)
		  z_o <= 1'b1;
		else
		  z_o <= 1'b0;
		
		// ZERO FLAG
		if (wacc2ram2ula[DATA_WIDTH-1] == 1'b1)
		  n_o <= 1'b1;
		else
		  n_o <= 1'b0;
		
	end
end

endmodule
