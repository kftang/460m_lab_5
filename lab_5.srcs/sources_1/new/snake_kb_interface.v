`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2019 10:19:14 PM
// Design Name: 
// Module Name: snake_kb_interface
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


module snake_kb_interface(
  input ps2_data,
  input ps2_clk,
  input clk,
  output reg strobe,
  output start,
  output pause,
  output escape,
  output restart,
  output up,
  output down,
  output left,
  output right
);

wire slow_clk;
reg [7:0] disp_digs;

reg reset;
wire ready;
wire [21:0] shift_reg;

reg [26:0] strobe_counter;

assign start = disp_digs == 8'h1b;
assign pause = disp_digs == 8'h4d;
assign escape = disp_digs == 8'h76;
assign restart = disp_digs == 8'h2d;
assign up = disp_digs == 8'h75;
assign down = disp_digs == 8'h72;
assign left = disp_digs == 8'h6b;
assign right = disp_digs == 8'h74;

initial begin
    reset = 0;
    strobe_counter = 0;
    strobe = 0;
end

clk_div clk_div(
  .clk(clk),
  .slow_clk(slow_clk)
);

shift_reg22 shift_reg22(
    .clk(ps2_clk),
    .reset(reset),
    .data_bit(ps2_data),
    .ready(ready),
    .shift_reg(shift_reg)
);

always @(posedge clk) begin
    if (ready && !reset && shift_reg[8:1] == 8'hF0) begin
        disp_digs <= shift_reg[19:12];
        strobe <= 1;
        strobe_counter <= strobe_counter + 1;
        if (strobe_counter == 10000000) begin
            strobe <= 0;
            reset <= 1;
            strobe_counter <= 0;
        end
    end else if (reset)
        reset <= 0;
end

endmodule
