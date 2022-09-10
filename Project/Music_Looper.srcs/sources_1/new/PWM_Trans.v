`timescale 1ns / 1ps

module PWM_Trans(
    input clk,
    input [7:0] PWM_in, 
    output reg PWM_out
    );
    
    reg [7:0] temp_pwm = 0;
    reg [7:0] pwm_counter = 0;
    
    always @(posedge clk) begin
        if (pwm_counter >= 7'b1111111) begin
            pwm_counter<=0; temp_pwm<=PWM_in; end
        else
            pwm_counter <= pwm_counter + 1'b1;
    end
    
    wire [7:0] br_counter;
    genvar k;
    generate for(k=0; k<8; k=k+1)
    begin : bit_reversal_loop
        assign br_counter[k] = pwm_counter[7-k];
    end endgenerate
    
    always@(posedge clk) begin
        PWM_out <= (temp_pwm>=br_counter);
    end
endmodule