transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/git/open-fpga/FpgaProjects/uart {C:/git/open-fpga/FpgaProjects/uart/pll.v}
vlog -vlog01compat -work work +incdir+C:/git/open-fpga/FpgaProjects/uart/db {C:/git/open-fpga/FpgaProjects/uart/db/pll_altpll.v}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/uart {C:/git/open-fpga/FpgaProjects/uart/uart.sv}

