create_clock -name osc -period 10.000 [get_ports {osc}]
derive_pll_clocks -create_base_clocks
derive_clock_uncertainty