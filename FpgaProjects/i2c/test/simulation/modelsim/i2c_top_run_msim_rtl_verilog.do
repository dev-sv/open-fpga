transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/user/Projects/cyclone_iv/i2c/hw_test {/home/user/Projects/cyclone_iv/i2c/hw_test/pll.v}
vlog -sv -work work +incdir+/home/user/Projects/cyclone_iv/i2c/hw_test {/home/user/Projects/cyclone_iv/i2c/hw_test/count.v}
vlog -sv -work work +incdir+/home/user/Projects/cyclone_iv/i2c/hw_test/db {/home/user/Projects/cyclone_iv/i2c/hw_test/db/pll_altpll1.v}
vlog -sv -work work +incdir+/home/user/Projects/cyclone_iv/i2c/i2c_if {/home/user/Projects/cyclone_iv/i2c/i2c_if/i2c.sv}
vlog -sv -work work +incdir+/home/user/Projects/cyclone_iv/i2c/hw_test {/home/user/Projects/cyclone_iv/i2c/hw_test/i2c_top.sv}
vlog -sv -work work +incdir+/home/user/Projects/cyclone_iv/i2c/hw_test {/home/user/Projects/cyclone_iv/i2c/hw_test/hw_test.sv}

