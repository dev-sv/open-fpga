transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Projects/max10/hdmi {C:/Projects/max10/hdmi/ddio.vo}
vlib ddio
vmap ddio ddio
vlog -vlog01compat -work ddio +incdir+C:/Projects/max10/hdmi {C:/Projects/max10/hdmi/ddio.v}
vlog -vlog01compat -work work +incdir+C:/Projects/max10/LogicSlice {C:/Projects/max10/LogicSlice/pll_hdmi.v}
vlog -vlog01compat -work work +incdir+C:/Projects/max10/LogicSlice {C:/Projects/max10/LogicSlice/counter_smp.v}
vlog -vlog01compat -work work +incdir+C:/Projects/max10/LogicSlice/db {C:/Projects/max10/LogicSlice/db/pll_hdmi_altpll.v}
vlog -sv -work work +incdir+C:/Projects/max10/hdmi {C:/Projects/max10/hdmi/hdmi.sv}
vlog -sv -work work +incdir+C:/Projects/max10/LogicSlice {C:/Projects/max10/LogicSlice/string.sv}
vlog -sv -work work +incdir+C:/Projects/max10/LogicSlice {C:/Projects/max10/LogicSlice/debouncer.sv}
vlog -sv -work work +incdir+C:/Projects/max10/LogicSlice {C:/Projects/max10/LogicSlice/ls_if.sv}
vlog -sv -work work +incdir+C:/Projects/max10/LogicSlice {C:/Projects/max10/LogicSlice/wave.sv}
vlog -sv -work work +incdir+C:/Projects/max10/hdmi {C:/Projects/max10/hdmi/tmds_serial.sv}
vlog -sv -work work +incdir+C:/Projects/max10/hdmi {C:/Projects/max10/hdmi/tmds_encoder.sv}
vlog -sv -work work +incdir+C:/Projects/max10/hdmi {C:/Projects/max10/hdmi/sync.sv}
vlog -sv -work ddio +incdir+C:/Projects/max10/hdmi/ddio {C:/Projects/max10/hdmi/ddio/altera_gpio_lite.sv}
vlog -sv -work work +incdir+C:/Projects/max10/LogicSlice {C:/Projects/max10/LogicSlice/encoder.sv}
vlog -sv -work work +incdir+C:/Projects/max10/LogicSlice {C:/Projects/max10/LogicSlice/display_data.sv}
vlog -sv -work work +incdir+C:/Projects/max10/LogicSlice {C:/Projects/max10/LogicSlice/ls.sv}

