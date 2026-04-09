`timescale 1ns / 1ps

module ALU_tb;
reg [31:0] A;
reg [31:0] B;
reg [3:0] ALUControl;
wire [31:0] ALUResult;
wire Zero;

ALU uut (

    .A(A),
    .B(B),
    .ALUControl(ALUControl),
    .ALUResult(ALUResult),
    .Zero(Zero)
    
);

initial begin
    // ADD
    A = 12; B = 8; ALUControl = 4'b0000;
    #10;
    // SUB
    A = 20; B = 5; ALUControl = 4'b0001;
    #10;
    // AND
    A = 15; B = 9; ALUControl = 4'b0010;
    #10;
    // OR
    A = 10; B = 3; ALUControl = 4'b0011;
    #10;
    // XOR
    A = 7; B = 2; ALUControl = 4'b0100;
    #10;
    // Shift Left
    A = 5; B = 1; ALUControl = 4'b0101;
    #10;
    // Shift Right
    A = 16; B = 2; ALUControl = 4'b0110;
    #10;
    // BEQ (equal)
    A = 9; B = 9; ALUControl = 4'b0111;
    #10;
    // BEQ (not equal)
    A = 9; B = 3; ALUControl = 4'b0111;
    #10;
    $finish;
end
endmodule