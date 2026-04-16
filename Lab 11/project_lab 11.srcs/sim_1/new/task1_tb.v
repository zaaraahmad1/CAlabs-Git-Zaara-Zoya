`timescale 1ns / 1ps

module Task1_tb;
reg clk;
reg rst;
reg PCSrc;
wire [31:0] PC;
wire [31:0] PC_plus4;
wire [31:0] branchAddr;
wire [31:0] nextPC;
wire [31:0] immOut;
reg [31:0] instruction;

ProgramCounter pc(
    .clk(clk),
    .rst(rst),
    .nextPC(nextPC),
    .PC(PC)
);

pcAdder adder1(
    .PC(PC),
    .PC_plus4(PC_plus4)
);

branchAdder adder2(
    .PC(PC),
    .imm(immOut),
    .branchAddr(branchAddr)
);

mux2 mux(
    .in0(PC_plus4),
    .in1(branchAddr),
    .sel(PCSrc),
    .out(nextPC)
);

immGen ig(
    .instruction(instruction),
    .immOut(immOut)
);

always #5 clk = ~clk;

initial begin
clk = 0;
rst = 1;
PCSrc = 0;
instruction = 0;

#10 rst = 0;

instruction = 32'b00000000010100000000000010010011;

#10;

if (immOut != 5) $stop;

instruction = 32'b00000000010100000010000000100011;

#10;

if (immOut != 5) $stop;

instruction = 32'b00000000000100000000000001100011;

#10;

if (immOut == 0) $stop;

instruction = 0;

#10; if (PC != 0) $stop;

#10; if (PC != 4) $stop;

#10; if (PC != 8) $stop;

#10; if (PC != 12) $stop;

instruction = 32'b00000000000100000000000001100011; // B-type

PCSrc = 1;

#10;

if (nextPC != branchAddr) $stop;

if (branchAddr != PC + (immOut << 1)) $stop;

#20;

$finish;

end
endmodule
 