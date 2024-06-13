`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2024 10:38:41 AM
// Design Name: 
// Module Name: setMod
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


module setMod(
//input
mod,
//output
timer

    );
    
input [1:0] mod;
output reg [4:0] timer;

always @ (mod) begin
    case (mod)
        0: timer = 5'd14;
        1: timer = 5'd10;
        2: timer = 5'd8;
        3: timer = 5'd6;
    endcase
end
endmodule
