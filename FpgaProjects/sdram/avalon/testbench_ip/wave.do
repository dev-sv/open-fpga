onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Master BFM}

add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/master_bfm/clk
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/master_bfm/reset
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_address

add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_burstcount

add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_byteenable
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_waitrequest
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_write
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_writedata
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_read
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/master_bfm/avm_readdata
add wave -noupdate -format Logic /master_bfm_tb/tb/master_bfm/avm_readdatavalid

add wave -noupdate -divider Sdram_Slave_Avalon

add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/sdram_avl/clk
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/sdram_avl/reset
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/sdram_avl/s_burstcount
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/sdram_avl/s_byteenable
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/sdram_avl/s_readdatavalid
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/sdram_avl/s_address
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/sdram_avl/s_read
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/sdram_avl/s_readdata
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/sdram_avl/s_waitrequest
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/sdram_avl/s_write
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/sdram_avl/s_writedata

add wave -noupdate -divider Sdram_interface

add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/sdram_avl/osc
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/sdram_avl/cs
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/sdram_avl/we
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/sdram_avl/ras
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/sdram_avl/cas
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/sdram_avl/address
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/sdram_avl/ba
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/sdram_avl/dqm
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/sdram_avl/dq


#add wave -format Analog -Height 84 -Max 4000 -radix unsigned /master_bfm_tb/tb/adc_max10/adc_inst/dout


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
