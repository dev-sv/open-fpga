	component hdmi_qsys is
		port (
			clk_clk             : in    std_logic                     := 'X';             -- clk
			hdmi_clk_pix_p      : out   std_logic;                                        -- clk_pix_p
			hdmi_clk_pix_n      : out   std_logic;                                        -- clk_pix_n
			hdmi_red_p          : out   std_logic;                                        -- red_p
			hdmi_red_n          : out   std_logic;                                        -- red_n
			hdmi_green_p        : out   std_logic;                                        -- green_p
			hdmi_green_n        : out   std_logic;                                        -- green_n
			hdmi_blue_p         : out   std_logic;                                        -- blue_p
			hdmi_blue_n         : out   std_logic;                                        -- blue_n
			memory_mem_a        : out   std_logic_vector(14 downto 0);                    -- mem_a
			memory_mem_ba       : out   std_logic_vector(2 downto 0);                     -- mem_ba
			memory_mem_ck       : out   std_logic;                                        -- mem_ck
			memory_mem_ck_n     : out   std_logic;                                        -- mem_ck_n
			memory_mem_cke      : out   std_logic;                                        -- mem_cke
			memory_mem_cs_n     : out   std_logic;                                        -- mem_cs_n
			memory_mem_ras_n    : out   std_logic;                                        -- mem_ras_n
			memory_mem_cas_n    : out   std_logic;                                        -- mem_cas_n
			memory_mem_we_n     : out   std_logic;                                        -- mem_we_n
			memory_mem_reset_n  : out   std_logic;                                        -- mem_reset_n
			memory_mem_dq       : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
			memory_mem_dqs      : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
			memory_mem_dqs_n    : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
			memory_mem_odt      : out   std_logic;                                        -- mem_odt
			memory_mem_dm       : out   std_logic_vector(3 downto 0);                     -- mem_dm
			memory_oct_rzqin    : in    std_logic                     := 'X';             -- oct_rzqin
			pll_0_locked_export : out   std_logic                                         -- export
		);
	end component hdmi_qsys;

	u0 : component hdmi_qsys
		port map (
			clk_clk             => CONNECTED_TO_clk_clk,             --          clk.clk
			hdmi_clk_pix_p      => CONNECTED_TO_hdmi_clk_pix_p,      --         hdmi.clk_pix_p
			hdmi_clk_pix_n      => CONNECTED_TO_hdmi_clk_pix_n,      --             .clk_pix_n
			hdmi_red_p          => CONNECTED_TO_hdmi_red_p,          --             .red_p
			hdmi_red_n          => CONNECTED_TO_hdmi_red_n,          --             .red_n
			hdmi_green_p        => CONNECTED_TO_hdmi_green_p,        --             .green_p
			hdmi_green_n        => CONNECTED_TO_hdmi_green_n,        --             .green_n
			hdmi_blue_p         => CONNECTED_TO_hdmi_blue_p,         --             .blue_p
			hdmi_blue_n         => CONNECTED_TO_hdmi_blue_n,         --             .blue_n
			memory_mem_a        => CONNECTED_TO_memory_mem_a,        --       memory.mem_a
			memory_mem_ba       => CONNECTED_TO_memory_mem_ba,       --             .mem_ba
			memory_mem_ck       => CONNECTED_TO_memory_mem_ck,       --             .mem_ck
			memory_mem_ck_n     => CONNECTED_TO_memory_mem_ck_n,     --             .mem_ck_n
			memory_mem_cke      => CONNECTED_TO_memory_mem_cke,      --             .mem_cke
			memory_mem_cs_n     => CONNECTED_TO_memory_mem_cs_n,     --             .mem_cs_n
			memory_mem_ras_n    => CONNECTED_TO_memory_mem_ras_n,    --             .mem_ras_n
			memory_mem_cas_n    => CONNECTED_TO_memory_mem_cas_n,    --             .mem_cas_n
			memory_mem_we_n     => CONNECTED_TO_memory_mem_we_n,     --             .mem_we_n
			memory_mem_reset_n  => CONNECTED_TO_memory_mem_reset_n,  --             .mem_reset_n
			memory_mem_dq       => CONNECTED_TO_memory_mem_dq,       --             .mem_dq
			memory_mem_dqs      => CONNECTED_TO_memory_mem_dqs,      --             .mem_dqs
			memory_mem_dqs_n    => CONNECTED_TO_memory_mem_dqs_n,    --             .mem_dqs_n
			memory_mem_odt      => CONNECTED_TO_memory_mem_odt,      --             .mem_odt
			memory_mem_dm       => CONNECTED_TO_memory_mem_dm,       --             .mem_dm
			memory_oct_rzqin    => CONNECTED_TO_memory_oct_rzqin,    --             .oct_rzqin
			pll_0_locked_export => CONNECTED_TO_pll_0_locked_export  -- pll_0_locked.export
		);

