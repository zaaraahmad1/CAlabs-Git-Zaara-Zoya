`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2026 10:58:45 AM
// Design Name: 
// Module Name: AddressDecoder
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
module AddressDecoder(
input [31:0] address,
input readEnable,
input writeEnable,
output reg DataMemRead,
output reg DataMemWrite,
output reg LEDWrite,
output reg SwitchRead
);

always @(*)
begin

DataMemRead = 0;
DataMemWrite = 0;
LEDWrite = 0;
SwitchRead = 0;

case(address[9:8])

2'b00:
begin
    DataMemRead = readEnable;
    DataMemWrite = writeEnable;
end

2'b01:
begin
    LEDWrite = writeEnable;
end

2'b10:
begin
    SwitchRead = readEnable;
end

default:
begin
end

endcase

end

endmodule

