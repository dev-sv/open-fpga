
module hw_qsys (
	clk_clk,
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
	reset_reset_n,
	slave_read,
	slave_write,
	slave_address,
	slave_writedata,
	slave_burstcount,
	slave_byteenable,
	slave_waitrequest,
	slave_readdatavalid,
	slave_readdata);	

	input		clk_clk;
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
	input		slave_read;
	input		slave_write;
	input	[9:0]	slave_address;
	input	[31:0]	slave_writedata;
	input		slave_burstcount;
	input	[3:0]	slave_byteenable;
	output		slave_waitrequest;
	output		slave_readdatavalid;
	output	[31:0]	slave_readdata;
endmodule
