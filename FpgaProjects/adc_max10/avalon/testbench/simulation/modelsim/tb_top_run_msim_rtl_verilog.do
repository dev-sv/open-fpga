transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/user/Projects/ip/adc_max10/avalon/testbench {/home/user/Projects/ip/adc_max10/avalon/testbench/tb_top.sv}

