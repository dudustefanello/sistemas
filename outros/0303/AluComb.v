
module AluComb(
  input [7:0] a,    //[vetor de 8 posições (0 à 7)]
  input [7:0] b, 
  input [1:0] op, 
  output [7:0] c);

  reg [7:0] c_reg;
  assign c = c_reg;

  always @(op, a, b) begin    //always == processo //@(area de sensibilidade)
    case (op)                 //case == escolha através da variavel op
      0: c_reg <= a + b;
      1: c_reg <= a - b;
      2: c_reg <= a & b;
      3: c_reg <= a | b;
    endcase
  end

endmodule

module test(output v);

  reg [7:0] a;
  reg [7:0] b;
  reg [1:0] op;

  wire [7:0] c;

  AluComb A(a, b, op, c);


  initial begin
    $dumpvars(0, A);
    #10;
    a <= 7;
    b <= 3;
    op <= 0;
    #20;
    op <= 1;
    #30;
    op <= 2;
    #40;
    op <= 3;
    #50;
    op <= 0;
    #500;
    $finish;
  end
endmodule