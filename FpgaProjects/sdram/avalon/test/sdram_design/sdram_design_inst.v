	sdram_design u0 (
		.clk_clk            (<connected-to-clk_clk>),            //   clk.clk
		.reset_reset_n      (<connected-to-reset_reset_n>),      // reset.reset_n
		.sdram_dq           (<connected-to-sdram_dq>),           // sdram.dq
		.sdram_address      (<connected-to-sdram_address>),      //      .address
		.sdram_ba           (<connected-to-sdram_ba>),           //      .ba
		.sdram_dqm          (<connected-to-sdram_dqm>),          //      .dqm
		.sdram_osc          (<connected-to-sdram_osc>),          //      .osc
		.sdram_cs           (<connected-to-sdram_cs>),           //      .cs
		.sdram_we           (<connected-to-sdram_we>),           //      .we
		.sdram_ras          (<connected-to-sdram_ras>),          //      .ras
		.sdram_cas          (<connected-to-sdram_cas>),          //      .cas
		.user_waitrequest   (<connected-to-user_waitrequest>),   //  user.waitrequest
		.user_readdata      (<connected-to-user_readdata>),      //      .readdata
		.user_readdatavalid (<connected-to-user_readdatavalid>), //      .readdatavalid
		.user_burstcount    (<connected-to-user_burstcount>),    //      .burstcount
		.user_writedata     (<connected-to-user_writedata>),     //      .writedata
		.user_address       (<connected-to-user_address>),       //      .address
		.user_write         (<connected-to-user_write>),         //      .write
		.user_read          (<connected-to-user_read>),          //      .read
		.user_byteenable    (<connected-to-user_byteenable>),    //      .byteenable
		.user_debugaccess   (<connected-to-user_debugaccess>)    //      .debugaccess
	);

