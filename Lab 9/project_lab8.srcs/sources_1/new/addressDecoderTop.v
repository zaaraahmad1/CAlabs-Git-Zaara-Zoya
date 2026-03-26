`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2026 11:01:31 AM
// Design Name: 
// Module Name: addressDecoderTop
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
module addressDecoderTop(
input clk,
input rst,
input [31:0] address,
input readEnable,
input writeEnable,
input [31:0] writeData,
input [15:0] switches,
output [31:0] readData,
output [15:0] leds
);

wire DataMemRead;
wire DataMemWrite;
wire LEDWrite;
wire SwitchRead;
wire [31:0] memReadData;
wire [31:0] switchData;

AddressDecoder decoder(
.address(address),
.readEnable(readEnable),
.writeEnable(writeEnable),
.DataMemRead(DataMemRead),
.DataMemWrite(DataMemWrite),
.LEDWrite(LEDWrite),
.SwitchRead(SwitchRead)
);

DataMemory mem(
.clk(clk),
.MemWrite(DataMemWrite),
.MemRead(DataMemRead),
.address(address),
.write_data(writeData),
.read_data(memReadData)
);

assign switchData = {16'b0, switches};

assign readData =
        (DataMemRead) ? memReadData :
        (SwitchRead)  ? switchData :
        32'b0;

assign leds = (LEDWrite) ? writeData[15:0] : 16'b0;
endmodule
