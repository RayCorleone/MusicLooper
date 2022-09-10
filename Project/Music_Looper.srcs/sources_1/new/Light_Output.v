`timescale 1ns / 1ps

module Bin_To_Decimal(  // 2 -> 10
	input [11:0] b,                // 12 bits
	output reg [15:0] decimals     // 16 (4*4) bits
	);
	
	integer i;

    always @(b) begin
        decimals = 0;
        for(i = 11; i >= 0; i = i-1) begin
            if (decimals[15:12]>4)  decimals[15:12]=decimals[15:12]+3;
            if (decimals[11:8]>4)   decimals[11:8]=decimals[11:8]+3;
            if (decimals[7:4]>4)    decimals[7:4]=decimals[7:4]+3;
            if (decimals[3:0]>4)    decimals[3:0]=decimals[3:0]+3;
            decimals = {decimals[14:0], b[i]};
        end         
    end
endmodule

module Seg_Decoder(  // 7 Seg Display
	input [4:0] in,
	output reg [6:0] out  
    );
    
    always @(in)
        case (in)
          5'h0: out = 7'b1000000;     5'h1: out = 7'b1111001;
          5'h2: out = 7'b0100100;     5'h3: out = 7'b0110000;
          5'h4: out = 7'b0011001;     5'h5: out = 7'b0010010;
          5'h6: out = 7'b0000010;     5'h7: out = 7'b1111000;
          5'h8: out = 7'b0000000;     5'h9: out = 7'b0011000;
          5'hA: out = 7'b0001000;     5'hB: out = 7'b0000011;
          5'hC: out = 7'b1000110;     5'hD: out = 7'b0100001;
          5'hE: out = 7'b0000110;     5'hF: out = 7'b0001110;
          5'h10: out = 7'b0101111;    5'h11: out = 7'b0001100;
          5'h12: out = 7'b0000110;    5'h13: out = 7'b1111111;
          default: out = 7'b1001001;
        endcase
endmodule

module Mux38(   // Send Data To Seg
    input [4:0] I0, I1, I2, I3,
    input [4:0] I4, I5, I6, I7,
    input  [2:0] Sel,
    output [4:0] Out
); 
    assign Out = ( Sel == 0 )? I0 : ( Sel == 1 )? I1 : ( Sel == 2 )? I2 : ( Sel == 3 )? I3 : ( Sel == 4 )? I4 :( Sel == 5 )? I5 :( Sel == 6 )? I6 : I7;
endmodule

module Seg_Clk_Divider( // Clk Divide 10kHz
    input clk,  input rst,
    output reg clk_div
    );
         
     localparam constantNumber = 10000;
     reg [31:0] count;
     
    always @ (posedge(clk), posedge(rst)) begin
        if (rst == 1'b1)
            count <= 32'b0;
        else if (count == constantNumber - 1)
            count <= 32'b0;               
        else
            count <= count + 1;
    end
    
    always @ (posedge(clk), posedge(rst)) begin
        if (rst == 1'b1)
            clk_div <= 1'b0;
        else if (count == constantNumber - 1)
            clk_div <= ~clk_div;
        else
            clk_div <= clk_div;
    end
endmodule

module Counter(     // Count Select Signal
    input clk, input rst,
    output reg [2:0] Q
    );
    always @ (posedge(clk)) begin
        if (rst == 1'b1)    Q <= 3'b0;
        else                Q <= Q + 1'b1;
    end
endmodule

module Decoder38 (  // Deside Which Seg Light Up
    input [2:0] I,
    output [7:0] an
    );
    assign an[0] = ~(~I[2] & ~I[1] & ~I[0]);
    assign an[1] = ~(~I[2] & ~I[1] & I[0]);
    assign an[2] = ~(~I[2] & I[1] & ~I[0]);
    assign an[3] = ~(~I[2] & I[1] & I[0]);
    assign an[4] = ~(I[2] & ~I[1] & ~I[0]);
    assign an[5] = ~(I[2] & ~I[1] & I[0]);
    assign an[6] = ~(I[2] & I[1] & ~I[0]);
    assign an[7] = ~(I[2] & I[1] & I[0]);
endmodule

module Light_Output(
    input [2:0] bank,                                       // Banks
    input [7:0] record, play, active,                       // Bank States
    input clk, input rst,                                   // System Signal
    output [7:0] an, output [6:0]seg, input [11:0] timer   // Show On 7 Seg
    );
    
    wire [15:0] BCD;
    wire [4:0] dig4,dig5,dig6,dig7;
    
    // 5'h10->r     5'h11->P    5'h12->E    5'h5->S     5'h13->None  5'hB ->b
    assign dig4 = (record[bank]==1)? 5'h10 : (play[bank]==1)? 5'h11: (active[bank]==1) ? 5'h5: 5'h12;
    assign dig5 = 5'h13;            // Nothing
    assign dig6 = {2'b00, bank};    // Now bank
    assign dig7 = 5'hB;             // 'b' for bank
    
    wire segClk;
    wire [4:0] number;  // Store temp val on seg
    wire [2:0] select;  // Select seg to shine
    
    Bin_To_Decimal bin_to_decimal (   // Change Time Bin To BCD
        .b(timer), .decimals(BCD));
    
    Seg_Clk_Divider seg_clk_divider (   // Generate 10kHz Clk
        .clk(clk),.rst(rst),.clk_div(segClk));

    Counter counter (   // Generate Select Signal
        .clk(segClk),.rst(rst),.Q(select[2:0]));

    Mux38 mux38 (      // Select Data To Seg
        .I0({1'b0,BCD[3:0]}),.I1({1'b0,BCD[7:4]}),.I2({1'b0,BCD[11:8]}),.I3({1'b0,BCD[15:12]}),
        .I4(dig4[4:0]),.I5(dig5[4:0]),.I6(dig6[4:0]),.I7(dig7[4:0]),.Sel(select[2:0]), 
        .Out(number[4:0]));
    
    Seg_Decoder seg_decoder (   // Generate Seg Signal
        .in(number[4:0]),.out(seg[6:0]));
        
    Decoder38  decoder38 (      // Decide Which One Work
        .I(select[2:0]),.an(an[7:0]));
endmodule