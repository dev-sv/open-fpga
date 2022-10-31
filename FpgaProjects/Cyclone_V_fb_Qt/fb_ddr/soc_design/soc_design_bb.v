
module soc_design (
	clk_clk,
	ddr_address,
	ddr_burstcount,
	ddr_waitrequest,
	ddr_readdata,
	ddr_readdatavalid,
	ddr_read,
	ddr_writedata,
	ddr_byteenable,
	ddr_write,
	full_external_connection_export,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	memory_mem_dm,
	memory_oct_rzqin,
	start_address_external_connection_export);	

	input		clk_clk;
	input	[29:0]	ddr_address;
	input	[7:0]	ddr_burstcount;
	output		ddr_waitrequest;
	output	[31:0]	ddr_readdata;
	output		ddr_readdatavalid;
	input		ddr_read;
	input	[31:0]	ddr_writedata;
	input	[3:0]	ddr_byteenable;
	input		ddr_write;
	output	[7:0]	full_external_connection_export;
	output	[14:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output		memory_mem_ck;
	output		memory_mem_ck_n;
	output		memory_mem_cke;
	output		memory_mem_cs_n;
	output		memory_mem_ras_n;
	output		memory_mem_cas_n;
	output		memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[31:0]	memory_mem_dq;
	inout	[3:0]	memory_mem_dqs;
	inout	[3:0]	memory_mem_dqs_n;
	output		memory_mem_odt;
	output	[3:0]	memory_mem_dm;
	input		memory_oct_rzqin;
	output	[29:0]	start_address_external_connection_export;
endmodule
