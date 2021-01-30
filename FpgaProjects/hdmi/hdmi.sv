

import pkg_disp::t_sync;


module hdmi(input bit osc, input bit[7:0] red, green, blue,  output  bit clk_p, clk_n, red_p, red_n, 
														green_p, green_n, blue_p, blue_n, output bit[10:0] x, y); 

// sync params.
t_sync sp = '{horz_front_porch:24, horz_sync:136, horz_back_porch:160, horz_pix:1024,

				  vert_front_porch:10, vert_sync:8, vert_back_porch:30, vert_pix:600};


													
wire  w_de,
		w_clk, 
		q_clk,  
		w_clk_x10;
			

wire [1:0]	w_vh;

wire [9:0]  w_out_r,
				w_out_g,
				w_out_b;


	pll	pll_inst(.inclk0(osc), .c0(w_clk), .c1(w_clk_x10));
		
	counter 	counter_inst(.clock(w_clk), .q(q_clk));
			
	assign clk_p = q_clk;
	assign clk_n = ~q_clk;


	sync sync_inst(.clk(clk_p), .de(w_de), .vh(w_vh), .x(x), .y(y), .sp(sp));

	tmds_encoder tmds_encoder_red(.clk(clk_p), .de(w_de), .vh(2'b00), .d(red), .d_out(w_out_r));
	tmds_serial  tmds_serial_red(.clk_x10(w_clk_x10), .d(w_out_r), .p(red_p), .n(red_n)); 

	tmds_encoder tmds_encoder_green(.clk(clk_p), .de(w_de), .vh(2'b00), .d(green), .d_out(w_out_g));
	tmds_serial  tmds_serial_green(.clk_x10(w_clk_x10), .d(w_out_g), .p(green_p), .n(green_n)); 

	tmds_encoder tmds_encoder_blue(.clk(clk_p), .de(w_de), .vh(w_vh), .d(blue), .d_out(w_out_b));
	tmds_serial  tmds_serial_blue(.clk_x10(w_clk_x10), .d(w_out_b), .p(blue_p), .n(blue_n)); 

	
endmodule: hdmi