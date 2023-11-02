
set DIR /home/user/Projects/max10/adc_max10/avalon
set LIB /home/user/intelFPGA_lite/18.0/modelsim_ase/altera/verilog

vlib work
vmap work work

vlog -reportprogress 300 -work work $DIR/testbench_ip/adc_qsys/synthesis/submodules/verbosity_pkg.sv
vlog -reportprogress 300 -work work $DIR/testbench_ip/adc_qsys/synthesis/submodules/avalon_mm_pkg.sv
vlog -reportprogress 300 -work work $DIR/testbench_ip/adc_qsys/synthesis/submodules/avalon_utilities_pkg.sv
vlog -reportprogress 300 -work work $DIR/testbench_ip/adc_qsys/synthesis/submodules/altera_avalon_mm_master_bfm.sv

vlog -reportprogress 300 -work work $DIR/testbench_ip/adc_qsys/synthesis/submodules/*.sv
vlog -reportprogress 300 -work work $DIR/testbench_ip/adc_qsys/synthesis/submodules/*.v
vlog -reportprogress 300 -work work $DIR/testbench_ip/adc_qsys/synthesis/adc_qsys.v
vlog -reportprogress 300 -work work ./master_bfm_tb.sv

vlog -reportprogress 300  $DIR/adc_ip/adc_core/synthesis/submodules/chsel_code_converter_sw_to_hw.v
vlog -reportprogress 300  $DIR/adc_ip/adc_core/synthesis/submodules/fiftyfivenm_adcblock_primitive_wrapper.v
vlog -reportprogress 300  $DIR/adc_ip/adc_core/synthesis/submodules/fiftyfivenm_adcblock_top_wrapper.v

vsim work.master_bfm_tb -L $LIB/fiftyfivenm

#view wave

do wave.do

run 32769 us
