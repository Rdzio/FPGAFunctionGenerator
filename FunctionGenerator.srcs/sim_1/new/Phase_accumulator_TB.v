`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.06.2025 17:03:30
// Design Name: 
// Module Name: Phase_accumulator_TB
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


module Phase_accumulator_TB;
    reg clk = 0, reset = 1;
    reg [31:0] phase_inc;
    wire [31:0] phase_out;

    dds_phase_accumulator uut (
        .clk(clk),
        .reset(reset),
        .phase_inc(phase_inc),
        .phase_out(phase_out)
    );

    always #5 clk = ~clk; // 100 MHz clock

    initial begin
        #10 reset = 0;
        phase_inc = 32'h10000000; // Adjust for desired freq
        #1000 $stop;
    end
endmodule

