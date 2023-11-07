create_clock -name clk -period 10.000 [get_ports {clk}]
derive_pll_clocks
derive_clock_uncertainty

set Tsu 		1.5
set Th  		0.8
set Tco 		1.8
set Data_delay_max 	0.2 
set Data_delay_min 	0.1
set Clock_delay_max 	0.2
set Clock_delay_min 	0.1
 
create_generated_clock -name osc -source pll_inst|altpll_component|auto_generated|pll1|clk[0] [get_ports {osc}]

set_input_delay -clock { osc } -max [expr $Clock_delay_max + $Tco + $Data_delay_max] [get_ports {dq[0] dq[1] dq[2] dq[3] dq[4] dq[5] dq[6] dq[7] dq[8] dq[9] dq[10] dq[11] dq[12] dq[13] dq[14] dq[15]}]
set_input_delay -clock { osc } -min [expr $Clock_delay_min + $Tco + $Data_delay_min] [get_ports {dq[0] dq[1] dq[2] dq[3] dq[4] dq[5] dq[6] dq[7] dq[8] dq[9] dq[10] dq[11] dq[12] dq[13] dq[14] dq[15]}]

set_output_delay -clock { osc } -max [expr $Data_delay_max + $Tsu - $Clock_delay_min] [get_ports {address[0] address[1] address[2] address[3] address[4] address[5] address[6] address[7] address[8] address[9] address[10] address[11] ba[0] ba[1] cas cs dq[0] dq[1] dq[2] dq[3] dq[4] dq[5] dq[6] dq[7] dq[8] dq[9] dq[10] dq[11] dq[12] dq[13] dq[14] dq[15] dqm[0] dqm[1] ras we}]
set_output_delay -clock { osc } -min [expr $Data_delay_min - $Th - $Clock_delay_max] [get_ports {address[0] address[1] address[2] address[3] address[4] address[5] address[6] address[7] address[8] address[9] address[10] address[11] ba[0] ba[1] cas cs dq[0] dq[1] dq[2] dq[3] dq[4] dq[5] dq[6] dq[7] dq[8] dq[9] dq[10] dq[11] dq[12] dq[13] dq[14] dq[15] dqm[0] dqm[1] ras we}]

set_false_path -from [get_clocks {pll_inst|altpll_component|auto_generated|pll1|clk[0]}] -to [get_ports {led[0] led[1] led[2] led[3] led[4] led[5] led[6] led[7]}]