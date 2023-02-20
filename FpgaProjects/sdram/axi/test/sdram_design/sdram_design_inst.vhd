	component sdram_design is
		port (
			clk_clk       : in    std_logic                     := 'X';             -- clk
			reset_reset_n : in    std_logic                     := 'X';             -- reset_n
			sdram_dq      : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_address : out   std_logic_vector(11 downto 0);                    -- address
			sdram_ba      : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_dqm     : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_osc     : out   std_logic;                                        -- osc
			sdram_cs      : out   std_logic;                                        -- cs
			sdram_we      : out   std_logic;                                        -- we
			sdram_ras     : out   std_logic;                                        -- ras
			sdram_cas     : out   std_logic;                                        -- cas
			sdram_led     : out   std_logic_vector(7 downto 0);                     -- led
			user_awid     : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- awid
			user_awaddr   : in    std_logic_vector(21 downto 0) := (others => 'X'); -- awaddr
			user_awlen    : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- awlen
			user_awsize   : in    std_logic_vector(2 downto 0)  := (others => 'X'); -- awsize
			user_awburst  : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- awburst
			user_awvalid  : in    std_logic                     := 'X';             -- awvalid
			user_awready  : out   std_logic;                                        -- awready
			user_wdata    : in    std_logic_vector(15 downto 0) := (others => 'X'); -- wdata
			user_wstrb    : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- wstrb
			user_wlast    : in    std_logic                     := 'X';             -- wlast
			user_wvalid   : in    std_logic                     := 'X';             -- wvalid
			user_wready   : out   std_logic;                                        -- wready
			user_bid      : out   std_logic_vector(7 downto 0);                     -- bid
			user_bresp    : out   std_logic_vector(1 downto 0);                     -- bresp
			user_bvalid   : out   std_logic;                                        -- bvalid
			user_bready   : in    std_logic                     := 'X';             -- bready
			user_arid     : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- arid
			user_araddr   : in    std_logic_vector(21 downto 0) := (others => 'X'); -- araddr
			user_arlen    : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- arlen
			user_arsize   : in    std_logic_vector(2 downto 0)  := (others => 'X'); -- arsize
			user_arburst  : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- arburst
			user_arvalid  : in    std_logic                     := 'X';             -- arvalid
			user_arready  : out   std_logic;                                        -- arready
			user_rid      : out   std_logic_vector(7 downto 0);                     -- rid
			user_rdata    : out   std_logic_vector(15 downto 0);                    -- rdata
			user_rresp    : out   std_logic_vector(1 downto 0);                     -- rresp
			user_rlast    : out   std_logic;                                        -- rlast
			user_rvalid   : out   std_logic;                                        -- rvalid
			user_rready   : in    std_logic                     := 'X'              -- rready
		);
	end component sdram_design;

	u0 : component sdram_design
		port map (
			clk_clk       => CONNECTED_TO_clk_clk,       --   clk.clk
			reset_reset_n => CONNECTED_TO_reset_reset_n, -- reset.reset_n
			sdram_dq      => CONNECTED_TO_sdram_dq,      -- sdram.dq
			sdram_address => CONNECTED_TO_sdram_address, --      .address
			sdram_ba      => CONNECTED_TO_sdram_ba,      --      .ba
			sdram_dqm     => CONNECTED_TO_sdram_dqm,     --      .dqm
			sdram_osc     => CONNECTED_TO_sdram_osc,     --      .osc
			sdram_cs      => CONNECTED_TO_sdram_cs,      --      .cs
			sdram_we      => CONNECTED_TO_sdram_we,      --      .we
			sdram_ras     => CONNECTED_TO_sdram_ras,     --      .ras
			sdram_cas     => CONNECTED_TO_sdram_cas,     --      .cas
			sdram_led     => CONNECTED_TO_sdram_led,     --      .led
			user_awid     => CONNECTED_TO_user_awid,     --  user.awid
			user_awaddr   => CONNECTED_TO_user_awaddr,   --      .awaddr
			user_awlen    => CONNECTED_TO_user_awlen,    --      .awlen
			user_awsize   => CONNECTED_TO_user_awsize,   --      .awsize
			user_awburst  => CONNECTED_TO_user_awburst,  --      .awburst
			user_awvalid  => CONNECTED_TO_user_awvalid,  --      .awvalid
			user_awready  => CONNECTED_TO_user_awready,  --      .awready
			user_wdata    => CONNECTED_TO_user_wdata,    --      .wdata
			user_wstrb    => CONNECTED_TO_user_wstrb,    --      .wstrb
			user_wlast    => CONNECTED_TO_user_wlast,    --      .wlast
			user_wvalid   => CONNECTED_TO_user_wvalid,   --      .wvalid
			user_wready   => CONNECTED_TO_user_wready,   --      .wready
			user_bid      => CONNECTED_TO_user_bid,      --      .bid
			user_bresp    => CONNECTED_TO_user_bresp,    --      .bresp
			user_bvalid   => CONNECTED_TO_user_bvalid,   --      .bvalid
			user_bready   => CONNECTED_TO_user_bready,   --      .bready
			user_arid     => CONNECTED_TO_user_arid,     --      .arid
			user_araddr   => CONNECTED_TO_user_araddr,   --      .araddr
			user_arlen    => CONNECTED_TO_user_arlen,    --      .arlen
			user_arsize   => CONNECTED_TO_user_arsize,   --      .arsize
			user_arburst  => CONNECTED_TO_user_arburst,  --      .arburst
			user_arvalid  => CONNECTED_TO_user_arvalid,  --      .arvalid
			user_arready  => CONNECTED_TO_user_arready,  --      .arready
			user_rid      => CONNECTED_TO_user_rid,      --      .rid
			user_rdata    => CONNECTED_TO_user_rdata,    --      .rdata
			user_rresp    => CONNECTED_TO_user_rresp,    --      .rresp
			user_rlast    => CONNECTED_TO_user_rlast,    --      .rlast
			user_rvalid   => CONNECTED_TO_user_rvalid,   --      .rvalid
			user_rready   => CONNECTED_TO_user_rready    --      .rready
		);

