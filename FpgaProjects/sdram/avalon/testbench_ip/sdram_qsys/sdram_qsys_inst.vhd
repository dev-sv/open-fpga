	component sdram_qsys is
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
			sdram_cas     : out   std_logic                                         -- cas
		);
	end component sdram_qsys;

	u0 : component sdram_qsys
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
			sdram_cas     => CONNECTED_TO_sdram_cas      --      .cas
		);

