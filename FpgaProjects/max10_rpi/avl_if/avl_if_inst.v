	avl_if u0 (
		.aclk_aclk         (<connected-to-aclk_aclk>),         //  aclk.aclk
		.adc_waitrequest   (<connected-to-adc_waitrequest>),   //   adc.waitrequest
		.adc_readdata      (<connected-to-adc_readdata>),      //      .readdata
		.adc_readdatavalid (<connected-to-adc_readdatavalid>), //      .readdatavalid
		.adc_burstcount    (<connected-to-adc_burstcount>),    //      .burstcount
		.adc_writedata     (<connected-to-adc_writedata>),     //      .writedata
		.adc_address       (<connected-to-adc_address>),       //      .address
		.adc_write         (<connected-to-adc_write>),         //      .write
		.adc_read          (<connected-to-adc_read>),          //      .read
		.adc_byteenable    (<connected-to-adc_byteenable>),    //      .byteenable
		.adc_debugaccess   (<connected-to-adc_debugaccess>),   //      .debugaccess
		.clk_clk           (<connected-to-clk_clk>),           //   clk.clk
		.reset_reset_n     (<connected-to-reset_reset_n>)      // reset.reset_n
	);

