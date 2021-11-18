

 transcript on

 set PRJ_DIR "c:/Projects/uart"
 set TB_DIR $PRJ_DIR/simulation/modelsim/tb_uart

 vlib $TB_DIR/work

 vlog -sv -novopt $PRJ_DIR/uart.sv $PRJ_DIR/tb_uart.sv
  
 vsim tb_uart -L altera_mf_ver
 
 add wave /tb_uart/tx
 add wave /tb_uart/tx_busy
 add wave /tb_uart/rx
 add wave /tb_uart/rx_full
 add wave /tb_uart/val

 run 3000000
