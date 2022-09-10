`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////
// This module utilized a module called 'mem_control' in a Git project
// named 'Looper'. The Core Code of that module remains untouched.
////////////////////////////////////////////////////////////////////////////
module Memory_Control(
    input clk100,           // Clk
    input rst,              // Reset signal
    input [7:0] play,       // Playing bank
    input [7:0] record,     // Recording bank
    input [2:0] delBank,    // Bank to delete
    input delete,           // Delete flag
    input [22:0] maxBlock,  // Max block 
    
    output reg deleted,     // Deleted flag
    output reg RamCEn,      // Ram en
    output reg RamOEn,      // Ram read en
    output reg RamWEn,      // Ram write en
    output reg writeZero,   // Write nothing flag
    output reg getData,     // Data in flag
    output reg dataReady,   // Data ready flag
    output reg mixData,     // Mix data flag
    output reg [22:0] addrblock44khz,   // Address block
    output [22:0] mem_block_addr,       // Memory address
    output reg [2:0] mem_bank           // Bank operating now
    );
    
    // To Generate 44.1Khz pulse
    parameter MHz44cnt = 2268;
    
    // Memory State Machine States
    parameter BANK = 4'b0000;       parameter FLAG = 4'b0010;
    parameter BANK_ACK = 4'b0001;   parameter INC_BLOCK = 4'b0011;
    parameter WAIT = 4'b0111;       parameter DELETE = 4'b0100;
    parameter DELETE_ACK = 4'b0101; parameter DELETE_INC = 4'b0110;
    parameter ONECYCLE = 4'b1000;   parameter ENTERDELETE = 4'b1010;
    parameter LEAVEDELETE = 4'b1001;
    
    // Initial
    initial deleted = 0;        // IsDeleted = False
    initial writeZero = 0;      // Write_zero = False
    initial getData = 0;        // Get_data = False
    initial dataReady = 0;      // Data_ready = False
    initial mixData=0;          // Mix_data = False
    initial mem_bank=0;         // Bank = 0
    initial addrblock44khz = 0; // Address = 0
    integer counter = 0;        // Delay counter
    
    // Address Flag
    wire address_enable;
    assign address_enable = play || record;
    
    // Reg to be Used
    reg [4:0] pstate = WAIT;    // Present state
    reg [3:0] nstate = BANK;    // Next state
    reg [12:0] count = 0;       // Generate 44.1khz count
    reg WEn_d1=1;               // Write en
    reg pulse = 0;              // 44.1khz pulse
    reg increment = 0;          // Address increment flag
    reg delay_done = 0;         // Delay_done flag
    reg counterEnable = 0;      // Start founter flag
    reg [22:0] delete_address=0;// Address of memory to be delete
    reg [22:0] max_delete_block=0;  // Address of bank to be delete
    
    // Mem_block Address Is Driven To Delete_address Only If WriteZero Is True
    assign mem_block_addr = (writeZero == 0) ? addrblock44khz : delete_address;
    
    // Generates 44.1Khz Pulse -> Change Address Block
    always @ (posedge(clk100)) begin
        if (rst == 1) begin
            count <= 0; pulse <= 0; end
        else if (count < MHz44cnt) begin
            count <= count + 1; pulse <= 0; end
        else begin  // Count is at max, triggers every 44.1KHz
            pulse <= 1; count <= 0; end
    end
        
    // 44Khz Block Incrementer
    always @ (posedge(clk100)) begin
        if (rst == 1) begin
            addrblock44khz<=0; end
        else if (address_enable == 0) begin // No playing or recording
            addrblock44khz<=0; end
        else if (increment == 1) begin      // Increse address block
            if(maxBlock==0 || addrblock44khz < maxBlock) begin
                addrblock44khz <= addrblock44khz + 1; end
            else begin
                addrblock44khz <= 0; end end
    end
    
    // Write Signal
    always @(posedge(clk100)) begin
        RamWEn<=WEn_d1;
    end
    
    // Delay -> Give Time For Delete/Write/Mix
    always @(posedge clk100) begin
        if (counterEnable == 0) begin
            counter <= 0; delay_done <= 0; end
        else if(counter < 60) begin
            counter <= counter + 1; delay_done <= 0; end
        else begin
            counter <= 0; delay_done <= 1; end
    end     
    
    // Memory State Machine
    always @ (posedge clk100) begin
        if (rst == 1) begin
            pstate <= WAIT;     counterEnable <= 0;
            writeZero <= 0;     getData<=0;
            dataReady<=0;       mem_bank<=0;    end
        else begin
            if (pulse == 1)
                nstate <= LEAVEDELETE;
            case (pstate)
                BANK : begin
                    if (mem_bank == 7)  nstate<=INC_BLOCK;  // One set of address end
                    else                nstate<=BANK;  
                    if (record[mem_bank] == 1) begin     // Recording
                        getData <= 1;   counterEnable <= 1;
                        RamCEn<=0;      RamOEn<=1;
                        WEn_d1<=0;      pstate<=BANK_ACK; end
                    else if (play[mem_bank] == 1) begin  // Playing
                        getData<=0;     RamCEn <= 0;
                        RamOEn <= 0;    WEn_d1 <= 1;
                        counterEnable <= 1; pstate<=BANK_ACK; end
                    else begin  // No need to move this bank
                        getData<=0;     RamCEn <= 1;
                        RamOEn <= 1;    WEn_d1 <= 1;
                        dataReady <= 1; pstate <= FLAG; end            
                end
                
                FLAG : begin    // No data on current bank
                    dataReady <= 0;
                    mem_bank <= mem_bank + 1;   // Increment bank by 1 after dataReady pulse
                    pstate <= nstate;
                end
                
                BANK_ACK : begin
                    getData<=0;    // Turn off get_data pulse
                    if (counter == 55)begin   // At 55 clock cycles, send dataReady pulse, turn off memory signals
                        dataReady<=1;  RamCEn<=1;
                        RamOEn<=1;      WEn_d1<=1;  end
                    else dataReady<=0;  // dataReady pulse stays low
                    if (delay_done == 1) begin  // Delay done, go to next bank
                        pstate <= nstate;
                        mem_bank <= mem_bank + 1;   // Increment bank by one
                        counterEnable <= 0;
                    end
                end
                
                INC_BLOCK: begin    // Block plus one, wait for pause
                    increment <= 1;     mixData<=1;
                    nstate <= WAIT;     pstate <= WAIT;
                end
                
                WAIT: begin     // Wait for pause or delete signal
                    mixData <= 0;
                    increment <= 0; // Stop incrementing addrblock44khz
                    if(pulse == 1)begin
                        pstate <= BANK; end
                    else if(delete == 1)begin
                        pstate <= ENTERDELETE; end
                    else 
                        pstate <= WAIT; end
    
                ENTERDELETE: begin  // Set max_delete_bloc to prepare
                    if (max_delete_block==0)begin
                        if (maxBlock==0)
                            max_delete_block<=mem_block_addr;
                        else
                            max_delete_block<=maxBlock;
                    end
                    nstate<=DELETE;
                    mem_bank<=delBank;      // Mem bank to delete_bank
                    writeZero <= 1;         // Write a 0 to erase data from memory
                    pstate<=DELETE;
                end
                
                DELETE : begin  // Prepare for delete, start delay
                    RamCEn <= 0;    RamOEn <= 1;
                    WEn_d1 <= 0;    counterEnable <= 1;
                    pstate <= DELETE_ACK;
                end
                     
                DELETE_ACK : begin  // Start deleting, end delay
                    if (delay_done == 1) begin
                        pstate <= DELETE_INC;
                        RamCEn <= 1;    RamOEn <= 1;
                        WEn_d1 <= 1;    counterEnable <= 0; end
                end 
                 
                DELETE_INC : begin  // Delete address plus one
                    if (delete_address < max_delete_block) begin    // Not done erasing
                        delete_address<=delete_address+1;
                        pstate <= nstate;   // Will either go to DELETE, 
                        // or will go to LEAVEDELETE if a pulse was triggered
                    end
                    else begin  // Done erasing 
                        deleted <= 1; // Delete signal on
                        delete_address<=0;
                        writeZero<=0;
                        max_delete_block<=0; 
                        mem_bank<=0;    
                        pstate <= ONECYCLE;  
                    end  
                end 
                             
                ONECYCLE: begin // Deleted signal reset, back to wait
                   deleted<=0; pstate <=WAIT;
                end
                
                LEAVEDELETE: begin  // Pause come, back to new bank
                    mem_bank<=0;
                    writeZero<=0;
                    counterEnable<=1;
                    if(delay_done==1)begin
                        counterEnable<=0;   pstate<=BANK; end
                end
        endcase 
    end end         
endmodule