

/*

 clk = 50 MHz.

 w_clk[7] = 195.312 kHz (clk/256).
 
 sclk = 97.656 kHz (w_clk[7]/2).
 
*/

module i2c_top(
               input wire	clk,
					
               inout 		sda, 
					
					output wire sclk, 
					
               output wire[3:0] led
);

 wire[7:0] w_clk;
 wire      w_count_clk; 
 
 wire      w_en;
 wire[1:0] w_rw;
 wire[7:0] w_wr_data;
 wire[7:0] w_rd_data;
 wire 	  w_wr_ready;
 wire 	  w_rd_ready;
   

 
  
	pll pll_inst(.inclk0(clk), .c0(w_count_clk));

	count count_inst(.clock(w_count_clk), .q(w_clk));

			
	 
 
	i2c i2c_inst(
	
					.clk(w_clk[7]),					
										
					.rw(w_rw),
					
					.wr_data(w_wr_data), 
				
					.sda(sda), 
					
					.sclk(sclk),
					
					.rd_data(w_rd_data),
					
					.wr_ready(w_wr_ready),
					
					.rd_ready(w_rd_ready)					
 );

 
/* 
 
 Nb number bytes to write/read.
 
 max Nb = 56.
 
*/
  
 `define Nb 1
  
 hw_test #(.Nb(`Nb)) hw_test_inst (
	
					 .clk(w_clk[7]),
					 					 
					 .sclk(sclk),
					 
					 .sda(sda),
								
					 .dev_addr(8'hd0),
					 
					 .addr(8'h08),
								
					 .wr_ready(w_wr_ready),
					 
					 .rd_ready(w_rd_ready),
					 					 
					 .wr_data(w_wr_data),
					 
					 .rd_in(w_rd_data),
					 					 
 					 .rw(w_rw),
					 
					 .led(led)
);

 		
endmodule: i2c_top
