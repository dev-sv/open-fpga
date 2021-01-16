transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Projects/FPGA/SystemVerilog/GitHubRelease/uart {C:/Projects/FPGA/SystemVerilog/GitHubRelease/uart/pll.v}
vlog -vlog01compat -work work +incdir+C:/Projects/FPGA/SystemVerilog/GitHubRelease/uart/db {C:/Projects/FPGA/SystemVerilog/GitHubRelease/uart/db/pll_altpll.v}
vlog -sv -work work +incdir+C:/Projects/FPGA/SystemVerilog/GitHubRelease/uart {C:/Projects/FPGA/SystemVerilog/GitHubRelease/uart/uart.sv}

