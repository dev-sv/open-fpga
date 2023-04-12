// sdram_design.v

// Generated using ACDS version 18.0 614

`timescale 1 ps / 1 ps
module sdram_design (
		input  wire        clk_clk,            //   clk.clk
		input  wire        reset_reset_n,      // reset.reset_n
		inout  wire [15:0] sdram_dq,           // sdram.dq
		output wire [11:0] sdram_address,      //      .address
		output wire [1:0]  sdram_ba,           //      .ba
		output wire [1:0]  sdram_dqm,          //      .dqm
		output wire        sdram_osc,          //      .osc
		output wire        sdram_cs,           //      .cs
		output wire        sdram_we,           //      .we
		output wire        sdram_ras,          //      .ras
		output wire        sdram_cas,          //      .cas
		output wire        user_waitrequest,   //  user.waitrequest
		output wire [15:0] user_readdata,      //      .readdata
		output wire        user_readdatavalid, //      .readdatavalid
		input  wire [8:0]  user_burstcount,    //      .burstcount
		input  wire [15:0] user_writedata,     //      .writedata
		input  wire [21:0] user_address,       //      .address
		input  wire        user_write,         //      .write
		input  wire        user_read,          //      .read
		input  wire [1:0]  user_byteenable,    //      .byteenable
		input  wire        user_debugaccess    //      .debugaccess
	);

	wire         mm_bridge_0_m0_waitrequest;                                      // mm_interconnect_0:mm_bridge_0_m0_waitrequest -> mm_bridge_0:m0_waitrequest
	wire  [15:0] mm_bridge_0_m0_readdata;                                         // mm_interconnect_0:mm_bridge_0_m0_readdata -> mm_bridge_0:m0_readdata
	wire         mm_bridge_0_m0_debugaccess;                                      // mm_bridge_0:m0_debugaccess -> mm_interconnect_0:mm_bridge_0_m0_debugaccess
	wire  [21:0] mm_bridge_0_m0_address;                                          // mm_bridge_0:m0_address -> mm_interconnect_0:mm_bridge_0_m0_address
	wire         mm_bridge_0_m0_read;                                             // mm_bridge_0:m0_read -> mm_interconnect_0:mm_bridge_0_m0_read
	wire   [1:0] mm_bridge_0_m0_byteenable;                                       // mm_bridge_0:m0_byteenable -> mm_interconnect_0:mm_bridge_0_m0_byteenable
	wire         mm_bridge_0_m0_readdatavalid;                                    // mm_interconnect_0:mm_bridge_0_m0_readdatavalid -> mm_bridge_0:m0_readdatavalid
	wire  [15:0] mm_bridge_0_m0_writedata;                                        // mm_bridge_0:m0_writedata -> mm_interconnect_0:mm_bridge_0_m0_writedata
	wire         mm_bridge_0_m0_write;                                            // mm_bridge_0:m0_write -> mm_interconnect_0:mm_bridge_0_m0_write
	wire   [8:0] mm_bridge_0_m0_burstcount;                                       // mm_bridge_0:m0_burstcount -> mm_interconnect_0:mm_bridge_0_m0_burstcount
	wire  [15:0] mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_readdata;      // MT48LC4M16A2_AVL_0:s_readdata -> mm_interconnect_0:MT48LC4M16A2_AVL_0_avalon_slave_readdata
	wire         mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_waitrequest;   // MT48LC4M16A2_AVL_0:s_waitrequest -> mm_interconnect_0:MT48LC4M16A2_AVL_0_avalon_slave_waitrequest
	wire  [21:0] mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_address;       // mm_interconnect_0:MT48LC4M16A2_AVL_0_avalon_slave_address -> MT48LC4M16A2_AVL_0:s_address
	wire         mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_read;          // mm_interconnect_0:MT48LC4M16A2_AVL_0_avalon_slave_read -> MT48LC4M16A2_AVL_0:s_read
	wire   [1:0] mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_byteenable;    // mm_interconnect_0:MT48LC4M16A2_AVL_0_avalon_slave_byteenable -> MT48LC4M16A2_AVL_0:s_byteenable
	wire         mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_readdatavalid; // MT48LC4M16A2_AVL_0:s_readdatavalid -> mm_interconnect_0:MT48LC4M16A2_AVL_0_avalon_slave_readdatavalid
	wire         mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_write;         // mm_interconnect_0:MT48LC4M16A2_AVL_0_avalon_slave_write -> MT48LC4M16A2_AVL_0:s_write
	wire  [15:0] mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_writedata;     // mm_interconnect_0:MT48LC4M16A2_AVL_0_avalon_slave_writedata -> MT48LC4M16A2_AVL_0:s_writedata
	wire   [8:0] mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_burstcount;    // mm_interconnect_0:MT48LC4M16A2_AVL_0_avalon_slave_burstcount -> MT48LC4M16A2_AVL_0:s_burstcount
	wire         rst_controller_reset_out_reset;                                  // rst_controller:reset_out -> [MT48LC4M16A2_AVL_0:reset, mm_bridge_0:reset, mm_interconnect_0:mm_bridge_0_reset_reset_bridge_in_reset_reset]

	sdram #(
		.WRITE_RECOVERY_TIME      (2),
		.PRECHARGE_COMMAND_PERIOD (2),
		.AUTO_REFRESH_PERIOD      (7),
		.LOAD_MODE_REGISTER       (3),
		.ACTIVE_READ_WRITE        (2),
		.REFRESH_PERIOD           (6400000)
	) mt48lc4m16a2_avl_0 (
		.clk             (clk_clk),                                                         //        clock.clk
		.reset           (rst_controller_reset_out_reset),                                  //        reset.reset
		.dq              (sdram_dq),                                                        //        sdram.dq
		.address         (sdram_address),                                                   //             .address
		.ba              (sdram_ba),                                                        //             .ba
		.dqm             (sdram_dqm),                                                       //             .dqm
		.osc             (sdram_osc),                                                       //             .osc
		.cs              (sdram_cs),                                                        //             .cs
		.we              (sdram_we),                                                        //             .we
		.ras             (sdram_ras),                                                       //             .ras
		.cas             (sdram_cas),                                                       //             .cas
		.s_read          (mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_read),          // avalon_slave.read
		.s_write         (mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_write),         //             .write
		.s_address       (mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_address),       //             .address
		.s_writedata     (mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_writedata),     //             .writedata
		.s_burstcount    (mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_burstcount),    //             .burstcount
		.s_byteenable    (mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_byteenable),    //             .byteenable
		.s_waitrequest   (mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_waitrequest),   //             .waitrequest
		.s_readdatavalid (mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_readdatavalid), //             .readdatavalid
		.s_readdata      (mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_readdata)       //             .readdata
	);

	altera_avalon_mm_bridge #(
		.DATA_WIDTH        (16),
		.SYMBOL_WIDTH      (8),
		.HDL_ADDR_WIDTH    (22),
		.BURSTCOUNT_WIDTH  (9),
		.PIPELINE_COMMAND  (1),
		.PIPELINE_RESPONSE (1)
	) mm_bridge_0 (
		.clk              (clk_clk),                        //   clk.clk
		.reset            (rst_controller_reset_out_reset), // reset.reset
		.s0_waitrequest   (user_waitrequest),               //    s0.waitrequest
		.s0_readdata      (user_readdata),                  //      .readdata
		.s0_readdatavalid (user_readdatavalid),             //      .readdatavalid
		.s0_burstcount    (user_burstcount),                //      .burstcount
		.s0_writedata     (user_writedata),                 //      .writedata
		.s0_address       (user_address),                   //      .address
		.s0_write         (user_write),                     //      .write
		.s0_read          (user_read),                      //      .read
		.s0_byteenable    (user_byteenable),                //      .byteenable
		.s0_debugaccess   (user_debugaccess),               //      .debugaccess
		.m0_waitrequest   (mm_bridge_0_m0_waitrequest),     //    m0.waitrequest
		.m0_readdata      (mm_bridge_0_m0_readdata),        //      .readdata
		.m0_readdatavalid (mm_bridge_0_m0_readdatavalid),   //      .readdatavalid
		.m0_burstcount    (mm_bridge_0_m0_burstcount),      //      .burstcount
		.m0_writedata     (mm_bridge_0_m0_writedata),       //      .writedata
		.m0_address       (mm_bridge_0_m0_address),         //      .address
		.m0_write         (mm_bridge_0_m0_write),           //      .write
		.m0_read          (mm_bridge_0_m0_read),            //      .read
		.m0_byteenable    (mm_bridge_0_m0_byteenable),      //      .byteenable
		.m0_debugaccess   (mm_bridge_0_m0_debugaccess),     //      .debugaccess
		.s0_response      (),                               // (terminated)
		.m0_response      (2'b00)                           // (terminated)
	);

	sdram_design_mm_interconnect_0 mm_interconnect_0 (
		.clk_0_clk_clk                                 (clk_clk),                                                         //                               clk_0_clk.clk
		.mm_bridge_0_reset_reset_bridge_in_reset_reset (rst_controller_reset_out_reset),                                  // mm_bridge_0_reset_reset_bridge_in_reset.reset
		.mm_bridge_0_m0_address                        (mm_bridge_0_m0_address),                                          //                          mm_bridge_0_m0.address
		.mm_bridge_0_m0_waitrequest                    (mm_bridge_0_m0_waitrequest),                                      //                                        .waitrequest
		.mm_bridge_0_m0_burstcount                     (mm_bridge_0_m0_burstcount),                                       //                                        .burstcount
		.mm_bridge_0_m0_byteenable                     (mm_bridge_0_m0_byteenable),                                       //                                        .byteenable
		.mm_bridge_0_m0_read                           (mm_bridge_0_m0_read),                                             //                                        .read
		.mm_bridge_0_m0_readdata                       (mm_bridge_0_m0_readdata),                                         //                                        .readdata
		.mm_bridge_0_m0_readdatavalid                  (mm_bridge_0_m0_readdatavalid),                                    //                                        .readdatavalid
		.mm_bridge_0_m0_write                          (mm_bridge_0_m0_write),                                            //                                        .write
		.mm_bridge_0_m0_writedata                      (mm_bridge_0_m0_writedata),                                        //                                        .writedata
		.mm_bridge_0_m0_debugaccess                    (mm_bridge_0_m0_debugaccess),                                      //                                        .debugaccess
		.MT48LC4M16A2_AVL_0_avalon_slave_address       (mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_address),       //         MT48LC4M16A2_AVL_0_avalon_slave.address
		.MT48LC4M16A2_AVL_0_avalon_slave_write         (mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_write),         //                                        .write
		.MT48LC4M16A2_AVL_0_avalon_slave_read          (mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_read),          //                                        .read
		.MT48LC4M16A2_AVL_0_avalon_slave_readdata      (mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_readdata),      //                                        .readdata
		.MT48LC4M16A2_AVL_0_avalon_slave_writedata     (mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_writedata),     //                                        .writedata
		.MT48LC4M16A2_AVL_0_avalon_slave_burstcount    (mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_burstcount),    //                                        .burstcount
		.MT48LC4M16A2_AVL_0_avalon_slave_byteenable    (mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_byteenable),    //                                        .byteenable
		.MT48LC4M16A2_AVL_0_avalon_slave_readdatavalid (mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_readdatavalid), //                                        .readdatavalid
		.MT48LC4M16A2_AVL_0_avalon_slave_waitrequest   (mm_interconnect_0_mt48lc4m16a2_avl_0_avalon_slave_waitrequest)    //                                        .waitrequest
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (0),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                 // reset_in0.reset
		.clk            (clk_clk),                        //       clk.clk
		.reset_out      (rst_controller_reset_out_reset), // reset_out.reset
		.reset_req      (),                               // (terminated)
		.reset_req_in0  (1'b0),                           // (terminated)
		.reset_in1      (1'b0),                           // (terminated)
		.reset_req_in1  (1'b0),                           // (terminated)
		.reset_in2      (1'b0),                           // (terminated)
		.reset_req_in2  (1'b0),                           // (terminated)
		.reset_in3      (1'b0),                           // (terminated)
		.reset_req_in3  (1'b0),                           // (terminated)
		.reset_in4      (1'b0),                           // (terminated)
		.reset_req_in4  (1'b0),                           // (terminated)
		.reset_in5      (1'b0),                           // (terminated)
		.reset_req_in5  (1'b0),                           // (terminated)
		.reset_in6      (1'b0),                           // (terminated)
		.reset_req_in6  (1'b0),                           // (terminated)
		.reset_in7      (1'b0),                           // (terminated)
		.reset_req_in7  (1'b0),                           // (terminated)
		.reset_in8      (1'b0),                           // (terminated)
		.reset_req_in8  (1'b0),                           // (terminated)
		.reset_in9      (1'b0),                           // (terminated)
		.reset_req_in9  (1'b0),                           // (terminated)
		.reset_in10     (1'b0),                           // (terminated)
		.reset_req_in10 (1'b0),                           // (terminated)
		.reset_in11     (1'b0),                           // (terminated)
		.reset_req_in11 (1'b0),                           // (terminated)
		.reset_in12     (1'b0),                           // (terminated)
		.reset_req_in12 (1'b0),                           // (terminated)
		.reset_in13     (1'b0),                           // (terminated)
		.reset_req_in13 (1'b0),                           // (terminated)
		.reset_in14     (1'b0),                           // (terminated)
		.reset_req_in14 (1'b0),                           // (terminated)
		.reset_in15     (1'b0),                           // (terminated)
		.reset_req_in15 (1'b0)                            // (terminated)
	);

endmodule
