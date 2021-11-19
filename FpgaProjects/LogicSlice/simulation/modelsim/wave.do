



 transcript on
 
 set PRJ_DIR "c:/git/open-fpga/FpgaProjects/LogicSlice" 
 set UVM_DIR "c:/git/open-fpga/FpgaProjects/uvm-1.2/src"   
 set TB_DIR $PRJ_DIR/UTB/wave


 vlib $TB_DIR/work

 vlog -sv -novopt +define+UVM_NO_DPI +incdir+$UVM_DIR $UVM_DIR/uvm.sv $PRJ_DIR/ls_if.sv $PRJ_DIR/wave.sv $TB_DIR/tb_wave.sv
 
 
 vsim tb_wave
 
 add wave /tb_wave/wave/clk_pix
 
 add wave /tb_wave/wave/x
 
 add wave /tb_wave/wave/y
 
 add wave /tb_wave/wave/ch
 
 add wave /tb_wave/wave/s
     
 run 307200

