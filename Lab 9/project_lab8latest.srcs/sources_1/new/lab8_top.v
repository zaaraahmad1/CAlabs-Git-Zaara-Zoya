`timescale 1ns / 1ps

module lab8_top(
    input clk,
    input rst,
    input [15:0] sw,
    input btnC,
    input btnU,
    output [15:0] led
);

wire [31:0] address;
wire [31:0] writeData;

assign address   = {16'b0, sw};
assign writeData = {16'b0, sw};

wire clean_write;
wire clean_read;

debouncer db_write(
    .clk(clk),
    .pbin(btnC),
    .pbout(clean_write)
);

debouncer db_read(
    .clk(clk),
    .pbin(btnU),
    .pbout(clean_read)
);

wire readEnable;
wire writeEnable;

assign writeEnable = clean_write;
assign readEnable  = clean_read;

wire [31:0] readData;
wire [15:0] led_internal;

addressDecoderTop uut(
    .clk(clk),
    .rst(rst),
    .address(address),
    .readEnable(readEnable),
    .writeEnable(writeEnable),
    .writeData(writeData),
    .switches(sw),
    .readData(readData),
    .leds(led_internal)
);

assign led = led_internal;

endmodule