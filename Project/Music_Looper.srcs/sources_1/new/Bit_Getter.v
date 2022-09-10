`timescale 1ns / 1ps

module Bit_Getter(
    input clk_100MHz,
    input micData,
    output reg pwm_val
    );
    
    parameter kHZ_Cnt = 5120;    // 16*320
    parameter Begin_kHZ_Cnt = 0;
    parameter least_value = 2720;  // 16*170

    reg [12:0] begin_Cnt=0;
    reg [12:0] micInUse_Cnt=0;
    reg [12:0] micInUse=0;

    always@(posedge(clk_100MHz))begin
        if(begin_Cnt>=Begin_kHZ_Cnt)begin
            if(micInUse_Cnt>=kHZ_Cnt)begin
                micInUse_Cnt <= 0;
                pwm_val <= (micInUse < least_value) ? 0:1;
                micInUse <= 0; end
            else begin
                micInUse_Cnt <= micInUse_Cnt + 1;
                micInUse <= micInUse + micData; end end
        else begin begin_Cnt <= begin_Cnt + 1; end
    end
endmodule
