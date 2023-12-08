	component hdmi_qsys is
		port (
			clk_clk        : in  std_logic                     := 'X';             -- clk
			clk_pix_clk    : in  std_logic                     := 'X';             -- clk
			clk_x10_clk    : in  std_logic                     := 'X';             -- clk
			hdmi_blue_n    : out std_logic;                                        -- blue_n
			hdmi_blue_p    : out std_logic;                                        -- blue_p
			hdmi_clk_pix_n : out std_logic;                                        -- clk_pix_n
			hdmi_clk_pix_p : out std_logic;                                        -- clk_pix_p
			hdmi_green_n   : out std_logic;                                        -- green_n
			hdmi_green_p   : out std_logic;                                        -- green_p
			hdmi_red_n     : out std_logic;                                        -- red_n
			hdmi_red_p     : out std_logic;                                        -- red_p
			hdmi_x         : out std_logic_vector(10 downto 0);                    -- x
			hdmi_y         : out std_logic_vector(10 downto 0);                    -- y
			hdmi_horz      : out std_logic_vector(10 downto 0);                    -- horz
			hdmi_vert      : out std_logic_vector(10 downto 0);                    -- vert
			hdmi_clk_st    : out std_logic;                                        -- clk_st
			reset_reset    : in  std_logic                     := 'X';             -- reset
			st_in_data     : in  std_logic_vector(23 downto 0) := (others => 'X'); -- data
			st_in_ready    : out std_logic;                                        -- ready
			st_in_valid    : in  std_logic                     := 'X'              -- valid
		);
	end component hdmi_qsys;

	u0 : component hdmi_qsys
		port map (
			clk_clk        => CONNECTED_TO_clk_clk,        --     clk.clk
			clk_pix_clk    => CONNECTED_TO_clk_pix_clk,    -- clk_pix.clk
			clk_x10_clk    => CONNECTED_TO_clk_x10_clk,    -- clk_x10.clk
			hdmi_blue_n    => CONNECTED_TO_hdmi_blue_n,    --    hdmi.blue_n
			hdmi_blue_p    => CONNECTED_TO_hdmi_blue_p,    --        .blue_p
			hdmi_clk_pix_n => CONNECTED_TO_hdmi_clk_pix_n, --        .clk_pix_n
			hdmi_clk_pix_p => CONNECTED_TO_hdmi_clk_pix_p, --        .clk_pix_p
			hdmi_green_n   => CONNECTED_TO_hdmi_green_n,   --        .green_n
			hdmi_green_p   => CONNECTED_TO_hdmi_green_p,   --        .green_p
			hdmi_red_n     => CONNECTED_TO_hdmi_red_n,     --        .red_n
			hdmi_red_p     => CONNECTED_TO_hdmi_red_p,     --        .red_p
			hdmi_x         => CONNECTED_TO_hdmi_x,         --        .x
			hdmi_y         => CONNECTED_TO_hdmi_y,         --        .y
			hdmi_horz      => CONNECTED_TO_hdmi_horz,      --        .horz
			hdmi_vert      => CONNECTED_TO_hdmi_vert,      --        .vert
			hdmi_clk_st    => CONNECTED_TO_hdmi_clk_st,    --        .clk_st
			reset_reset    => CONNECTED_TO_reset_reset,    --   reset.reset
			st_in_data     => CONNECTED_TO_st_in_data,     --   st_in.data
			st_in_ready    => CONNECTED_TO_st_in_ready,    --        .ready
			st_in_valid    => CONNECTED_TO_st_in_valid     --        .valid
		);

