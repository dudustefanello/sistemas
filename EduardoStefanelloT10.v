module multiplicador(clk, e, a, b, valid, c); // implementação seguindo o exemplo
    input clk, e;
    input [3:0] a, b;
    output valid; 
    output [7:0] c;

    reg [7:0] total;
    reg [1:0] count;
    wire m1;
    wire [3:0] m4, r;

    assign c = (count == 3) ? total : 0;
    assign m1 = b[count];
    assign m4 = {m1, m1, m1, m1};
    assign r = m4 & a;

    always @(posedge clk) begin
        if (e) begin
            total = (total << 1) + r;
            count = count + 1;
        end // if
        else begin
            count = 0;
            total = 0;
        end // else
    end // always clock
endmodule // multiplicador

module test;
    reg e, clk = 0;
    reg [3:0] a, b;
    wire valid;
    wire [7:0] c;

    always #1 clk = !clk;

    multiplicador M1(clk, e, a, b, valid, c);

    initial begin
        $dumpvars(0, M1);
        e = 0;
        #5;
        a = 3;
        b = 8;
        e = 1;
        #15;
        $finish;
    end
endmodule
