create_clock -name clk -period 20.000 [get_ports {clk}]
derive_clock_uncertainty
derive_pll_clocks