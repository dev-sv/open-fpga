
module hw_qsys (
	clk_clk,
	hdmi_blue_n,
	hdmi_blue_p,
	hdmi_clk_pix_n,
	hdmi_clk_pix_p,
	hdmi_green_n,
	hdmi_green_p,
	hdmi_red_n,
	hdmi_red_p,
	hdmi_x,
	hdmi_y,
	hdmi_horz,
	hdmi_vert,
	hdmi_clk_st,
	reset_reset_n,
	sink_data,
	sink_ready,
	sink_valid);	

	input		clk_clk;
	output		hdmi_blue_n;
	output		hdmi_blue_p;
	output		hdmi_clk_pix_n;
	output		hdmi_clk_pix_p;
	output		hdmi_green_n;
	output		hdmi_green_p;
	output		hdmi_red_n;
	output		hdmi_red_p;
	output	[10:0]	hdmi_x;
	output	[10:0]	hdmi_y;
	output	[10:0]	hdmi_horz;
	output	[10:0]	hdmi_vert;
	output		hdmi_clk_st;
	input		reset_reset_n;
	input	[23:0]	sink_data;
	output		sink_ready;
	input		sink_valid;
endmodule
