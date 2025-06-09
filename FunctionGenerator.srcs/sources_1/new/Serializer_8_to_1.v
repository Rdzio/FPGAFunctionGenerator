`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.06.2025 22:06:40
// Design Name: 
// Module Name: Serializer_8_to_1
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


module Serializer_8_to_1(
    input CLKin,
    input CLKDIVin,
    input CE,
    input RESET,
    input Load,
    input [7:0] Data,
    output Q
    );
    
    OSERDESE2 #(
       .DATA_RATE_OQ("DDR"),   // DDR, SDR
       .DATA_RATE_TQ("DDR"),   // DDR, BUF, SDR
       .DATA_WIDTH(8),         // Parallel data width (2-8,10,14)
       .INIT_OQ(1'b0),         // Initial value of OQ output (1'b0,1'b1)
       .INIT_TQ(1'b0),         // Initial value of TQ output (1'b0,1'b1)
       .SERDES_MODE("MASTER"), // MASTER, SLAVE
       .SRVAL_OQ(1'b0),        // OQ output value when SR is used (1'b0,1'b1)
       .SRVAL_TQ(1'b0),        // TQ output value when SR is used (1'b0,1'b1)
       .TBYTE_CTL("FALSE"),    // Enable tristate byte operation (FALSE, TRUE)
       .TBYTE_SRC("FALSE"),    // Tristate byte source (FALSE, TRUE)
       .TRISTATE_WIDTH(4)      // 3-state converter width (1,4)
    )
    
    OSERDESE2_inst (
       .OFB(OFB),             // 1-bit output: Feedback path for data
       .OQ(Q),               // 1-bit output: Data path output
       // SHIFTOUT1 / SHIFTOUT2: 1-bit (each) output: Data output expansion (1-bit each)
       .SHIFTOUT1(SHIFTOUT1),
       .SHIFTOUT2(SHIFTOUT2),
       .TBYTEOUT(TBYTEOUT),   // 1-bit output: Byte group tristate
       .TFB(TFB),             // 1-bit output: 3-state control
       .TQ(TQ),               // 1-bit output: 3-state control
       .CLK(CLKin),             // 1-bit input: High speed clock
       .CLKDIV(CLKDIVin),       // 1-bit input: Divided clock
       // D1 - D8: 1-bit (each) input: Parallel data inputs (1-bit each)
       .D1(Data[0]),
       .D2(Data[1]),
       .D3(Data[2]),
       .D4(Data[3]),
       .D5(Data[4]),
       .D6(Data[5]),
       .D7(Data[6]),
       .D8(Data[7]),
       .OCE(CE),             // 1-bit input: Output data clock enable
       .RST(RESET),             // 1-bit input: Reset
       // SHIFTIN1 / SHIFTIN2: 1-bit (each) input: Data input expansion (1-bit each)
       .SHIFTIN1(SHIFTIN1),
       .SHIFTIN2(SHIFTIN2),
       // T1 - T4: 1-bit (each) input: Parallel 3-state inputs
       .T1(1'b0),
       .T2(1'b0),
       .T3(1'b0),
       .T4(1'b0),
       .TBYTEIN(1'b0),     // 1-bit input: Byte group tristate
       .TCE(1'b0)              // 1-bit input: 3-state clock enable
    );

endmodule
