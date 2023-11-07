	sdram_qsys u0 (
		.clk_clk       (<connected-to-clk_clk>),       //   clk.clk
		.reset_reset_n (<connected-to-reset_reset_n>), // reset.reset_n
		.sdram_dq      (<connected-to-sdram_dq>),      // sdram.dq
		.sdram_address (<connected-to-sdram_address>), //      .address
		.sdram_ba      (<connected-to-sdram_ba>),      //      .ba
		.sdram_dqm     (<connected-to-sdram_dqm>),     //      .dqm
		.sdram_osc     (<connected-to-sdram_osc>),     //      .osc
		.sdram_cs      (<connected-to-sdram_cs>),      //      .cs
		.sdram_we      (<connected-to-sdram_we>),      //      .we
		.sdram_ras     (<connected-to-sdram_ras>),     //      .ras
		.sdram_cas     (<connected-to-sdram_cas>)      //      .cas
	);

