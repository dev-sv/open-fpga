

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
  
 enum { SET_DATA, WR0, WR1, RD0, RD1, RD2, CMP, ERR } st = SET_DATA;

 
 bit[8:0] i = 0,
			 nw = 0,
			 nr = 0,
			 bc = 1,				// new burstcount.
			 bc_wr = 1,			// burstcount wr.
			 bc_rd = 1,			// burstcount rd.
			 burstcount;
			 
 bit     read = 1'b0,
			write = 1'b0;
 wire 	w_clk,
			waitrequest,
			readdatavalid;
			
 wire[15:0] readdata;
				
 bit[21:0] 	addr, 
				wr_addr = 22'h000000,
				rd_addr = 22'h000000;
				 
 bit[15:0]  writedata,
				wr_data[256],
			   rd_data[256],
				value = 0,
				start = 0;
								
int unsigned pc = 0;						// page counter.
bit[7:0] 	 error = 8'h00;			// error code.
				 
		

		  
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
				
							led <= start;

							if(i < `PAGE) begin
							
							   wr_data[i] <= value + start;
								
								i <= i + 1'b1;
								
								value <= value + 1'b1;
							end
						   else begin	
								
									i <= 0;	
									
									pc <= pc + 1;
									
									st <= WR0;
							end		
						 end	
					  
// write.	
	
			WR0: 		if(!read)begin

							burstcount <= bc_wr;
							
							addr <= wr_addr;
											
							write <= 1'b1;
							
							writedata <= wr_data[i];
						
							i <= i + 1'b1;
							
							nw <= nw + 1'b1;
								
							st <= WR1;											
						end
						
	
			WR1:    if(!waitrequest) begin
			
							write <= 1'b0;	

							if(nw < burstcount)	
							   st <= WR0;
							
							else begin
							
									nw <= 0;

									if(i == `PAGE) begin
										
										i <= 0;
										
									   st <= RD0;
									end
									else begin									
							
										wr_addr <= wr_addr + bc_wr;
										
									   st <= WR0;
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
				  																
									rd_data[i] <= readdata;
								
									nr <= nr + 1'b1;
						  
									i <= i + 1'b1;
								
								end
								else begin											
																				
										nr <= 0;										
									
										if(i == `PAGE) begin
										
											i <= 0;
			
											st <= CMP;
										end
										else begin
										
												rd_addr <= rd_addr + bc_rd;
												
												st <= RD0;												
										end		
											
								end		
							end
						end
					  			

			CMP: 		begin
			
							if(i < `PAGE) begin
						
								if(rd_data[i] != wr_data[i]) begin
						
									error <= 8'h81;
									
									st <= ERR;
								end
								else i <= i + 1;					
							end
							else begin	
		
// all banks passed.		
							
									if(pc == `MAX_PAGE) begin

// set new burstcount.					
										case(bc)
								
								
											0: begin
										
													bc_wr <= 1;
													bc_rd <= 1;
												end
										
											1: bc_wr <= 2;
										
											2: begin
									
													bc_wr <= 1;
													bc_rd <= 2;
												end
										
											3: bc_wr <= 2;										
										
											4: begin
									
													bc_wr <= 4;
													bc_rd <= 1;
												end
																				
											5: bc_rd <= 2;
										
											6: bc_rd <= 4;
										
											7: bc_wr <= 1;
										
											8: bc_wr <= 2;
									
											9: begin
									
													bc_wr <= 8;
													bc_rd <= 1;									
												end
										
											10: bc_rd <= 2;
										
											11: bc_rd <= 4;

											12: bc_rd <= 8;
										
											13: bc_wr <= 1;
										
											14: bc_wr <= 2;
										
											15: bc_wr <= 4;

											16: begin
									
													bc_wr <= 256;
													bc_rd <= 1;
												 end
										
											17: bc_rd <= 2;
										
											18: bc_rd <= 4;
										
											19: bc_rd <= 8;
										
											20: begin
									
													bc_rd <= 256;
													bc_wr <= 1;
												 end
										
											21: bc_wr <= 2;
										
											22: bc_wr <= 4;
										
											23: bc_wr <= 8;
										
											24: bc_wr <= 256;										
										
											default: ;
									
										endcase	
																
										pc <= 0;
								
										start <= start + 1;
																
										bc <= (bc == 24) ? 0 : bc + 1;	
							end							
// next page.							
							wr_addr <= wr_addr + bc_wr;
							rd_addr <= rd_addr + bc_rd;
													
							i <= 0;
							value <= 0;
							st <= SET_DATA;
							
						end
				end

					  
			ERR: led <= error;

	
			default: ;
	
	
		endcase
	
	end
	

endmodule: sdram_test
														

