create_clock -name osc -period 20.000 -waveform {0 10} [get_ports {osc}]
#create_clock -name pll_osc -period 20.000 -waveform {0 10} [get_nets {pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]}]
derive_pll_clocks
derive_clock_uncertainty
