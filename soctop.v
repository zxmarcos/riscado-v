/*
 * Copyright (c) 2021, Marcos Medeiros
 * Licensed under BSD 3-clause.
 */
 /*
module soctop(input clk, input reset, output [31:0] do);
    
    
    wire [31:0] busDataIn;
    wire [31:0] cpuDataOut;
    wire [31:0] busAddress;
    wire        busWriteEnable;
    
    assign do = busAddress;
    
    RAM ram(
        .clk(clk),
        .address(busAddress),
        .dataIn(cpuDataOut),
        .writeEnable(busWriteEnable),
        .dataOut(busDataIn)
    );
        
    RISCV cpu(
        .clk(clk),
        .reset(reset),
        .dataIn(busDataIn),
        .dataOut(cpuDataOut),
        .address(busAddress),
        .writeEnable(busWriteEnable)
    );
    
    
endmodule
*/