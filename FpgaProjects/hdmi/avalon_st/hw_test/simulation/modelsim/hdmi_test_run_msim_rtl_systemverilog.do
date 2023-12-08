transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlib hw_qsys
vmap hw_qsys hw_qsys
vlog -vlog01compat -work hw_qsys +incdir+/home/user/Projects/max10/hdmi/avalon_st/hw_test/hw_qsys/synthesis {/home/user/Projects/max10/hdmi/avalon_st/hw_test/hw_qsys/synthesis/hw_qsys.v}
vlog -vlog01compat -work hw_qsys +incdir+/home/user/Projects/max10/hdmi/avalon_st/hw_test/hw_qsys/synthesis/submodules {/home/user/Projects/max10/hdmi/avalon_st/hw_test/hw_qsys/synthesis/submodules/altera_reset_controller.v}
vlog -vlog01compat -work hw_qsys +incdir+/home/user/Projects/max10/hdmi/avalon_st/hw_test/hw_qsys/synthesis/submodules {/home/user/Projects/max10/hdmi/avalon_st/hw_test/hw_qsys/synthesis/submodules/altera_reset_synchronizer.v}
vlog -vlog01compat -work hw_qsys +incdir+/home/user/Projects/max10/hdmi/avalon_st/hw_test/hw_qsys/synthesis/submodules {/home/user/Projects/max10/hdmi/avalon_st/hw_test/hw_qsys/synthesis/submodules/hw_qsys_altpll_0.v}
vlog -sv -work hw_qsys +incdir+/home/user/Projects/max10/hdmi/avalon_st/hw_test/hw_qsys/synthesis/submodules {/home/user/Projects/max10/hdmi/avalon_st/hw_test/hw_qsys/synthesis/submodules/altera_avalon_st_pipeline_stage.sv}
vlog -vlog01compat -work hw_qsys +incdir+/home/user/Projects/max10/hdmi/avalon_st/hw_test/hw_qsys/synthesis/submodules {/home/user/Projects/max10/hdmi/avalon_st/hw_test/hw_qsys/synthesis/submodules/altera_avalon_st_pipeline_base.v}
vlog -sv -work hw_qsys +incdir+/home/user/Projects/max10/hdmi/avalon_st/hw_test/hw_qsys/synthesis/submodules {/home/user/Projects/max10/hdmi/avalon_st/hw_test/hw_qsys/synthesis/submodules/hdmi_st.sv}
vlog -sv -work work +incdir+/home/user/Projects/max10/hdmi/avalon_st/hw_test {/home/user/Projects/max10/hdmi/avalon_st/hw_test/hdmi_test.sv}
vlog -sv -work work +incdir+/home/user/Projects/max10/hdmi/avalon_st/hdmi_ip/ddio {/home/user/Projects/max10/hdmi/avalon_st/hdmi_ip/ddio/altera_gpio_lite.sv}

