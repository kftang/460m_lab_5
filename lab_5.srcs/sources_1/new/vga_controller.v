`timescale 1ns / 1ps

module vga_controller(
	input clk,
	input [7:0] sw,
	output reg hsync,
	output reg vsync,
	output [3:0] r,
	output [3:0] g,
	output [3:0] b,
	output reg [9:0] hcount,
	output reg [9:0] vcount
);

//    reg [9:0] hcount;
//    reg [9:0] vcount;
    reg disp_en;
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

    initial begin
        hcount = 0;
        vcount = 0;
        disp_en = 1;
        hsync = 1;
        vsync = 1;
    end
    
    always @(posedge pixel_clk) begin
        if (vcount > 639 || hcount > 479)
            disp_en <= 0;
        else
            disp_en <= 1;
        
        // Counting logic
        hcount <= hcount + 1;
        if (hcount == 799) begin
            vcount <= vcount + 1;
            hcount <= 0;
        end
        if (vcount == 524) begin
            vcount <= 0;
        end
        
        // Sync timing logic
        if (hcount > 658 && hcount < 755)
            hsync <= 0;
        else
            hsync <= 1;
    
        if (vcount > 492 && vcount < 494)
            vsync <= 0;
        else
            vsync <= 1;
    end
endmodule