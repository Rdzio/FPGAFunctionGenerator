`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.06.2025 17:01:48
// Design Name: 
// Module Name: Phase_accumulator
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


module phase_accumulator #(
    parameter ADDR_WIDTH = 13       // 8192 próbek => 13-bitowy adres
)(
    input  wire                 clk,          // LS_CLK
    input  wire                 reset,        // reset synchroniczny
    input  wire [ADDR_WIDTH-1:0] phase_step,  // krok fazowy
    output reg  [ADDR_WIDTH-1:0] addr         // adres wyjœciowy do pamiêci
);

    reg [ADDR_WIDTH-1:0] phase_acc;

    always @(posedge clk) begin
        if (reset) begin
            phase_acc <= 0;
        end else begin
            phase_acc <= phase_acc + phase_step;
        end
    end

    always @(*) begin
        addr = phase_acc;
    end

endmodule
