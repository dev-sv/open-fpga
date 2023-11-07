
module sdram_qsys (
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
	sdram_cas);	

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
endmodule
