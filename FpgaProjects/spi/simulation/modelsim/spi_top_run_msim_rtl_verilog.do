transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Projects/FPGA/SystemVerilog/GitHubRelease/spi {C:/Projects/FPGA/SystemVerilog/GitHubRelease/spi/pll.v}
vlog -vlog01compat -work work +incdir+C:/Projects/FPGA/SystemVerilog/GitHubRelease/spi/db {C:/Projects/FPGA/SystemVerilog/GitHubRelease/spi/db/pll_altpll.v}
vlog -sv -work work +incdir+C:/Projects/FPGA/SystemVerilog/GitHubRelease/spi {C:/Projects/FPGA/SystemVerilog/GitHubRelease/spi/max7219.sv}
vlog -sv -work work +incdir+C:/Projects/FPGA/SystemVerilog/GitHubRelease/spi {C:/Projects/FPGA/SystemVerilog/GitHubRelease/spi/spi_top.sv}
vlog -sv -work work +incdir+C:/Projects/FPGA/SystemVerilog/GitHubRelease/spi {C:/Projects/FPGA/SystemVerilog/GitHubRelease/spi/spi.sv}
vlog -sv -work work +incdir+C:/Projects/FPGA/SystemVerilog/GitHubRelease/spi {C:/Projects/FPGA/SystemVerilog/GitHubRelease/spi/w25q32.sv}

