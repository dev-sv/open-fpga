onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider {Master BFM}

add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/clk_clk
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/reset_reset_n

add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_address
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_burstcount
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_byteenable
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_waitrequest
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_write
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_writedata

add wave -noupdate -divider {Dut HDMI}

add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/hdmi_clk_pix_p
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/hdmi_clk_pix_n
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/hdmi_red_p
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/hdmi_red_n
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/hdmi_green_p
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/hdmi_green_n
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/hdmi_blue_p
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/hdmi_blue_n


#TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}

configure wave -namecolwidth  350

#configure wave -valuecolwidth 100
#configure wave -justifyvalue left
#configure wave -signalnamewidth 0
#configure wave -snapdistance 10
#configure wave -datasetprefix 0
#configure wave -rowmargin 4
#configure wave -childrowmargin 2
#configure wave -gridoffset 0
#configure wave -gridperiod 1
#configure wave -griddelta 40
#configure wave -timeline 0
configure wave -timelineunits ps
#update
#WaveRestoreZoom {0 ps} {525 ns}

#run 1 us