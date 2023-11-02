transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/user/Projects/max10/adc_max10/avalon/testbench_ip {/home/user/Projects/max10/adc_max10/avalon/testbench_ip/adc_ip.sv}

