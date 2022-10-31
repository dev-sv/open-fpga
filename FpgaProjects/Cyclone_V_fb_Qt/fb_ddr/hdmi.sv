



package pkg_disp;

 typedef struct{

	int horz_front_porch;
	int horz_sync;
	int horz_back_porch;
	int horz_pix;

	int vert_front_porch;
	int vert_sync;
	int vert_back_porch;
	int vert_pix;

 } t_sync;


 const bit[9:0] code[4] = '{10'b0010101011, 10'b1101010100,
                            10'b0010101010, 10'b1101010101};
endpackage



interface hdmi_if();

 import pkg_disp::t_sync;

 t_sync sp;
	  
 bit[10:0] x, y;
	  
 logic[9:0] d;
 
 logic[7:0] color;
 
 logic[9:0] out;

 bit p, n;

 bit       de;
 bit[1:0]   vh; 

 modport pair(output p, n);

 modport s_de_vh(output de, vh);

 modport e_de_vh(input de, vh);

endinterface: hdmi_if



module hdmi(input bit clk_x10, clk_pix, input bit[7:0] red, green, blue, input pkg_disp::t_sync sp,
              hdmi_if.pair red_p, hdmi_if.pair green_p, hdmi_if.pair blue_p, hdmi_if.pair clk_p, input bit[10:0] x, y);

				  				  
hdmi_if _if();

wire[9:0] w_r,
			 w_g,
			 w_b;


	always @(posedge clk_x10) begin
	
		clk_p.p <= clk_pix;
		clk_p.n <= ~clk_pix;
	end
	

	sync sync_inst(.clk(clk_pix), .s(_if.s_de_vh), .sp(sp), .x(x), .y(y));


	tmds_encoder tmds_encoder_red(.clk(clk_pix), .e(_if.e_de_vh), .color(red), .out(w_r));

	tmds_serial  tmds_serial_red(.clk_x10(clk_x10), .d(w_r), .pair(red_p));


	tmds_encoder tmds_encoder_green(.clk(clk_pix), .e(_if.e_de_vh), .color(green), .out(w_g));

	tmds_serial  tmds_serial_green(.clk_x10(clk_x10), .d(w_g), .pair(green_p));


	tmds_encoder tmds_encoder_blue(.clk(clk_pix), .e(_if.e_de_vh), .color(blue), .out(w_b));

	tmds_serial  tmds_serial_blue(.clk_x10(clk_x10), .d(w_b), .pair(blue_p));


endmodule: hdmi
