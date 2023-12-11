transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlib hdmi_qsys
vmap hdmi_qsys hdmi_qsys
vlog -sv -work hdmi_qsys +incdir+/home/user/Projects/max10/hdmi/avalon_mm/testbench_ip/hdmi_qsys/synthesis/submodules {/home/user/Projects/max10/hdmi/avalon_mm/testbench_ip/hdmi_qsys/synthesis/submodules/hdmi_mm.sv}
vlog -sv -work work +incdir+/home/user/Projects/max10/hdmi/avalon_mm/testbench_ip {/home/user/Projects/max10/hdmi/avalon_mm/testbench_ip/tb_top.sv}

