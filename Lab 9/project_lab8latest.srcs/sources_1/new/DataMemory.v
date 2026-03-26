`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2026 10:57:52 AM
// Design Name: 
// Module Name: DataMemory
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
module DataMemory(
    input clk,
    input rst,
    input MemWrite,
    input MemRead,
    input [31:0] address,
    input [31:0] write_data,
    output reg [31:0] read_data
);

reg [31:0] memory [0:511];
wire [8:0] addr;

assign addr = address[8:0];

integer i;

// WRITE + RESET
always @(posedge clk or posedge rst)
begin
    if (rst) begin
        for (i = 0; i < 512; i = i + 1)
            memory[i] <= 32'b0;
    end
    else if (MemWrite)
        memory[addr] <= write_data;
end

// READ
always @(*)
begin
    if (MemRead)
        read_data = memory[addr];
    else
        read_data = 32'b0;
end

endmodule