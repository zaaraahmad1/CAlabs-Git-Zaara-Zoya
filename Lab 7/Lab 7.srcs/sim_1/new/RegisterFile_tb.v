`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2026 09:42:18 AM
// Design Name: 
// Module Name: RegisterFile_tb
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

module RegisterFile_tb;

reg clk;
reg rst;
reg WriteEnable;
reg [4:0] rs1;
reg [4:0] rs2;
reg [4:0] rd;
reg [31:0] WriteData;
wire [31:0] ReadData1;
wire [31:0] ReadData2;

RegisterFile uut(
    .clk(clk),
    .rst(rst),
    .WriteEnable(WriteEnable),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .WriteData(WriteData),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2)
);

always #5 clk = ~clk;

initial begin
clk = 0;
rst = 1;
WriteEnable = 0;
#10 rst = 0;
$display("---- Test Write to Register ----");
rd = 5'd5;
WriteData = 32'hABCDEFAB;
WriteEnable = 1;
#10 WriteEnable = 0;
rs1 = 5'd5;
#10;
$display("Register x5 value = %h", ReadData1);
$display("---- Test Write to x0 ----");
rd = 5'd0;
WriteData = 32'hFFFFFFFF;
WriteEnable = 1;
#10 WriteEnable = 0;
rs1 = 5'd0;
#10;
$display("Register x0 value = %h (should be 0)", ReadData1);
$display("---- Two simultaneous reads ----");
rs1 = 5'd5;
rs2 = 5'd0;
#10;
$display("Read1 = %h Read2 = %h", ReadData1, ReadData2);
$finish;
end

endmodule
 
