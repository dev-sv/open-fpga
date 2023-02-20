
 transcript on

 set PRJ_DIR "/home/user/Projects/ip/sdram_micron/axi"

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
 add wave /tb_sdram/awlen
 add wave /tb_sdram/awvalid
 add wave /tb_sdram/w_awready
 add wave /tb_sdram/w_wready
 add wave /tb_sdram/wvalid
 add wave /tb_sdram/wdata

 add wave /tb_sdram/address
 add wave /tb_sdram/arlen
 add wave /tb_sdram/w_arready
 add wave /tb_sdram/arvalid
 add wave /tb_sdram/rready
 add wave /tb_sdram/w_rvalid
 add wave /tb_sdram/w_rdata

# run 1650000000
 run -All

