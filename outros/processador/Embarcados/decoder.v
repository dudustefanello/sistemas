//----------------------------------
//		DECODER
//----------------------------------
`timescale 10 ns/100 ps

module decoder 
#(
	parameter DATA_WIDTH 	= 16,
	parameter OPERAND_WIDTH = 11,
	parameter OPCODE_WIDTH  = 5,
	parameter SEL_OPERATION = 3,
	parameter SEL_WIDTH     = 2
)
(
	clock_i,
	nreset_i,
	opcode_i,
	hold_i,
	n_i,
	z_i,
	ram_data_i,
	branch_o,
	wrPC_o,
	selA_o,
	selB_o,
	wrAccA_o,

	op_o,
	im_OEn,
	im_CEn,
	dm_OEn,
	dm_CEn,
	dm_WEn
);

input  wire					     clock_i;
input  wire					     nreset_i;
input  wire [(OPCODE_WIDTH-1):0] opcode_i;
input	 wire  				     hold_i;
input  wire						 n_i;
input  wire						 z_i;
input  wire [(DATA_WIDTH-1):  0] ram_data_i;

output reg 						 branch_o;
output reg               		 wrPC_o;
output reg [(SEL_WIDTH-1):    0] selA_o;
output reg               		 selB_o;
output reg                       wrAccA_o;
output reg [(SEL_OPERATION-1):0] op_o;
output reg   					 im_OEn;
output reg 					     im_CEn;
output reg 					     dm_OEn;
output reg 						 dm_CEn;
output reg					     dm_WEn;

//-----------------------------------
// 				FSM - MAIN
//-----------------------------------
localparam  FETCH = 2'b00,
			DEC   = 2'b01,
			EXEC  = 2'b10,
			RESET = 2'b11;
				
reg [3:0] mainstate;
reg [3:0] nextmainstate;

always @(posedge clock_i or negedge nreset_i)
begin
	if ( nreset_i == 1'b0 )
		mainstate = RESET;
	else
		mainstate = nextmainstate;
end

always @(mainstate or topstate)
begin
 	nextmainstate = FETCH;
	case (mainstate)
	  RESET: begin
	    nextmainstate = FETCH;
	  end
	  
	  FETCH: begin
		nextmainstate = DEC;
	  end
			
	  DEC: begin
		nextmainstate = EXEC;		
	  end
	  
	  EXEC: begin
		nextmainstate = FETCH;		
	 end
	endcase	
end

always @(mainstate or topstate or opcode_i or n_i or z_i)
begin
  
	case (mainstate)
	  RESET: begin
			op_o 	   = 3'b000;
			wrAccA_o   = 1'b0;
			selA_o	   = 2'b00;
			selB_o	   = 1'b0;
			wrPC_o	   = 1'b0;
			branch_o   = 1'b0;
			im_OEn 	   = 1'b1;
			im_CEn	   = 1'b1;
			dm_OEn	   = 1'b1;
			dm_CEn	   = 1'b1;
			dm_WEn	   = 1'b1;	
	  end
	  FETCH: begin
			op_o 	   = 3'b000;
			wrAccA_o   = 1'b0;
			selA_o	   = 2'b00;
			selB_o	   = 1'b0;
		    wrPC_o	   = 1'b0;
			branch_o   = 1'b0;
			im_OEn     = 1'b0;
			im_CEn	   = 1'b0;
			dm_OEn	   = 1'b0;
			dm_CEn	   = 1'b0;
			dm_WEn     = 1'b1;
		end

		DEC: begin
			wrAccA_o   = 1'b0;
			wrPC_o	   = 1'b0;
			im_OEn 	   = 1'b1;
			im_CEn	   = 1'b1;
			dm_OEn	   = 1'b0;
			dm_CEn	   = 1'b0;
			dm_WEn	   = 1'b1;
			branch_o   = 1'b0;
			op_o 	   = 3'b000;
			
			if(opcode_i == 5'b0_0000) //NOP
			begin
			  op_o 		= 3'b000;
				selA_o	= 2'b00;
				selB_o	= 1'b0;
			end
		  else
			if (opcode_i == 5'b0_0001) //STO
			begin
				op_o 	= 3'b000;
				selA_o	= 2'b00;
				selB_o	= 1'b0;
			end
			else
			if (opcode_i == 5'b0_0010) //LD
			begin
				op_o 	= 3'b000;
				selA_o	= 2'b00;
				selB_o	= 1'b0;
			end
			else
			
			if (opcode_i == 5'b0_0011) //LDI
			begin
				op_o 	= 3'b000;
				selA_o	= 2'b01;
				selB_o	= 1'b1;
			end
			else
			
			if (opcode_i == 5'b0_0100) //ADD
			begin
				op_o 	= 3'b000;
				selA_o	= 2'b10;
				selB_o	= 1'b0;
			end
			else
			
			if (opcode_i == 5'b0_0101) //ADDI
			begin
			    op_o 	= 3'b000;
				selA_o	= 2'b10;
				selB_o	= 1'b1;
			end
			else
			
			if (opcode_i == 5'b0_0110) //SUB
			begin
			    op_o 	= 3'b001;
				selA_o	= 2'b10;
				selB_o	= 1'b0;
			end
			else
			
			if (opcode_i == 5'b0_0111) //SUBI
			begin
			    op_o 	= 3'b001;
				selA_o	= 2'b10;
				selB_o	= 1'b1;
			end
			else
			
			if ((opcode_i == 5'b0_1000) && 
							 (z_i == 1'b1)) //BEQ
			begin
			    op_o 	= 3'b000;
				selA_o	= 2'b00;
				selB_o	= 1'b0;
			end
			else
			
			if ((opcode_i == 5'b0_1001) && 
							  (z_i == 1'b0)) //BNE
			begin
			    op_o 	= 3'b000;
				selA_o	= 2'b00;
				selB_o	= 1'b0;
			end
			else
			
			if ((opcode_i == 5'b0_1010) && 
							  (n_i == 1'b0) && 
							  (z_i == 1'b0)) //BGT
			begin
			    op_o 	= 3'b000;
				selA_o	= 2'b00;
				selB_o	= 1'b0;
			end
			else
			
			if ((opcode_i == 5'b0_1011) && 
							 (n_i == 1'b0)) //BGE
			begin
			    op_o 	= 3'b000;
				selA_o	= 2'b00;
				selB_o	= 1'b0;
			end
			else
			
			if ((opcode_i == 5'b0_1100) && 
							 (n_i == 1'b1)) //BLT
			begin
			    op_o 	= 3'b000;
				selA_o	= 2'b00;
				selB_o	= 1'b0;
			end
			else
			
			// BLE ----------------------------------------------------------------
			if ((opcode_i == 5'b0_1101) && 
							  (n_i == 1'b1) && 
							  (z_i == 1'b0)) //BLE
			begin	
				op_o 	= 3'b000;
				selA_o	= 2'b00;
				selB_o	= 1'b0;
			end
			else
			
			if ((opcode_i == 5'b0_1101) && 
				((n_i == 1'b0) && (z_i == 1'b1) ||
				 (n_i == 1'b1) && (z_i == 1'b0) ||
				 (n_i == 1'b1) && (z_i == 1'b1) ))
			begin
			    op_o 	= 3'b000;
				selA_o	= 2'b00;
				selB_o	= 1'b0;
			end
			else
			
			//---------------------------------------------------------------------
			if (opcode_i == 5'b0_1110) // JMP
			begin
			    op_o 	= 3'b000;
				selA_o	= 2'b00;
				selB_o	= 1'b0;
			end
			else
			
			if (opcode_i == 5'b0_1111) // NOT
			begin
			    op_o 	= 3'b010;
				selA_o	= 2'b10;
				selB_o	= 1'b0;
			end
			else
			
			if (opcode_i == 5'b1_0000) // AND
			begin
			    op_o 	= 3'b011;
				selA_o	= 2'b10;
				selB_o	= 1'b0;
			end
			else
			
			if (opcode_i == 5'b1_0001) // ANDI
			begin
			    op_o 	= 3'b011;
				selA_o	= 2'b10;
				selB_o	= 1'b1;
			end
			else
			
			if (opcode_i == 5'b1_0010) // OR
			begin
			    op_o 	= 3'b100;
				selA_o	= 2'b10;
				selB_o	= 1'b0;
			end
			else
			
			if (opcode_i == 5'b1_0011) // ORI
			begin
			    op_o 	= 3'b100;
				selA_o	= 2'b10;
				selB_o	= 1'b0;
			end
			else
			
			if (opcode_i == 5'b1_0100) // XOR
			begin
			    op_o 	= 3'b101;
				selA_o	= 2'b10;
				selB_o	= 1'b0;
			end
			else
			
			if (opcode_i == 5'b1_0101) // XORI
			begin
			    op_o 	= 3'b101;
				selA_o	= 2'b10;
				selB_o	= 1'b1;
			end
			else
			
			if (opcode_i == 5'b1_0110) // SLL
			begin
				op_o 	= 3'b110;
				selA_o	= 2'b10;
				selB_o	= 1'b1;
			end
			else
			
			if (opcode_i == 5'b1_0111) // SRL
			begin
				op_o 	= 3'b111;
				selA_o	= 2'b10;
				selB_o	= 1'b1;
			end
			else
			begin
				op_o 	= 3'b000;
				selA_o	= 2'b00;
				selB_o	= 1'b0;
			end
		end
		
		//--------------------------------
		// EXECUTE
		//--------------------------------
		EXEC: 
		begin

			im_OEn = 1'b1;
			im_CEn = 1'b1;
			dm_OEn = 1'b0;
			dm_CEn = 1'b0;
			
			if (opcode_i == 5'b0_0000) // NOP
			begin
				wrAccA_o = 1'b0;
				wrPC_o	 = 1'b0;
				op_o 	 = 3'b000;
				selA_o	 = 2'b00;
				selB_o	 = 1'b0;
				branch_o = 1'b0;
				dm_WEn	 = 1'b1;
			end
			else
			if (opcode_i == 5'b0_0001) //STO
			begin
		        wrPC_o = 1'b1;	
				op_o     = 3'b000;
				selA_o	 = 2'b00;
				selB_o	 = 1'b0;
				branch_o = 1'b0;
				wrAccA_o = 1'b0;
				dm_WEn	 = 1'b0;
			end
			else
			if (opcode_i == 5'b0_0010) //LD
			begin
		        wrPC_o	= 1'b1;
				op_o     = 3'b000;
				selA_o	 = 2'b00;
				selB_o	 = 1'b0;
				branch_o = 1'b0;
				wrAccA_o = 1'b1;
				dm_WEn	 = 1'b1;
			end
			else
			
			if (opcode_i == 5'b0_0011) //LDI
			begin
		        wrPC_o	 = 1'b1;
				op_o     = 3'b000;
				selA_o	 = 2'b01;
				selB_o	 = 1'b0;
				branch_o = 1'b0;
				wrAccA_o = 1'b1;
				dm_WEn	 = 1'b1;
			end
			else
			
			if (opcode_i == 5'b0_0100) //ADD
			begin
		        wrPC_o	 = 1'b1;
				op_o     = 3'b000;
				selA_o	 = 2'b10;
				selB_o	 = 1'b0;
				branch_o = 1'b0;
				wrAccA_o = 1'b1;
				dm_WEn	 = 1'b1;
			end
			else
			
			if (opcode_i == 5'b0_0101) //ADDI
			begin
		        wrPC_o	 = 1'b1;
			    op_o     = 3'b000;
				selA_o	 = 2'b10;
				selB_o	 = 1'b1;
				branch_o = 1'b0;
				wrAccA_o = 1'b1;
				dm_WEn	 = 1'b1;
			end
			else
			
			if (opcode_i == 5'b0_0110) //SUB
			begin
		        wrPC_o	 = 1'b1;
			    op_o     = 3'b001;
				selA_o	 = 2'b10;
				selB_o	 = 1'b0;
				branch_o = 1'b0;
				wrAccA_o = 1'b1;
				dm_WEn	 = 1'b1;
			end
			else
			
			if (opcode_i == 5'b0_0111) //SUBI
			begin
		        wrPC_o	 = 1'b1;
			    op_o 	 = 3'b001;
				selA_o	 = 2'b10;
				selB_o	 = 1'b1;
				branch_o = 1'b0;
				wrAccA_o = 1'b1;
				dm_WEn	 = 1'b1;
			end
			else
			
			if ((opcode_i == 5'b0_1000) && 
							 (z_i == 1'b1)) //BEQ
			begin
		        wrPC_o	 = 1'b1;
			    op_o 	 = 3'b000;
				selA_o	 = 2'b00;
				selB_o	 = 1'b0;
				branch_o = 1'b1;
				wrAccA_o = 1'b0;
				dm_WEn	 = 1'b1;
			end
			else
			
			if ((opcode_i == 5'b0_1001) && 
							  (z_i == 1'b0)) //BNE
			begin
		        wrPC_o	 = 1'b1;
			    op_o     = 3'b000;
				selA_o	 = 2'b00;
				selB_o	 = 1'b0;
				branch_o = 1'b1;
				wrAccA_o = 1'b1;
				dm_WEn	 = 1'b1;
			end
			else
			
			if ((opcode_i == 5'b0_1010) && 
							  (n_i == 1'b0) && 
							  (z_i == 1'b0)) //BGT
			begin
		        wrPC_o	 = 1'b1;
			    op_o 	 = 3'b000;
				selA_o	 = 2'b00;
				selB_o	 = 1'b0;
				branch_o = 1'b1;
				wrAccA_o = 1'b0;
				dm_WEn	 = 1'b1;
			end
			else
			
			if ((opcode_i == 5'b0_1011) && 
							 (n_i == 1'b0)) //BGE
			begin
		        wrPC_o	 = 1'b1;
			    op_o     = 3'b000;
				selA_o	 = 2'b00;
				selB_o	 = 1'b0;
				branch_o = 1'b1;
				wrAccA_o = 1'b0;
				dm_WEn	 = 1'b1;
			end
			else
			
			if ((opcode_i == 5'b0_1100) && 
							 (n_i == 1'b1)) //BLT
			begin
		        wrPC_o	 = 1'b1;
			    op_o 	 = 3'b000;
				selA_o	 = 2'b00;
				selB_o	 = 1'b0;
				branch_o = 1'b1;
				wrAccA_o = 1'b0;
				dm_WEn	 = 1'b1;
			end
			else
			
			// BLE ----------------------------------------------------------------
			if ((opcode_i == 5'b0_1101) && 
							  (n_i == 1'b0) && 
							  (z_i == 1'b0)) //BLE
			begin	
		        wrPC_o	 = 1'b1;
				op_o 	 = 3'b000;
				selA_o	 = 2'b00;
				selB_o	 = 1'b0;
				branch_o = 1'b0;
				wrAccA_o = 1'b0;
				dm_WEn	 = 1'b1;
			end
			else
			
			if ((opcode_i == 5'b0_1101) && 
				((n_i == 1'b0) && (z_i == 1'b1) ||
				 (n_i == 1'b1) && (z_i == 1'b0) ||
				 (n_i == 1'b1) && (z_i == 1'b1) )) //BLE
			begin
		        wrPC_o	 = 1'b1;
			    op_o     = 3'b000;
				selA_o	 = 2'b00;
				selB_o	 = 1'b0;
				branch_o = 1'b1;
				wrAccA_o = 1'b0;
				dm_WEn	 = 1'b1;
			end
			else
			
			//---------------------------------------------------------------------
			if (opcode_i == 5'b0_1110) // JMP
			begin

		        wrPC_o	 = 1'b1;
			    op_o 	 = 3'b000;
				selA_o	 = 2'b00;
				selB_o	 = 1'b0;
				branch_o = 1'b1;
				wrAccA_o = 1'b0;
				dm_WEn	 = 1'b1;
			end
			else
			
			if (opcode_i == 5'b0_1111) // NOT
			begin
		        wrPC_o	 = 1'b1;
			    op_o 	 = 3'b010;
				selA_o	 = 2'b10;
				selB_o	 = 1'b0;
				branch_o = 1'b0;
				wrAccA_o = 1'b1;
				dm_WEn	 = 1'b1;
			end
			else
			
			if (opcode_i == 5'b1_0000) // AND
			begin
		        wrPC_o	  = 1'b1;
			    op_o      = 3'b011;
				selA_o	  = 2'b10;
				selB_o	  = 1'b0;
				branch_o  = 1'b0;
				wrAccA_o  = 1'b1;
				dm_WEn	  = 1'b1;
			end
			else
			
			if (opcode_i == 5'b1_0001) // ANDI
			begin
		        wrPC_o	 = 1'b1;
			    op_o 	 = 3'b011;
				selA_o	 = 2'b10;
				selB_o	 = 1'b1;
				branch_o = 1'b0;
				wrAccA_o = 1'b1;
				dm_WEn	 = 1'b1;
			end
			else
			
			if (opcode_i == 5'b1_0010) // OR
			begin
		        wrPC_o	 = 1'b1;
			    op_o 	 = 3'b100;
				selA_o	 = 2'b10;
				selB_o   = 1'b1;
				branch_o = 1'b0;
				wrAccA_o = 1'b1;
				dm_WEn	 = 1'b1;
			end
			else
			
			if (opcode_i == 5'b1_0011) // ORI
			begin
		        wrPC_o	  = 1'b1;
			    op_o 	  = 3'b100;
				selA_o	  = 2'b10;
				selB_o	  = 1'b1;
				branch_o  = 1'b0;
				wrAccA_o  = 1'b1;
				dm_WEn	  = 1'b1;
			end
			else
			
			if (opcode_i == 5'b1_0100) // XOR
			begin
		        wrPC_o	  = 1'b1;
			    op_o 	  = 3'b101;
				selA_o	  = 2'b10;
				selB_o	  = 1'b1;
				branch_o  = 1'b0;
				wrAccA_o  = 1'b1;
				dm_WEn    = 1'b1;
			end
			else
			
			if (opcode_i == 5'b1_0101) // XORI
			begin
		        wrPC_o	 = 1'b1;
			    op_o 	 = 3'b101;
				selA_o	 = 2'b10;
				selB_o	 = 1'b1;
				branch_o = 1'b0;
				wrAccA_o = 1'b1;
				dm_WEn	 = 1'b1;
			end
			else
			
			if (opcode_i == 5'b1_0110) // SLL
			begin
		        wrPC_o	 = 1'b1;
				op_o     = 3'b110;
				selA_o	 = 2'b10;
				selB_o	 = 1'b1;
				branch_o = 1'b0;
				wrAccA_o = 1'b1;
				dm_WEn	 = 1'b1;
			end
			else
			
			if (opcode_i == 5'b1_0111) // SRL
			begin
		        wrPC_o	= 1'b1;
				op_o 	 = 3'b111;
				selA_o	 = 2'b10;
				selB_o	 = 1'b1;
				branch_o = 1'b0;
				wrAccA_o = 1'b1;
				dm_WEn	 = 1'b1;
			end
			else
			begin
		        wrPC_o	 = 1'b1;
				op_o     = 3'b000;
				selA_o	 = 2'b00;
				selB_o	 = 1'b0;
				branch_o = 1'b0;
				wrAccA_o = 1'b0;
				dm_WEn	 = 1'b1;
			end
		end
		
	endcase	
end
endmodule
