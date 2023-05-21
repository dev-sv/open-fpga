create_clock -name clk -period 20.000 [get_ports {clk}]
derive_clock_uncertainty
derive_pll_clocks

set_input_delay -clock { clk } -min 0 [get_ports {sda}]
set_input_delay -clock { clk } -max 1 [get_ports {sda}]

set_output_delay -clock { clk } -min 0 [get_ports {led[0] led[1] led[2] led[3] sclk}]
set_output_delay -clock { clk } -max 1 [get_ports {led[0] led[1] led[2] led[3] sclk}]