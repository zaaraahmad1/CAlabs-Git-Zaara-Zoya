`timescale 1ns/1ps
module lab5_top(
    input clk,
    input reset_button,
    input [15:0] SW,      //FPGA switches
    output [15:0] LED     //FPGA LEDs
);

    wire rst_clean;
    wire [15:0] switch_value;
    wire [15:0] led_value;

    debouncer db(
        .clk(clk),
        .pbin(reset_button),
        .pbout(rst_clean)
    );

    switches sw(
        .clk(clk),
        .rst(rst_clean),
        .writeData({16'b0, SW}),   // lower 16 bits = switches
        .writeEnable(1'b1),        // always load
        .readEnable(1'b0),
        .memAddress(30'b0),
        .readData(),
        .leds(switch_value)
    );

    fsm_counter fsm(
        .clk(clk),
        .rst(rst_clean),
        .switch_in(switch_value),
        .led_out(led_value)
    );

    leds ledmod(
        .clk(clk),
        .rst(rst_clean),
        .btns(16'b0),
        .writeData(32'b0),
        .writeEnable(1'b0),
        .readEnable(1'b0),
        .memAddress(30'b0),
        .switches(led_value),
        .readData()
    );

    assign LED = led_value;

endmodule
 