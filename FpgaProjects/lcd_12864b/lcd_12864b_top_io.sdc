#create_clock -name virt_clk_in -period 8000.000 -waveform {0 4000}
create_clock -name virt_clk_out -period 8000.000 -waveform {0 4000}
set_output_delay -clock { virt_clk_out } -min 0 [get_ports {data[0] data[1] data[2] data[3] data[4] data[5] data[6] data[7] e rs rw}]
set_output_delay -clock { virt_clk_out } -max 1 [get_ports {data[0] data[1] data[2] data[3] data[4] data[5] data[6] data[7] e rs rw}]

