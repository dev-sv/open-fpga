create_clock -name osc -period 10.000 [get_ports {osc}]
derive_clock_uncertainty
derive_pll_clocks