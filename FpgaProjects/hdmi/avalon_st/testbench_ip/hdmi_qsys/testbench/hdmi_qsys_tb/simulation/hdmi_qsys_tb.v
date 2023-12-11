// hdmi_qsys_tb.v

// Generated using ACDS version 18.0 614

`timescale 1 ps / 1 ps
module hdmi_qsys_tb (
	);

	wire   [0:0] hdmi_qsys_inst_st_in_bfm_src_valid;   // hdmi_qsys_inst_st_in_bfm:src_valid -> hdmi_qsys_inst:st_in_valid
	wire  [23:0] hdmi_qsys_inst_st_in_bfm_src_data;    // hdmi_qsys_inst_st_in_bfm:src_data -> hdmi_qsys_inst:st_in_data
	wire         hdmi_qsys_inst_st_in_bfm_src_ready;   // hdmi_qsys_inst:st_in_ready -> hdmi_qsys_inst_st_in_bfm:src_ready
	wire         hdmi_qsys_inst_clk_bfm_clk_clk;       // hdmi_qsys_inst_clk_bfm:clk -> [hdmi_qsys_inst:clk_clk, hdmi_qsys_inst_hdmi_bfm:clk, hdmi_qsys_inst_reset_bfm:clk, hdmi_qsys_inst_st_in_bfm:clk]
	wire         hdmi_qsys_inst_clk_pix_bfm_clk_clk;   // hdmi_qsys_inst_clk_pix_bfm:clk -> hdmi_qsys_inst:clk_pix_clk
	wire         hdmi_qsys_inst_clk_x10_bfm_clk_clk;   // hdmi_qsys_inst_clk_x10_bfm:clk -> hdmi_qsys_inst:clk_x10_clk
	wire  [10:0] hdmi_qsys_inst_hdmi_vert;             // hdmi_qsys_inst:hdmi_vert -> hdmi_qsys_inst_hdmi_bfm:sig_vert
	wire         hdmi_qsys_inst_hdmi_blue_p;           // hdmi_qsys_inst:hdmi_blue_p -> hdmi_qsys_inst_hdmi_bfm:sig_blue_p
	wire         hdmi_qsys_inst_hdmi_blue_n;           // hdmi_qsys_inst:hdmi_blue_n -> hdmi_qsys_inst_hdmi_bfm:sig_blue_n
	wire         hdmi_qsys_inst_hdmi_clk_st;           // hdmi_qsys_inst:hdmi_clk_st -> hdmi_qsys_inst_hdmi_bfm:sig_clk_st
	wire         hdmi_qsys_inst_hdmi_red_n;            // hdmi_qsys_inst:hdmi_red_n -> hdmi_qsys_inst_hdmi_bfm:sig_red_n
	wire         hdmi_qsys_inst_hdmi_red_p;            // hdmi_qsys_inst:hdmi_red_p -> hdmi_qsys_inst_hdmi_bfm:sig_red_p
	wire  [10:0] hdmi_qsys_inst_hdmi_x;                // hdmi_qsys_inst:hdmi_x -> hdmi_qsys_inst_hdmi_bfm:sig_x
	wire         hdmi_qsys_inst_hdmi_clk_pix_n;        // hdmi_qsys_inst:hdmi_clk_pix_n -> hdmi_qsys_inst_hdmi_bfm:sig_clk_pix_n
	wire  [10:0] hdmi_qsys_inst_hdmi_y;                // hdmi_qsys_inst:hdmi_y -> hdmi_qsys_inst_hdmi_bfm:sig_y
	wire         hdmi_qsys_inst_hdmi_clk_pix_p;        // hdmi_qsys_inst:hdmi_clk_pix_p -> hdmi_qsys_inst_hdmi_bfm:sig_clk_pix_p
	wire         hdmi_qsys_inst_hdmi_green_n;          // hdmi_qsys_inst:hdmi_green_n -> hdmi_qsys_inst_hdmi_bfm:sig_green_n
	wire         hdmi_qsys_inst_hdmi_green_p;          // hdmi_qsys_inst:hdmi_green_p -> hdmi_qsys_inst_hdmi_bfm:sig_green_p
	wire  [10:0] hdmi_qsys_inst_hdmi_horz;             // hdmi_qsys_inst:hdmi_horz -> hdmi_qsys_inst_hdmi_bfm:sig_horz
	wire         hdmi_qsys_inst_reset_bfm_reset_reset; // hdmi_qsys_inst_reset_bfm:reset -> [hdmi_qsys_inst:reset_reset, hdmi_qsys_inst_st_in_bfm:reset]

	hdmi_qsys hdmi_qsys_inst (
		.clk_clk        (hdmi_qsys_inst_clk_bfm_clk_clk),       //     clk.clk
		.clk_pix_clk    (hdmi_qsys_inst_clk_pix_bfm_clk_clk),   // clk_pix.clk
		.clk_x10_clk    (hdmi_qsys_inst_clk_x10_bfm_clk_clk),   // clk_x10.clk
		.hdmi_blue_n    (hdmi_qsys_inst_hdmi_blue_n),           //    hdmi.blue_n
		.hdmi_blue_p    (hdmi_qsys_inst_hdmi_blue_p),           //        .blue_p
		.hdmi_clk_pix_n (hdmi_qsys_inst_hdmi_clk_pix_n),        //        .clk_pix_n
		.hdmi_clk_pix_p (hdmi_qsys_inst_hdmi_clk_pix_p),        //        .clk_pix_p
		.hdmi_green_n   (hdmi_qsys_inst_hdmi_green_n),          //        .green_n
		.hdmi_green_p   (hdmi_qsys_inst_hdmi_green_p),          //        .green_p
		.hdmi_red_n     (hdmi_qsys_inst_hdmi_red_n),            //        .red_n
		.hdmi_red_p     (hdmi_qsys_inst_hdmi_red_p),            //        .red_p
		.hdmi_x         (hdmi_qsys_inst_hdmi_x),                //        .x
		.hdmi_y         (hdmi_qsys_inst_hdmi_y),                //        .y
		.hdmi_horz      (hdmi_qsys_inst_hdmi_horz),             //        .horz
		.hdmi_vert      (hdmi_qsys_inst_hdmi_vert),             //        .vert
		.hdmi_clk_st    (hdmi_qsys_inst_hdmi_clk_st),           //        .clk_st
		.reset_reset    (hdmi_qsys_inst_reset_bfm_reset_reset), //   reset.reset
		.st_in_data     (hdmi_qsys_inst_st_in_bfm_src_data),    //   st_in.data
		.st_in_ready    (hdmi_qsys_inst_st_in_bfm_src_ready),   //        .ready
		.st_in_valid    (hdmi_qsys_inst_st_in_bfm_src_valid)    //        .valid
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (80000000),
		.CLOCK_UNIT (1)
	) hdmi_qsys_inst_clk_bfm (
		.clk (hdmi_qsys_inst_clk_bfm_clk_clk)  // clk.clk
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (80000000),
		.CLOCK_UNIT (1)
	) hdmi_qsys_inst_clk_pix_bfm (
		.clk (hdmi_qsys_inst_clk_pix_bfm_clk_clk)  // clk.clk
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (400000000),
		.CLOCK_UNIT (1)
	) hdmi_qsys_inst_clk_x10_bfm (
		.clk (hdmi_qsys_inst_clk_x10_bfm_clk_clk)  // clk.clk
	);

	altera_conduit_bfm hdmi_qsys_inst_hdmi_bfm (
		.clk           (hdmi_qsys_inst_clk_bfm_clk_clk), //     clk.clk
		.sig_blue_n    (hdmi_qsys_inst_hdmi_blue_n),     // conduit.blue_n
		.sig_blue_p    (hdmi_qsys_inst_hdmi_blue_p),     //        .blue_p
		.sig_clk_pix_n (hdmi_qsys_inst_hdmi_clk_pix_n),  //        .clk_pix_n
		.sig_clk_pix_p (hdmi_qsys_inst_hdmi_clk_pix_p),  //        .clk_pix_p
		.sig_clk_st    (hdmi_qsys_inst_hdmi_clk_st),     //        .clk_st
		.sig_green_n   (hdmi_qsys_inst_hdmi_green_n),    //        .green_n
		.sig_green_p   (hdmi_qsys_inst_hdmi_green_p),    //        .green_p
		.sig_horz      (hdmi_qsys_inst_hdmi_horz),       //        .horz
		.sig_red_n     (hdmi_qsys_inst_hdmi_red_n),      //        .red_n
		.sig_red_p     (hdmi_qsys_inst_hdmi_red_p),      //        .red_p
		.sig_vert      (hdmi_qsys_inst_hdmi_vert),       //        .vert
		.sig_x         (hdmi_qsys_inst_hdmi_x),          //        .x
		.sig_y         (hdmi_qsys_inst_hdmi_y),          //        .y
		.reset         (1'b0)                            // (terminated)
	);

	altera_avalon_reset_source #(
		.ASSERT_HIGH_RESET    (1),
		.INITIAL_RESET_CYCLES (50)
	) hdmi_qsys_inst_reset_bfm (
		.reset (hdmi_qsys_inst_reset_bfm_reset_reset), // reset.reset
		.clk   (hdmi_qsys_inst_clk_bfm_clk_clk)        //   clk.clk
	);

	altera_avalon_st_source_bfm #(
		.USE_PACKET       (0),
		.USE_CHANNEL      (0),
		.USE_ERROR        (0),
		.USE_READY        (1),
		.USE_VALID        (1),
		.USE_EMPTY        (0),
		.ST_SYMBOL_W      (24),
		.ST_NUMSYMBOLS    (1),
		.ST_CHANNEL_W     (1),
		.ST_ERROR_W       (1),
		.ST_EMPTY_W       (1),
		.ST_READY_LATENCY (0),
		.ST_BEATSPERCYCLE (1),
		.ST_MAX_CHANNELS  (0),
		.VHDL_ID          (0)
	) hdmi_qsys_inst_st_in_bfm (
		.clk               (hdmi_qsys_inst_clk_bfm_clk_clk),       //       clk.clk
		.reset             (hdmi_qsys_inst_reset_bfm_reset_reset), // clk_reset.reset
		.src_data          (hdmi_qsys_inst_st_in_bfm_src_data),    //       src.data
		.src_valid         (hdmi_qsys_inst_st_in_bfm_src_valid),   //          .valid
		.src_ready         (hdmi_qsys_inst_st_in_bfm_src_ready),   //          .ready
		.src_startofpacket (),                                     // (terminated)
		.src_endofpacket   (),                                     // (terminated)
		.src_empty         (),                                     // (terminated)
		.src_channel       (),                                     // (terminated)
		.src_error         ()                                      // (terminated)
	);

endmodule