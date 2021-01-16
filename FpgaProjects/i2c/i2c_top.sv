


module i2c_top(input bit osc, inout sda_lcd, output bit sclk_lcd, inout sda_ds1307, output bit sclk_ds1307, 
               inout sda_at24c04, output bit sclk_at24c04);



wire      w_c0; 
wire[3:0] w_q;

lcd_t::lcd_1602 w_ds1307,
                w_at24c04;


	pll	pll_inst(.inclk0(osc), .c0(w_c0));
	
	counter	counter_inst(.clock(w_c0), .q(w_q));
	
		
	ds1307	ds1307_inst(.clk(w_c0), .sda(sda_ds1307), .sclk(sclk_ds1307), .out_ds1307(w_ds1307));
	
	at24c04	at24c04_inst(.clk(w_c0), .sda(sda_at24c04), .sclk(sclk_at24c04), .out_at24c04(w_at24c04));	
	
	lcd_1602	lcd_1602_inst(.clk(w_q[3]), .sda(sda_lcd), .sclk(sclk_lcd), .ch0(w_ds1307), .ch1(w_at24c04));
	

endmodule: i2c_top
