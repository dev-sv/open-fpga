


 transcript on

 set PRJ_DIR "c:/git/open-fpga/FpgaProjects/i2c"
 set TB_DIR $PRJ_DIR/simulation/modelsim/tb_i2c_write

 vlib $TB_DIR/work

 vlog -sv -novopt $PRJ_DIR/i2c.sv $PRJ_DIR/tb_i2c_write.sv

 vsim tb_i2c_write
 
 add wave /tb_i2c_write/clk
 add wave /tb_i2c_write/sclk
 add wave /tb_i2c_write/sda

# for one by one bytes. 
 run 19000

# for sequential
# run 6000 

