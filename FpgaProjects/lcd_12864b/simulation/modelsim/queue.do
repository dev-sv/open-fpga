

 transcript on

 set PRJ_DIR "c:/Projects/lcd_12864b"
 set TB_DIR $PRJ_DIR/simulation/modelsim/tb_queue

 vlib $TB_DIR/work

 vlog -sv -novopt $PRJ_DIR/queue.sv $PRJ_DIR/tb_queue.sv

 vsim tb_queue
 
 add wave /tb_queue/clk
 add wave /tb_queue/query
 add wave /tb_queue/full
 add wave /tb_queue/in_data
 add wave /tb_queue/out_queue

 run 2000
