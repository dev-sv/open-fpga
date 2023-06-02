create_clock -name clk -period 20.000 [get_ports {clk}]
derive_clock_uncertainty
set_input_delay -clock { clk } -min 0 [get_ports {in_data[0] in_data[1] in_data[2] in_data[3] in_data[4] in_data[5] in_data[6] in_data[7] miso mode[0] mode[1] op[0] op[1]}]
set_input_delay -clock { clk } -max 1 [get_ports {in_data[0] in_data[1] in_data[2] in_data[3] in_data[4] in_data[5] in_data[6] in_data[7] miso mode[0] mode[1] op[0] op[1]}]
set_output_delay -clock { clk } -min 0 [get_ports {mosi out_data[0] out_data[1] out_data[2] out_data[3] out_data[4] out_data[5] out_data[6] out_data[7] rb[0] rb[1] rb[2] rb[3] sb[0] sb[1] sb[2] sb[3] sclk ss}]
set_output_delay -clock { clk } -max 1 [get_ports {mosi out_data[0] out_data[1] out_data[2] out_data[3] out_data[4] out_data[5] out_data[6] out_data[7] rb[0] rb[1] rb[2] rb[3] sb[0] sb[1] sb[2] sb[3] sclk ss}]
