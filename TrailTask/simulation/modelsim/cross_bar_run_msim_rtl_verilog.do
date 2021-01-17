transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Projects/FPGA/SystemVerilog/TrailTask {C:/Projects/FPGA/SystemVerilog/TrailTask/pkg.sv}
vlog -sv -work work +incdir+C:/Projects/FPGA/SystemVerilog/TrailTask {C:/Projects/FPGA/SystemVerilog/TrailTask/cross_bar.sv}

