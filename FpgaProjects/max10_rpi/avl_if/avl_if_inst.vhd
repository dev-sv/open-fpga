	component avl_if is
		port (
			aclk_aclk         : in  std_logic                     := 'X';             -- aclk
			adc_waitrequest   : out std_logic;                                        -- waitrequest
			adc_readdata      : out std_logic_vector(15 downto 0);                    -- readdata
			adc_readdatavalid : out std_logic;                                        -- readdatavalid
			adc_burstcount    : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- burstcount
			adc_writedata     : in  std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
			adc_address       : in  std_logic_vector(9 downto 0)  := (others => 'X'); -- address
			adc_write         : in  std_logic                     := 'X';             -- write
			adc_read          : in  std_logic                     := 'X';             -- read
			adc_byteenable    : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- byteenable
			adc_debugaccess   : in  std_logic                     := 'X';             -- debugaccess
			clk_clk           : in  std_logic                     := 'X';             -- clk
			reset_reset_n     : in  std_logic                     := 'X'              -- reset_n
		);
	end component avl_if;

	u0 : component avl_if
		port map (
			aclk_aclk         => CONNECTED_TO_aclk_aclk,         --  aclk.aclk
			adc_waitrequest   => CONNECTED_TO_adc_waitrequest,   --   adc.waitrequest
			adc_readdata      => CONNECTED_TO_adc_readdata,      --      .readdata
			adc_readdatavalid => CONNECTED_TO_adc_readdatavalid, --      .readdatavalid
			adc_burstcount    => CONNECTED_TO_adc_burstcount,    --      .burstcount
			adc_writedata     => CONNECTED_TO_adc_writedata,     --      .writedata
			adc_address       => CONNECTED_TO_adc_address,       --      .address
			adc_write         => CONNECTED_TO_adc_write,         --      .write
			adc_read          => CONNECTED_TO_adc_read,          --      .read
			adc_byteenable    => CONNECTED_TO_adc_byteenable,    --      .byteenable
			adc_debugaccess   => CONNECTED_TO_adc_debugaccess,   --      .debugaccess
			clk_clk           => CONNECTED_TO_clk_clk,           --   clk.clk
			reset_reset_n     => CONNECTED_TO_reset_reset_n      -- reset.reset_n
		);

