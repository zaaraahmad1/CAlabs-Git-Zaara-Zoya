`timescale 1ns / 1ps

module addressDecoderTop(

    input clk,
    input rst,
    input [31:0] address,
    input readEnable,
    input writeEnable,
    input [31:0] writeData,
    input [15:0] switches,

    output [31:0] readData,
    output [15:0] leds
);

wire DataMemRead;
wire DataMemWrite;
wire LEDWrite;
wire SwitchRead;

wire [31:0] memReadData;
wire [31:0] switchData;

// -----------------------------
// Address Decoder
// -----------------------------
AddressDecoder decoder(
    .address(address),
    .readEnable(readEnable),
    .writeEnable(writeEnable),
    .DataMemRead(DataMemRead),
    .DataMemWrite(DataMemWrite),
    .LEDWrite(LEDWrite),
    .SwitchRead(SwitchRead)
);

// -----------------------------
// Data Memory
// -----------------------------
DataMemory mem(
    .clk(clk),
    .MemWrite(DataMemWrite),
    .MemRead(DataMemRead),
    .address(address),
    .write_data(writeData),
    .read_data(memReadData)
);

// -----------------------------
// Switch data (16 ? 32 bit)
// -----------------------------
assign switchData = {16'b0, switches};

// -----------------------------
// Read MUX
// -----------------------------
assign readData =
        (DataMemRead) ? memReadData :
        (SwitchRead)  ? switchData :
        32'b0;

// -----------------------------
// LED REGISTER (FINAL FIX)
// -----------------------------
reg [15:0] led_reg;

always @(posedge clk or posedge rst) begin
    if (rst)
        led_reg <= 16'b0;

    // WRITE to LED device
    else if (LEDWrite)
        led_reg <= writeData[15:0];

    // READ from memory or switches ? show result
    else if (DataMemRead || SwitchRead)
        led_reg <= readData[15:0];
end

assign leds = led_reg;

endmodule