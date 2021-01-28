
module VRAM(
  input               clk_p1,
  input               enable_p1,
  input [16:0]        address_p1,
  input               writeEnable_p1,
  input [15:0]        dataIn_p1,
  output reg [15:0]   dataOut_p1,
  
  input               clk_p2,
  input [16:0]        address_p2,
  input               writeEnable_p2,
  input [15:0]        dataIn_p2,
  output reg [15:0]   dataOut_p2
);
  reg [15:0] VRAM[0:320*240-1] /* synthesis ram_init_file = "riscvlogo.mif" */;
  
  //initial begin
  //  $readmemh("riscvlogo.mem", VRAM);
  //end

  always @(posedge clk_p1)
  begin
    if (enable_p1)
    begin
      if (writeEnable_p1)
        VRAM[address_p1] <= dataIn_p1;
      else
        dataOut_p1 <= VRAM[address_p1];
    end
  end

  always @(posedge clk_p2)
  begin
    if (writeEnable_p2)
      VRAM[address_p2] <= dataIn_p2;
    else
      dataOut_p2 <= VRAM[address_p2];
  end
endmodule
