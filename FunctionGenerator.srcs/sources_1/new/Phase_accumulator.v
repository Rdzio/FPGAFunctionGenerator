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


module Phase_accumulator #(
    parameter PHASE_WIDTH = 32
)(
    input wire clk,
    input wire reset,
    input wire [PHASE_WIDTH-1:0] phase_inc, // phase increment input
    output reg [PHASE_WIDTH-1:0] phase_out  // full phase output
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            phase_out <= 0;
        else
            phase_out <= phase_out + phase_inc;
    end

endmodule
