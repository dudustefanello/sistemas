module values(input  clk, output light);
   
   reg [6:0] counter = -1;
   reg lightON = 0;
   
   assign light = lightON;
   
   always @(posedge clk) begin
      if(counter == 24) begin
	        lightON <= ~lightON;
	        counter <= 0;
      end
      else begin
	        counter <= counter+1;
      end
   end
   
endmodule

module test;

   reg clk;
   wire light;

   values adder(clk,
		light);

   always #1 clk = ~clk;
   
   initial begin
      $dumpvars(0,adder);
      #0;
      clk <= 0;
      #100;
      $finish;   
   end
endmodule