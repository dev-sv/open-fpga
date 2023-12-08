# Set the hierarchy variables used in Qsys-generated msim_setup.tcl
set TOP_LEVEL_NAME "top"
set SYSTEM_INSTANCE_NAME "tb"

set QSYS_SIMDIR "../hdmi_qsys/testbench"
set DIR_IP "/home/user/Projects/max10/hdmi/avalon_st"

source $QSYS_SIMDIR/mentor/msim_setup.tcl

# Compile device library files
dev_com

# Compile the design files in correct order
com


# Compile the additional test files

vlog -sv $DIR_IP/hdmi_ip/tmds_encoder.sv
vlog -sv $DIR_IP/hdmi_ip/tmds_serial.sv
vlog -sv $DIR_IP/hdmi_ip/ddio_sim/altera_gpio_lite/altera_gpio_lite.sv
vlog -sv $DIR_IP/hdmi_ip/ddio_sim/ddio.v

vlog -sv ./tmds_rx.sv
vlog -sv ./tb_hdmi.sv
vlog -sv ./top.sv

# Elaborate top level design
elab_debug

# Load the waveform "do file" Tcl script
do ./wave.do

# Log 
#add log -r sim:/top/tb/*