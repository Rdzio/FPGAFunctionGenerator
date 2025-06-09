`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2025 18:16:36
// Design Name: 
// Module Name: waveform_generator_top_tb
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


module waveform_generator_top_tb;


    // Parameters
    localparam CLK_HS_PERIOD = 2.5;   // 400 MHz => 2.5 ns
    localparam CLK_LS_PERIOD = 10;    // 100 MHz => 10 ns

    // Testbench signals
    reg LS_CLK = 0;
    reg HS_CLK = 0;
    reg reset = 1;
    reg clk_a = 0;
    reg we_a = 0;
    reg [12:0] addr_a = 0;
    reg [63:0] din_a = 0;
    wire [63:0] dout_a;
    wire [7:0] outs;

    // Rozpakowane wyjœcia serializerów
    wire out0, out1, out2, out3, out4, out5, out6, out7;
    assign outs = {out7, out6, out5, out4, out3, out2, out1, out0};

    reg [12:0] phase_step = 13'd1;
    
    // do generacji przebiegu trójk¹tnego
    integer i;

    // DUT
    waveform_generator_top dut (
        .LS_CLK(LS_CLK),
        .HS_CLK(HS_CLK),
        .reset(reset),
        .phase_step(phase_step),
        .clk_a(clk_a),
        .we_a(we_a),
        .addr_a(addr_a),
        .din_a(din_a),
        .dout_a(dout_a),
        .out0(out0), .out1(out1), .out2(out2), .out3(out3),
        .out4(out4), .out5(out5), .out6(out6), .out7(out7)
    );

    // Clock generators
    always #(CLK_LS_PERIOD/2) LS_CLK = ~LS_CLK;
    always #(CLK_HS_PERIOD/2) HS_CLK = ~HS_CLK;
    always #(CLK_LS_PERIOD/2) clk_a = ~clk_a;

    // Initialize triangle waveform memory
    task write_sample;
        input [12:0] address;
        input [63:0] value;
        begin
            @(posedge clk_a);
            addr_a <= address;
            din_a <= value;
            we_a <= 1;
            @(posedge clk_a);
            we_a <= 0;
        end
    endtask

    initial begin
        // Reset
        #50;
        reset = 0;

        // Write triangle waveform to memory (example: ramping pattern)
        for (i = 0; i < 32; i = i + 1) begin
            write_sample(i[12:0], {8*i, 8*i, 8*i, 8*i, 8*i, 8*i, 8*i, 8*i});
        end
    
        // przyk³adowy task write_sample, do zast¹pienia Twoj¹ implementacj¹
    
        // Run simulation
        #1000;
        $finish;
    end

endmodule

