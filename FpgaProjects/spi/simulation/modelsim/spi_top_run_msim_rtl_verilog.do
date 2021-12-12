transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/git/open-fpga/FpgaProjects/spi {C:/git/open-fpga/FpgaProjects/spi/pll.v}
vlog -vlog01compat -work work +incdir+C:/git/open-fpga/FpgaProjects/spi/db {C:/git/open-fpga/FpgaProjects/spi/db/pll_altpll.v}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/spi {C:/git/open-fpga/FpgaProjects/spi/spi_if.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/spi {C:/git/open-fpga/FpgaProjects/spi/max7219.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/spi {C:/git/open-fpga/FpgaProjects/spi/spi_top.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/spi {C:/git/open-fpga/FpgaProjects/spi/spi.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/spi {C:/git/open-fpga/FpgaProjects/spi/w25q32.sv}

