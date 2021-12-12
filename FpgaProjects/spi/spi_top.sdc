create_clock -name osc -period 20.000 -waveform {0 10} [get_ports {osc}]
derive_pll_clocks
derive_clock_uncertainty
