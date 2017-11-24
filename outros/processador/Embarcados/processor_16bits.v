/******************************************************************
*								 PROCESSOR
*								   2014
******************************************************************/
/*****************************************************************
* HIGH PERFORMANCE 16 BITS PROCESSOR
* MULTICYCLE DATAPATH - 4 STAGES
* CLOCK FREQUENCY 100 MHz
* 24 ISA
* INSTRUCTION MEMORY - 16-BITS WIDE, 1024 POSITIONS (1KB)
* DATA MEMORY - 16 BITS WIDE, 2048 POSITIONS (1MB)
******************************************************************/
/*****************************************************************
*
******************************************************************/
`timescale 10 ns/100 ps

module processor_16bits
#(
	parameter MSB_DATA 	   = 16,
	parameter MSB_ROM       = 11,
	parameter MSB_RAM       = 10,
	parameter MSB_OPERAND   = 11,
	//parameter MSB_OPCODE  = 5,
	parameter MSB_OPERATION = 3,
	parameter MSB_SEL       = 2,
	parameter LSB				= 0
)
(
	//-----------------------------
	//	GENERAL SYSTEM INTERFACE
	//-----------------------------
	CLOCK_i,
	RESET_n_i,
	HOLD_n_i,
	//-----------------------------
	//	INSTRUCTION MEMORY INTERFACE
	//-----------------------------
	ADDR_im_o,
	DATA_im_i,
	CEnable_im_o,
	OEnable_im_o,
	//-----------------------------
	//	DATA MEMORY INTERFACE
	//-----------------------------	
	WEnable_dm_o,
	CEnable_dm_o,
	OEnable_dm_o,
	ADDR_dm_o,
	DATA_dm_i,
	DATA_dm_o
);

input	wire					CLOCK_i;	    // GENERAL CLOCK SIGNAL
input	wire					RESET_n_i;    // ASSYNCHRONOUS RESET. ACTIVE LOW
input	wire					HOLD_n_i;	    // HOLD PROCESSOR STATE. FREEZE MODE. ACTIVE LOW
input wire  [(MSB_DATA-1):LSB ] DATA_dm_i;    // DATA FROM DATA MEMORY 
input wire  [(MSB_DATA-1):LSB ] DATA_im_i;    // DATA FROM INSTRUCTION MEMORY

output wire [(MSB_RAM-1) :LSB ] ADDR_im_o;	 // ADDRESS TO INSTRUCTION MEMORY
output wire 					CEnable_im_o; // INSTRUCTION MEMORY CHIP ENABLE. ACTIVE LOW
output wire						OEnable_im_o; // INSTRUCTION MEMORY OUTPUT ENABLE . ACTIVE LOW
output wire						CEnable_dm_o; // DATA MEMORY WRITE ENABLE. ACTIVE LOW
output wire						OEnable_dm_o; // DATA MEMORY CHIP ENABLE. ACTIVE LOW
output wire					    WEnable_dm_o; // DATA MEMORY OUTPUT ENABLE. ACTIVE LOW
output wire [(MSB_ROM-1 ):LSB ] ADDR_dm_o;	 // ADDRESS TO DATA MEMORY
output wire [(MSB_DATA-1):LSB ] DATA_dm_o;    // DATA TO DATA MEMORY

wire [(MSB_OPERATION-1):LSB] wop;
wire [(MSB_OPERAND-1):LSB]   woperand ;
wire [(MSB_DATA-1):LSB]      wram_data;
wire [ (MSB_SEL-1):LSB]      wselA;
wire [(MSB_RAM-1):LSB]       wext2pc; 
wire 						 wwraccA;
wire 						 wwraccB;
wire 						 wrStatus;
wire 						 wselB;
wire 						 wn;
wire 						 wz;

control
CTRL00
(
	.clock_i	 ( CLOCK_i      ),
	.nreset_i  	 ( RESET_n_i    ),
	.im_data_i 	 ( DATA_im_i    ),
	.im_addr_o 	 ( ADDR_im_o    ),
	.ext2pc_i  	 ( wext2pc      ),
	.hold_i    	 ( HOLD_n_i     ),
	.n_i       	 ( wn	        ),
	.z_i       	 ( wz	        ),
	.ram_data_i  ( wram_data    ),
	.operand_o 	 ( woperand     ),
	.op_o      	 ( wop          ),
	.wrAccA_o 	 ( wwraccA      ),
	.selA_o    	 ( wselA        ),
	.selB_o    	 ( wselB        ),
	.im_OEn_o  	 ( OEnable_im_o ),
	.im_CEn_o  	 ( CEnable_im_o ),
	.dm_OEn_o  	 ( OEnable_dm_o ),
	.dm_CEn_o  	 ( CEnable_dm_o ),
	.dm_WEn_o  	 ( WEnable_dm_o )
);

datapath 
DPTH00
(
	.clock_i	  ( CLOCK_i   	),
	.nreset_i	  ( RESET_n_i 	),
	.selA_i		  ( wselA   	),
	.selB_i		  ( wselB   	),
	.wrAccA_i 	  ( wwraccA     ),
	.op_i		  ( wop     	),
	.operand_i	  ( woperand 	),
	.dm_in_data   ( DATA_dm_i   ),
	.ext2pc_o	  ( wext2pc	    ),
	.n_o		  ( wn			),
	.z_o		  ( wz			),
	.dm_addr_o	  ( ADDR_dm_o   ),
	.dm_out_data  ( DATA_dm_o   ),
	.ram_data_o   ( wram_data   )
);

endmodule
