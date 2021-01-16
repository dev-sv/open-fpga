create_clock -name virt_clk_in -period 200.000 -waveform {0 100}
create_clock -name virt_clk_out -period 200.000 -waveform {0 100}
set_input_delay -clock { virt_clk_in } -min 0 [get_ports {miso_w25}]
set_input_delay -clock { virt_clk_in } -max 1 [get_ports {miso_w25}]
set_output_delay -clock { virt_clk_out } -min 0 [get_ports {mosi_max mosi_w25 sclk_max sclk_w25 ss_max ss_w25}]
set_output_delay -clock { virt_clk_out } -max 1 [get_ports {mosi_max mosi_w25 sclk_max sclk_w25 ss_max ss_w25}]
