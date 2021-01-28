/*
 * Copyright (c) 2021, Marcos Medeiros
 * Licensed under BSD 3-clause.
 */
module GPU(
  input                   clk,
  input                   enable,
  input         [16:0]    busAddress,
  input                   busWriteEnable,
  input         [31:0]    busDataIn,
  output        [15:0]    busDataOut,
  output  wire  [7:0]     VGA_B,
  output  wire            VGA_BLANK_N,
  output  wire            VGA_CLK,
  output  wire  [7:0]     VGA_G,
  output  wire            VGA_HS,
  output  wire  [7:0]     VGA_R,
  output  wire            VGA_SYNC_N,
  output  wire            VGA_VS
);
  wire clk25;
  
  ClkDivider clkdiv(
    .clk(clk),
    .clkdiv2(clk25)
  );
  
  wire [9:0] x;
  wire [9:0] y;
  wire hsync, vsync, visible;
  wire xmax, ymax;
  
  reg [7:0] r_color;
  reg [7:0] g_color;
  reg [7:0] b_color;
  
  assign VGA_R    = r_color;
  assign VGA_B    = b_color;
  assign VGA_G    = g_color;
  assign VGA_BLANK_N  = 1'b1;
  assign VGA_SYNC_N   = 1'b0;
  assign VGA_HS     = hsync;
  assign VGA_VS     = vsync;
  assign VGA_CLK    = clk25;
  
  VGAEncoder vga(
    .clk(clk25),
    .x(x),
    .y(y),
    .hsync(hsync),
    .vsync(vsync),
    .visible(visible),
    .xmax(xmax),
    .ymax(ymax)
  );

  reg [16:0] vramPixelAddress;
  reg [16:0] vramRowAddress;
  reg [15:0] pixel;
  wire [15:0] wpixel;
  
  
  wire [15:0] vramDataIn = busAddress[0] ? busDataIn[31:16] : busDataIn[15:0];
  VRAM vram(
    .clk_p1(clk),
    .enable_p1(enable),
    .address_p1(busAddress),
    .dataOut_p1(busDataOut),
    .writeEnable_p1(busWriteEnable),
    .dataIn_p1(vramDataIn),
    
    .clk_p2(clk25),
    .address_p2(vramPixelAddress),
    .dataOut_p2(wpixel),
    .writeEnable_p2(1'b0),
    .dataIn_p2(16'b0)
  );
  
  always @(posedge clk25)
  begin
    if (y == 0)
    begin
      vramRowAddress <= 0;
      vramPixelAddress <= 0;
    end
    if (xmax)
    begin
      if (y[0])
        vramRowAddress <= vramRowAddress + 320;
      vramPixelAddress <= vramRowAddress;
    end
    
    if (visible)
    begin
      pixel <= wpixel;
      r_color <= (({3'b0, pixel[15:11]} * 527 + 23) >> 6);
      g_color <= (({3'b0, pixel[10: 5]} * 259 + 33) >> 6);
      b_color <= (({3'b0, pixel[ 4: 0]} * 527 + 23) >> 6);
      
      if (x[0])
        vramPixelAddress <= vramPixelAddress + 1;
    end
    else
    begin
      r_color <= 5'b0;
      g_color <= 6'b0;
      b_color <= 5'b0;
    end
  end
endmodule
