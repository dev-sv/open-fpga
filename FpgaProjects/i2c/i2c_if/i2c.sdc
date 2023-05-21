
create_clock -name clk -period 5120.000 [get_ports {clk}]
derive_clock_uncertainty

set_input_delay -clock { clk } -min 0 [get_ports {rw[0] rw[1] wr_data[0] wr_data[1] wr_data[2] wr_data[3] wr_data[4] wr_data[5] wr_data[6] wr_data[7] sda}]
set_input_delay -clock { clk } -max 1 [get_ports {rw[0] rw[1] wr_data[0] wr_data[1] wr_data[2] wr_data[3] wr_data[4] wr_data[5] wr_data[6] wr_data[7] sda}]

set_output_delay -clock { clk } -min 0 [get_ports {rd_data[0] rd_data[1] rd_data[2] rd_data[3] rd_data[4] rd_data[5] rd_data[6] rd_data[7] rd_ready wr_ready sda sclk}]
set_output_delay -clock { clk } -max 1 [get_ports {rd_data[0] rd_data[1] rd_data[2] rd_data[3] rd_data[4] rd_data[5] rd_data[6] rd_data[7] rd_ready wr_ready sda sclk}]
