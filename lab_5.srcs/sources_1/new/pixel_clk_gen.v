`timescale 1ns / 1ps

module pixel_clk_gen(
	input clk,
	output pixel_clk
);
    reg [1:0] counter;

    assign pixel_clk = counter[1];
    
    initial
        counter = 0;

    always @(posedge clk) begin
	   counter = counter + 1;
    end
endmodule