module SOCTOP_TB;

reg clk;
reg reset;

soctop st(clk, reset);

initial begin
	clk = 0;
	reset = 0;
	
	#1
	clk = 1;
	reset = 1;
	#1
	clk = 0;
	reset = 0;
	
end

endmodule
