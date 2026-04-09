`timescale 1ns / 1ps

module Control_tb;

reg [6:0] opcode;
reg [2:0] funct3;
reg [6:0] funct7;

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

initial begin

// ADD
opcode = 7'b0110011;
funct3 = 3'b000;
funct7 = 7'b0000000;
#10;

// SUB
funct7 = 7'b0100000;
#10;

// AND
funct3 = 3'b111;
#10;

// OR
funct3 = 3'b110;
#10;

// XOR
funct3 = 3'b100;
#10;

// SLL
funct3 = 3'b001;
#10;

// SRL
funct3 = 3'b101;
#10;


// ADDI
opcode = 7'b0010011;
funct3 = 3'b000;
#10;


// LOAD
opcode = 7'b0000011;
#10;


// LH
opcode = 7'b0000011;
funct3 = 3'b001;
#10;

// LB
opcode = 7'b0000011;
funct3 = 3'b000;
#10;


// STORE
opcode = 7'b0100011;
#10;


// SH
opcode = 7'b0100011;
funct3 = 3'b001;
#10;

// SB
opcode = 7'b0100011;
funct3 = 3'b000;
#10;


// BEQ
opcode = 7'b1100011;
#10;


$finish;

end

endmodule