transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/git/open-fpga/FpgaProjects/i2c {C:/git/open-fpga/FpgaProjects/i2c/pll.v}
vlog -vlog01compat -work work +incdir+C:/git/open-fpga/FpgaProjects/i2c {C:/git/open-fpga/FpgaProjects/i2c/counter.v}
vlog -vlog01compat -work work +incdir+C:/git/open-fpga/FpgaProjects/i2c/db {C:/git/open-fpga/FpgaProjects/i2c/db/pll_altpll.v}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/i2c {C:/git/open-fpga/FpgaProjects/i2c/i2c.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/i2c {C:/git/open-fpga/FpgaProjects/i2c/lcd_1602.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/i2c {C:/git/open-fpga/FpgaProjects/i2c/i2c_top.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/i2c {C:/git/open-fpga/FpgaProjects/i2c/ds1307.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/i2c {C:/git/open-fpga/FpgaProjects/i2c/at24c04.sv}

