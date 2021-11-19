


 transcript on
 
 set PRJ_DIR "c:/git/open-fpga/FpgaProjects/LogicSlice" 
 set UVM_DIR "c:/git/open-fpga/FpgaProjects/uvm-1.2/src"  
 set TB_DIR $PRJ_DIR/UTB/debouncer


 vlib $TB_DIR/work

 vlog -sv -novopt +define+UVM_NO_DPI +incdir+$UVM_DIR $UVM_DIR/uvm.sv $PRJ_DIR/ls_if.sv $PRJ_DIR/debouncer.sv $TB_DIR/tb_debouncer.sv
 
 
 vsim tb_debouncer
 
 add wave /tb_debouncer/debouncer/clk_pix
 
 add wave /tb_debouncer/debouncer/in
 
 add wave /tb_debouncer/debouncer/out
 
 add wave /tb_debouncer/debouncer/delay
 
    
 run 1000
