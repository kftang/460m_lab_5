`timescale 1ns / 1ps

module tb_snake_game;

    reg clk;
    reg start;
    reg pause;
    reg escape;
    reg restart;
    reg ps2_clk;
    reg ps2_data;
	wire hsync;
	wire vsync;
	wire [2:0] r;
	wire [2:0] g;
	wire [2:0] b;
    
    snake_game snake_game(
        .clk(clk),
        .start(start),
        .pause(pause),
        .escape(escape),
        .restart(restart),
        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data),
        .hsync(hsync),
        .vsync(vsync),
        .r(r),
        .g(g),
        .b(b)
    );
    
    always
        #10 clk = ~clk;
    
    initial begin
        clk = 0;
        start = 0;
        pause = 0;
        escape = 0;
        restart = 0;
        ps2_clk = 0;
        ps2_data = 0;
        #20;
        start = 1;
        #20;
        start = 0;
    end
endmodule