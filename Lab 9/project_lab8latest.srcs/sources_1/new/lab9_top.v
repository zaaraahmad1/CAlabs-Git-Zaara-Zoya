`timescale 1ns / 1ps

module lab9_top(

input clk,
input [15:0] sw,

output [15:0] led

);

wire [6:0] opcode;
wire [2:0] funct3;
wire [6:0] funct7;

assign opcode = sw[6:0];
assign funct3 = sw[9:7];
assign funct7 = {sw[15:10]};

wire RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch;
wire [1:0] ALUOp;
wire [3:0] ALUCtrl;


MainControl mc(
.opcode(opcode),
.RegWrite(RegWrite),
.ALUSrc(ALUSrc),
.MemRead(MemRead),
.MemWrite(MemWrite),
.MemtoReg(MemtoReg),
.Branch(Branch),
.ALUOp(ALUOp)
);

ALUControl ac(
.ALUOp(ALUOp),
.funct3(funct3),
.funct7(funct7),
.ALUControl(ALUCtrl)
);


// map outputs to LEDs
assign led[0] = RegWrite;
assign led[1] = ALUSrc;
assign led[2] = MemRead;
assign led[3] = MemWrite;
assign led[4] = MemtoReg;
assign led[5] = Branch;

assign led[7:6] = ALUOp;
assign led[11:8] = ALUCtrl;

assign led[15:12] = 4'b0000;

endmodule