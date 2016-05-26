module soma1ports(a, b, c_in, out, c_out); //implementação com portas lógicas

    /*
    Fiz um pequeno circuito somador com portas lógicas.
    Utilizei a tabela verdade da soma com carry e portas and, or e not(!)
    Obtive o mesmo funcionamento.
    
    Isso foi bem utilizado?
    */

    input a, b, c_in;
    output out, c_out;

    wire x, y, w, z, r, s, t;

    and(x, a, b, c_in);
    and(y, a, !b, !c_in);
    and(w, !a, !b, c_in);
    and(z, !a, b, !c_in);
    or(out, x, y, w, z);

    and(r, b, c_in);
    and(s, a, c_in);
    and(t, a, b);
    or(c_out, r, s, t);

endmodule // soma1ports

module soma1case(a, b, c_in, out, c_out); //implementação seguindo o exemplo
    input a, b, c_in;
    output c_out, out;

    reg carry, value;

    assign c_out = carry, out = value;

    always @ (a, b, c_in) begin
        case ({a, b, c_in})
            3'b000: begin
                value = 0; carry = 0;
            end
            3'b001: begin
                value = 1; carry = 0;
            end
            3'b010: begin
                value = 1; carry = 0;
            end
            3'b011: begin
                value = 0; carry = 1;
            end
            3'b100: begin
                value = 1; carry = 0;
            end
            3'b101: begin
                value = 0; carry = 1;
            end
            3'b110: begin
                value = 0; carry = 1;
            end
            3'b111: begin
                value = 1; carry = 1;
            end
        endcase
    end //always

endmodule // soma1case

module soma4bit(input [3:0]a, input [3:0]b, output [3:0]o_out, output c_out);

    wire [2:0]carry;
    wire carry2;

    assign c_out = carry2;

    soma1ports S1(a[0], b[0],     1'b0, o_out[0], carry[0]);
    soma1ports S2(a[1], b[1], carry[0], o_out[1], carry[1]);
    soma1ports S3(a[2], b[2], carry[1], o_out[2], carry[2]);
    soma1ports S4(a[3], b[3], carry[2], o_out[3], carry2);

endmodule // soma4bit

module test;

    reg  [3:0] a, b;
    wire [3:0] o;
    wire c;

    soma4bit S1(a, b, o, c);

    initial begin
        $dumpvars(0, S1);
        a = 4;
        b = 2;
        #1
        a = 1;
        b = 9;
        #2
        a = 10;
        b = 6;
        #3
        $finish;
    end

endmodule // test
