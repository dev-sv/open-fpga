


module spi_top(input bit osc, miso_w25, output bit sclk_max, ss_max, mosi_max, 
               sclk_w25, ss_w25, mosi_w25);



wire	    w_c0;
wire[7:0] w_data;
wire[15:0] w_addr;



	pll	pll_inst(.inclk0(osc), .c0(w_c0));

	max7219	max7219_inst(.clk(w_c0), .sclk(sclk_max), .ss(ss_max), .mosi(mosi_max), .max_data(w_data), .addr_data(w_addr));

	w25q32	w25q32(.clk(w_c0), .miso(miso_w25), .sclk(sclk_w25), .ss(ss_w25), .mosi(mosi_w25), .mem_data(w_data), .addr_data(w_addr));
	

endmodule: spi_top

