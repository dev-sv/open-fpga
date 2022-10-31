create_clock -name virt_clk_out -period 20.000
set_output_delay -clock { virt_clk_out } -min 0 [get_ports {blue.n blue.p green.n green.p red.n red.p sclk.n sclk.p leds[0] leds[1] leds[2] leds[3] leds[4] leds[5] leds[6] leds[7]}]
set_output_delay -clock { virt_clk_out } -max 1 [get_ports {blue.n blue.p green.n green.p leds[0] leds[1] leds[2] leds[3] leds[4] leds[5] leds[6] leds[7] red.n red.p sclk.n sclk.p}]
create_clock -name virt_clk_in -period 20.000
set_input_delay -clock { virt_clk_in } -min 0 [get_ports {reset}]
set_input_delay -clock { virt_clk_in } -max 1 [get_ports {reset}]