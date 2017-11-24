module test_clock;
  reg clk1,			//declaração dos registradores
  	  clk2;			//separação por vírgula
  wire led1,    //Ponto e Virgula no final
       led2;

  assign led1 = clk1;
  assign led2 = clk2;

  always #1 clk1 = ~clk1;	//always de "sempre"
  always #3 clk2 = ~clk2;	//#numero (unidade de tempo)
  							//registrador recebe seu valor negado


  initial begin				//início do escopo de execução
    $dumpvars(0, clk1);
    $dumpvars(0, clk2);
    clk1 <= 0;				//registrador recebe valor 0
    clk2 <= 0;
    #500;					//execução até 500 unidades de tempo
    $finish;
  end


endmodule