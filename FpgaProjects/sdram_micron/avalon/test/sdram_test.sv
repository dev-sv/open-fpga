

/*

 Hardware test.
 
*/
module sdram_test(input bit clk,

						output wire      	osc,
						                  cs,
												ras,
												cas,
												we,												
						output wire[1:0]  ba,
						                  dqm,
						output wire[11:0] address,	
						inout  	  [15:0] dq,
			
						output wire[7:0] led
);


 
 `define PAGE 		256				// 256x16.
 `define MAX_PAGE 16384				// 4 banks x 4096 rows.
  
 enum { SET_DATA, WR0, WR1, RD0, RD1, RD2, CMP, NEXT, CH_DATA, ERR, STOP } st = SET_DATA;

 
 bit[8:0] i = 0,
			 nw = 0,
			 nr = 0,
			 bc_wr = 1,			// burstcount wr.
			 bc_rd = 1,			// burstcount rd.
			 burstcount;
			 
 bit     read = 1'b0,
			write = 1'b0;
	   
 wire 	w_clk,
			waitrequest,
			readdatavalid;
			
 wire[15:0] readdata;
				
 bit[22:0] 	addr, 
				wr_addr = 23'h000000,
				rd_addr = 23'h000000;
				 
 bit[15:0]  writedata,
				arr_wr[`PAGE],
			   arr_rd[`PAGE],
				value = 16'h0000,
				start_value = 0;
								
int unsigned pc = 0,						// page counter.
             pass_all_banks = 0;	   // all banks counter.
bit[7:0] 	 err = 8'h81;				// error code.
				 
		

		  
	pll pll_inst(.inclk0(clk), .c0(w_clk));

	
	
sdram_design  sdram_inst(


		.clk_clk(w_clk),
		.user_waitrequest(waitrequest),
		.user_readdata(readdata),
		.user_readdatavalid(readdatavalid),
		.user_burstcount(burstcount),
		.user_writedata(writedata),
		.user_address(addr),
		.user_write(write),
		.user_read(read),
		.user_byteenable(2'b11),
		.reset_reset_n(1'b1),
		
		.sdram_osc(osc),
		.sdram_dq(dq),
		.sdram_address(address),
		.sdram_we(we),
		.sdram_ras(ras),
		.sdram_cas(cas),
		.sdram_dqm(dqm),
		.sdram_ba(ba),
		.sdram_cs(cs)
		
		//.sdram_led(led)
	);
	
	

	
	always @(posedge w_clk)begin
	

	
		case(st)

		
		
			SET_DATA: begin
				
							arr_wr[i] <= value;
													
							st <= WR0;
						 end	
					  
// write.	
	
			WR0: 		if(!read)begin

							burstcount <= bc_wr;
							addr <= wr_addr;
											
							write <= 1'b1;
							writedata <= arr_wr[i];
						
							i <= i + 1'b1;
							
							nw <= nw + 1;
								
							value <= value + 1;								
								
							st <= WR1;											
						end
						
	
			WR1:    if(!waitrequest) begin
			
							write <= 1'b0;	

							if(nw < burstcount) begin
								
							   st <= SET_DATA;
							end
							else begin
							
									nw <= 0;

									if(i == `PAGE) begin
										
										i <= 0;										
									   st <= RD0;
									   
									end
									else begin									
							
										wr_addr <= wr_addr + (bc_wr << 1);
										
									   st <= SET_DATA;
										
									end
							end		
																						
						end						
												
// read.	

			RD0: 		if(!write) begin
			
							burstcount <= bc_rd;
							addr <= rd_addr;
					
							read <= 1'b1;
		
							st <= RD1;							
						end
				  				
	
			RD1: 		if(!waitrequest)
							st <= RD2;

	
			RD2: 		begin
			
							if(readdatavalid) begin
									  
								read <= 1'b0;
				  
								if(nr < burstcount) begin
				  																
									arr_rd[i] <= readdata;
								
									nr <= nr + 1'b1;
						  
									i <= i + 1;
								
								end
								else begin											
																				
										nr <= 0;										
									
										if(i == `PAGE) begin
										
											i <= 0;
																						
											pc <= pc + 1;
			
											st <= CMP;

										end
										else begin
										
												rd_addr <= rd_addr + (bc_rd << 1);
												
												st <= RD0;												
										end		
											
								end		
							end
						end
					  				  

			  
			CMP: 		st <= (arr_rd[i] != arr_wr[i]) ? ERR : NEXT;
													


// next page and new burstcount.
					
			NEXT:		begin
								
							if(i < (`PAGE - 1)) begin
							
								i <= i + 1;
								st <= CMP;
							end
							else begin
							
									i <= 0;									
									
									if(pc < (`MAX_PAGE + 1)) begin

										wr_addr <= wr_addr + (bc_wr << 1);
										rd_addr <= rd_addr + (bc_rd << 1);											
										 
										st <= SET_DATA;
									end
									else begin									
											
// change burst count.											
											if(bc_wr == `PAGE) begin
														
					          				if(bc_rd != `PAGE) begin
												
													bc_wr <= (bc_rd != 8) ? bc_rd << 1 : `PAGE;
												
													bc_rd <= (bc_rd != 8) ? bc_rd << 1 : `PAGE;
												end
												else begin
												
														bc_wr <= 1;
														bc_rd <= 1;
												end		
												
											end	
											else bc_wr <= (bc_wr != 8) ? bc_wr << 1 : `PAGE;
											
											
											pass_all_banks <= pass_all_banks + 1;
												
											start_value <= start_value + 1;
			
											st <= CH_DATA;												
									end		
							end
							
						end
							
// change data.

			CH_DATA: begin
	
							pc <= 0;
													
							led <= pass_all_banks;
														
							wr_addr <= 23'h000000;
							rd_addr <= 23'h000000;
							value <= start_value;
			
							st <= SET_DATA;
						end
											
					  
			ERR: led <= err;

	
			default: ;
	
	
		endcase
	
	end
	

endmodule: sdram_test
														

