`define SNAKE_LENGTH 4

`define DIR_NONE 0
`define DIR_UP 1
`define DIR_DOWN 2
`define DIR_LEFT 3
`define DIR_RIGHT 4

module snake_vga_controller(
	input clk,
	input [6:0] head_row,
	input [6:0] head_col,
	input [2:0] head_dir,
	input game_stopped,
	output hsync,
	output vsync,
	output [2:0] r,
	output [2:0] g,
	output [2:0] b
);

    reg [9:0] hcount;
    reg [9:0] vcount;
    wire disp_en;
    reg [11:0] rgb_gated; // will be gated with disp_en
    reg [5:0] tail_row;
    reg [4:0] tail_col;

    wire pixel_clk;

    pixel_clk_gen pixel_clk_gen(
        .clk(clk),
        .pixel_clk(pixel_clk)
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
        rgb_gated = 0;
        tail_row = 0;
        tail_col = 0;
    end
    
    always @(head_dir, head_col, head_row) begin
        case (head_dir)
            `DIR_UP: begin
                tail_row = head_row + `SNAKE_LENGTH;
                tail_col = head_col;
            end
            `DIR_DOWN: begin
                tail_row = head_row - `SNAKE_LENGTH;
                tail_col = head_col;
            end
            `DIR_LEFT: begin
                tail_row = head_row;
                tail_col = head_col + `SNAKE_LENGTH;
            end
            `DIR_RIGHT: begin
                tail_row = head_row;
                tail_col = head_col - `SNAKE_LENGTH;
            end
        endcase
    end

    always @(posedge clk) begin
        rgb_gated = game_stopped ? 12'h000 : 12'hFFF;
        if (hcount / 10 == head_col && (head_dir == `DIR_UP || head_dir == `DIR_DOWN)) begin
            if ((vcount / 10 >= tail_row && vcount / 10 <= head_row) || (vcount / 10 >= head_row && vcount / 10 <= tail_row)) begin
                rgb_gated = 12'h0F0;
            end
        end
        if (vcount / 10 == head_row && (head_dir == `DIR_LEFT || head_dir == `DIR_RIGHT)) begin
            if ((hcount / 10 >= tail_col && hcount / 10 <= head_col) || (hcount / 10 >= head_col && hcount / 10 <= tail_col)) begin
                rgb_gated = 12'h00F;
            end
        end
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
