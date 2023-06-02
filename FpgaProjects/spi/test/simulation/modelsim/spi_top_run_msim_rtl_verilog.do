transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/user/Projects/cyclone_iv/spi/test {/home/user/Projects/cyclone_iv/spi/test/pll.v}
vlog -vlog01compat -work work +incdir+/home/user/Projects/cyclone_iv/spi/test/db {/home/user/Projects/cyclone_iv/spi/test/db/pll_altpll.v}
vlog -sv -work work +incdir+/home/user/Projects/cyclone_iv/spi/spi_if {/home/user/Projects/cyclone_iv/spi/spi_if/spi.sv}
vlog -sv -work work +incdir+/home/user/Projects/cyclone_iv/spi/test {/home/user/Projects/cyclone_iv/spi/test/spi_top.sv}

