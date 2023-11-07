


`timescale 1ns / 1ps


module master_bfm_tb();


 import avalon_mm_pkg::*;
 
  
 `define MSTR_BFM tb.master_bfm
  
 `define MAX	256
 
  
	bit  clk = 1'b0;
	bit  rst = 1'b0;
 
   bit[8:0]  bc;
	bit[21:0] addr;
	bit[15:0] rd_data;
	bit[15:0] wr_buff[`MAX];  
	bit[15:0] rd_buff[`MAX];  
  
	wire [15:0] dq;
	wire [11:0] address;
	wire [1:0]  ba;
	wire [1:0]  dqm;
	wire        osc;
	wire        cs;
	wire        we;
	wire        ras;
	wire        cas;
  
  
   string str;
    
  
// instantiate Platform Designer module.
  sdram_qsys tb(
						.clk_clk(clk), 
						.reset_reset_n(rst),
												
						.sdram_dq(dq),
						.sdram_address(address),
						.sdram_ba(ba),
						.sdram_dqm(dqm),
						.sdram_osc(osc),
						.sdram_cs(cs),
						.sdram_we(we),
						.sdram_ras(ras),
						.sdram_cas(cas)
						
					);
  

// instantiate sdram model.
  mt48lc4m16a2 mt48lc4m16a2_inst(
											.Dq(dq), 
											.Addr(address), 
											.Ba(ba), 
											.Clk(osc), 
											.Cke(1'b1),
											.Cs_n(cs), 
											.Ras_n(ras), 
											.Cas_n(cas), 
											.We_n(we), 
											.Dqm(dqm)
											
										  );
 

	initial
		forever #5 clk = ~clk;
	

	initial
		#3 rst = 1'b1;

			


 initial begin
  	
	
//initialize the master BFM
	`MSTR_BFM.init();		 

	
//wait for reset to de-assert.
	wait(`MSTR_BFM.reset == 0);
	 
	 	 		
	$display("Start test...");
	
	bc = `MAX;
	
	addr = 0;	
	
	
	for(int i = 0; i < `MAX; i++)
	
		 wr_buff[i] = i + 1;

	
// 100us after power-up.
	#100000
			
	rw(REQ_WRITE, addr, bc,  wr_buff, rd_buff);
	
	$display("\n\n Testbench sdram...\n");

	
	rw(REQ_READ, addr, bc,  wr_buff, rd_buff);
		 
		 
	for(int i = 0; i < `MAX; i++) begin
	
		 if(wr_buff[i] != rd_buff[i])	
			 str = "error";
			 
		 else str = "pass";
	
		 $display("wr_buff[%.3d] = %x\t rd_buff[%.3d] = %x %s", i, wr_buff[i], i, rd_buff[i], str);
	end

	
 end

 

  
  task automatic rw(
							input  Request_t 	op, 
							input  bit[21:0]  addr, 
							input  bit[8:0] 	bc,
							ref	 bit[15:0] 	wr_data[`MAX],
							ref	 bit[15:0] 	rd_data[`MAX]
						);  
		
  
	`MSTR_BFM.set_command_request(op);
   `MSTR_BFM.set_command_address(addr);    
   `MSTR_BFM.set_command_byte_enable(2'b11, 0);
   `MSTR_BFM.set_command_burst_count(bc);
   `MSTR_BFM.set_command_burst_size(bc);
   `MSTR_BFM.set_command_idle(0, 0);
	`MSTR_BFM.set_command_init_latency(0);
	`MSTR_BFM.set_command_timeout(300);
	

// write.

	 if(op == REQ_WRITE) begin
	 
		 for(int i = addr; i < (addr + bc); i++)
		 
			  `MSTR_BFM.set_command_data(wr_data[i - addr], (i - addr));		 
	 end 	 
	 

	`MSTR_BFM.push_command();
	

	
// read.

	#5000 if(`MSTR_BFM.get_response_queue_size() > 0) begin
	

				 `MSTR_BFM.pop_response();
				
					
				 if(`MSTR_BFM.get_response_request() == REQ_READ) begin
				
					 for(int i = addr; i < (addr + bc); i++)
					
						  rd_data[i - addr] = `MSTR_BFM.get_response_data(i - addr);
				  
				 end
				
			 end
		 
	  
  endtask
  
  
  		  
endmodule
