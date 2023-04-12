
module avl_if (
	aclk_aclk,
	adc_waitrequest,
	adc_readdata,
	adc_readdatavalid,
	adc_burstcount,
	adc_writedata,
	adc_address,
	adc_write,
	adc_read,
	adc_byteenable,
	adc_debugaccess,
	clk_clk,
	reset_reset_n);	

	input		aclk_aclk;
	output		adc_waitrequest;
	output	[15:0]	adc_readdata;
	output		adc_readdatavalid;
	input	[0:0]	adc_burstcount;
	input	[15:0]	adc_writedata;
	input	[9:0]	adc_address;
	input		adc_write;
	input		adc_read;
	input	[1:0]	adc_byteenable;
	input		adc_debugaccess;
	input		clk_clk;
	input		reset_reset_n;
endmodule
