`timescale 1ns / 1ps

module vga_controller(
	input clk,
	input [7:0] sw,
	output hsync,
	output vsync,
	output [3:0] r,
	output [3:0] g,
	output [3:0] b
);

    reg [9:0] hcount;
    reg [9:0] vcount;
    wire disp_en;
    wire pixel_clk;
    wire [11:0] rgb_gated; // will be gated with disp_en
    
    pixel_clk_gen pixel_clk_gen(
        .clk(clk),
        .pixel_clk(pixel_clk)
    );
    
    color_decoder color_decoder(
        .sw(sw),
        .r(rgb_gated[11:8]),
        .g(rgb_gated[7:4]),
        .b(rgb_gated[3:0])
    );
    
    assign r = disp_en ? rgb_gated[11:8] : 0;
    assign g = disp_en ? rgb_gated[7:4] : 0;
    assign b = disp_en ? rgb_gated[3:0] : 0;
    assign hsync = hcount < 659 || hcount > 755;
    assign vsync = vcount < 493 || vcount > 494;
    assign disp_en = hcount < 640 && vcount < 480;

    initial begin
        hcount = 0;
        vcount = 0;
    end
    
    always @(posedge pixel_clk) begin
        // Counting logic
        hcount <= hcount + 1;
        if (hcount == 799) begin
            if (vcount == 524)
                vcount <= 0;
            else
                vcount <= vcount + 1;
            hcount <= 0;
        end
    end
endmodule