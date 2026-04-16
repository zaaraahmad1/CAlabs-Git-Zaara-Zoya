`timescale 1ns / 1ps
module TopLevelProcessor_tb;
reg clk;
reg rst;
// DUT
TopLevelProcessor uut (
   .clk(clk),
   .rst(rst)
);
// Clock
always #5 clk = ~clk;
// Stimulus
initial begin
   clk = 0;
   rst = 1;
   #10;
   rst = 0;
   // run enough time for full program execution
   #250;
   $finish;
end
endmodule