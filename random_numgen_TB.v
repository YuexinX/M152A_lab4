`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2024 10:41:56 AM
// Design Name: 
// Module Name: random_numgen_TB
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

module tb_lfsr;
    reg clk;
    wire [7:0] LFSRregister;

    // Instantiate the LFSR module with an initial seed
    lfsr #(8'b10010011) uut (
        .LFSRregister(LFSRregister),
        .clk(clk)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 time units clock period
    end

    // Display the LFSR output every clock cycle
    always @(posedge clk) begin
        $display("Time: %0t | LFSR Register: %b", $time, LFSRregister);
    end

    // Simulation control
    initial begin
        // Run the simulation for a specified time
        #100 $finish;
    end
endmodule
