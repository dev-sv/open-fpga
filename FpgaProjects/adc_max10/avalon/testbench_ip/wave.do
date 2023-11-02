onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Master BFM}

add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/master_bfm/clk
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/master_bfm/reset
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_address
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_byteenable
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_waitrequest
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_write
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_writedata
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_read
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_readdata
add wave -noupdate -format Logic /master_bfm_tb/tb/master_bfm/avm_readdatavalid

add wave -noupdate -divider Adc_Slave_Avalon

add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/adc_max10/clk
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/adc_max10/reset
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/adc_max10/aclk
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/adc_max10/burstcount
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/adc_max10/byteenable
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/adc_max10/readdatavalid
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/adc_max10/address
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/adc_max10/read
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/adc_max10/readdata
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/adc_max10/waitrequest
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/adc_max10/write
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/adc_max10/writedata

add wave -format Analog -Height 84 -Max 4000 -radix unsigned /master_bfm_tb/tb/adc_max10/adc_inst/dout


#TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 358
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
