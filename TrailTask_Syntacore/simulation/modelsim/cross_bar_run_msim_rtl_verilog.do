transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Projects/FPGA/SystemVerilog/GHRelease/TrailTask_Syntacore {C:/Projects/FPGA/SystemVerilog/GHRelease/TrailTask_Syntacore/pkg.sv}
vlog -sv -work work +incdir+C:/Projects/FPGA/SystemVerilog/GHRelease/TrailTask_Syntacore {C:/Projects/FPGA/SystemVerilog/GHRelease/TrailTask_Syntacore/cross_bar.sv}

