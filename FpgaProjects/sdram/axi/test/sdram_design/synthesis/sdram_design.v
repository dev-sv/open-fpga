// sdram_design.v

// Generated using ACDS version 18.0 614

`timescale 1 ps / 1 ps
module sdram_design (
		input  wire        clk_clk,       //   clk.clk
		input  wire        reset_reset_n, // reset.reset_n
		inout  wire [15:0] sdram_dq,      // sdram.dq
		output wire [11:0] sdram_address, //      .address
		output wire [1:0]  sdram_ba,      //      .ba
		output wire [1:0]  sdram_dqm,     //      .dqm
		output wire        sdram_osc,     //      .osc
		output wire        sdram_cs,      //      .cs
		output wire        sdram_we,      //      .we
		output wire        sdram_ras,     //      .ras
		output wire        sdram_cas,     //      .cas
		output wire [7:0]  sdram_led,     //      .led
		input  wire [7:0]  user_awid,     //  user.awid
		input  wire [21:0] user_awaddr,   //      .awaddr
		input  wire [7:0]  user_awlen,    //      .awlen
		input  wire [2:0]  user_awsize,   //      .awsize
		input  wire [1:0]  user_awburst,  //      .awburst
		input  wire        user_awvalid,  //      .awvalid
		output wire        user_awready,  //      .awready
		input  wire [15:0] user_wdata,    //      .wdata
		input  wire [1:0]  user_wstrb,    //      .wstrb
		input  wire        user_wlast,    //      .wlast
		input  wire        user_wvalid,   //      .wvalid
		output wire        user_wready,   //      .wready
		output wire [7:0]  user_bid,      //      .bid
		output wire [1:0]  user_bresp,    //      .bresp
		output wire        user_bvalid,   //      .bvalid
		input  wire        user_bready,   //      .bready
		input  wire [7:0]  user_arid,     //      .arid
		input  wire [21:0] user_araddr,   //      .araddr
		input  wire [7:0]  user_arlen,    //      .arlen
		input  wire [2:0]  user_arsize,   //      .arsize
		input  wire [1:0]  user_arburst,  //      .arburst
		input  wire        user_arvalid,  //      .arvalid
		output wire        user_arready,  //      .arready
		output wire [7:0]  user_rid,      //      .rid
		output wire [15:0] user_rdata,    //      .rdata
		output wire [1:0]  user_rresp,    //      .rresp
		output wire        user_rlast,    //      .rlast
		output wire        user_rvalid,   //      .rvalid
		input  wire        user_rready    //      .rready
	);

	wire   [1:0] axi_bridge_0_m0_awburst;                          // axi_bridge_0:m0_awburst -> mm_interconnect_0:axi_bridge_0_m0_awburst
	wire   [7:0] axi_bridge_0_m0_arlen;                            // axi_bridge_0:m0_arlen -> mm_interconnect_0:axi_bridge_0_m0_arlen
	wire   [1:0] axi_bridge_0_m0_wstrb;                            // axi_bridge_0:m0_wstrb -> mm_interconnect_0:axi_bridge_0_m0_wstrb
	wire         axi_bridge_0_m0_wready;                           // mm_interconnect_0:axi_bridge_0_m0_wready -> axi_bridge_0:m0_wready
	wire   [7:0] axi_bridge_0_m0_rid;                              // mm_interconnect_0:axi_bridge_0_m0_rid -> axi_bridge_0:m0_rid
	wire         axi_bridge_0_m0_rready;                           // axi_bridge_0:m0_rready -> mm_interconnect_0:axi_bridge_0_m0_rready
	wire   [7:0] axi_bridge_0_m0_awlen;                            // axi_bridge_0:m0_awlen -> mm_interconnect_0:axi_bridge_0_m0_awlen
	wire         axi_bridge_0_m0_wvalid;                           // axi_bridge_0:m0_wvalid -> mm_interconnect_0:axi_bridge_0_m0_wvalid
	wire  [21:0] axi_bridge_0_m0_araddr;                           // axi_bridge_0:m0_araddr -> mm_interconnect_0:axi_bridge_0_m0_araddr
	wire   [2:0] axi_bridge_0_m0_arprot;                           // axi_bridge_0:m0_arprot -> mm_interconnect_0:axi_bridge_0_m0_arprot
	wire   [2:0] axi_bridge_0_m0_awprot;                           // axi_bridge_0:m0_awprot -> mm_interconnect_0:axi_bridge_0_m0_awprot
	wire  [15:0] axi_bridge_0_m0_wdata;                            // axi_bridge_0:m0_wdata -> mm_interconnect_0:axi_bridge_0_m0_wdata
	wire         axi_bridge_0_m0_arvalid;                          // axi_bridge_0:m0_arvalid -> mm_interconnect_0:axi_bridge_0_m0_arvalid
	wire   [7:0] axi_bridge_0_m0_arid;                             // axi_bridge_0:m0_arid -> mm_interconnect_0:axi_bridge_0_m0_arid
	wire  [21:0] axi_bridge_0_m0_awaddr;                           // axi_bridge_0:m0_awaddr -> mm_interconnect_0:axi_bridge_0_m0_awaddr
	wire   [1:0] axi_bridge_0_m0_bresp;                            // mm_interconnect_0:axi_bridge_0_m0_bresp -> axi_bridge_0:m0_bresp
	wire         axi_bridge_0_m0_arready;                          // mm_interconnect_0:axi_bridge_0_m0_arready -> axi_bridge_0:m0_arready
	wire  [15:0] axi_bridge_0_m0_rdata;                            // mm_interconnect_0:axi_bridge_0_m0_rdata -> axi_bridge_0:m0_rdata
	wire         axi_bridge_0_m0_awready;                          // mm_interconnect_0:axi_bridge_0_m0_awready -> axi_bridge_0:m0_awready
	wire   [1:0] axi_bridge_0_m0_arburst;                          // axi_bridge_0:m0_arburst -> mm_interconnect_0:axi_bridge_0_m0_arburst
	wire   [2:0] axi_bridge_0_m0_arsize;                           // axi_bridge_0:m0_arsize -> mm_interconnect_0:axi_bridge_0_m0_arsize
	wire         axi_bridge_0_m0_bready;                           // axi_bridge_0:m0_bready -> mm_interconnect_0:axi_bridge_0_m0_bready
	wire         axi_bridge_0_m0_rlast;                            // mm_interconnect_0:axi_bridge_0_m0_rlast -> axi_bridge_0:m0_rlast
	wire         axi_bridge_0_m0_wlast;                            // axi_bridge_0:m0_wlast -> mm_interconnect_0:axi_bridge_0_m0_wlast
	wire   [1:0] axi_bridge_0_m0_rresp;                            // mm_interconnect_0:axi_bridge_0_m0_rresp -> axi_bridge_0:m0_rresp
	wire   [7:0] axi_bridge_0_m0_awid;                             // axi_bridge_0:m0_awid -> mm_interconnect_0:axi_bridge_0_m0_awid
	wire   [7:0] axi_bridge_0_m0_bid;                              // mm_interconnect_0:axi_bridge_0_m0_bid -> axi_bridge_0:m0_bid
	wire         axi_bridge_0_m0_bvalid;                           // mm_interconnect_0:axi_bridge_0_m0_bvalid -> axi_bridge_0:m0_bvalid
	wire   [2:0] axi_bridge_0_m0_awsize;                           // axi_bridge_0:m0_awsize -> mm_interconnect_0:axi_bridge_0_m0_awsize
	wire         axi_bridge_0_m0_awvalid;                          // axi_bridge_0:m0_awvalid -> mm_interconnect_0:axi_bridge_0_m0_awvalid
	wire         axi_bridge_0_m0_rvalid;                           // mm_interconnect_0:axi_bridge_0_m0_rvalid -> axi_bridge_0:m0_rvalid
	wire   [1:0] mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awburst; // mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_awburst -> MT48LC4M16A2_AXI_0:axi_awburst
	wire   [7:0] mm_interconnect_0_mt48lc4m16a2_axi_0_axi_arlen;   // mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_arlen -> MT48LC4M16A2_AXI_0:axi_arlen
	wire   [1:0] mm_interconnect_0_mt48lc4m16a2_axi_0_axi_wstrb;   // mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_wstrb -> MT48LC4M16A2_AXI_0:axi_wstrb
	wire         mm_interconnect_0_mt48lc4m16a2_axi_0_axi_wready;  // MT48LC4M16A2_AXI_0:axi_wready -> mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_wready
	wire   [7:0] mm_interconnect_0_mt48lc4m16a2_axi_0_axi_rid;     // MT48LC4M16A2_AXI_0:axi_rid -> mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_rid
	wire         mm_interconnect_0_mt48lc4m16a2_axi_0_axi_rready;  // mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_rready -> MT48LC4M16A2_AXI_0:axi_rready
	wire   [7:0] mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awlen;   // mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_awlen -> MT48LC4M16A2_AXI_0:axi_awlen
	wire         mm_interconnect_0_mt48lc4m16a2_axi_0_axi_wvalid;  // mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_wvalid -> MT48LC4M16A2_AXI_0:axi_wvalid
	wire  [21:0] mm_interconnect_0_mt48lc4m16a2_axi_0_axi_araddr;  // mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_araddr -> MT48LC4M16A2_AXI_0:axi_araddr
	wire  [15:0] mm_interconnect_0_mt48lc4m16a2_axi_0_axi_wdata;   // mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_wdata -> MT48LC4M16A2_AXI_0:axi_wdata
	wire         mm_interconnect_0_mt48lc4m16a2_axi_0_axi_arvalid; // mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_arvalid -> MT48LC4M16A2_AXI_0:axi_arvalid
	wire   [7:0] mm_interconnect_0_mt48lc4m16a2_axi_0_axi_arid;    // mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_arid -> MT48LC4M16A2_AXI_0:axi_arid
	wire  [21:0] mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awaddr;  // mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_awaddr -> MT48LC4M16A2_AXI_0:axi_awaddr
	wire         mm_interconnect_0_mt48lc4m16a2_axi_0_axi_arready; // MT48LC4M16A2_AXI_0:axi_arready -> mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_arready
	wire  [15:0] mm_interconnect_0_mt48lc4m16a2_axi_0_axi_rdata;   // MT48LC4M16A2_AXI_0:axi_rdata -> mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_rdata
	wire         mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awready; // MT48LC4M16A2_AXI_0:axi_awready -> mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_awready
	wire   [1:0] mm_interconnect_0_mt48lc4m16a2_axi_0_axi_arburst; // mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_arburst -> MT48LC4M16A2_AXI_0:axi_arburst
	wire   [2:0] mm_interconnect_0_mt48lc4m16a2_axi_0_axi_arsize;  // mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_arsize -> MT48LC4M16A2_AXI_0:axi_arsize
	wire         mm_interconnect_0_mt48lc4m16a2_axi_0_axi_bready;  // mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_bready -> MT48LC4M16A2_AXI_0:axi_bready
	wire         mm_interconnect_0_mt48lc4m16a2_axi_0_axi_rlast;   // MT48LC4M16A2_AXI_0:axi_rlast -> mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_rlast
	wire         mm_interconnect_0_mt48lc4m16a2_axi_0_axi_wlast;   // mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_wlast -> MT48LC4M16A2_AXI_0:axi_wlast
	wire   [7:0] mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awid;    // mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_awid -> MT48LC4M16A2_AXI_0:axi_awid
	wire   [7:0] mm_interconnect_0_mt48lc4m16a2_axi_0_axi_bid;     // MT48LC4M16A2_AXI_0:axi_bid -> mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_bid
	wire         mm_interconnect_0_mt48lc4m16a2_axi_0_axi_bvalid;  // MT48LC4M16A2_AXI_0:axi_bvalid -> mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_bvalid
	wire   [2:0] mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awsize;  // mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_awsize -> MT48LC4M16A2_AXI_0:axi_awsize
	wire         mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awvalid; // mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_awvalid -> MT48LC4M16A2_AXI_0:axi_awvalid
	wire         mm_interconnect_0_mt48lc4m16a2_axi_0_axi_rvalid;  // MT48LC4M16A2_AXI_0:axi_rvalid -> mm_interconnect_0:MT48LC4M16A2_AXI_0_axi_rvalid
	wire         rst_controller_reset_out_reset;                   // rst_controller:reset_out -> [MT48LC4M16A2_AXI_0:reset, axi_bridge_0:aresetn, mm_interconnect_0:axi_bridge_0_clk_reset_reset_bridge_in_reset_reset]

	sdram mt48lc4m16a2_axi_0 (
		.clk         (clk_clk),                                          // clock.clk
		.reset       (rst_controller_reset_out_reset),                   // reset.reset
		.dq          (sdram_dq),                                         // sdram.dq
		.address     (sdram_address),                                    //      .address
		.ba          (sdram_ba),                                         //      .ba
		.dqm         (sdram_dqm),                                        //      .dqm
		.osc         (sdram_osc),                                        //      .osc
		.cs          (sdram_cs),                                         //      .cs
		.we          (sdram_we),                                         //      .we
		.ras         (sdram_ras),                                        //      .ras
		.cas         (sdram_cas),                                        //      .cas
		.led         (sdram_led),                                        //      .led
		.axi_awid    (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awid),    //   axi.awid
		.axi_awaddr  (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awaddr),  //      .awaddr
		.axi_awlen   (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awlen),   //      .awlen
		.axi_awsize  (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awsize),  //      .awsize
		.axi_awburst (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awburst), //      .awburst
		.axi_awvalid (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awvalid), //      .awvalid
		.axi_awready (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awready), //      .awready
		.axi_wdata   (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_wdata),   //      .wdata
		.axi_wstrb   (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_wstrb),   //      .wstrb
		.axi_wvalid  (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_wvalid),  //      .wvalid
		.axi_wready  (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_wready),  //      .wready
		.axi_bid     (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_bid),     //      .bid
		.axi_bvalid  (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_bvalid),  //      .bvalid
		.axi_bready  (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_bready),  //      .bready
		.axi_arid    (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_arid),    //      .arid
		.axi_araddr  (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_araddr),  //      .araddr
		.axi_arlen   (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_arlen),   //      .arlen
		.axi_arsize  (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_arsize),  //      .arsize
		.axi_arburst (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_arburst), //      .arburst
		.axi_arvalid (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_arvalid), //      .arvalid
		.axi_arready (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_arready), //      .arready
		.axi_rid     (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_rid),     //      .rid
		.axi_rdata   (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_rdata),   //      .rdata
		.axi_rlast   (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_rlast),   //      .rlast
		.axi_rvalid  (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_rvalid),  //      .rvalid
		.axi_rready  (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_rready),  //      .rready
		.axi_wlast   (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_wlast)    //      .wlast
	);

	altera_axi_bridge #(
		.USE_PIPELINE          (1),
		.USE_M0_AWID           (1),
		.USE_M0_AWREGION       (0),
		.USE_M0_AWLEN          (1),
		.USE_M0_AWSIZE         (1),
		.USE_M0_AWBURST        (1),
		.USE_M0_AWLOCK         (0),
		.USE_M0_AWCACHE        (0),
		.USE_M0_AWQOS          (0),
		.USE_S0_AWREGION       (0),
		.USE_S0_AWLOCK         (0),
		.USE_S0_AWCACHE        (0),
		.USE_S0_AWQOS          (0),
		.USE_S0_AWPROT         (0),
		.USE_M0_WSTRB          (1),
		.USE_S0_WLAST          (1),
		.USE_M0_BID            (1),
		.USE_M0_BRESP          (1),
		.USE_S0_BRESP          (1),
		.USE_M0_ARID           (1),
		.USE_M0_ARREGION       (0),
		.USE_M0_ARLEN          (1),
		.USE_M0_ARSIZE         (1),
		.USE_M0_ARBURST        (1),
		.USE_M0_ARLOCK         (0),
		.USE_M0_ARCACHE        (0),
		.USE_M0_ARQOS          (0),
		.USE_S0_ARREGION       (0),
		.USE_S0_ARLOCK         (0),
		.USE_S0_ARCACHE        (0),
		.USE_S0_ARQOS          (0),
		.USE_S0_ARPROT         (0),
		.USE_M0_RID            (1),
		.USE_M0_RRESP          (1),
		.USE_M0_RLAST          (1),
		.USE_S0_RRESP          (1),
		.M0_ID_WIDTH           (8),
		.S0_ID_WIDTH           (8),
		.DATA_WIDTH            (16),
		.WRITE_ADDR_USER_WIDTH (64),
		.READ_ADDR_USER_WIDTH  (64),
		.WRITE_DATA_USER_WIDTH (64),
		.WRITE_RESP_USER_WIDTH (64),
		.READ_DATA_USER_WIDTH  (64),
		.ADDR_WIDTH            (22),
		.USE_S0_AWUSER         (0),
		.USE_S0_ARUSER         (0),
		.USE_S0_WUSER          (0),
		.USE_S0_RUSER          (0),
		.USE_S0_BUSER          (0),
		.USE_M0_AWUSER         (0),
		.USE_M0_ARUSER         (0),
		.USE_M0_WUSER          (0),
		.USE_M0_RUSER          (0),
		.USE_M0_BUSER          (0),
		.AXI_VERSION           ("AXI4"),
		.BURST_LENGTH_WIDTH    (8),
		.LOCK_WIDTH            (1)
	) axi_bridge_0 (
		.aclk        (clk_clk),                                                              //       clk.clk
		.aresetn     (~rst_controller_reset_out_reset),                                      // clk_reset.reset_n
		.s0_awid     (user_awid),                                                            //        s0.awid
		.s0_awaddr   (user_awaddr),                                                          //          .awaddr
		.s0_awlen    (user_awlen),                                                           //          .awlen
		.s0_awsize   (user_awsize),                                                          //          .awsize
		.s0_awburst  (user_awburst),                                                         //          .awburst
		.s0_awvalid  (user_awvalid),                                                         //          .awvalid
		.s0_awready  (user_awready),                                                         //          .awready
		.s0_wdata    (user_wdata),                                                           //          .wdata
		.s0_wstrb    (user_wstrb),                                                           //          .wstrb
		.s0_wlast    (user_wlast),                                                           //          .wlast
		.s0_wvalid   (user_wvalid),                                                          //          .wvalid
		.s0_wready   (user_wready),                                                          //          .wready
		.s0_bid      (user_bid),                                                             //          .bid
		.s0_bresp    (user_bresp),                                                           //          .bresp
		.s0_bvalid   (user_bvalid),                                                          //          .bvalid
		.s0_bready   (user_bready),                                                          //          .bready
		.s0_arid     (user_arid),                                                            //          .arid
		.s0_araddr   (user_araddr),                                                          //          .araddr
		.s0_arlen    (user_arlen),                                                           //          .arlen
		.s0_arsize   (user_arsize),                                                          //          .arsize
		.s0_arburst  (user_arburst),                                                         //          .arburst
		.s0_arvalid  (user_arvalid),                                                         //          .arvalid
		.s0_arready  (user_arready),                                                         //          .arready
		.s0_rid      (user_rid),                                                             //          .rid
		.s0_rdata    (user_rdata),                                                           //          .rdata
		.s0_rresp    (user_rresp),                                                           //          .rresp
		.s0_rlast    (user_rlast),                                                           //          .rlast
		.s0_rvalid   (user_rvalid),                                                          //          .rvalid
		.s0_rready   (user_rready),                                                          //          .rready
		.m0_awid     (axi_bridge_0_m0_awid),                                                 //        m0.awid
		.m0_awaddr   (axi_bridge_0_m0_awaddr),                                               //          .awaddr
		.m0_awlen    (axi_bridge_0_m0_awlen),                                                //          .awlen
		.m0_awsize   (axi_bridge_0_m0_awsize),                                               //          .awsize
		.m0_awburst  (axi_bridge_0_m0_awburst),                                              //          .awburst
		.m0_awprot   (axi_bridge_0_m0_awprot),                                               //          .awprot
		.m0_awvalid  (axi_bridge_0_m0_awvalid),                                              //          .awvalid
		.m0_awready  (axi_bridge_0_m0_awready),                                              //          .awready
		.m0_wdata    (axi_bridge_0_m0_wdata),                                                //          .wdata
		.m0_wstrb    (axi_bridge_0_m0_wstrb),                                                //          .wstrb
		.m0_wlast    (axi_bridge_0_m0_wlast),                                                //          .wlast
		.m0_wvalid   (axi_bridge_0_m0_wvalid),                                               //          .wvalid
		.m0_wready   (axi_bridge_0_m0_wready),                                               //          .wready
		.m0_bid      (axi_bridge_0_m0_bid),                                                  //          .bid
		.m0_bresp    (axi_bridge_0_m0_bresp),                                                //          .bresp
		.m0_bvalid   (axi_bridge_0_m0_bvalid),                                               //          .bvalid
		.m0_bready   (axi_bridge_0_m0_bready),                                               //          .bready
		.m0_arid     (axi_bridge_0_m0_arid),                                                 //          .arid
		.m0_araddr   (axi_bridge_0_m0_araddr),                                               //          .araddr
		.m0_arlen    (axi_bridge_0_m0_arlen),                                                //          .arlen
		.m0_arsize   (axi_bridge_0_m0_arsize),                                               //          .arsize
		.m0_arburst  (axi_bridge_0_m0_arburst),                                              //          .arburst
		.m0_arprot   (axi_bridge_0_m0_arprot),                                               //          .arprot
		.m0_arvalid  (axi_bridge_0_m0_arvalid),                                              //          .arvalid
		.m0_arready  (axi_bridge_0_m0_arready),                                              //          .arready
		.m0_rid      (axi_bridge_0_m0_rid),                                                  //          .rid
		.m0_rdata    (axi_bridge_0_m0_rdata),                                                //          .rdata
		.m0_rresp    (axi_bridge_0_m0_rresp),                                                //          .rresp
		.m0_rlast    (axi_bridge_0_m0_rlast),                                                //          .rlast
		.m0_rvalid   (axi_bridge_0_m0_rvalid),                                               //          .rvalid
		.m0_rready   (axi_bridge_0_m0_rready),                                               //          .rready
		.s0_awlock   (1'b0),                                                                 // (terminated)
		.s0_awcache  (4'b0000),                                                              // (terminated)
		.s0_awprot   (3'b000),                                                               // (terminated)
		.s0_awuser   (64'b0000000000000000000000000000000000000000000000000000000000000000), // (terminated)
		.s0_awqos    (4'b0000),                                                              // (terminated)
		.s0_awregion (4'b0000),                                                              // (terminated)
		.s0_wuser    (64'b0000000000000000000000000000000000000000000000000000000000000000), // (terminated)
		.s0_buser    (),                                                                     // (terminated)
		.s0_arlock   (1'b0),                                                                 // (terminated)
		.s0_arcache  (4'b0000),                                                              // (terminated)
		.s0_arprot   (3'b000),                                                               // (terminated)
		.s0_aruser   (64'b0000000000000000000000000000000000000000000000000000000000000000), // (terminated)
		.s0_arqos    (4'b0000),                                                              // (terminated)
		.s0_arregion (4'b0000),                                                              // (terminated)
		.s0_ruser    (),                                                                     // (terminated)
		.m0_awlock   (),                                                                     // (terminated)
		.m0_awcache  (),                                                                     // (terminated)
		.m0_awuser   (),                                                                     // (terminated)
		.m0_awqos    (),                                                                     // (terminated)
		.m0_awregion (),                                                                     // (terminated)
		.m0_wuser    (),                                                                     // (terminated)
		.m0_buser    (64'b0000000000000000000000000000000000000000000000000000000000000000), // (terminated)
		.m0_arlock   (),                                                                     // (terminated)
		.m0_arcache  (),                                                                     // (terminated)
		.m0_aruser   (),                                                                     // (terminated)
		.m0_arqos    (),                                                                     // (terminated)
		.m0_arregion (),                                                                     // (terminated)
		.m0_ruser    (64'b0000000000000000000000000000000000000000000000000000000000000000), // (terminated)
		.m0_wid      (),                                                                     // (terminated)
		.s0_wid      (8'b00000000)                                                           // (terminated)
	);

	sdram_design_mm_interconnect_0 mm_interconnect_0 (
		.axi_bridge_0_m0_awid                               (axi_bridge_0_m0_awid),                             //                              axi_bridge_0_m0.awid
		.axi_bridge_0_m0_awaddr                             (axi_bridge_0_m0_awaddr),                           //                                             .awaddr
		.axi_bridge_0_m0_awlen                              (axi_bridge_0_m0_awlen),                            //                                             .awlen
		.axi_bridge_0_m0_awsize                             (axi_bridge_0_m0_awsize),                           //                                             .awsize
		.axi_bridge_0_m0_awburst                            (axi_bridge_0_m0_awburst),                          //                                             .awburst
		.axi_bridge_0_m0_awprot                             (axi_bridge_0_m0_awprot),                           //                                             .awprot
		.axi_bridge_0_m0_awvalid                            (axi_bridge_0_m0_awvalid),                          //                                             .awvalid
		.axi_bridge_0_m0_awready                            (axi_bridge_0_m0_awready),                          //                                             .awready
		.axi_bridge_0_m0_wdata                              (axi_bridge_0_m0_wdata),                            //                                             .wdata
		.axi_bridge_0_m0_wstrb                              (axi_bridge_0_m0_wstrb),                            //                                             .wstrb
		.axi_bridge_0_m0_wlast                              (axi_bridge_0_m0_wlast),                            //                                             .wlast
		.axi_bridge_0_m0_wvalid                             (axi_bridge_0_m0_wvalid),                           //                                             .wvalid
		.axi_bridge_0_m0_wready                             (axi_bridge_0_m0_wready),                           //                                             .wready
		.axi_bridge_0_m0_bid                                (axi_bridge_0_m0_bid),                              //                                             .bid
		.axi_bridge_0_m0_bresp                              (axi_bridge_0_m0_bresp),                            //                                             .bresp
		.axi_bridge_0_m0_bvalid                             (axi_bridge_0_m0_bvalid),                           //                                             .bvalid
		.axi_bridge_0_m0_bready                             (axi_bridge_0_m0_bready),                           //                                             .bready
		.axi_bridge_0_m0_arid                               (axi_bridge_0_m0_arid),                             //                                             .arid
		.axi_bridge_0_m0_araddr                             (axi_bridge_0_m0_araddr),                           //                                             .araddr
		.axi_bridge_0_m0_arlen                              (axi_bridge_0_m0_arlen),                            //                                             .arlen
		.axi_bridge_0_m0_arsize                             (axi_bridge_0_m0_arsize),                           //                                             .arsize
		.axi_bridge_0_m0_arburst                            (axi_bridge_0_m0_arburst),                          //                                             .arburst
		.axi_bridge_0_m0_arprot                             (axi_bridge_0_m0_arprot),                           //                                             .arprot
		.axi_bridge_0_m0_arvalid                            (axi_bridge_0_m0_arvalid),                          //                                             .arvalid
		.axi_bridge_0_m0_arready                            (axi_bridge_0_m0_arready),                          //                                             .arready
		.axi_bridge_0_m0_rid                                (axi_bridge_0_m0_rid),                              //                                             .rid
		.axi_bridge_0_m0_rdata                              (axi_bridge_0_m0_rdata),                            //                                             .rdata
		.axi_bridge_0_m0_rresp                              (axi_bridge_0_m0_rresp),                            //                                             .rresp
		.axi_bridge_0_m0_rlast                              (axi_bridge_0_m0_rlast),                            //                                             .rlast
		.axi_bridge_0_m0_rvalid                             (axi_bridge_0_m0_rvalid),                           //                                             .rvalid
		.axi_bridge_0_m0_rready                             (axi_bridge_0_m0_rready),                           //                                             .rready
		.MT48LC4M16A2_AXI_0_axi_awid                        (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awid),    //                       MT48LC4M16A2_AXI_0_axi.awid
		.MT48LC4M16A2_AXI_0_axi_awaddr                      (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awaddr),  //                                             .awaddr
		.MT48LC4M16A2_AXI_0_axi_awlen                       (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awlen),   //                                             .awlen
		.MT48LC4M16A2_AXI_0_axi_awsize                      (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awsize),  //                                             .awsize
		.MT48LC4M16A2_AXI_0_axi_awburst                     (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awburst), //                                             .awburst
		.MT48LC4M16A2_AXI_0_axi_awvalid                     (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awvalid), //                                             .awvalid
		.MT48LC4M16A2_AXI_0_axi_awready                     (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_awready), //                                             .awready
		.MT48LC4M16A2_AXI_0_axi_wdata                       (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_wdata),   //                                             .wdata
		.MT48LC4M16A2_AXI_0_axi_wstrb                       (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_wstrb),   //                                             .wstrb
		.MT48LC4M16A2_AXI_0_axi_wlast                       (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_wlast),   //                                             .wlast
		.MT48LC4M16A2_AXI_0_axi_wvalid                      (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_wvalid),  //                                             .wvalid
		.MT48LC4M16A2_AXI_0_axi_wready                      (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_wready),  //                                             .wready
		.MT48LC4M16A2_AXI_0_axi_bid                         (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_bid),     //                                             .bid
		.MT48LC4M16A2_AXI_0_axi_bvalid                      (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_bvalid),  //                                             .bvalid
		.MT48LC4M16A2_AXI_0_axi_bready                      (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_bready),  //                                             .bready
		.MT48LC4M16A2_AXI_0_axi_arid                        (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_arid),    //                                             .arid
		.MT48LC4M16A2_AXI_0_axi_araddr                      (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_araddr),  //                                             .araddr
		.MT48LC4M16A2_AXI_0_axi_arlen                       (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_arlen),   //                                             .arlen
		.MT48LC4M16A2_AXI_0_axi_arsize                      (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_arsize),  //                                             .arsize
		.MT48LC4M16A2_AXI_0_axi_arburst                     (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_arburst), //                                             .arburst
		.MT48LC4M16A2_AXI_0_axi_arvalid                     (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_arvalid), //                                             .arvalid
		.MT48LC4M16A2_AXI_0_axi_arready                     (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_arready), //                                             .arready
		.MT48LC4M16A2_AXI_0_axi_rid                         (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_rid),     //                                             .rid
		.MT48LC4M16A2_AXI_0_axi_rdata                       (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_rdata),   //                                             .rdata
		.MT48LC4M16A2_AXI_0_axi_rlast                       (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_rlast),   //                                             .rlast
		.MT48LC4M16A2_AXI_0_axi_rvalid                      (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_rvalid),  //                                             .rvalid
		.MT48LC4M16A2_AXI_0_axi_rready                      (mm_interconnect_0_mt48lc4m16a2_axi_0_axi_rready),  //                                             .rready
		.clk_0_clk_clk                                      (clk_clk),                                          //                                    clk_0_clk.clk
		.axi_bridge_0_clk_reset_reset_bridge_in_reset_reset (rst_controller_reset_out_reset)                    // axi_bridge_0_clk_reset_reset_bridge_in_reset.reset
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