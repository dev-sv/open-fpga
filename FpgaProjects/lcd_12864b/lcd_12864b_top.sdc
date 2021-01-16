create_clock -name osc -period 20.000 -waveform {0 10} [get_ports {osc}]
create_clock -name pll_osc -period 20.000 -waveform {0 10} [get_nets {pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]}]
derive_pll_clocks
derive_clock_uncertainty
create_generated_clock -name counter_clk -source [get_nets {pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]}] -divide_by 50 [get_nets {counter_inst|LPM_COUNTER_component|auto_generated|counter_reg_bit[2]}]