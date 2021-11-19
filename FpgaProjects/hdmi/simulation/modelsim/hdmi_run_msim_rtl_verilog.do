transcript on
if ![file isdirectory hdmi_iputf_libs] {
	file mkdir hdmi_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
vlib hdmi_iputf_libs/ddio
vmap ddio ./hdmi_iputf_libs/ddio
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vlog -sv "C:/git/open-fpga/FpgaProjects/hdmi/ddio_sim/altera_gpio_lite/altera_gpio_lite.sv" -work ddio
vlog     "C:/git/open-fpga/FpgaProjects/hdmi/ddio_sim/ddio.v"                                         

vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/hdmi {C:/git/open-fpga/FpgaProjects/hdmi/hdmi.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/hdmi {C:/git/open-fpga/FpgaProjects/hdmi/sync.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/hdmi {C:/git/open-fpga/FpgaProjects/hdmi/tmds_encoder.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/hdmi {C:/git/open-fpga/FpgaProjects/hdmi/tmds_serial.sv}

