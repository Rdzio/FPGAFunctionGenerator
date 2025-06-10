`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2025 16:56:34
// Design Name: 
// Module Name: dual_port_sample_ram_tb
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


module dual_port_sample_ram_tb;

    // Parameters
    localparam ADDR_WIDTH = 13;
    localparam DATA_WIDTH = 64;
    localparam CLK_A_PERIOD = 10;   // 100 MHz
    localparam CLK_B_PERIOD = 20;   // 50 MHz (dla rozró¿nienia)

    // Testbench signals
    reg clk_a = 0;
    reg clk_b = 0;
    reg we_a;
    reg [ADDR_WIDTH-1:0] addr_a;
    reg [DATA_WIDTH-1:0] din_a;
    wire [DATA_WIDTH-1:0] dout_a;
    reg [ADDR_WIDTH-1:0] addr_b;
    wire [DATA_WIDTH-1:0] dout_b;

    // DUT
    dual_port_sample_ram #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .clk_a(clk_a),
        .we_a(we_a),
        .addr_a(addr_a),
        .din_a(din_a),
        .dout_a(dout_a),
        .clk_b(clk_b),
        .addr_b(addr_b),
        .dout_b(dout_b)
    );

    // Clock generation
    always #(CLK_A_PERIOD / 2) clk_a = ~clk_a;
    always #(CLK_B_PERIOD / 2) clk_b = ~clk_b;

    // Test scenario
    initial begin
        $display("Start dual_port_sample_ram testbench");
        $monitor("Time %0t | A[%0d]=%h | dout_a=%h | B[%0d]=%h", $time, addr_a, din_a, dout_a, addr_b, dout_b);

        we_a = 0;
        addr_a = 0;
        din_a = 0;
        addr_b = 0;

        // Wait a few cycles
        #(CLK_A_PERIOD * 2);

        // Write some values into memory
        we_a = 1;
        for (int i = 0; i < 5; i++) begin
            addr_a = i;
            din_a = 64'hDEADBEEF00000000 + i;
            #(CLK_A_PERIOD);
        end
        we_a = 0;

        // Read back on port A
        for (int i = 0; i < 5; i++) begin
            addr_a = i;
            #(CLK_A_PERIOD);
        end

        // Read from port B
        for (int i = 0; i < 5; i++) begin
            addr_b = i;
            #(CLK_B_PERIOD);
        end

        $finish;
    end

endmodule