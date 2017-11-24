module Values(
       input clk,
       output light
      );
   
   assign light = clk;
   
endmodule

module test;

   reg clk;
   wire light;

  Values V(clk
         , light);
   always #1 clk = ~clk;
   
  initial begin
    $dumpvars(0, V);
    #0;
    clk <=  1'b1;
    #500;
    $finish;
  end
endmodule