`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2019 04:22:21 PM
// Design Name: 
// Module Name: tb_vga_controller
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


module tb_vga_controller;

reg clk;
reg [7:0] sw;
wire hsync;
wire vsync;
wire [3:0] r;
wire [3:0] g;
wire [3:0] b;

vga_controller vga_controller(
    .clk(clk),
    .sw(sw),
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
    sw = 8'b00000100;
    #16800000;
end

endmodule
