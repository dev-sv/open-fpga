create_clock -name virt_clk_in -period 20.000 -waveform {0 10}
create_clock -name virt_clk_out -period 20.000 -waveform {0 10}
set_input_delay -clock { virt_clk_in } -min 0 [get_ports {baud[0] baud[1] baud[2] baud[3] baud[4] baud[5] baud[6] baud[7] baud[8] baud[9] baud[10] baud[11] baud[12] baud[13] baud[14] baud[15] baud[16] baud[17] baud[18] baud[19] baud[20] baud[21] baud[22] baud[23] baud[24] baud[25] baud[26] baud[27] baud[28] baud[29] baud[30] baud[31] en_tx rx tx_data[0][0] tx_data[0][1] tx_data[0][2] tx_data[0][3] tx_data[0][4] tx_data[0][5] tx_data[0][6] tx_data[0][7]}]
set_input_delay -clock { virt_clk_in } -max 1 [get_ports {baud[0] baud[1] baud[2] baud[3] baud[4] baud[5] baud[6] baud[7] baud[8] baud[9] baud[10] baud[11] baud[12] baud[13] baud[14] baud[15] baud[16] baud[17] baud[18] baud[19] baud[20] baud[21] baud[22] baud[23] baud[24] baud[25] baud[26] baud[27] baud[28] baud[29] baud[30] baud[31] rx en_tx tx_data[0][0] tx_data[0][1] tx_data[0][2] tx_data[0][3] tx_data[0][4] tx_data[0][5] tx_data[0][6] tx_data[0][7]}]
set_output_delay -clock { virt_clk_out } -min 0 [get_ports {rx_data[0][0] rx_data[0][1] rx_data[0][2] rx_data[0][3] rx_data[0][4] rx_data[0][5] rx_data[0][6] rx_data[0][7] rx_full tx_busy tx}]
set_output_delay -clock { virt_clk_out } -max 1 [get_ports {rx_data[0][0] rx_data[0][1] rx_data[0][2] rx_data[0][3] rx_data[0][4] rx_data[0][5] rx_data[0][6] rx_data[0][7] rx_full tx_busy tx}]
