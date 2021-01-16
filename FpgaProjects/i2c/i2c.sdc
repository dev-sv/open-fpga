create_clock -name clk -period 5000.000 -waveform {0 2500} [get_ports {clk}]
derive_pll_clocks
derive_clock_uncertainty
create_clock -name virt_clk_in -period 10000.000 -waveform {0 5000}
create_clock -name virt_clk_out -period 10000.000 -waveform {0 5000}
set_input_delay -clock { virt_clk_in } -min 0 [get_ports {data[0] data[1] data[2] data[3] data[4] data[5] data[6] data[7] en[0] en[1] sda}]
set_input_delay -clock { virt_clk_in } -max 1 [get_ports {data[0] data[1] data[2] data[3] data[4] data[5] data[6] data[7] en[0] en[1] sda}]
set_output_delay -clock { virt_clk_out } -min 0 [get_ports {out_i2c[0] out_i2c[1] out_i2c[2] out_i2c[3] out_i2c[4] out_i2c[5] out_i2c[6] out_i2c[7] sclk st[0] st[1] st[2] st[3] st[4] st[5] st[6] st[7] st[8] st[9] st[10] st[11] st[12] st[13] st[14] st[15] st[16] st[17] st[18] st[19] st[20] st[21] st[22] st[23] st[24] st[25] st[26] st[27] st[28] st[29] st[30] st[31] sda}]
set_output_delay -clock { virt_clk_out } -max 1 [get_ports {out_i2c[0] out_i2c[1] out_i2c[2] out_i2c[3] out_i2c[4] out_i2c[5] out_i2c[6] out_i2c[7] sclk sda st[0] st[1] st[2] st[3] st[4] st[5] st[6] st[7] st[8] st[9] st[10] st[11] st[12] st[13] st[14] st[15] st[16] st[17] st[18] st[19] st[20] st[21] st[22] st[23] st[24] st[25] st[26] st[27] st[28] st[29] st[30] st[31]}]