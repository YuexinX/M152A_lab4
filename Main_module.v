`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2024 10:29:32 AM
// Design Name: 
// Module Name: Main_module
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


module Main_module(
//input
clk, sw, rst, mod, start,
//output
score
    );
input start;
input [7:0] sw;
input [1:0] mod;
input rst;
input clk; //100MHz

output score;


reg [4:0] timer = 4'd10;
reg [4:0] timer_temp = 4'd10;
reg [7:0] answer;
reg [7:0] answer_temp;

wire second;

reg [3:0] score_temp = 0;


setClk setclk(.sys_clk(clk), .sec_clk(second));


always @(*) begin
    if (!start) begin
        case (mod)
            0: timer = 4'd14;
            1: timer = 4'd10;
            2: timer = 4'd8;
            3: timer = 4'd6;
        endcase
        score_temp = 0;
        timer_temp = timer;
    end
end





    
endmodule
