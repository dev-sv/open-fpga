transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlib zzz
vmap zzz zzz
vlog -sv -work zzz +incdir+/home/user/Projects/ip/adc_max10/avalon/testbench/zzz/synthesis/submodules {/home/user/Projects/ip/adc_max10/avalon/testbench/zzz/synthesis/submodules/adc.sv}
vlog -sv -work work +incdir+/home/user/Projects/ip/adc_max10/avalon/testbench {/home/user/Projects/ip/adc_max10/avalon/testbench/tb_top.sv}

