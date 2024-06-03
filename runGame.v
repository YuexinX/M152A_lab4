`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2024 11:35:06 AM
// Design Name: 
// Module Name: runGame
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


module runGame(
//input
sys_clk, sec_clk, sw, timer, start, 
//output 
score, round, gameEnd
    );
    
input sys_clk;
input [7:0] sw;
input sec_clk;
input start;
input [3:0] timer;
output score;
output reg round;
output gameEnd;

reg [3:0] score_temp;
reg [7:0] answer;
reg [3:0] timer_temp = 3'b0;
reg [7:0] answer_temp;
reg set = 1'b0;
reg gameEnd_temp = 0;

lfsr #(8'b10010011) uut (
        .LFSRregister(answer),
        .clk(sys_clk)
    );

always @ (*) begin
    if (start) begin
        if (sw == answer) begin
            score_temp = score + 1;
            answer_temp = answer;
            round = round + 1;
        end
        if (!set)begin
            set = ~set;
            answer_temp = answer;
            round = 0;
        end
        if (round == 10) begin
            gameEnd_temp = 1;
        end
    end
end

always @ (posedge sec_clk) begin
    if (start) begin
        if (timer_temp == timer) begin
            timer_temp <= 0;
            answer_temp <= answer;
            round <= round + 1;
        end
        else begin
            timer_temp <= timer_temp + 1;
        end
    end
end

assign gameEnd = gameEnd_temp;
assign score = score_temp;

endmodule
