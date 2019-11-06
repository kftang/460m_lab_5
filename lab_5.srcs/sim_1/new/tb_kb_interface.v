`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2019 07:35:34 PM
// Design Name: 
// Module Name: tb_kb_interface
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


module tb_kb_interface;
    reg ps2_data;
    reg ps2_clk;
    reg clk;
    wire [6:0] seg;
    wire [3:0] an;
    wire strobe;

    keyboard_interface keyboard_interface(
        .ps2_data(ps2_data),
        .ps2_clk(ps2_clk),
        .clk(clk),
        .seg(seg),
        .an(an),
        .strobe(strobe)
    );
    always
        #10 clk = ~clk;
    
    initial begin
        clk = 0;
        ps2_data = 1;
        ps2_clk = 0;
        #20;
        ps2_clk = 1;
        ps2_data = 0;
        #20;
        ps2_clk = 0;
        #20;
        ps2_clk = 1;
        ps2_data = 1;
        #20;
        ps2_clk = 0;
        #20;
        ps2_clk = 1;
        ps2_data = 0;
        #20;
        ps2_clk = 0;
        #20;
        ps2_clk = 1;
        ps2_data = 1;
        #20;
        ps2_clk = 0;
        #20;
        ps2_clk = 1;
        ps2_data = 1;
        #20;
        ps2_clk = 0;
        #20;
        ps2_clk = 1;
        ps2_data = 0;
        #20;
        ps2_clk = 0;
        #20;
        ps2_clk = 1;
        ps2_data = 1;
        #20;
        ps2_clk = 0;
        #20;
        ps2_clk = 1;
        ps2_data = 1;
        #20;
        ps2_clk = 0;
        #20;
        ps2_clk = 1;
        ps2_data = 1;
        #20;
        ps2_clk = 0;
        #20;
        ps2_clk = 1;
        ps2_data = 0;
        #20;
        ps2_clk = 0;
        #20;
        ps2_clk = 1;
        ps2_data = 1;
        #20;
        ps2_clk = 0;
        
    end

endmodule
