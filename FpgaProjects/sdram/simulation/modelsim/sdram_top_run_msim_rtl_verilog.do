transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Projects/FPGA/SystemVerilog/sdram {C:/Projects/FPGA/SystemVerilog/sdram/pll.v}
vlog -vlog01compat -work work +incdir+C:/Projects/FPGA/SystemVerilog/sdram/db {C:/Projects/FPGA/SystemVerilog/sdram/db/pll_altpll.v}
vlog -sv -work work +incdir+C:/Projects/FPGA/SystemVerilog/sdram {C:/Projects/FPGA/SystemVerilog/sdram/sdram.sv}
vlog -sv -work work +incdir+C:/Projects/FPGA/SystemVerilog/sdram {C:/Projects/FPGA/SystemVerilog/sdram/sdram_top.sv}

