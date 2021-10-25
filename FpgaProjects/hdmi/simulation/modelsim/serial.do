

 transcript on

 set PRJ_DIR "c:/Projects/Ls/max10/hdmi"
 set UVM_DIR "c:/Projects/uvm-1.2/src"
 set TB_DIR $PRJ_DIR/UTB/tmds_serial


 vlib $TB_DIR/work

 vlog -sv -novopt +define+UVM_NO_DPI +incdir+$UVM_DIR $UVM_DIR/uvm.sv $PRJ_DIR/tmds_serial.sv \
           $TB_DIR/tb_tmds_serial.sv $PRJ_DIR/ddio_sim/altera_gpio_lite/altera_gpio_lite.sv
 
 vsim tb_tmds_serial -L altera_ver -L fiftyfivenm_ver
 
 add wave /tb_tmds_serial/dif/clk_x10
 
 add wave /tb_tmds_serial/dif/d

 add wave /tb_tmds_serial/dif/p
 
 add wave /tb_tmds_serial/dif/n
  
 run 204800
 