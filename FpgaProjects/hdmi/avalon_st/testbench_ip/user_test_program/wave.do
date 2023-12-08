onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -radix hexadecimal /top/tb/hdmi_qsys_inst_clk_bfm/clk
add wave -noupdate -radix hexadecimal /top/tb/hdmi_qsys_inst_reset_bfm/reset

add wave -noupdate -divider {Source BFM}

add wave -noupdate -radix hexadecimal /top/tb/hdmi_qsys_inst_st_in_bfm/src_data
add wave -noupdate -radix hexadecimal /top/tb/hdmi_qsys_inst_st_in_bfm/src_valid
add wave -noupdate -radix hexadecimal /top/tb/hdmi_qsys_inst_st_in_bfm/src_ready

add wave -noupdate -divider {Dut HDMI}

add wave -noupdate -radix hexadecimal /top/tb/hdmi_qsys_inst_hdmi_bfm/sig_clk_pix_p
add wave -noupdate -radix hexadecimal /top/tb/hdmi_qsys_inst_hdmi_bfm/sig_clk_pix_n

add wave -noupdate -radix hexadecimal /top/tb/hdmi_qsys_inst_hdmi_bfm/sig_red_p
add wave -noupdate -radix hexadecimal /top/tb/hdmi_qsys_inst_hdmi_bfm/sig_red_n

add wave -noupdate -radix hexadecimal /top/tb/hdmi_qsys_inst_hdmi_bfm/sig_green_p
add wave -noupdate -radix hexadecimal /top/tb/hdmi_qsys_inst_hdmi_bfm/sig_green_n

add wave -noupdate -radix hexadecimal /top/tb/hdmi_qsys_inst_hdmi_bfm/sig_blue_p
add wave -noupdate -radix hexadecimal /top/tb/hdmi_qsys_inst_hdmi_bfm/sig_blue_n


TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {960609 ps} {1187791 ps}

run 10.8 ms
