`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2024 10:22:53 AM
// Design Name: 
// Module Name: setClk
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


module setClk(
//input
sys_clk, rst,
//Output
sec_clk
    );
    
input sys_clk;
input rst;
output wire sec_clk;
reg sec_clk_temp;

reg [31:0] sec_count;

always @ (posedge sys_clk or posedge rst) begin
    if (rst) begin
        sec_count <= 0;
        sec_clk_temp <= 0;
    end
    else if (sec_count == 32'd50000000 - 32'b1) begin
        sec_count <= 0;
        sec_clk_temp <= ~sec_clk;
    end
    else begin
        sec_count <= sec_count + 1;
        sec_clk_temp <= sec_clk;
    end
end

assign sec_clk = sec_clk_temp;


endmodule
