`define SNAKE_LENGTH 4

`define DIR_NONE 0
`define DIR_UP 1
`define DIR_DOWN 2
`define DIR_LEFT 3
`define DIR_RIGHT 4

module snake_game(
    input clk,
    input start,
    input pause,
    input escape,
    input restart,
    input [7:0] sw,
    input ps2_clk,
    input ps2_data,
	output hsync,
	output vsync,
	output [2:0] r,
	output [2:0] g,
	output [2:0] b
);

    wire up;
    wire down;
    wire left;
    wire right;
//    wire pause;
//    wire escape;
//    wire restart;
//    wire start;

    assign up = sw[0];
    assign down = sw[1];
    assign left = sw[2];
    assign right = sw[3];

    reg [6:0] head_row;
    reg [6:0] head_col;
    reg [2:0] head_dir;
  
    reg game_paused;  // p
    reg game_over;    // out of bounds
    reg game_stopped; // esc
    reg [26:0] game_counter;
    reg game_clk;

    snake_vga_controller snake_vga_controller(
        .clk(clk),
        .head_row(head_row),
        .head_col(head_col),
        .head_dir(head_dir),
        .game_stopped(game_stopped),
        .hsync(hsync),
        .vsync(vsync),
        .r(r),
        .g(g),
        .b(b)
    );
    
    initial begin
        game_stopped = 0;
        game_paused = 0;
        game_over = 0;
        game_counter = 0;
        game_clk = 0;
        head_row = 0;
        head_col = 0;
        head_dir = `DIR_NONE;
    end

    always @(posedge clk) begin
        game_counter = game_counter + 1;
        if (game_counter[26]) begin
            if (game_clk == 0) begin
                game_clk = 1;
                if (!game_over && !game_paused && !game_stopped) begin
                    case ({up, down, left, right})
                        4'b1000: begin
                            if (head_dir != `DIR_UP) begin
                                head_dir = `DIR_UP;
                                if (head_row < `SNAKE_LENGTH) begin
                                    game_over = 1;
                                    head_row = 0;
                                end else begin
                                    head_row = head_row - `SNAKE_LENGTH;
                                end
                            end
                        end
                        4'b0100: begin
                            if (head_dir != `DIR_DOWN) begin
                                head_dir = `DIR_DOWN;
                                if (48 - head_row < `SNAKE_LENGTH) begin
                                    game_over = 1;
                                    head_row = 47;
                                end else begin
                                    head_row = head_row + `SNAKE_LENGTH;
                                end
                            end
                        end
                        4'b0010: begin
                            if (head_dir != `DIR_LEFT) begin
                                head_dir = `DIR_LEFT;
                                if (head_col < `SNAKE_LENGTH) begin
                                    game_over = 1;
                                    head_col = 0;
                                end else begin
                                    head_col = head_col - `SNAKE_LENGTH;
                                end
                            end
                        end
                        4'b0001: begin
                            if (head_dir != `DIR_RIGHT) begin
                                head_dir = `DIR_RIGHT;
                                if (64 - head_col < `SNAKE_LENGTH) begin
                                    game_over = 1;
                                    head_col = 63;
                                end else begin
                                    head_col = head_col + `SNAKE_LENGTH;
                                end
                            end
                        end
                    endcase    
                    case (head_dir)
                      `DIR_UP: begin
                        if (head_row == 0)
                            game_over = 1;
                        else
                            head_row = head_row - 1;
                      end
                      `DIR_DOWN: begin
                        if (head_row == 47)
                            game_over = 1;
                        else
                            head_row = head_row + 1;
                      end
                      `DIR_LEFT: begin
                        if (head_col == 0)
                            game_over = 1;
                        else
                            head_col = head_col - 1;
                      end
                      `DIR_RIGHT: begin
                        if (head_col == 63)
                            game_over = 1;
                        else
                            head_col = head_col + 1;
                      end
                    endcase
                end
            end
        end else
            game_clk = 0;
        if (escape) begin
            game_stopped = 1;
        end
        if (start) begin
            game_stopped = 0;
            game_paused = 0;
            game_over = 0;
            head_row = 3;
            head_col = 4;
            head_dir = `DIR_RIGHT;
        end
        if (game_paused && restart && !game_stopped && !game_over)
            game_paused = 0;
        if (!game_paused && pause && !game_stopped && !game_over)
            game_paused = 1;
    end
endmodule
