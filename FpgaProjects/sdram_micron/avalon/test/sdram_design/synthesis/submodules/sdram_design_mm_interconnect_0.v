// sdram_design_mm_interconnect_0.v

// This file was auto-generated from altera_mm_interconnect_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 18.0 614

`timescale 1 ps / 1 ps
module sdram_design_mm_interconnect_0 (
		input  wire        clk_0_clk_clk,                                 //                               clk_0_clk.clk
		input  wire        mm_bridge_0_reset_reset_bridge_in_reset_reset, // mm_bridge_0_reset_reset_bridge_in_reset.reset
		input  wire [23:0] mm_bridge_0_m0_address,                        //                          mm_bridge_0_m0.address
		output wire        mm_bridge_0_m0_waitrequest,                    //                                        .waitrequest
		input  wire [8:0]  mm_bridge_0_m0_burstcount,                     //                                        .burstcount
		input  wire [1:0]  mm_bridge_0_m0_byteenable,                     //                                        .byteenable
		input  wire        mm_bridge_0_m0_read,                           //                                        .read
		output wire [15:0] mm_bridge_0_m0_readdata,                       //                                        .readdata
		output wire        mm_bridge_0_m0_readdatavalid,                  //                                        .readdatavalid
		input  wire        mm_bridge_0_m0_write,                          //                                        .write
		input  wire [15:0] mm_bridge_0_m0_writedata,                      //                                        .writedata
		input  wire        mm_bridge_0_m0_debugaccess,                    //                                        .debugaccess
		output wire [22:0] MT48LC4M16A2_0_avalon_slave_address,           //             MT48LC4M16A2_0_avalon_slave.address
		output wire        MT48LC4M16A2_0_avalon_slave_write,             //                                        .write
		output wire        MT48LC4M16A2_0_avalon_slave_read,              //                                        .read
		input  wire [15:0] MT48LC4M16A2_0_avalon_slave_readdata,          //                                        .readdata
		output wire [15:0] MT48LC4M16A2_0_avalon_slave_writedata,         //                                        .writedata
		output wire [8:0]  MT48LC4M16A2_0_avalon_slave_burstcount,        //                                        .burstcount
		output wire [1:0]  MT48LC4M16A2_0_avalon_slave_byteenable,        //                                        .byteenable
		input  wire        MT48LC4M16A2_0_avalon_slave_readdatavalid,     //                                        .readdatavalid
		input  wire        MT48LC4M16A2_0_avalon_slave_waitrequest        //                                        .waitrequest
	);

	wire         mm_bridge_0_m0_translator_avalon_universal_master_0_waitrequest;   // MT48LC4M16A2_0_avalon_slave_translator:uav_waitrequest -> mm_bridge_0_m0_translator:uav_waitrequest
	wire  [15:0] mm_bridge_0_m0_translator_avalon_universal_master_0_readdata;      // MT48LC4M16A2_0_avalon_slave_translator:uav_readdata -> mm_bridge_0_m0_translator:uav_readdata
	wire         mm_bridge_0_m0_translator_avalon_universal_master_0_debugaccess;   // mm_bridge_0_m0_translator:uav_debugaccess -> MT48LC4M16A2_0_avalon_slave_translator:uav_debugaccess
	wire  [23:0] mm_bridge_0_m0_translator_avalon_universal_master_0_address;       // mm_bridge_0_m0_translator:uav_address -> MT48LC4M16A2_0_avalon_slave_translator:uav_address
	wire         mm_bridge_0_m0_translator_avalon_universal_master_0_read;          // mm_bridge_0_m0_translator:uav_read -> MT48LC4M16A2_0_avalon_slave_translator:uav_read
	wire   [1:0] mm_bridge_0_m0_translator_avalon_universal_master_0_byteenable;    // mm_bridge_0_m0_translator:uav_byteenable -> MT48LC4M16A2_0_avalon_slave_translator:uav_byteenable
	wire         mm_bridge_0_m0_translator_avalon_universal_master_0_readdatavalid; // MT48LC4M16A2_0_avalon_slave_translator:uav_readdatavalid -> mm_bridge_0_m0_translator:uav_readdatavalid
	wire         mm_bridge_0_m0_translator_avalon_universal_master_0_lock;          // mm_bridge_0_m0_translator:uav_lock -> MT48LC4M16A2_0_avalon_slave_translator:uav_lock
	wire         mm_bridge_0_m0_translator_avalon_universal_master_0_write;         // mm_bridge_0_m0_translator:uav_write -> MT48LC4M16A2_0_avalon_slave_translator:uav_write
	wire  [15:0] mm_bridge_0_m0_translator_avalon_universal_master_0_writedata;     // mm_bridge_0_m0_translator:uav_writedata -> MT48LC4M16A2_0_avalon_slave_translator:uav_writedata
	wire   [9:0] mm_bridge_0_m0_translator_avalon_universal_master_0_burstcount;    // mm_bridge_0_m0_translator:uav_burstcount -> MT48LC4M16A2_0_avalon_slave_translator:uav_burstcount

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (24),
		.AV_DATA_W                   (16),
		.AV_BURSTCOUNT_W             (9),
		.AV_BYTEENABLE_W             (2),
		.UAV_ADDRESS_W               (24),
		.UAV_BURSTCOUNT_W            (10),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (1),
		.USE_READDATAVALID           (1),
		.USE_WAITREQUEST             (1),
		.USE_READRESPONSE            (0),
		.USE_WRITERESPONSE           (0),
		.AV_SYMBOLS_PER_WORD         (2),
		.AV_ADDRESS_SYMBOLS          (1),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (1),
		.UAV_CONSTANT_BURST_BEHAVIOR (1),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) mm_bridge_0_m0_translator (
		.clk                    (clk_0_clk_clk),                                                     //                       clk.clk
		.reset                  (mm_bridge_0_reset_reset_bridge_in_reset_reset),                     //                     reset.reset
		.uav_address            (mm_bridge_0_m0_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount         (mm_bridge_0_m0_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read               (mm_bridge_0_m0_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write              (mm_bridge_0_m0_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest        (mm_bridge_0_m0_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid      (mm_bridge_0_m0_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable         (mm_bridge_0_m0_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata           (mm_bridge_0_m0_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata          (mm_bridge_0_m0_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock               (mm_bridge_0_m0_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess        (mm_bridge_0_m0_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address             (mm_bridge_0_m0_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest         (mm_bridge_0_m0_waitrequest),                                        //                          .waitrequest
		.av_burstcount          (mm_bridge_0_m0_burstcount),                                         //                          .burstcount
		.av_byteenable          (mm_bridge_0_m0_byteenable),                                         //                          .byteenable
		.av_read                (mm_bridge_0_m0_read),                                               //                          .read
		.av_readdata            (mm_bridge_0_m0_readdata),                                           //                          .readdata
		.av_readdatavalid       (mm_bridge_0_m0_readdatavalid),                                      //                          .readdatavalid
		.av_write               (mm_bridge_0_m0_write),                                              //                          .write
		.av_writedata           (mm_bridge_0_m0_writedata),                                          //                          .writedata
		.av_debugaccess         (mm_bridge_0_m0_debugaccess),                                        //                          .debugaccess
		.av_beginbursttransfer  (1'b0),                                                              //               (terminated)
		.av_begintransfer       (1'b0),                                                              //               (terminated)
		.av_chipselect          (1'b0),                                                              //               (terminated)
		.av_lock                (1'b0),                                                              //               (terminated)
		.uav_clken              (),                                                                  //               (terminated)
		.av_clken               (1'b1),                                                              //               (terminated)
		.uav_response           (2'b00),                                                             //               (terminated)
		.av_response            (),                                                                  //               (terminated)
		.uav_writeresponsevalid (1'b0),                                                              //               (terminated)
		.av_writeresponsevalid  ()                                                                   //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (23),
		.AV_DATA_W                      (16),
		.UAV_DATA_W                     (16),
		.AV_BURSTCOUNT_W                (9),
		.AV_BYTEENABLE_W                (2),
		.UAV_BYTEENABLE_W               (2),
		.UAV_ADDRESS_W                  (24),
		.UAV_BURSTCOUNT_W               (10),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (1),
		.USE_WAITREQUEST                (1),
		.USE_UAV_CLKEN                  (0),
		.USE_READRESPONSE               (0),
		.USE_WRITERESPONSE              (0),
		.AV_SYMBOLS_PER_WORD            (2),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) mt48lc4m16a2_0_avalon_slave_translator (
		.clk                    (clk_0_clk_clk),                                                     //                      clk.clk
		.reset                  (mm_bridge_0_reset_reset_bridge_in_reset_reset),                     //                    reset.reset
		.uav_address            (mm_bridge_0_m0_translator_avalon_universal_master_0_address),       // avalon_universal_slave_0.address
		.uav_burstcount         (mm_bridge_0_m0_translator_avalon_universal_master_0_burstcount),    //                         .burstcount
		.uav_read               (mm_bridge_0_m0_translator_avalon_universal_master_0_read),          //                         .read
		.uav_write              (mm_bridge_0_m0_translator_avalon_universal_master_0_write),         //                         .write
		.uav_waitrequest        (mm_bridge_0_m0_translator_avalon_universal_master_0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid      (mm_bridge_0_m0_translator_avalon_universal_master_0_readdatavalid), //                         .readdatavalid
		.uav_byteenable         (mm_bridge_0_m0_translator_avalon_universal_master_0_byteenable),    //                         .byteenable
		.uav_readdata           (mm_bridge_0_m0_translator_avalon_universal_master_0_readdata),      //                         .readdata
		.uav_writedata          (mm_bridge_0_m0_translator_avalon_universal_master_0_writedata),     //                         .writedata
		.uav_lock               (mm_bridge_0_m0_translator_avalon_universal_master_0_lock),          //                         .lock
		.uav_debugaccess        (mm_bridge_0_m0_translator_avalon_universal_master_0_debugaccess),   //                         .debugaccess
		.av_address             (MT48LC4M16A2_0_avalon_slave_address),                               //      avalon_anti_slave_0.address
		.av_write               (MT48LC4M16A2_0_avalon_slave_write),                                 //                         .write
		.av_read                (MT48LC4M16A2_0_avalon_slave_read),                                  //                         .read
		.av_readdata            (MT48LC4M16A2_0_avalon_slave_readdata),                              //                         .readdata
		.av_writedata           (MT48LC4M16A2_0_avalon_slave_writedata),                             //                         .writedata
		.av_burstcount          (MT48LC4M16A2_0_avalon_slave_burstcount),                            //                         .burstcount
		.av_byteenable          (MT48LC4M16A2_0_avalon_slave_byteenable),                            //                         .byteenable
		.av_readdatavalid       (MT48LC4M16A2_0_avalon_slave_readdatavalid),                         //                         .readdatavalid
		.av_waitrequest         (MT48LC4M16A2_0_avalon_slave_waitrequest),                           //                         .waitrequest
		.av_begintransfer       (),                                                                  //              (terminated)
		.av_beginbursttransfer  (),                                                                  //              (terminated)
		.av_writebyteenable     (),                                                                  //              (terminated)
		.av_lock                (),                                                                  //              (terminated)
		.av_chipselect          (),                                                                  //              (terminated)
		.av_clken               (),                                                                  //              (terminated)
		.uav_clken              (1'b0),                                                              //              (terminated)
		.av_debugaccess         (),                                                                  //              (terminated)
		.av_outputenable        (),                                                                  //              (terminated)
		.uav_response           (),                                                                  //              (terminated)
		.av_response            (2'b00),                                                             //              (terminated)
		.uav_writeresponsevalid (),                                                                  //              (terminated)
		.av_writeresponsevalid  (1'b0)                                                               //              (terminated)
	);

endmodule
