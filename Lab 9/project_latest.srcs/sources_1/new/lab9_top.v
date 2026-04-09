`timescale 1ns / 1ps

module lab9_top(

input clk,
input rst,
input [15:0] sw,
input [15:0] btns,  
output [15:0] led
);


wire [31:0] sw_readData;
wire [31:0] led_readData;


switches sw_inst(
    .clk(clk),
    .rst(rst),
    .btns(btns),
    .writeData(32'b0),
    .writeEnable(1'b0),
    .readEnable(1'b1),       
    .memAddress(30'b0),
    .switches(sw),
    .readData(sw_readData)
);


wire [6:0] opcode;
wire [2:0] funct3;
wire [6:0] funct7;

assign opcode = sw_readData[6:0];
assign funct3 = sw_readData[9:7];
assign funct7 = sw_readData[15:9];

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


wire [31:0] led_writeData;

assign led_writeData = {
    20'b0,
    ALUCtrl,     // [11:8]
    ALUOp,       // [7:6]
    Branch,      
    MemtoReg,    
    MemWrite,    
    MemRead,     
    ALUSrc,      
    RegWrite    
};


leds led_inst(
    .clk(clk),
    .rst(rst),
    .writeData(led_writeData),
    .writeEnable(1'b1),
    .readEnable(1'b0),
    .memAddress(30'b0),
    .readData(led_readData),
    .leds(led)
);

endmodule