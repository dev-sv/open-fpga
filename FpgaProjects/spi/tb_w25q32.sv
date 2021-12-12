


module tb_w25q32;


bit clk = 0, 
    miso, sclk, ss, mosi; 
logic[15:0] mem_data;


initial
begin

 forever
	#10 clk = ~clk;

end


	w25q32	w25q32_mut(.clk(clk), .miso(miso), .sclk(sclk), .ss(ss), .mosi(mosi), .mem_data(mem_data));

	
endmodule: tb_w25q32