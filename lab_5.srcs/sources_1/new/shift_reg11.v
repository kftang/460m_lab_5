`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2019 05:45:05 PM
// Design Name: 
// Module Name: shift_reg22
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

module shift_reg11(
  input clk,
  input reset,
  input data_bit,
  output reg ready,
  output reg [10:0] shift_reg
);

reg [4:0] counter;

initial begin
  ready = 0;
  shift_reg = 0;
  counter = 0;
end

always @(negedge clk, negedge reset) begin
    if (reset) begin
        shift_reg <= 0;
        ready <= 0;
        counter <= 0;
    end else if (!ready) begin
        shift_reg <= {data_bit, shift_reg[10:1]};
        counter <= counter + 1;
    end
    if (counter == 10) begin
        ready <= 1;
    end
end

endmodule

