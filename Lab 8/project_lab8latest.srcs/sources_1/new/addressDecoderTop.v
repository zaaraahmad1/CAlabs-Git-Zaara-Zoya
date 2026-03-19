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
wire [31:0] switchReadData;
wire [15:0] led_out;

AddressDecoder decoder(
    .address(address),
    .readEnable(readEnable),
    .writeEnable(writeEnable),
    .DataMemRead(DataMemRead),
    .DataMemWrite(DataMemWrite),
    .LEDWrite(LEDWrite),
    .SwitchRead(SwitchRead)
);

DataMemory mem(
    .clk(clk),
    .rst(rst),
    .MemWrite(DataMemWrite),
    .MemRead(DataMemRead),
    .address(address),
    .write_data(writeData),
    .read_data(memReadData)
);

switches sw_inst(
    .clk(clk),
    .rst(rst),
    .btns(16'b0),
    .writeData(32'b0),
    .writeEnable(1'b0),
    .readEnable(1'b1),
    .memAddress(address[31:2]),
    .switches(switches),
    .readData(switchReadData)
);

leds led_inst(
    .clk(clk),
    .rst(rst),
    .writeData(writeData),
    .writeEnable(LEDWrite),
    .readEnable(1'b0),
    .memAddress(address[31:2]),
    .readData(),
    .leds(led_out)
);

assign leds = led_out;

assign readData =
        (DataMemRead) ? memReadData :
        (SwitchRead)  ? switchReadData :
        32'b0;

endmodule