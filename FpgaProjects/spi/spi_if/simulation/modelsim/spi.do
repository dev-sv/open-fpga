
 transcript on

 set PRJ_DIR "/home/user/Projects/cyclone_iv/spi/spi_if"

 vlib work

 vlog -sv $PRJ_DIR/spi.sv $PRJ_DIR/tb_spi.sv

 vsim tb_spi


 add wave /tb_spi/sclk
 add wave /tb_spi/ss
 add wave /tb_spi/mosi
 add wave /tb_spi/miso
 add wave /tb_spi/op

 run 2150000

# run -All
