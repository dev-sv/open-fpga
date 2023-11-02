


`timescale 1ns / 1ns


module master_bfm_tb();


 import avalon_mm_pkg::*;
 
  
 `define MSTR_BFM tb.master_bfm
  
 `define MAX	4096
  
  bit  clk = 1'b0;
  bit  rst = 1'b0;
  bit  aclk = 1'b0;
  
  bit[9:0]  addr;
  bit[15:0] rd_data;
  bit[15:0] buff[`MAX];  
  
  
// instantiate Platform Designer module.
  adc_qsys tb(.aclk_clk(aclk), .clk_clk(clk), .reset_reset_n(rst));
  
	
	initial
		forever #5 clk = ~clk;
	

	initial
		#3 rst = 1'b1;

		
// input clk to adc.
	initial
		forever #250 aclk = ~aclk;
	


 initial begin
  	
	
//initialize the master BFM
	`MSTR_BFM.init();		 

	
//wait for reset to de-assert.
	wait(`MSTR_BFM.reset == 0);
	 
	 	 		
	$display("Start test...");
	
	
	addr = 0;	
	
	for(int i = 0; i < `MAX; i++)
	
		 read_adc(addr, buff[i]);

		 
	$display("\n\n Testbench adc..\n");
		 
	for(int i = 0; i < `MAX; i++)
	
		 $display("buff[%.4d] = %x", i, buff[i]);
	
	
 end
  


  
  task automatic read_adc(
									input  bit[9:0]  addr, 
									output bit[15:0] rd_data
								 );  
		
  
	`MSTR_BFM.set_command_request(REQ_READ);
   `MSTR_BFM.set_command_address(addr);    
   `MSTR_BFM.set_command_byte_enable(2'h3, 0);
   `MSTR_BFM.set_command_burst_count(1'b1);
   `MSTR_BFM.set_command_burst_size(1'b1);
   `MSTR_BFM.set_command_idle(0, 0);
	`MSTR_BFM.set_command_init_latency(0);
	`MSTR_BFM.set_command_timeout(10);
			 
	`MSTR_BFM.push_command();
	
	
// read data.	

		#8000 if(`MSTR_BFM.get_response_queue_size() > 0) begin

					`MSTR_BFM.pop_response();
				
					rd_data = `MSTR_BFM.get_response_data(0);
						 						 					
				end
					  
  endtask
	
		  
endmodule
