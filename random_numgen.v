`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2024 10:32:39 AM
// Design Name: 
// Module Name: random_numgen
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

module lfsr #(parameter seed = 8'b1) (output reg[7:0] LFSRregister, input clk);

    // initially register will contain seed value
    initial begin
        LFSRregister = seed;
    end

    // at edge of each clock pulse, shift and XOR required bits
    always @(posedge clk) begin
        LFSRregister = LFSRregister << 1;
        LFSRregister[0] = LFSRregister[7] ^ LFSRregister[5] ^ LFSRregister[4] ^ LFSRregister[3];
    end
endmodule