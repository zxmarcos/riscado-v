module SOCTOP_TB;

	reg clk;
	reg reset;

	reg [31:0] memory[0:4096];
	reg [31:0] dataOut;
	wire [31:0] dataIn;
	wire [31:0] address;
	wire we;
	
	
	RISCV riscv(
		.clk(clk),
		.reset(reset),
		.dataIn(dataOut),
		.dataOut(dataIn),
		.address(address),
		.writeEnable(we));
		
	

	always @(posedge clk)
	begin
		if (we)
			memory[address[31:2]] <= dataIn;
		else
			dataOut <= memory[address[31:2]];
	end

	initial begin
		$dumpfile("soctop.vcd");
		$dumpvars(0,SOCTOP_TB);
		$readmemh("D:/dev/DE1-SOC/Tools/SystemBuilder/CodeGenerated/DE1_SOC/RISCV_GPU_SOC/testdata/test_bug.mem", memory);
		
		clk = 0;
		reset = 0;
		
		
	end

	reset = 1;
	#1
	reset = 0;
	
	always #1 clk = !clk;

endmodule
