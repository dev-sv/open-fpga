create_clock -name clk -period 10.000 [get_ports {clk}]
derive_clock_uncertainty
derive_pll_clocks

set w_clk  pll_inst|altpll_component|auto_generated|pll1|clk[0]
set w_aclk pll_inst|altpll_component|auto_generated|pll1|clk[1]

set_false_path -from [get_clocks $w_clk] -to [get_ports {led[0] led[1] led[2] led[3] led[4] led[5] led[6] led[7]}]
set_false_path -from [get_ports {soc read}] -to [get_clocks $w_clk]
set_false_path -from [get_clocks $w_clk] -to [get_ports {data[0] data[1] data[2] data[3] data[4] data[5] data[6] data[7] data[8] data[9] data[10] data[11] ready}]
set_false_path -from [get_clocks $w_aclk] -to [get_clocks $w_clk]
set_false_path -from [get_clocks $w_clk] -to [get_clocks $w_aclk]
