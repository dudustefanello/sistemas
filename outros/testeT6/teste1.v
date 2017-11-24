module test;
	reg [3:0] a [0:31];
	initial begin
		$dumpvars(a[], test);
		#2
		a[2] <= 12;
		#10
		$finish;
	end
endmodule