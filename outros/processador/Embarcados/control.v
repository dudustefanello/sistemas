//--------------------------
//		CONTROL MODULE
//--------------------------
`timescale 10 ns/100 ps

module control
#(
	parameter DATA_WIDTH 	= 16,
	parameter OPERAND_WIDTH = 11,
	parameter ADDRRAM_WIDTH = 10,
	parameter OPCODE_WIDTH  = 5,
	parameter SEL_OPERATION = 3,
	parameter SEL_WIDTH     = 2
)
(
	clock_i,
	nreset_i,
	im_data_i,
	ext2pc_i,
	hold_i,
	n_i,
	z_i,
	ram_data_i,
	im_addr_o,
	operand_o,
	op_o,
	wrAccA_o,
	selA_o,
	selB_o,
	im_OEn_o,
	im_CEn_o,
	dm_OEn_o,
	dm_CEn_o,
	dm_WEn_o
);

input wire                        clock_i;   // system clock 
input wire                        nreset_i;  // negative reset - active low
input wire  [DATA_WIDTH-1:0  ]    im_data_i; // instruction memory data from ROM
input wire                        n_i;		  // negative signal
input wire   						    z_i;		  // zero signal
input wire  [(DATA_WIDTH-1):   0] ram_data_i;// data from extension signal
input wire  [(ADDRRAM_WIDTH-1):0] ext2pc_i;  // data from extension signal
input wire                        hold_i;	  // hold processor operations

output wire [(ADDRRAM_WIDTH-1):0] im_addr_o; // address to instruction memory
output wire [(OPERAND_WIDTH-1):0] operand_o; // operand (11 bits) to datapath

output wire [(SEL_OPERATION-1):0] op_o;		 // select ULA operation
output wire                       wrAccA_o;	 // set accumulator
output wire [(SEL_WIDTH - 1):0  ] selA_o;	 // select mux3x2 output
output wire                       selB_o;	 // select mux2x1 output

output wire                       im_OEn_o;	 // instruction memory output enable
output wire                       im_CEn_o; // instruction memory chip enable
output wire                       dm_OEn_o;	 // data memory output enable
output wire                       dm_CEn_o;	 // data memory chip enable
output wire                       dm_WEn_o;	 // data memory write enable
	
wire [(OPERAND_WIDTH-1):0] wdata;
wire [(ADDRRAM_WIDTH-1):0] walu2mux;
wire [(ADDRRAM_WIDTH-1):0] wmux2x1pc;
wire                       wcarry;

wire 							   wbranch;	 
wire [(ADDRRAM_WIDTH-1):0] wdatapc;
wire [(OPCODE_WIDTH-1): 0] wopcode;
wire                       wWrPC;

assign wopcode = im_data_i[ DATA_WIDTH-1:DATA_WIDTH-OPCODE_WIDTH ]; // 16 to 11
assign im_addr_o = wdatapc;
assign operand_o = im_data_i[OPERAND_WIDTH-1:0];



alupc 
ALU0
(
	.dataa_i ( wdatapc    ),
	.data_o  ( walu2mux )
);

mux2x1
#(10)
MUX0
(
	.a_i( walu2mux ),
	.b_i( ext2pc_i   ), 
	.c_o(	wmux2x1pc  ),
	.sel( wbranch    )
);

pc 
PC0
(
	.clock_i ( clock_i 	),
	.nreset_i( nreset_i 	),
	.data_i  ( wmux2x1pc ),
	.ena_i   ( wWrPC   	),
	.data_o  ( wdatapc 	)
);

decoder 
DEC0 
(
	.clock_i  	 ( clock_i   ),
	.nreset_i 	 ( nreset_i  ),
	.opcode_i 	 ( wopcode   ), 
	.hold_i	 	 ( hold_i	 ),
	.n_i		 	 ( n_i		 ),
	.z_i		 	 ( z_i		 ),
	.ram_data_i  ( ram_data_i),
	.branch_o	 ( wbranch   ),
	.wrPC_o  	 ( wWrPC     ),
	.selA_o  	 ( selA_o    ),
	.selB_o  	 ( selB_o    ),
	.wrAccA_o 	 ( wrAccA_o  ),
	.op_o    	 ( op_o      ),
	.im_OEn		 ( im_OEn_o	 ), 
	.im_CEn		 ( im_CEn_o	 ),
	.dm_OEn		 ( dm_OEn_o	 ),
	.dm_CEn		 ( dm_CEn_o	 ),
	.dm_WEn		 ( dm_WEn_o	 )

);

endmodule
