transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/user/Projects/cyclone_iv/spi/spi_if {/home/user/Projects/cyclone_iv/spi/spi_if/tb_spi.sv}
vlog -sv -work work +incdir+/home/user/Projects/cyclone_iv/spi/spi_if {/home/user/Projects/cyclone_iv/spi/spi_if/spi.sv}

