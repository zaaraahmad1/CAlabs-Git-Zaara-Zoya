`timescale 1ns / 1ps

module MemorySystem_tb;

reg clk;
reg rst;
reg [31:0] address;
reg readEnable;
reg writeEnable;
reg [31:0] writeData;
reg [15:0] switches;

wire [31:0] readData;
wire [15:0] leds;

addressDecoderTop uut(
    .clk(clk),
    .rst(rst),
    .address(address),
    .readEnable(readEnable),
    .writeEnable(writeEnable),
    .writeData(writeData),
    .switches(switches),
    .readData(readData),
    .leds(leds)
);

always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;

    address = 0;
    readEnable = 0;
    writeEnable = 0;
    writeData = 0;

    switches = 16'h00AA;

    #10 rst = 0;

    // -------------------------
    // 1. WRITE TO MEMORY
    // address[9:8] = 00 ? memory
    // -------------------------
    #10
    address = 32'd100;        // memory region
    writeData = 32'hABCDEFAB;
    writeEnable = 1;

    #10 writeEnable = 0;

    // -------------------------
    // 2. READ FROM MEMORY
    // -------------------------
    #10
    readEnable = 1;

    #10 readEnable = 0;

    // -------------------------
    // 3. WRITE TO LEDS
    // address[9:8] = 01 ? LED
    // -------------------------
    #10
    address = 32'd300;        // IMPORTANT FIX (was wrong before)
    writeData = 32'h0000FFFF;
    writeEnable = 1;

    #10 writeEnable = 0;

    // -------------------------
    // 4. READ FROM SWITCHES
    // address[9:8] = 10 ? switches
    // -------------------------
    #10
    address = 32'd600;        // switch region
    readEnable = 1;

    #10 readEnable = 0;

    #20 $finish;

end

endmodule