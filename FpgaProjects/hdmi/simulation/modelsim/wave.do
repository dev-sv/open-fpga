onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_tmds_encoder/dif/clk_pix
add wave -noupdate /tb_tmds_encoder/dif/de
add wave -noupdate /tb_tmds_encoder/dif/vh
add wave -noupdate /tb_tmds_encoder/dif/color
add wave -noupdate /tb_tmds_encoder/dif/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 193
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {962 ps}
