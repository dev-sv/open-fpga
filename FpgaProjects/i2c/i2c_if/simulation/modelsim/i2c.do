
 transcript on

 set PRJ_DIR "/home/user/Projects/cyclone_iv/i2c/i2c_if"

 vlib work

 vlog -sv $PRJ_DIR/i2c.sv $PRJ_DIR/tb_i2c.sv $PRJ_DIR/tb_stimulus.sv

 vsim tb_i2c

 add wave /tb_i2c/w_sclk
 add wave /tb_i2c/w_sda
 add wave /tb_i2c/sw
 add wave /tb_i2c/w_rw
 add wave /tb_i2c/w_wr_data
 add wave /tb_i2c/w_rd_data

 run 45000000000
# run -All
