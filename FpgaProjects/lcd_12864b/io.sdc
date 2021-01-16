create_clock -name virt_clk_in -period 8000.000 -waveform {0 4000}
create_clock -name virt_clk_out -period 8000.000 -waveform {0 4000}
set_input_delay -clock { virt_clk_in } -min 0 [get_ports {cmd e in_data[0] in_data[1] in_data[2] in_data[3] in_data[4] in_data[5] in_data[6] in_data[7] pWR[0] pWR[1] pWR[2]}]
set_input_delay -clock { virt_clk_in } -max 1 [get_ports {cmd e in_data[0] in_data[1] in_data[2] in_data[3] in_data[4] in_data[5] in_data[6] in_data[7] pWR[0] pWR[1] pWR[2]}]
set_output_delay -clock { virt_clk_out } -min 0 [get_ports {full out_data[0] out_data[1] out_data[2] out_data[3] out_data[4] out_data[5] out_data[6] out_data[7] rs rw e}]
set_output_delay -clock { virt_clk_out } -max 1 [get_ports {full out_data[0] out_data[1] out_data[2] out_data[3] out_data[4] out_data[5] out_data[6] out_data[7] rs rw e}]
