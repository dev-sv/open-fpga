
module sdram_design (
	clk_clk,
	reset_reset_n,
	sdram_dq,
	sdram_address,
	sdram_ba,
	sdram_dqm,
	sdram_osc,
	sdram_cs,
	sdram_we,
	sdram_ras,
	sdram_cas,
	sdram_led,
	user_waitrequest,
	user_readdata,
	user_readdatavalid,
	user_burstcount,
	user_writedata,
	user_address,
	user_write,
	user_read,
	user_byteenable,
	user_debugaccess);	

	input		clk_clk;
	input		reset_reset_n;
	inout	[15:0]	sdram_dq;
	output	[11:0]	sdram_address;
	output	[1:0]	sdram_ba;
	output	[1:0]	sdram_dqm;
	output		sdram_osc;
	output		sdram_cs;
	output		sdram_we;
	output		sdram_ras;
	output		sdram_cas;
	output	[7:0]	sdram_led;
	output		user_waitrequest;
	output	[15:0]	user_readdata;
	output		user_readdatavalid;
	input	[8:0]	user_burstcount;
	input	[15:0]	user_writedata;
	input	[21:0]	user_address;
	input		user_write;
	input		user_read;
	input	[1:0]	user_byteenable;
	input		user_debugaccess;
endmodule
