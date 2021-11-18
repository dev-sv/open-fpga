transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Projects/i2c {C:/Projects/i2c/pll.v}
vlog -vlog01compat -work work +incdir+C:/Projects/i2c {C:/Projects/i2c/counter.v}
vlog -vlog01compat -work work +incdir+C:/Projects/i2c/db {C:/Projects/i2c/db/pll_altpll.v}
vlog -sv -work work +incdir+C:/Projects/i2c {C:/Projects/i2c/i2c.sv}
vlog -sv -work work +incdir+C:/Projects/i2c {C:/Projects/i2c/lcd_1602.sv}
vlog -sv -work work +incdir+C:/Projects/i2c {C:/Projects/i2c/i2c_top.sv}
vlog -sv -work work +incdir+C:/Projects/i2c {C:/Projects/i2c/ds1307.sv}
vlog -sv -work work +incdir+C:/Projects/i2c {C:/Projects/i2c/at24c04.sv}

