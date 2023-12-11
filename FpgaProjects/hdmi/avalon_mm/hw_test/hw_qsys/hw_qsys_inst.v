	hw_qsys u0 (
		.clk_clk             (<connected-to-clk_clk>),             //   clk.clk
		.hdmi_clk_mm         (<connected-to-hdmi_clk_mm>),         //  hdmi.clk_mm
		.hdmi_clk_pix_p      (<connected-to-hdmi_clk_pix_p>),      //      .clk_pix_p
		.hdmi_clk_pix_n      (<connected-to-hdmi_clk_pix_n>),      //      .clk_pix_n
		.hdmi_red_p          (<connected-to-hdmi_red_p>),          //      .red_p
		.hdmi_red_n          (<connected-to-hdmi_red_n>),          //      .red_n
		.hdmi_green_p        (<connected-to-hdmi_green_p>),        //      .green_p
		.hdmi_green_n        (<connected-to-hdmi_green_n>),        //      .green_n
		.hdmi_blue_p         (<connected-to-hdmi_blue_p>),         //      .blue_p
		.hdmi_blue_n         (<connected-to-hdmi_blue_n>),         //      .blue_n
		.hdmi_x              (<connected-to-hdmi_x>),              //      .x
		.hdmi_y              (<connected-to-hdmi_y>),              //      .y
		.hdmi_horz           (<connected-to-hdmi_horz>),           //      .horz
		.hdmi_vert           (<connected-to-hdmi_vert>),           //      .vert
		.reset_reset_n       (<connected-to-reset_reset_n>),       // reset.reset_n
		.slave_read          (<connected-to-slave_read>),          // slave.read
		.slave_write         (<connected-to-slave_write>),         //      .write
		.slave_address       (<connected-to-slave_address>),       //      .address
		.slave_writedata     (<connected-to-slave_writedata>),     //      .writedata
		.slave_burstcount    (<connected-to-slave_burstcount>),    //      .burstcount
		.slave_byteenable    (<connected-to-slave_byteenable>),    //      .byteenable
		.slave_waitrequest   (<connected-to-slave_waitrequest>),   //      .waitrequest
		.slave_readdatavalid (<connected-to-slave_readdatavalid>), //      .readdatavalid
		.slave_readdata      (<connected-to-slave_readdata>)       //      .readdata
	);

