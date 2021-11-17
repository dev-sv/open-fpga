transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/zzz/open-fpga/FpgaProjects/lcd_12864b {C:/zzz/open-fpga/FpgaProjects/lcd_12864b/pll_osc.v}
vlog -vlog01compat -work work +incdir+C:/zzz/open-fpga/FpgaProjects/lcd_12864b {C:/zzz/open-fpga/FpgaProjects/lcd_12864b/counter.v}
vlog -vlog01compat -work work +incdir+C:/zzz/open-fpga/FpgaProjects/lcd_12864b/db {C:/zzz/open-fpga/FpgaProjects/lcd_12864b/db/pll_osc_altpll.v}
vlog -sv -work work +incdir+C:/zzz/open-fpga/FpgaProjects/lcd_12864b {C:/zzz/open-fpga/FpgaProjects/lcd_12864b/lcd_12864b.sv}
vlog -sv -work work +incdir+C:/zzz/open-fpga/FpgaProjects/lcd_12864b {C:/zzz/open-fpga/FpgaProjects/lcd_12864b/queue.sv}
vlog -sv -work work +incdir+C:/zzz/open-fpga/FpgaProjects/lcd_12864b {C:/zzz/open-fpga/FpgaProjects/lcd_12864b/lcd_12864b_top.sv}

