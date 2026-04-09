`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/19/2026 09:48:49 AM
// Design Name: 
// Module Name: debouncer
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

module debouncer(
    input clk,
    input pbin,
    output reg pbout
);
 
    reg [2:0] shift;
 
    always @(posedge clk) begin
        shift <= {shift[1:0], pbin};
        if (shift == 3'b111)
            pbout <= 1;
        else if (shift == 3'b000)
            pbout <= 0;
    end
 
endmodule
