`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2025 18:06:36
// Design Name: 
// Module Name: sample_distributor
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


module sample_distributor (
    input  wire        clk,         // zegar LS_CLK - taktuje rejestracjê
    input  wire [63:0] sample_in,   // dane z pamiêci (8 × 8 bitów)
    output reg  [7:0]  ch0,
    output reg  [7:0]  ch1,
    output reg  [7:0]  ch2,
    output reg  [7:0]  ch3,
    output reg  [7:0]  ch4,
    output reg  [7:0]  ch5,
    output reg  [7:0]  ch6,
    output reg  [7:0]  ch7
);

    always @(posedge clk) begin
        ch0 <= sample_in[7:0];
        ch1 <= sample_in[15:8];
        ch2 <= sample_in[23:16];
        ch3 <= sample_in[31:24];
        ch4 <= sample_in[39:32];
        ch5 <= sample_in[47:40];
        ch6 <= sample_in[55:48];
        ch7 <= sample_in[63:56];
    end

endmodule