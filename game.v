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
input reset,
input [7:0] sw,
input start,
output [7:0] answer,
output [4:0] score
    );
    
    reg [31:0] ctr_1Hz = 32'h0;
    reg r_1Hz = 1'b0;
        
    always @(posedge clk_100MHz or posedge reset)
        if(reset)
            ctr_1Hz <= 32'h0;
        else
            if(ctr_1Hz == 49_999_999) begin
                ctr_1Hz <= 32'h0;
                r_1Hz <= ~r_1Hz;
            end
            else
                ctr_1Hz <= ctr_1Hz + 1;
    
    wire [7:0] randomNum;
    reg [5:0] round = 6'b0;
    reg [3:0] count = 4'b0;
    reg [4:0] score_temp = 5'b0;
    reg [7:0] answer_temp = 8'b0;
    reg init_temp = 0;
    
    lfsr #(8'b10010011) utt (.LFSRregister(randomNum), .clk(clk_100MHz));
    
 
    
    always @(posedge r_1Hz)begin
            if (start) begin
//                if (answer_temp) begin
//                    count <= 0;
//                    round <= round+1;
//                    answer_temp <= randomNum;
//                    score_temp <= score_temp+1;
//                end
                score_temp<=score+1;
                if (count == 8) begin
                    count <= 4'b0;
                    round <= round+1;
                end
//                if (round[5]) begin
//                    answer_temp <= 0;
//                    round <= 6'b0;
//                    count <= 4'b0;
//                end
                else begin
                    if (count == 0)begin
                        answer_temp <= randomNum;
                    end
                    else begin
                        count <= count+1;            
                    end
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
