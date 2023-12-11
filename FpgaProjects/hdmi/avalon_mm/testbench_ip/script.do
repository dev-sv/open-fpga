
set DIR /home/user/Projects/max10/hdmi/avalon_mm
set LIB /home/user/intelFPGA_lite/18.0/modelsim_ase/altera/verilog

vlib work
vmap work work

vlog -reportprogress 300 -work work $DIR/testbench_ip/hdmi_qsys/synthesis/submodules/verbosity_pkg.sv
vlog -reportprogress 300 -work work $DIR/testbench_ip/hdmi_qsys/synthesis/submodules/avalon_mm_pkg.sv
vlog -reportprogress 300 -work work $DIR/testbench_ip/hdmi_qsys/synthesis/submodules/avalon_utilities_pkg.sv
vlog -reportprogress 300 -work work $DIR/testbench_ip/hdmi_qsys/synthesis/submodules/altera_avalon_mm_master_bfm.sv

vlog -reportprogress 300 -work work $DIR/testbench_ip/hdmi_qsys/synthesis/submodules/*.sv
vlog -reportprogress 300 -work work $DIR/testbench_ip/hdmi_qsys/synthesis/submodules/*.v
vlog -reportprogress 300 -work work $DIR/testbench_ip/hdmi_qsys/synthesis/hdmi_qsys.v
vlog -reportprogress 300 -work work ./master_bfm_tb.sv

vlog -reportprogress 300 -work work $DIR/hdmi_ip/ddio_sim/altera_gpio_lite/altera_gpio_lite.sv
vlog -reportprogress 300 -work work $DIR/hdmi_ip/ddio_sim/ddio.v
vlog -reportprogress 300 -work work $DIR/hdmi_ip/tmds_serial.sv
vlog -reportprogress 300 -work work $DIR/hdmi_ip/tmds_encoder.sv

vlog -reportprogress 300 -work work ./tmds_rx.sv

vsim work.master_bfm_tb -L $LIB/altera -L $LIB/fiftyfivenm 

#view wave

do wave.do

run 10800 us

