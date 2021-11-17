

 transcript on

 set PRJ_DIR "c:/Projects/lcd_12864b"
 set TB_DIR $PRJ_DIR/simulation/modelsim/tb_lcd_12864b

 vlib $TB_DIR/work

 vlog -sv -novopt $PRJ_DIR/lcd_12864b.sv $PRJ_DIR/tb_lcd_12864b.sv
  
 vsim tb_lcd_12864b
 
 add wave /tb_lcd_12864b/clk
 add wave /tb_lcd_12864b/rs
 add wave /tb_lcd_12864b/rw
 add wave /tb_lcd_12864b/e
 add wave /tb_lcd_12864b/out_data

 run 68000
