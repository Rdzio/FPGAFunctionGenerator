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


module phase_accumulator_tb;

    // Parameters
    localparam ADDR_WIDTH = 13;
    localparam CLK_PERIOD = 10;  // 100 MHz

    // Testbench signals
    reg clk = 0;
    reg reset = 1;
    reg [ADDR_WIDTH-1:0] phase_step;
    wire [ADDR_WIDTH-1:0] addr;

    // Device Under Test
    phase_accumulator #(
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .clk(clk),
        .reset(reset),
        .phase_step(phase_step),
        .addr(addr)
    );

    // Clock generation
    always #(CLK_PERIOD/2) clk = ~clk;

    // Test sequence
    initial begin
        $display("Starting phase_accumulator testbench");
        $monitor("Time = %0t | reset = %b | phase_step = %d | addr = %d", $time, reset, phase_step, addr);

        // Initialize
        phase_step = 0;
        reset = 1;
        #20;

        // Release reset
        reset = 0;
        phase_step = 13'd5;

        // Run for a few clock cycles
        #(CLK_PERIOD * 10);

        // Change phase step
        phase_step = 13'd123;
        #(CLK_PERIOD * 5);

        // Apply reset again
        reset = 1;
        #(CLK_PERIOD);
        reset = 0;

        // Observe result
        #(CLK_PERIOD * 5);

        $finish;
    end

endmodule