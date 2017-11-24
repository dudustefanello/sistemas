`include "trianguleMain.v"

module trianguleFileGenerator;
    reg [10:0]p1x,p1y,p2x,p2y,p3x,p3y,ptx,pty;
    reg flag = 0;
    wire clk;
    wire active, value;

    trianguleMain validerT(clk, p1x,p1y,p2x,p2y,p3x,p3y,ptx,pty,active,value);
      
    integer read_file, write_file, tmp;
      
    always @(posedge clk) begin
        if(!$feof(read_file) && active && !flag) begin
            flag = 1;
            tmp = $fscanf(read_file,"%d %d %d %d %d %d %d %d\n", p1x,p1y,p2x,p2y,p3x,p3y,ptx,pty);
        end
        else if(active && flag) begin
            flag <= 0;
            $fwrite(write_file,"[%0d] %0d %0d %0d %0d %0d %0d %0d %0d\n",value,p1x,p1y,p2x,p2y,p3x,p3y,ptx,pty);
        end
        else if($feof(read_file) && active) begin
            $finish;
        end
    end
      
    initial begin
        #0;
        tmp = 1;
        read_file = $fopen("input.in","r");
        write_file = $fopen("output_verilog.out","w");
    end
endmodule
