transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Projects/FPGA/SystemVerilog/GitHubRelease/lcd_12864b {C:/Projects/FPGA/SystemVerilog/GitHubRelease/lcd_12864b/pll.v}
vlog -vlog01compat -work work +incdir+C:/Projects/FPGA/SystemVerilog/GitHubRelease/lcd_12864b {C:/Projects/FPGA/SystemVerilog/GitHubRelease/lcd_12864b/counter.v}
vlog -vlog01compat -work work +incdir+C:/Projects/FPGA/SystemVerilog/GitHubRelease/lcd_12864b/db {C:/Projects/FPGA/SystemVerilog/GitHubRelease/lcd_12864b/db/pll_altpll.v}
vlog -sv -work work +incdir+C:/Projects/FPGA/SystemVerilog/GitHubRelease/lcd_12864b {C:/Projects/FPGA/SystemVerilog/GitHubRelease/lcd_12864b/lcd_12864b.sv}
vlog -sv -work work +incdir+C:/Projects/FPGA/SystemVerilog/GitHubRelease/lcd_12864b {C:/Projects/FPGA/SystemVerilog/GitHubRelease/lcd_12864b/queue.sv}
vlog -sv -work work +incdir+C:/Projects/FPGA/SystemVerilog/GitHubRelease/lcd_12864b {C:/Projects/FPGA/SystemVerilog/GitHubRelease/lcd_12864b/lcd_12864b_top.sv}

