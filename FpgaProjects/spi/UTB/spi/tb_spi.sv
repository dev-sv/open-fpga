

`timescale 1 ps / 1 ps


`include "../../UTB/spi/UTestSpi.svh"



module tb_spi;


bit clk = 0;

spi_if _if();	 
	 
	 
	 
initial begin
 
 
 forever #10 clk = ~clk;	
 
end


initial begin
 
 
 uvm_config_db #(virtual spi_if)::set(null, "*", "_if", _if);

 run_test("UTTest_0");
  
end
		

	spi  #(.NByte(4)) spi_dut(.clk(clk), ._if(_if.spi), .in_data(_if.in_data), 
	                          .out_data(_if.out_data), .nb_wr(_if.nb_wr), .nb_rd(_if.nb_rd), .mode(_if.mode));
	  

																							
endmodule: tb_spi
