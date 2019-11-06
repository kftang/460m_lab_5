`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2019 08:07:34 PM
// Design Name: 
// Module Name: game_clk_gen
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


module game_clk_gen(
    input clk,
    output game_clk
);

    reg [26:0] counter;
    
    assign game_clk = counter[26];
    
    initial
        counter = 0;

    always @(posedge clk)
        counter = counter + 1;
endmodule
