//--------------------------
// 	CPU 
//--------------------------
`timescale 10 ns/100 ps

module cpu
#(
	parameter DATASIZE    = 16, 
	parameter OPERANDSIZE = 11,
	parameter ADDRSIZE    = 11,
	parameter SELSIZE     = 2
)
(
	clock_i,
	nreset_i,
	romData_i,
	ramData_i,
	romAddr_o,
	ramData_o,
	ramAddr_o,
	wrRam_o,
	rdRam_o
);

input wire    	              clock_i;
input wire                   nreset_i;
input wire  [ DATASIZE-1:0 ] romData_i;
input wire  [ DATASIZE-1:0 ] ramData_i;
output wire [ ADDRSIZE-1:0 ] romAddr_o;
output wire [ DATASIZE-1:0 ] ramData_o;
output wire [ ADDRSIZE-1:0 ] ramAddr_o;
output wire                  wrRam_o;
output wire 					  rdRam_o;

wire [ OPERANDSIZE-1:0 ] woperand;
wire                     wOp;
wire                     wWrAcc;
wire                     wSelB;
wire [ SELSIZE-1:0 ]     wSelA;

control CTR0
(
	.clock_i    ( clock_i   ),
	.nreset_i   ( nreset_i  ),
	.data_i     ( romData_i ),
	.addr_o     ( romAddr_o ),
	.operand_o  ( woperand  ),
	.wrRam_o    ( wrRam_o   ),
	.rdRam_o		( rdRam_o   ),
	.op_o       ( wOp       ),
	.wrAcc_o    ( wWrAcc    ),
	.selB_o     ( wSelB     ),
	.selA_o     ( wSelA     )
);

datapath DPH0
(
	.clock_i     ( clock_i   ),
	.nreset_i    ( nreset_i   ),
	.selA_i      ( wSelA     ),
	.selB_i      ( wSelB     ),
	.wrAcc_i     ( wWrAcc    ),
	.op_i        ( wOp       ),
	.ramData_i   ( ramData_i ),
	.operand_i   ( woperand  ),
	.ramData_o   ( ramData_o ),
	.ramAddr_o   ( ramAddr_o )
);

endmodule
