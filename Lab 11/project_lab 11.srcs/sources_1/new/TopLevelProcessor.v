`timescale 1ns / 1ps

module TopLevelProcessor(
   input clk,
   input rst,
   input [15:0] switches,
   output [15:0] leds
);

wire [31:0] PC, nextPC, PC_plus4, branchAddr;
wire [31:0] instruction;

ProgramCounter pc(
   .clk(clk),
   .rst(rst),
   .nextPC(nextPC),
   .PC(PC)
);

pcAdder pc_add(
   .PC(PC),
   .PC_plus4(PC_plus4)
);

lab10_mem instr_mem(
   .instAddress(PC),
   .instruction(instruction)
);


wire RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch;
wire [1:0] ALUOp;

MainControl control(
   .opcode(instruction[6:0]),
   .RegWrite(RegWrite),
   .ALUSrc(ALUSrc),
   .MemRead(MemRead),
   .MemWrite(MemWrite),
   .MemtoReg(MemtoReg),
   .Branch(Branch),
   .ALUOp(ALUOp)
);

wire [31:0] ReadData1, ReadData2, WriteData;

RegisterFile rf(
   .clk(clk),
   .rst(rst),
   .WriteEnable(RegWrite),
   .rs1(instruction[19:15]),
   .rs2(instruction[24:20]),
   .rd(instruction[11:7]),
   .WriteData(WriteData),
   .ReadData1(ReadData1),
   .ReadData2(ReadData2)
);

wire [31:0] immOut;

immGen ig(
   .instruction(instruction),
   .immOut(immOut)
);

wire [3:0] ALUCtrl;

ALUControl alu_ctrl(
   .ALUOp(ALUOp),
   .funct3(instruction[14:12]),
   .funct7(instruction[31:25]),
   .ALUControl(ALUCtrl)
);

wire [31:0] ALU_input2;
wire [31:0] ALUResult;
wire Zero;

assign ALU_input2 = (ALUSrc) ? immOut : ReadData2;

ALU alu(
   .A(ReadData1),
   .B(ALU_input2),
   .ALUControl(ALUCtrl),
   .ALUResult(ALUResult),
   .Zero(Zero)
);

wire [31:0] memReadData;

addressDecoderTop mem_sys(
   .clk(clk),
   .rst(rst),
   .address(ALUResult),
   .readEnable(MemRead),
   .writeEnable(MemWrite),
   .writeData(ReadData2),
   .switches(switches),
   .readData(memReadData),
   .leds(leds)
);

assign WriteData = (MemtoReg) ? memReadData : ALUResult;

wire PCSrc;

assign PCSrc = Branch & Zero;

branchAdder br_add(
   .PC(PC),
   .imm(immOut),
   .branchAddr(branchAddr)
);

mux2 pc_mux(
   .in0(PC_plus4),
   .in1(branchAddr),
   .sel(PCSrc),
   .out(nextPC)
);

endmodule