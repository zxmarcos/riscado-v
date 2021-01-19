//`timescale 1 ns/1 ns
module RAM_TB;

	reg clk = 0;
	reg [31:0] address;
	reg [31:0] dataIn;
	wire [31:0] dataOut;
	reg writeEnable;
	
	RAM ram(.clk(clk), .address(address), .dataIn(dataIn), .dataOut(dataOut), .writeEnable(writeEnable));
	
	initial begin
		clk = 0;
		
		#1
		address = 0;
		writeEnable = 0;
		clk = 1;
		
		#1
		clk = 0;
		if (dataOut != 32'h3e800093)
			$error("Valor 0 errado %x", dataOut);
		
		#1
		address = 1;
		clk = 1;
		
		#1
		clk = 0;
		if (dataOut != 32'h7d008113)
			$error("Valor 1 errado %x", dataOut);
			
		#1
		address = 2;
		dataIn = 32'hDEADBEEF;
		clk = 1;
		
		#1
		clk = 0;
		if (dataOut != 32'hc1810193)
			$error("Valor 2 errado %x", dataOut);
			
		#1
		clk = 1;
		writeEnable = 1;
		
		#1
		clk = 0;
		
		#1
		if (dataOut != 32'hDEADBEEF)
			$error("Valor 3 errado %x", dataOut);
		
	end

endmodule
