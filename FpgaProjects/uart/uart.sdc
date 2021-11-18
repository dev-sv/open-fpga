create_clock -name osc -period 20.000 -waveform {0 10} [get_ports {osc}]
derive_pll_clocks
derive_clock_uncertainty
create_generated_clock -name sclk -source [get_nets {pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]}] -divide_by 434 [get_registers {sclk}]
