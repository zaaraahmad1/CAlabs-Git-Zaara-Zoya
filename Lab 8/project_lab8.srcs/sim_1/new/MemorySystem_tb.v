`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2026 11:03:35 AM
// Design Name: 
// Module Name: MemorySystem_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module MemorySystem_tb;

reg clk;
reg rst;
reg [31:0] address;
reg readEnable;
reg writeEnable;
reg [31:0] writeData;
reg [15:0] switches;
wire [31:0] readData;
wire [15:0] leds;

addressDecoderTop uut(
.clk(clk),
.rst(rst),
.address(address),
.readEnable(readEnable),
.writeEnable(writeEnable),
.writeData(writeData),
.switches(switches),
.readData(readData),
.leds(leds)
);

always #5 clk = ~clk;

initial begin

clk = 0;
rst = 1;

address = 0;
readEnable = 0;
writeEnable = 0;
writeData = 0;

switches = 16'h00AA;

#10
rst = 0;

#10
address = 32'd100;
writeData = 32'hABCDEFAB;
writeEnable = 1;

#10
writeEnable = 0;

#10
readEnable = 1;

#10
readEnable = 0;

#10
address = 32'd520;
writeData = 32'h0000FFFF;
writeEnable = 1;

#10
writeEnable = 0;

#10
address = 32'd800;
readEnable = 1;

#10
readEnable = 0;


#20
$finish;

end

endmodule
