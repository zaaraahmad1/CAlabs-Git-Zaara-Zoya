`timescale 1ns / 1ps

module lab7_top(
input clk,
input rst_btn,
input [3:0] sw,
output [15:0] led
);

wire [31:0] ReadData1;
wire [31:0] ReadData2;
wire [31:0] ALUResult;
wire Zero;
reg WriteEnable;
reg [4:0] rs1;
reg [4:0] rs2;
reg [4:0] rd;
reg [31:0] WriteData;
reg [1:0] state;

RegisterFile rf(
    .clk(clk),
    .rst(rst_btn),
    .WriteEnable(WriteEnable),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .WriteData(WriteData),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2)
);

ALU alu_inst(
    .A(ReadData1),
    .B(ReadData2),
    .ALUControl(sw),
    .ALUResult(ALUResult),
    .Zero(Zero)
);

always @(posedge clk or posedge rst_btn)
begin
    if(rst_btn)
    begin
        state <= 0;
        WriteEnable <= 0;
        rs1 <= 1;
        rs2 <= 2;
    end
    else
    begin
        case(state)

        0:
        begin
            WriteEnable <= 1;
            rd <= 1;
            WriteData <= 32'h10101010;
            state <= 1;
        end

        1:
        begin
            rd <= 2;
            WriteData <= 32'h01010101;
            state <= 2;
        end

        2:
        begin
            WriteEnable <= 0;
        end

        endcase
    end
end

assign led[14:0] = ALUResult[14:0];
assign led[15] = Zero;

endmodule