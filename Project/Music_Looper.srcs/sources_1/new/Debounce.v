`timescale 1ns / 1ps

module Debounce(
    input clk, input rst,
    input [3:0] btn_in,         // Buttons to debounce
    output reg [3:0] btn_out    // Debounced Buttons
    );

    reg [12:0] cnt0=0, cnt1=0, cnt2=0, cnt3=0;
    reg [3:0] state = 0;     // Buttons States
    parameter Time = 4000;  // 0.00004s

    always @ (posedge(clk))begin
        if(rst == 1) begin    // Reset
            cnt0<=0; cnt1<=0; cnt2<=0; cnt3<=0; btn_out<=0; end
        else begin  // Debounce
            if (btn_in[0] == state[0]) begin   // Button 0
                if (cnt0 == Time) begin
                    btn_out[0]<=state[0]; end
                else begin
                    cnt0<=cnt0+1; end end
            else begin
                cnt0<=0; state[0]<=btn_in[0]; end

            if (btn_in[1] == state[1]) begin   // Button 1
                if (cnt1 == Time) begin
                    btn_out[1]<=state[1]; end
                else begin
                    cnt1<=cnt1+1; end end
            else begin
                cnt1<=1; state[1]<=btn_in[1]; end

            if (btn_in[2] == state[2]) begin   // Button 2
                if (cnt2 == Time) begin
                    btn_out[2]<=state[2]; end
                else begin
                    cnt2<=cnt2+1; end end
            else begin
                cnt2<=0; state[2]<=btn_in[2]; end
            
            if (btn_in[3] == state[3]) begin   // Button 3
                    if (cnt3 == Time) begin
                        btn_out[3]<=state[3]; end
                    else begin
                        cnt3<=cnt3+1; end end
                else begin
                    cnt3<=0; state[3]<=btn_in[3]; end
        end end
endmodule