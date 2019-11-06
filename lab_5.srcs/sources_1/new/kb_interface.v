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
  input ps2_data,
  input ps2_clk,
  input clk,
  output [6:0] seg,
  output [3:0] an,
  output reg strobe
);

wire slow_clk;
wire [7:0] disp_digs;

reg reset;
wire ready;
wire [21:0] shift_reg;

reg [26:0] strobe_counter;

assign disp_digs = ready ? shift_reg[19:12] : disp_digs;

initial begin
    reset = 0;
    strobe_counter = 0;
end

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

shift_reg22 shift_reg22(
    .clk(ps2_clk),
    .reset(reset),
    .data_bit(ps2_data),
    .ready(ready),
    .shift_reg(shift_reg)
);

always @(posedge clk) begin
    if (ready && !reset) begin
        strobe = 1;
        strobe_counter = strobe_counter + 1;
        if (strobe_counter == 10000000) begin
            strobe = 0;
            reset = 1;
            strobe_counter = 0;
        end
    end
end

endmodule

