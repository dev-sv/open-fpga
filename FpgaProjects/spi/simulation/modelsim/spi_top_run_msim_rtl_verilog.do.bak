transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Projects/spi {C:/Projects/spi/pll.v}
vlog -vlog01compat -work work +incdir+C:/Projects/spi/db {C:/Projects/spi/db/pll_altpll.v}
vlog -sv -work work +incdir+C:/Projects/spi {C:/Projects/spi/spi_if.sv}
vlog -sv -work work +incdir+C:/Projects/spi {C:/Projects/spi/max7219.sv}
vlog -sv -work work +incdir+C:/Projects/spi {C:/Projects/spi/spi_top.sv}
vlog -sv -work work +incdir+C:/Projects/spi {C:/Projects/spi/spi.sv}
vlog -sv -work work +incdir+C:/Projects/spi {C:/Projects/spi/w25q32.sv}

