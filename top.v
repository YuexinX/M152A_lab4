`timescale 1ns / 1ps
////////////////////////////////////////////////////////////
// Authored by David J. Marion aka FPGA Dude
// Created on 4/11/2022
//
// Description: Top module for the VGA Clock
////////////////////////////////////////////////////////////


module top(
    input clk_100MHz,       // 100MHz on Basys 3
    input reset,            // btnC
    input tick_hr,
    input start,
    input [7:0] sw,          // btnL
    input tick_min,         // btnR
    output hsync,           // to VGA Connector
    output vsync,           // to VGA Connector
    output [11:0] rgb       // to DAC, to VGA Connector
    );
    
    // Internal Connection Signals
    wire [9:0] w_x, w_y;
    wire video_on, p_tick;
    wire [3:0] hr_10s, hr_1s, min_10s, min_1s, sec_10s, sec_1s, c1_01, c2_02;
    reg [11:0] rgb_reg;
    wire [11:0] rgb_next;
    
    // Instantiate Modules
    vga_controller vga(
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .video_on(video_on),
        .hsync(hsync),
        .vsync(vsync),
        .p_tick(p_tick),
        .x(w_x),
        .y(w_y)
        );
 
wire [7:0] display_answer;
wire [4:0] score;
game play(
.clk_100MHz(clk_100MHz),
.reset(reset),
.sw(sw),
.start(start),
.answer(display_answer),
.score(score)
    );


assign hr_10s = display_answer[0];
assign hr_1s = display_answer[1];
assign c1_01 = display_answer[2];
assign min_10s = display_answer[3];
assign min_1s = display_answer[4];
assign c2_02 = display_answer[5];
assign sec_10s = display_answer[6];
assign sec_1s = display_answer[7];


    pixel_clk_gen pclk(
        .clk(clk_100MHz),
        .video_on(video_on),
        //.tick_1Hz(),
        .x(w_x),
        .y(w_y),
        .sec_1s(sec_1s),
        .sec_10s(sec_10s),
        .min_1s(min_10s),
        .scr(score),
        .min_10s(min_1s),
        .hr_1s(hr_1s),
        .hr_10s(hr_10s),
        .cl_01s(c1_01),
        .c2_02s(c2_02),
        .time_rgb(rgb_next)
        );
 
    // rgb buffer
    always @(posedge clk_100MHz)
        if(p_tick)
            rgb_reg <= rgb_next;
            
    // output
    assign rgb = rgb_reg; 
    
endmodule