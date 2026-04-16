`timescale 1ns / 1ps

module immGen(
    input [31:0] instruction,
    output reg [31:0] immOut
);

wire [6:0] opcode;
assign opcode = instruction[6:0];

always @(*) begin
    case(opcode)
    // I-type
    7'b0000011, 7'b0010011: begin
        immOut = {{20{instruction[31]}}, instruction[31:20]};
    end

    // S-typ
    7'b0100011: begin
        immOut = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
    end

    // B-type
    7'b1100011: begin
        immOut = {{19{instruction[31]}},
                  instruction[31],
                  instruction[7],
                  instruction[30:25],
                  instruction[11:8],
                  1'b0};
    end

    default: begin
        immOut = 32'b0;
    end
    endcase
end
endmodule
 