`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2019 04:38:42 PM
// Design Name: 
// Module Name: tb_pixel_clk_gen
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


module tb_pixel_clk_gen;

reg clk;
wire pixel_clk;

pixel_clk_gen pixel_clk_gen(
    .clk(clk),
    .pixel_clk(pixel_clk)
);

always
    #10 clk = ~clk;

initial begin
    clk = 0;
end
endmodule
