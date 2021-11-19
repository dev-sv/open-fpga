

 transcript on
 
 set PRJ_DIR "c:/git/open-fpga/FpgaProjects/hdmi" 
 set UVM_DIR "c:/git/open-fpga/FpgaProjects/uvm-1.2/src"  
 set TB_DIR $PRJ_DIR/UTB/sync


 vlib $TB_DIR/work

 vlog -sv -novopt +define+UVM_NO_DPI +incdir+$UVM_DIR $UVM_DIR/uvm.sv $PRJ_DIR/sync.sv $TB_DIR/tb_sync.sv
 
 
 vsim tb_sync
 
 add wave /tb_sync/dif/clk_pix
 
 add wave /tb_sync/dif/de

 add wave /tb_sync/dif/vh
 
 add wave /tb_sync/dif/x
 
 add wave /tb_sync/dif/y
   
 
 run 1723881 

