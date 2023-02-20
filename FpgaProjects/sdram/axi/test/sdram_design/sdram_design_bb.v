
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
	user_awid,
	user_awaddr,
	user_awlen,
	user_awsize,
	user_awburst,
	user_awvalid,
	user_awready,
	user_wdata,
	user_wstrb,
	user_wlast,
	user_wvalid,
	user_wready,
	user_bid,
	user_bresp,
	user_bvalid,
	user_bready,
	user_arid,
	user_araddr,
	user_arlen,
	user_arsize,
	user_arburst,
	user_arvalid,
	user_arready,
	user_rid,
	user_rdata,
	user_rresp,
	user_rlast,
	user_rvalid,
	user_rready);	

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
	input	[7:0]	user_awid;
	input	[21:0]	user_awaddr;
	input	[7:0]	user_awlen;
	input	[2:0]	user_awsize;
	input	[1:0]	user_awburst;
	input		user_awvalid;
	output		user_awready;
	input	[15:0]	user_wdata;
	input	[1:0]	user_wstrb;
	input		user_wlast;
	input		user_wvalid;
	output		user_wready;
	output	[7:0]	user_bid;
	output	[1:0]	user_bresp;
	output		user_bvalid;
	input		user_bready;
	input	[7:0]	user_arid;
	input	[21:0]	user_araddr;
	input	[7:0]	user_arlen;
	input	[2:0]	user_arsize;
	input	[1:0]	user_arburst;
	input		user_arvalid;
	output		user_arready;
	output	[7:0]	user_rid;
	output	[15:0]	user_rdata;
	output	[1:0]	user_rresp;
	output		user_rlast;
	output		user_rvalid;
	input		user_rready;
endmodule
