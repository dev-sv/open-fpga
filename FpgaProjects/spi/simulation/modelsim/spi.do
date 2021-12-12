



 transcript on

 set PRJ_DIR "c:/git/open-fpga/FpgaProjects/spi"
 set UVM_DIR "c:/Projects/uvm-1.2/src" 
 set TB_DIR $PRJ_DIR/UTB/spi
 
 vlib $TB_DIR/work


 vlog -sv -novopt +define+UVM_NO_DPI +incdir+$UVM_DIR $UVM_DIR/uvm.sv $PRJ_DIR/spi_if.sv $PRJ_DIR/spi.sv $TB_DIR/tb_spi.sv
 
 
 vsim tb_spi
 
 add wave /tb_spi/clk
 add wave /tb_spi/_if/sclk
 add wave /tb_spi/_if/ss
 add wave /tb_spi/_if/mosi
 add wave /tb_spi/_if/miso
 add wave /tb_spi/_if/in_data
 add wave /tb_spi/_if/out_data

 run 84000

