`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/07/2024 03:17:21 PM
// Design Name: 
// Module Name: game
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


module game(
input clk_100MHz,
input 1HZ_clk,
input reset,
input [7:0] sw,
input start,
output [7:0] answer,
output [4:0] score
    );

    
    wire [7:0] randomNum;
    reg [5:0] round = 6'b0;
    reg [3:0] count = 4'b0;
    reg [4:0] score_temp = 5'b0;
    reg [7:0] answer_temp = 8'b0;
    reg init_temp = 0;
    reg hit_temp = 0;
    wire hit;
    
    lfsr #(8'b10010011) utt (.LFSRregister(randomNum), .clk(clk_100MHz));
    
    always @(posedge clk_100MHz) begin
        if (answer_temp != 5'b0 && sw == answer_temp)
            hit_temp = 1;
        else
            hit_temp = 0;
    end

    assign hit = hit_temp;
    
    always @(posedge 1HZ_clk)begin
            if (start) begin
                if (hit) begin
                   count <= 0;
                   round <= round+1;
                   answer_temp <= randomNum;
                   score_temp <= score+1;
               end
                if (count == 8) begin
                    count <= 4'b0;
                    round <= round+1;
                end
               if (round[5]) begin
                   answer_temp <= 0;
                   round <= 6'b0;
                   count <= 4'b0;
               end
                else begin
                    if (count == 0)begin
                        answer_temp <= randomNum;
                    end
                    count <= count+1;            
                end
            
            end
            else begin
                answer_temp <= 0;
                score_temp<=0;
            end
    end

assign answer = answer_temp;
assign score = score_temp;


endmodule
