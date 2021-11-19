

 transcript on

 
 set PRJ_DIR "c:/git/open-fpga/FpgaProjects/LogicSlice" 
 set UVM_DIR "c:/git/open-fpga/FpgaProjects/uvm-1.2/src" 
 set TB_DIR $PRJ_DIR/UTB/channel


 vlib $TB_DIR/work

 vlog -sv -novopt +define+UVM_NO_DPI +incdir+$UVM_DIR $UVM_DIR/uvm.sv $PRJ_DIR/ls_if.sv $PRJ_DIR/channel.sv $TB_DIR/tb_channel.sv
 
 
 vsim tb_channel
 
 add wave /tb_channel/channel/clk
 
 add wave /tb_channel/channel/in
  
 add wave /tb_channel/channel/ch
      
 run 1928
