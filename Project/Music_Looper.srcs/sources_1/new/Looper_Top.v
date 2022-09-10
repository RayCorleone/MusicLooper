`timescale 1ns / 1ps

module Looper_Top(
    input clk100, input rstn,                           // System
    input micData, output micClk, output micLRSel,      // Mic
    input btnL, input btnR, input btnD, input btnC,     // Buttons
    output audPWM, output audSD,                        // Audio
    output [7:0] led, output ledR, output ledG,         // LEDs
    output [7:0] an, output [6:0] seg,                  // 7 Segment
    
    // DDR2 Memory Signals ******************************
    output [12:0] ddr2_addr,// Address                  *
    output [2:0] ddr2_ba,   // Bank                     *
    output ddr2_ras_n,      // Row En                   *
    output ddr2_cas_n,      // Column En                *
    output ddr2_we_n,       // Write En                 *
    output ddr2_cke,        // Clk En                   *
    output ddr2_ck_p,       // Clk Posedge              *
    output ddr2_ck_n,       // Clk Negedge              *
    output ddr2_cs_n,       // Chip Select En           *
    output [1:0] ddr2_dm,   // High/Low Flag            *
    output ddr2_odt,        // On-Die Termination       *
    inout  [15:0] ddr2_dq,  // Data                     *
    inout  [1:0] ddr2_dqs_p,// Data Clk Posedge         *
    inout  [1:0] ddr2_dqs_n // Data Clk Negedge         *
    //***************************************************
    );

//******************** Part_00 -> Global *************************/
    // Reset
    wire rst;

    // Banks States
    wire [7:0] play;    // Banks playing
    wire [7:0] record;  // Banks recording
    wire [7:0] active;  // Banks recorded
    wire [2:0] nowBank; // Bank being operating
    wire [2:0] delBank; // Bank to delete
//****************************************************************/
//
//******************** Part_01 -> Prepare ************************/
    // Reset Button
    assign rst = ~rstn;
    
    // Generate 100 & 200MHz Clock
    clk_wiz_0 clk_1(
        .clk_in1(clk100),   // System clock
        .clk_out1(clk200),  // 200MHz clock
        .locked()           // Status signals  
    );
    
    // Generate Debounced Buttons
    wire [3:0] tempBtn;
    assign tempBtn = {btnR, btnC, btnD, btnL};
    wire [3:0] btns;    // Debounced buttons
    Debounce debounce(
        .clk(clk100),       // Clk
        .rst(rst),          // Reset
        .btn_in(tempBtn),   // Buttons
        .btn_out(btns)      // Debounced buttons
        );
//****************************************************************/
//
//******************** Part_02 -> Memory *************************/
    // RAM Memory Signals ************************               //
    wire mem_ub;            // RAM high bits    *                //
    wire mem_lb;            // RAM low bits     *                //
    wire mem_cen;           // RAM en           *                //
    wire mem_oen;           // RAM read en      *                //
    wire mem_wen;           // RAM write en     *                //
    wire [2:0] mem_bank;    // Bank             *                //
    wire [26:0] mem_a;      // Address          *                //
    wire [15:0] mem_dq;     // Data wire        *                //
    wire [15:0] mem_dq_i;   // Data in          *                //
    wire [15:0] mem_dq_o;   // Data out         *                //
    //********************************************               //
                                                                 //
    // Temp Data In DDR2                                         //
    wire [11:0] chipTemp;                                        //
    assign chipTemp = 12'b0;                                     //
                                                                 //
    // Memory Signal Initial                                     //
    assign mem_ub = 0;                                           //
    assign mem_lb = 0;                                           //
    assign mem_a[26] = 1'b0;                                     //
                                                                 //
    // Memory Instantiation                                      //
    Ram2Ddr Ram(                                                 //
        .clk_200MHz_i(clk200),          // Clk 200MHz            //
        .rst_i(rst),                    // Reset                 //
        .device_temp_i(chipTemp),       // Temp data             //
                                                                 //
        .ram_ub(mem_ub), .ram_lb(mem_lb),                        //
        .ram_a(mem_a), .ram_dq_i(mem_dq_i),                      //
        .ram_oen(mem_oen), .ram_wen(mem_wen),                    //
        .ram_dq_o(mem_dq_o), .ram_cen(mem_cen),                  //
                                                                 //
        .ddr2_odt(ddr2_odt), .ddr2_dq(ddr2_dq),                  //
        .ddr2_addr(ddr2_addr), .ddr2_ba(ddr2_ba),                //
        .ddr2_cs_n(ddr2_cs_n), .ddr2_dm(ddr2_dm),                //
        .ddr2_ck_n(ddr2_ck_n), .ddr2_cke(ddr2_cke),              //
        .ddr2_we_n(ddr2_we_n), .ddr2_ck_p(ddr2_ck_p),            //
        .ddr2_ras_n(ddr2_ras_n), .ddr2_cas_n(ddr2_cas_n),        //
        .ddr2_dqs_p(ddr2_dqs_p), .ddr2_dqs_n(ddr2_dqs_n)         //
        );                                                       //
//****************************************************************/
//
//******************** Part_03 -> Input **************************/
    // Mic Clock
    reg [3:0] clkCnt = 0;   // 16 count
    always@(posedge(clk100)) begin
        if(clkCnt >= 4'b1111)begin
            clkCnt <= 0; end
        else
            clkCnt <= clkCnt + 1;
    end   
    assign micClk = clkCnt[3];
    
    // Mic Left & Right
    assign micLRSel = 0;

    // Mic Input Data
    wire [15:0] auxIn;
    Mic_Input mic_input(
        .micData(micData),
        .Clk(clk100),
        .aux_data(auxIn)
    );
//****************************************************************/
//
//******************** Part_04 -> Control ************************/
    // Flags
    wire delete;        // Delete flag
    wire deleted;       // Deleted flag
    wire mixData;       // Mix flag
    wire dataFlag;      // Recording flag
    wire dataReady;     // Recorded flag
    wire writeZero;     // Write nothing flag
    wire setMaxBlock;   // Set_max flag
    wire rstMaxBlock;   // Reset_max flag

    // Block States
    reg [22:0] maxBlock = 0;    // Max Memory Block
    wire [22:0] nowBlock;       // Block being operating
    wire [22:0] block44KHz;     // 44.1KHz block

    // Memory Address Control
    assign mem_a [25:0] = (nowBlock << 3) + mem_bank;   // Block * 8 + Bank

    // Mic Data Latch Control
    reg [15:0] sound;
    always@(posedge(clk100)) begin
        if (dataFlag == 1)begin
            sound <= auxIn; end
    end
    assign mem_dq_i = (writeZero==0) ?  sound : 16'h0000;

    // Max Memory Block Set & Reset Control
    always @ (posedge(clk100)) begin
        if (rstMaxBlock == 1) begin     // Reset max
            maxBlock<=0; end
        else if(setMaxBlock == 1) begin // Set max
            maxBlock<=nowBlock; end
    end
    
    // Loop Control
    Main_Control main_control(
        .clk100(clk100),        // Clk
        .rst(rst),              // Reset
        .btns(btns),            // Buttons
        .deleted(deleted),      // Deleted flag
        .nowMax(maxBlock),      // Max bolck
        
        .setMax(setMaxBlock),   // Set_max flag
        .rstMax(rstMaxBlock),   // Reset_max flag
        .play(play),            // Playing banks
        .record(record),        // Recording banks
        .active(active),        // Actived banks
        .bank(nowBank),         // Bank being oprating
        .delete(delete),        // Belete flag
        .delBank(delBank)       // Bank to delete
        );

    // Memory Control ////////////////////////////
    Memory_Control memory_control(              //
        .clk100(clk100),                        // 
        .rst(rst),                              //
        .play(play),                            //
        .record(record),                        //
        .delete(delete),                        //
        .delBank(delBank),                      //
        .maxBlock(maxBlock),                    //
                                                //
        .deleted(deleted),                      //
        .RamCEn(mem_cen),                       //
        .RamOEn(mem_oen),                       //
        .RamWEn(mem_wen),                       //
        .writeZero(writeZero),                  //
        .getData(dataFlag),                     //
        .dataReady(dataReady),                  //
        .mixData(mixData),                      //
        .addrblock44khz(block44KHz),            //
        .mem_block_addr(nowBlock),              //
        .mem_bank(mem_bank)                     //
        );                                      //
//****************************************************************/
//
//******************** Part_05 -> Mixer **************************/
    // Data Mixing
    reg [7:0] PWM;
    reg [19:0] mix;
    reg [15:0] outBank;
    
    integer CH0=0, CH1=0, CH2=0, CH3=0, CH4=0;
    integer CH5=0, CH6=0, CH7=0, mixer=0;
    integer intMixer=0;
    
    always@(posedge(clk100)) begin
        outBank<=mem_dq_o; end
    
    always@(posedge(clk100)) begin
        if(dataReady==1)begin
            case(mem_bank)
                0: begin
                    if (play[0])    CH0 = outBank - 32767;
                    else            CH0 = 0; end
                1: begin
                    if (play[1])    CH1 = outBank - 32767;
                    else            CH1 = 0; end
                2: begin
                    if (play[2])    CH2 = outBank - 32767;
                    else            CH2 = 0; end
                3: begin
                    if (play[3])    CH3 = outBank - 32767;
                    else            CH3 = 0; end
                4: begin
                    if (play[4])    CH4 = outBank - 32767;
                    else            CH4 = 0; end
                5: begin
                    if (play[5])    CH5 = outBank - 32767;
                    else            CH5 = 0; end
                6: begin
                    if (play[6])    CH6 = outBank - 32767;
                    else            CH6 = 0; end
                7: begin
                    if (play[7])    CH7 = outBank - 32767;
                    else            CH7 = 0; end
                default:begin end
            endcase
    end end
    
    // Mixer State Machine
    reg [2:0] mixState=0;
    always@(posedge(clk100))begin
        case(mixState)
            0: begin
                if (mixData==1)     mixState<=1;
                else                mixState<=0;
            end
            1: begin
               intMixer<=(32767*(1+play[0]+play[1]+play[2]+play[3]+play[4]+play[5]+play[6]+play[7]));
               mixState<=2; end
            2: begin
                intMixer<=CH5+CH6+CH7+intMixer;
                mixState<=3; end
            3: begin
                mixer<=CH0+CH1+CH2+CH3+CH4+intMixer;
                mixState<=4; end
            4: begin
                mix<=(mixer<<1);
                mixState<=5; end
            5: begin
                PWM<=mix[19:12];
                mixState<=0; end
        endcase
    end
    
    assign audSD = 1'b1;
        
    // Output Trans PWM
    PWM_Trans pwm_trans(
        .clk(clk100),
        .PWM_in(PWM),
        .PWM_out(audPWM)
    );
//****************************************************************/
//
//******************** Part_06 -> Display ************************/
    // Time Count & Time Value
    parameter Tenhz = 10000000; // Time Count Max -> 0.1s
    reg [26:0] timerCnt=0;
    reg [11:0] timerVal=0;

    // Timer Shown On Seven Segment
    always @(posedge(clk100)) begin
        if (play|record) begin
            if (block44KHz == 0) begin
                timerVal<=0; timerCnt<=0; end
            else if (timerCnt < Tenhz) begin
                timerCnt<=timerCnt+1; end
            else begin
                timerCnt<=0; timerVal<=timerVal+1; end end
        else begin
            timerCnt<=0; timerVal<=0; end
    end

    // LEDs control
    assign led[7:0] = active[7:0];                  // Actived Banks LED
    assign ledR = ( record == 4'b0000 ) ? 0 : 1;    // Recording LED
    assign ledG = ( play == 4'b0000 ) ? 0 : 1;      // Playing LED

    // Seven Segment Display
    Light_Output light_output(
       .clk(clk100),.rst(rst),
       .an(an),.seg(seg),.timer(timerVal),
       .bank(nowBank),.record(record),.play(play),.active(active)
    );
//****************************************************************/    
endmodule