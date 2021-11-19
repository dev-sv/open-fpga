

 transcript on

 
 set PRJ_DIR "c:/git/open-fpga/FpgaProjects/hdmi" 
 set UVM_DIR "c:/git/open-fpga/FpgaProjects/uvm-1.2/src"
 set TB_DIR $PRJ_DIR/UTB/tmds_encoder


 vlib $TB_DIR/work

 vlog -sv -novopt +define+UVM_NO_DPI +incdir+$UVM_DIR $UVM_DIR/uvm.sv $PRJ_DIR/tmds_encoder.sv $TB_DIR/tb_tmds_encoder.sv
 
 
 vsim tb_tmds_encoder
 
 add wave /tb_tmds_encoder/dif/clk_pix
 
 add wave /tb_tmds_encoder/dif/de

 add wave /tb_tmds_encoder/dif/vh
 
 add wave /tb_tmds_encoder/dif/color
 
 add wave /tb_tmds_encoder/dif/out
   
 run 4096
