`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2025 18:01:28
// Design Name: 
// Module Name: dual_port_sample_ram
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


module dual_port_sample_ram #(
    parameter ADDR_WIDTH = 13,  // 8192 próbek
    parameter DATA_WIDTH = 64   // 8 kana³ów × 8 bitów
)(
    input  wire                  clk_a,     // zegar portu A (Microblaze)
    input  wire                  we_a,      // write enable portu A
    input  wire [ADDR_WIDTH-1:0] addr_a,    // adres portu A
    input  wire [DATA_WIDTH-1:0] din_a,     // dane do zapisu
    output reg  [DATA_WIDTH-1:0] dout_a,    // dane z odczytu (opcjonalnie)

    input  wire                  clk_b,     // zegar portu B (LS_CLK)
    input  wire [ADDR_WIDTH-1:0] addr_b,    // adres portu B (od akumulatora)
    output reg  [DATA_WIDTH-1:0] dout_b     // dane do serializerów
);

    // Pamiêæ RAM
    reg [DATA_WIDTH-1:0] mem [0:(1 << ADDR_WIDTH)-1];

    // Port A - zapis/odczyt (Microblaze)
    always @(posedge clk_a) begin
        if (we_a)
            mem[addr_a] <= din_a;
        dout_a <= mem[addr_a];  // odczyt synchroniczny
    end

    // Port B - tylko odczyt (dla generatora)
    always @(posedge clk_b) begin
        dout_b <= mem[addr_b];
    end

endmodule

