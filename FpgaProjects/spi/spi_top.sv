


module spi_top(input bit osc, spi_if.spi spi_max7219, spi_if.spi spi_w25q32);


wire	     w_c0;
wire[7:0]  w_data;
wire[15:0] w_addr;



	pll	pll_inst(.inclk0(osc), .c0(w_c0));

	
	max7219	max7219_inst(.clk(w_c0), .spi(spi_max7219), .max_data(w_data), .addr_data(w_addr));
	
	w25q32	w25q32(.clk(w_c0), .spi(spi_w25q32), .mem_data(w_data), .addr_data(w_addr));
	
	
endmodule: spi_top

