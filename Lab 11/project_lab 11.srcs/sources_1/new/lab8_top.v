`timescale 1ns / 1ps

module lab8_top(

    input clk,
    input rst,
    input [15:0] sw,
    input btnC,   // write
    input btnU,   // read

    output [15:0] led

);

wire [31:0] address;
wire [31:0] writeData;

// -----------------------------
// Use switches as address/data
// -----------------------------
assign address   = {16'b0, sw};
assign writeData = {16'b0, sw};

// -----------------------------
// Debounce buttons
// -----------------------------
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

// -----------------------------
// Memory system
// -----------------------------
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

// -----------------------------
// Output LEDs
// -----------------------------
assign led = led_internal;

endmodule