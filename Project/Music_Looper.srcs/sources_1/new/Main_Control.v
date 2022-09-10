`timescale 1ns / 1ps

module Main_Control(
    input clk100,               // Clk
    input rst,                  // Reset Signal
    input [3:0] btns,           // Buttons = [0-back, 1-stop/delete, 2-play/record, 3-next]
    input deleted,              // Deleted Flag
    input [22:0] nowMax,        // Current Max Block
    
    output reg setMax,          // Set_max Flag
    output reg rstMax,          // Reset_max Flag
    output reg [7:0] play,      // Playing Banks
    output reg [7:0] record,    // Recording Banks
    output reg [7:0] active,    // Actived Banks
    output reg [2:0] bank,      // The Bank Being Oprating (0-8)
    output reg delete,          // Delete Flag
    output reg [2:0] delBank    // Bank to Delete
    );
    
    // Button Refference
    `define BACK 0
    `define STOP 1
    `define PLAY 2
    `define FORWARD 3
    
    // Delete Counter Max
    parameter count_max = 150000000;    // Press for 1.5s
    
    // Loop State Machine States
    parameter DEFAULT = 4'b0000;    parameter PLAY =   4'b0001;
    parameter RECORD = 4'b0010;     parameter DELETE = 4'b0011;
    parameter STOP =   4'b0100;     parameter PBTNDB = 4'b0101;
    parameter PDELBTNDB = 4'b0110;  parameter DELETEOTHERS = 4'b0111;
    parameter DEFAULT_DB = 4'b1000;
    
    // Initial
    initial delete = 1'b0;          // Delete flag = flase
    initial delBank = 1'b0;         // Delete bank = 0
    initial play = 8'b00000000;     // Playing Bank = 0
    initial record = 8'b00000000;   // Recording Bank = 0
    initial active = 8'b00000000;   // Actived Bank = 0
    initial bank = 3'b000;          // The Bank Being Oprating = 0
        
    // Delete Hold Timer
    reg [27:0] counter = 0;     // Delete Counter
    reg delay_en = 0;           // Delete Count Start Flag
    reg delay_done = 0;         // Delete Count Finish Flag
    always @(posedge (clk100)) begin
        if (delay_en==0) begin
            counter <= 0; delay_done <= 0; end
        else if (counter < count_max) begin
            counter <= counter + 1; delay_done <= 0; end
        else begin
            counter <= 0; delay_done <= 1; end
    end
    
    // Main Loop State Machine
    reg [3:0] pstate = DEFAULT; // State Machine (Present)
    reg [3:0] nstate = DEFAULT; // State Machine (Next)
    always @(posedge (clk100)) begin
        if (rst == 1) begin // If Reset:
            pstate <= DEFAULT;  // Restart State Machine
            rstMax <= 1;        // Reset_max = True
            setMax <= 0;        // Set_max = False
            delay_en <= 0;      // Delete Count Start = False
            delete <= 1'b0;     // Delete Flag = False
            delBank <= 1'b0;    // Delete Bank = 0
            active <= 8'b00000000;      play <= 8'b00000000;
            record <= 8'b00000000;      bank <= 3'b000; end
        else begin
            if (deleted) begin
                delete <= 1'b0; end
            case (pstate)
                DEFAULT: begin // Default State
                    rstMax <= 0;  setMax <= 0;
                    if((btns[`BACK] == 1)) begin        // Back bank button pressed
                        bank<=bank-1;
                        pstate <= DEFAULT_DB; end
                    else if (btns[`FORWARD] == 1) begin // Forward bank button pressed
                        bank<=bank+1;
                        pstate <= DEFAULT_DB; end
                    else if (btns[`STOP] == 1) begin    // Stop/Delete button pressed
                        pstate <= STOP; end
                    else if (btns[`PLAY] == 1) begin    // Play/Record button pressed
                        if (active[bank] == 0)  // The current bank is not recorded on yet
                            pstate <= RECORD;       //So record onto it
                        else begin              //The current bank is recorded on already
                            if (play[bank] == 0) //If the current bank is not playing
                                pstate <= PLAY;
                            else                    //The current bank is playing already
                                pstate <= RECORD;
                        end end end //End DEFAULT
                
                DEFAULT_DB: begin   // Default_debounce State
                    if (btns == 0)  // Wait until button is released
                        pstate <= DEFAULT;  end
                
                PLAY: begin // To Play State
                    play[bank] <= 1;
                    record[bank] <= 0;
                    setMax <= 0;
                    if (btns[`PLAY] == 0) // Wait until button is released
                        pstate <= nstate; end
                
                RECORD: begin   // To Record State
                    record[bank] <= 1;
                    play[bank] <= 0;
                    if (btns[`PLAY] == 0) begin // Play button is released, go to the db state
                        pstate <= PBTNDB; end
                    else if (btns[`STOP]) begin // Play button is still hold & Press Stop
                        pstate <= DELETE; end end
                
                PBTNDB: begin   // Play button is released (is recording)
                    if (btns[`STOP] == 1)   // Stop button pressed, delete the bank
                        pstate<=DELETE;
                    else if (btns[`PLAY] == 1) begin // Play button is pressed again
                        active[bank] <= 1;  // This bank is now active
                        if (nowMax == 0) begin // If there is no other banks recorded on (max is 0 still) delete the other banks!
                            setMax<=1;           // Set max = True
                            delBank<=bank+1;  // Delete the other banks
                            delete<=1;            // Delete = True
                            nstate<=DELETEOTHERS; // After the play state, we will go to the DELETEOTHERS state instead of default
                        end
                        pstate<=PLAY; end end  //Then go to PLAY state to start the track
                
                DELETEOTHERS: begin // Delete others State (when current_max = 0)
                    nstate<=DEFAULT;    // Reset nstate
                    if (delete == 0) begin  // If done deleting
                        delBank=delBank+1;  // Increment delete_bank
                        if (active[delBank] == 0) begin // If the new bank isn't recorded on
                            delete<=1; end  // Delete the old data on that bank
                        else    // If the new bank is recorded on, we know it is the first loop, so return
                            pstate<=DEFAULT; end end
                
                DELETE: begin   // Detelt State
                    delete <= 1;
                    delBank <= bank;
                    record[bank] <= 0;
                    active[bank] <= 0;
                    pstate <= PDELBTNDB; end
                
                PDELBTNDB: begin    // Detelt db State
                    if (active == 8'b00000000) begin    // All of the banks are erased
                        rstMax <= 1; end // Reset_max flag = True
                    if (btns[`STOP] == 0)   // Debounce, wait until the stop button is released
                        pstate<=DEFAULT; end
                
                STOP: begin
                    delay_en <= 1;      // Start delay counter
                    play[bank] <= 0; // Stop playing the bank
                    if (btns[`STOP] == 0) begin     //If the stop button is released before 1.5s
                        delay_en <= 0;                  // Stop and reset the delete counter
                        pstate <= DEFAULT; end          // Return to DEFAULT
                    else if (delay_done == 1) begin //If the stop button is held for 1.5s,(delete)
                        delay_en <= 0;                  // Turn off the delete counter
                        pstate <= DELETE; end end       // Delete the bank
            endcase
    end end
endmodule