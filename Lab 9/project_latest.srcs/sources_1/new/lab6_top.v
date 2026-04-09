`timescale 1ns / 1ps

module lab6_top(

    input clk,
    input rst_btn,
    input [15:0] sw_phys,

    output [15:0] led_phys,
    output [6:0] seg,
    output [3:0] an

);
wire clean_rst;
wire [15:0] sw_data;
wire [3:0] ALUControl;
wire [31:0] ALUResult;
wire Zero;
wire [15:0] fsm_out;
wire [31:0] A = 32'h10101010;
wire [31:0] B = 32'h01010101;

debouncer db(
    .clk(clk),
    .pbin(rst_btn),
    .pbout(clean_rst)
);
switches sw_inst(
    .clk(clk),
    .rst(clean_rst),
    .writeData({16'b0,sw_phys}),
    .writeEnable(1'b1),
    .readEnable(1'b0),
    .memAddress(30'b0),
    .readData(),
    .leds(sw_data)
);
assign ALUControl = sw_data[3:0];
ALU alu_inst(
    .A(A),
    .B(B),
    .ALUControl(ALUControl),
    .ALUResult(ALUResult),
    .Zero(Zero)
);
fsm_counter fsm_inst(
    .clk(clk),
    .rst(clean_rst),
    .switch_in(ALUResult[15:0]),
    .led_out(fsm_out)
);
leds led_inst(
    .clk(clk),
    .rst(clean_rst),
    .btns(16'b0),
    .writeData(32'b0),
    .writeEnable(1'b0),
    .readEnable(1'b0),
    .memAddress(30'b0),
    .switches(ALUResult[15:0]),
    .readData()
);
sevenseg_basys3 display(
    .clk(clk),
    .value(ALUResult[15:0]),
    .seg(seg),
    .an(an)
);
assign led_phys[14:0] = ALUResult[14:0];
assign led_phys[15] = Zero;

endmodule