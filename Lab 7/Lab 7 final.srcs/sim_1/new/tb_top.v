`timescale 1ns/1ps
 
module tb_top;
 
    reg clk;
    reg reset_button;
    reg [31:0] writeData;
    reg writeEnable;
    wire [15:0] switch_value;
    wire [15:0] led_value;

    switches sw(
        .clk(clk),
        .rst(reset_button),
        .writeData(writeData),
        .writeEnable(writeEnable),
        .readEnable(1'b0),
        .memAddress(30'b0),
        .readData(),
        .leds(switch_value)
    );

    fsm_counter fsm(
        .clk(clk),
        .rst(reset_button),
        .switch_in(switch_value),
        .led_out(led_value)
    );
 
    // clock generation
    always #5 clk = ~clk;
 
    initial begin
        clk = 0;
        reset_button = 1;
        writeEnable = 0;
        writeData = 0;

        #20 reset_button = 0;

        #20;
        writeData = 32'd5;   //5
        writeEnable = 1;
        #10 writeEnable = 0;

        #150;

        writeData = 32'd3;   //3
        writeEnable = 1;
        #10 writeEnable = 0;
 
        #120;

        // press reset during counting
          reset_button = 1;
        #20 reset_button = 0;
        #100;
        $finish;
    end
endmodule

 