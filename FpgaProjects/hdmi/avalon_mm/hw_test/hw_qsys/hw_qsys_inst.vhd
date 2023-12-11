	component hw_qsys is
		port (
			clk_clk             : in  std_logic                     := 'X';             -- clk
			hdmi_clk_mm         : out std_logic;                                        -- clk_mm
			hdmi_clk_pix_p      : out std_logic;                                        -- clk_pix_p
			hdmi_clk_pix_n      : out std_logic;                                        -- clk_pix_n
			hdmi_red_p          : out std_logic;                                        -- red_p
			hdmi_red_n          : out std_logic;                                        -- red_n
			hdmi_green_p        : out std_logic;                                        -- green_p
			hdmi_green_n        : out std_logic;                                        -- green_n
			hdmi_blue_p         : out std_logic;                                        -- blue_p
			hdmi_blue_n         : out std_logic;                                        -- blue_n
			hdmi_x              : out std_logic_vector(10 downto 0);                    -- x
			hdmi_y              : out std_logic_vector(10 downto 0);                    -- y
			hdmi_horz           : out std_logic_vector(10 downto 0);                    -- horz
			hdmi_vert           : out std_logic_vector(10 downto 0);                    -- vert
			reset_reset_n       : in  std_logic                     := 'X';             -- reset_n
			slave_read          : in  std_logic                     := 'X';             -- read
			slave_write         : in  std_logic                     := 'X';             -- write
			slave_address       : in  std_logic_vector(9 downto 0)  := (others => 'X'); -- address
			slave_writedata     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			slave_burstcount    : in  std_logic                     := 'X';             -- burstcount
			slave_byteenable    : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			slave_waitrequest   : out std_logic;                                        -- waitrequest
			slave_readdatavalid : out std_logic;                                        -- readdatavalid
			slave_readdata      : out std_logic_vector(31 downto 0)                     -- readdata
		);
	end component hw_qsys;

	u0 : component hw_qsys
		port map (
			clk_clk             => CONNECTED_TO_clk_clk,             --   clk.clk
			hdmi_clk_mm         => CONNECTED_TO_hdmi_clk_mm,         --  hdmi.clk_mm
			hdmi_clk_pix_p      => CONNECTED_TO_hdmi_clk_pix_p,      --      .clk_pix_p
			hdmi_clk_pix_n      => CONNECTED_TO_hdmi_clk_pix_n,      --      .clk_pix_n
			hdmi_red_p          => CONNECTED_TO_hdmi_red_p,          --      .red_p
			hdmi_red_n          => CONNECTED_TO_hdmi_red_n,          --      .red_n
			hdmi_green_p        => CONNECTED_TO_hdmi_green_p,        --      .green_p
			hdmi_green_n        => CONNECTED_TO_hdmi_green_n,        --      .green_n
			hdmi_blue_p         => CONNECTED_TO_hdmi_blue_p,         --      .blue_p
			hdmi_blue_n         => CONNECTED_TO_hdmi_blue_n,         --      .blue_n
			hdmi_x              => CONNECTED_TO_hdmi_x,              --      .x
			hdmi_y              => CONNECTED_TO_hdmi_y,              --      .y
			hdmi_horz           => CONNECTED_TO_hdmi_horz,           --      .horz
			hdmi_vert           => CONNECTED_TO_hdmi_vert,           --      .vert
			reset_reset_n       => CONNECTED_TO_reset_reset_n,       -- reset.reset_n
			slave_read          => CONNECTED_TO_slave_read,          -- slave.read
			slave_write         => CONNECTED_TO_slave_write,         --      .write
			slave_address       => CONNECTED_TO_slave_address,       --      .address
			slave_writedata     => CONNECTED_TO_slave_writedata,     --      .writedata
			slave_burstcount    => CONNECTED_TO_slave_burstcount,    --      .burstcount
			slave_byteenable    => CONNECTED_TO_slave_byteenable,    --      .byteenable
			slave_waitrequest   => CONNECTED_TO_slave_waitrequest,   --      .waitrequest
			slave_readdatavalid => CONNECTED_TO_slave_readdatavalid, --      .readdatavalid
			slave_readdata      => CONNECTED_TO_slave_readdata       --      .readdata
		);

