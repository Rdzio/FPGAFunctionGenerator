`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.06.2025 22:13:36
// Design Name: 
// Module Name: Serializer_8_to_1_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Serializer_8_to_1_TB;

    reg CLKin = 0;
    reg CLKDIVin = 0;
    reg CE = 0;
    reg RESET = 0;
    reg Load = 0;
    reg [7:0] Data = 8'b0;
    wire Q;

    // Clock generation
    always #1 CLKin = ~CLKin; // 500 MHz
    always #4 CLKDIVin = ~CLKDIVin; // 125 MHz

    // Instantiate the DUT
    Serializer_8_to_1 uut (
        .CLKin(CLKin),
        .CLKDIVin(CLKDIVin),
        .CE(CE),
        .RESET(RESET),
        .Load(Load),
        .Data(Data),
        .Q(Q)
    );

    initial begin  
        #4;
        CE = 1;
        RESET = 1;

        #8;
        RESET = 0;
        
        #88;
        Load = 1;
        #8;
        Data = 8'h00;
        #8;
        Data = 8'h03;
        #8;
        Data = 8'h05;
        #8;
        Data = 8'h0e;
        #8;
        Data = 8'h13;
        #8;
        Data = 8'h35;
        #8;
        Data = 8'h5f;
        #8;
        Data = 8'he0;
        #8;
        Data = 8'h21;
        #8;
        Data = 8'h63;
        #8;
        Data = 8'ha5;
        #8;
        Data = 8'hee;
        #8;
        Data = 8'h33;
        #8;
        Data = 8'h55;
        #8;
        Data = 8'hff;
        #8;
        Data = 8'h01;
        #8;
        Data = 8'h02;
        #8;
        Data = 8'h06;
        #8;
        Data = 8'h0b;
        #320;

        // Finish simulation
        $finish;
    end

endmodule