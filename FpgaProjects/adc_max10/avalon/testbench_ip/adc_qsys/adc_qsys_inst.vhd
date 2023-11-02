	component adc_qsys is
		port (
			aclk_clk      : in std_logic := 'X'; -- clk
			clk_clk       : in std_logic := 'X'; -- clk
			reset_reset_n : in std_logic := 'X'  -- reset_n
		);
	end component adc_qsys;

	u0 : component adc_qsys
		port map (
			aclk_clk      => CONNECTED_TO_aclk_clk,      --  aclk.clk
			clk_clk       => CONNECTED_TO_clk_clk,       --   clk.clk
			reset_reset_n => CONNECTED_TO_reset_reset_n  -- reset.reset_n
		);

