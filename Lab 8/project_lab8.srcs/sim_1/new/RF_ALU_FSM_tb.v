`timescale 1ns / 1ps

module RF_ALU_FSM_tb;

reg clk;
reg rst;
reg WriteEnable;
reg [4:0] rs1;
reg [4:0] rs2;
reg [4:0] rd;
reg [31:0] WriteData;
reg [3:0] ALUControl;
wire [31:0] ReadData1;
wire [31:0] ReadData2;
wire [31:0] ALUResult;
wire Zero;

RegisterFile rf(
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

ALU alu(
    .A(ReadData1),
    .B(ReadData2),
    .ALUControl(ALUControl),
    .ALUResult(ALUResult),
    .Zero(Zero)
);


always #5 clk = ~clk;

initial begin

clk = 0;
rst = 1;
WriteEnable = 0;

rs1 = 0;
rs2 = 0;
rd = 0;
WriteData = 0;
ALUControl = 0;

#10
rst = 0;

#10
WriteEnable = 1;
rd = 5'd1;
WriteData = 32'h10101010;

#10
WriteEnable = 0;
rs1 = 5'd1;

#10

#10
WriteEnable = 1;
rd = 5'd2;
WriteData = 32'h01010101;

#10
WriteEnable = 0;
rs1 = 5'd2;

#10

#10
WriteEnable = 1;
rd = 5'd0;
WriteData = 32'hFFFFFFFF;

#10
WriteEnable = 0;
rs1 = 5'd0;

#10

#10
rs1 = 5'd1;
rs2 = 5'd2;

#10

#10
ALUControl = 4'b0000;

#10

#10
ALUControl = 4'b0001;

#10

#10
ALUControl = 4'b0010;

#10

#10
ALUControl = 4'b0011;

#10

#20
$finish;
end

endmodule
