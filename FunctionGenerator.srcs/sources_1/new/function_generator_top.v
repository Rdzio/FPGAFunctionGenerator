`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2025 18:08:09
// Design Name: 
// Module Name: function_generator_top
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


module waveform_generator_top (
    input  wire         LS_CLK,      // zegar logiki niskiej prêdkoœci (100 MHz)
    input  wire         HS_CLK,      // zegar wysokiej prêdkoœci (400 MHz)
    input  wire         reset,       // synchroniczny reset
    input  wire [12:0]  phase_step,  // krok fazowy

    // port A pamiêci (dla Microblaze)
    input  wire         clk_a,
    input  wire         we_a,
    input  wire [12:0]  addr_a,
    input  wire [63:0]  din_a,
    output wire [63:0]  dout_a,

    // wyjœcia zsynchronizowane z HS_CLK
    output wire         out0,
    output wire         out1,
    output wire         out2,
    output wire         out3,
    output wire         out4,
    output wire         out5,
    output wire         out6,
    output wire         out7
);

    wire [12:0] sample_addr;
    wire [63:0] sample_data;

    wire [7:0] ch [7:0];  // tablica kana³ów

    // Akumulator fazy
    phase_accumulator #(
        .ADDR_WIDTH(13)
    ) acc_inst (
        .clk        (LS_CLK),
        .reset      (reset),
        .phase_step (phase_step),
        .addr       (sample_addr)
    );

    // Pamiêæ próbek
    dual_port_sample_ram #(
        .ADDR_WIDTH(13),
        .DATA_WIDTH(64)
    ) ram_inst (
        .clk_a   (clk_a),
        .we_a    (we_a),
        .addr_a  (addr_a),
        .din_a   (din_a),
        .dout_a  (dout_a),
        .clk_b   (LS_CLK),
        .addr_b  (sample_addr),
        .dout_b  (sample_data)
    );

    // Rozdzielacz danych
    sample_distributor dist_inst (
        .clk       (LS_CLK),
        .sample_in (sample_data),
        .ch0       (ch[0]),
        .ch1       (ch[1]),
        .ch2       (ch[2]),
        .ch3       (ch[3]),
        .ch4       (ch[4]),
        .ch5       (ch[5]),
        .ch6       (ch[6]),
        .ch7       (ch[7])
    );

    // Serializery
    wire [7:0] serializer_outputs;

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : serializers
            serializer_8_to_1 ser_inst (
                .CLKin    (HS_CLK),
                .CLKDIVin (LS_CLK),
                .CE       (1'b1),
                .RESET    (reset),
                .Load     (1'b1),
                .Data     (ch[i]),
                .Q        (serializer_outputs[i])
            );
        end
    endgenerate

    // Przypisania wyjœæ
    assign out0 = serializer_outputs[0];
    assign out1 = serializer_outputs[1];
    assign out2 = serializer_outputs[2];
    assign out3 = serializer_outputs[3];
    assign out4 = serializer_outputs[4];
    assign out5 = serializer_outputs[5];
    assign out6 = serializer_outputs[6];
    assign out7 = serializer_outputs[7];
endmodule

