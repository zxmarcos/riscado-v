/*
 * Copyright (c) 2021, Marcos Medeiros
 * Licensed under BSD 3-clause.
 */
module RAM(
  input             clk,
  input [31:0]      address,
  input [31:0]      dataIn,
  input             writeEnable,
  output reg [31:0] dataOut
);
  
  reg [31:0] memory[0:4095];
  wire [30:0] daddr = address[31:2];
  
  initial begin
    $readmemh("testdata/test_branchs.mem", memory);
  end
  
  // Acesso a memória.
  always @(posedge clk)
  begin
    if (writeEnable)
    begin
      memory[daddr] <= dataIn;
    end
    dataOut <= memory[daddr];
  end
endmodule
  