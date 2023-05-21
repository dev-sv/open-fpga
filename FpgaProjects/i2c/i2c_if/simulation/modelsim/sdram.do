
 transcript on

 set PRJ_DIR "/home/user/Projects/ip/sdram_micron/avalon"

 set TB_DIR $PRJ_DIR/testbench

 vlib work

 vlog -sv $TB_DIR/mt48lc4m16a2.v $TB_DIR/tb_sdram.sv $PRJ_DIR/test/sdram_design/synthesis/submodules/sdram.sv

 vsim tb_sdram

 add wave /tb_sdram/osc
 add wave /tb_sdram/ba
 add wave /tb_sdram/address
 add wave /tb_sdram/dq
 add wave /tb_sdram/cs
 add wave /tb_sdram/we
 add wave /tb_sdram/ras
 add wave /tb_sdram/cas

 add wave /tb_sdram/clk
 add wave /tb_sdram/address
 add wave /tb_sdram/burstcount
 add wave /tb_sdram/writedata
 add wave /tb_sdram/write
 add wave /tb_sdram/readdata
 add wave /tb_sdram/readdatavalid
 add wave /tb_sdram/read

# run 1650000000
 run -All
