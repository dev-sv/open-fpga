

 transcript on

 set PRJ_DIR "c:/git/open-fpga/FpgaProjects/i2c"
 set TB_DIR $PRJ_DIR/simulation/modelsim/tb_i2c_read

 vlib $TB_DIR/work

 vlog -sv -novopt $PRJ_DIR/i2c.sv $PRJ_DIR/tb_i2c_read.sv

 vsim tb_i2c_read
 
 add wave /tb_i2c_read/clk
 add wave /tb_i2c_read/sclk
 add wave /tb_i2c_read/sda

# for one by one bytes. 
 run 26000

# for sequential
# run 7000 

