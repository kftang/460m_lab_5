`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2019 05:45:05 PM
// Design Name: 
// Module Name: kb_display_driver
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

module kb_display_driver(
  input clk,
  input [7:0] hex_digs,
  output [6:0] seg,
  output reg [3:0] an
);

reg cur_seg;
reg [3:0] cur_dig;

initial begin
    cur_seg = 0;
    cur_dig = 0;
    an = 0;
end

hex_to_seg hex_to_seg(
  .hex(cur_dig),
  .seg(seg)
);

initial
  cur_seg = 0;

always @(posedge clk) begin
  cur_seg <= ~cur_seg;
  if (cur_seg) begin
    an <= 4'b1101;
    cur_dig <= hex_digs[7:4];
  end else begin
    an <= 4'b1110;
    cur_dig <= hex_digs[3:0];
  end
end

endmodule
