
module hdmi_qsys (
	clk_clk,
	clk_x10_clk,
	hdmi_clk_mm,
	hdmi_clk_pix_p,
	hdmi_clk_pix_n,
	hdmi_red_p,
	hdmi_red_n,
	hdmi_green_p,
	hdmi_green_n,
	hdmi_blue_p,
	hdmi_blue_n,
	hdmi_x,
	hdmi_y,
	hdmi_horz,
	hdmi_vert,
	reset_reset_n);	

	input		clk_clk;
	input		clk_x10_clk;
	output		hdmi_clk_mm;
	output		hdmi_clk_pix_p;
	output		hdmi_clk_pix_n;
	output		hdmi_red_p;
	output		hdmi_red_n;
	output		hdmi_green_p;
	output		hdmi_green_n;
	output		hdmi_blue_p;
	output		hdmi_blue_n;
	output	[10:0]	hdmi_x;
	output	[10:0]	hdmi_y;
	output	[10:0]	hdmi_horz;
	output	[10:0]	hdmi_vert;
	input		reset_reset_n;
endmodule
