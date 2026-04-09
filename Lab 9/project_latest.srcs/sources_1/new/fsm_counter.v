module fsm_counter(
    input clk,
    input rst,
    input [15:0] switch_in,
    output reg [15:0] led_out
);
 
    parameter WAIT = 1'b0, COUNT = 1'b1;
    reg state;
    reg [15:0] counter;
 
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state   <= WAIT;
            counter <= 0;
            led_out <= 0;
        end
 
        else begin
            case(state)
            WAIT: begin
                led_out <= 0;
                if (switch_in != 0) begin
                    counter <= switch_in;
                    led_out <= switch_in;
                    state   <= COUNT;
                end
            end
 
            COUNT: begin
                led_out <= counter;
                if (counter > 0)
                    counter <= counter - 1;
                else
                    state <= WAIT;
            end
            endcase
        end
    end
endmodule

 