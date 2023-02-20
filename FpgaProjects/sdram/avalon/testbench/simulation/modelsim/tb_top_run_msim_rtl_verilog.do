transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/user/Projects/ip/sdram_micron/avalon/testbench {/home/user/Projects/ip/sdram_micron/avalon/testbench/tb_top.sv}

