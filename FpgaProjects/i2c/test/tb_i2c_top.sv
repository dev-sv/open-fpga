

`timescale 1 ns / 1 ps


module tb_i2c_top;


 bit clk = 1'b0; 
 wire sda;
 wire sclk;


 
 initial begin
 
	forever #10 clk = ~clk;
	
 end
 

 i2c_top i2c_top_dut(.clk(clk), .sda(sda), .sclk(sclk), .led());



endmodule
