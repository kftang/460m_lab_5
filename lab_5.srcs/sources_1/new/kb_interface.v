`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2019 05:45:05 PM
// Design Name: 
// Module Name: kb_interface
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

module keyboard_interface(
  input [1:0] PS2Data,
  input PS2Clk,
  input clk,
  output [6:0] seg,
  output [3:0] an,
  output strobe
);

wire slow_clk;
wire disp_digs;

clk_div clk_div(
  .clk(clk),
  .slow_clk(slow_clk)
);

kb_display_driver kb_display_driver(
  .clk(slow_clk),
  .hex_digs(disp_digs),
  .seg(seg),
  .an(an)
);

endmodule

