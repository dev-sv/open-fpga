transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/git/open-fpga/FpgaProjects/hdmi {C:/git/open-fpga/FpgaProjects/hdmi/ddio.vo}
vlib ddio
vmap ddio ddio
vlog -vlog01compat -work ddio +incdir+C:/git/open-fpga/FpgaProjects/hdmi {C:/git/open-fpga/FpgaProjects/hdmi/ddio.v}
vlog -vlog01compat -work work +incdir+C:/git/open-fpga/FpgaProjects/LogicSlice {C:/git/open-fpga/FpgaProjects/LogicSlice/pll_hdmi.v}
vlog -vlog01compat -work work +incdir+C:/git/open-fpga/FpgaProjects/LogicSlice {C:/git/open-fpga/FpgaProjects/LogicSlice/counter_smp.v}
vlog -vlog01compat -work work +incdir+C:/git/open-fpga/FpgaProjects/LogicSlice/db {C:/git/open-fpga/FpgaProjects/LogicSlice/db/pll_hdmi_altpll.v}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/hdmi {C:/git/open-fpga/FpgaProjects/hdmi/hdmi.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/LogicSlice {C:/git/open-fpga/FpgaProjects/LogicSlice/debouncer.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/LogicSlice {C:/git/open-fpga/FpgaProjects/LogicSlice/channel.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/LogicSlice {C:/git/open-fpga/FpgaProjects/LogicSlice/ls_if.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/LogicSlice {C:/git/open-fpga/FpgaProjects/LogicSlice/wave.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/hdmi {C:/git/open-fpga/FpgaProjects/hdmi/tmds_serial.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/hdmi {C:/git/open-fpga/FpgaProjects/hdmi/tmds_encoder.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/hdmi {C:/git/open-fpga/FpgaProjects/hdmi/sync.sv}
vlog -sv -work ddio +incdir+C:/git/open-fpga/FpgaProjects/hdmi/ddio {C:/git/open-fpga/FpgaProjects/hdmi/ddio/altera_gpio_lite.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/LogicSlice {C:/git/open-fpga/FpgaProjects/LogicSlice/encoder.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/LogicSlice {C:/git/open-fpga/FpgaProjects/LogicSlice/display_data.sv}
vlog -sv -work work +incdir+C:/git/open-fpga/FpgaProjects/LogicSlice {C:/git/open-fpga/FpgaProjects/LogicSlice/ls.sv}

