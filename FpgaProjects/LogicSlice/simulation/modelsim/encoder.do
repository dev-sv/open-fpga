


 transcript on
 
 set PRJ_DIR "c:/git/open-fpga/FpgaProjects/LogicSlice" 
 set UVM_DIR "c:/git/open-fpga/FpgaProjects/uvm-1.2/src"  
 set TB_DIR $PRJ_DIR/UTB/encoder


 vlib $TB_DIR/work

 vlog -sv -novopt +define+UVM_NO_DPI +incdir+$UVM_DIR $UVM_DIR/uvm.sv $PRJ_DIR/ls_if.sv $PRJ_DIR/encoder.sv $TB_DIR/tb_encoder.sv
 
 
 vsim tb_encoder
 
 add wave /tb_encoder/encoder/clk_pix
  
 add wave /tb_encoder/encoder/clk
 
 add wave /tb_encoder/encoder/dt
 
 add wave /tb_encoder/encoder/data
 
 add wave /tb_encoder/encoder/p
    
 run 16384
