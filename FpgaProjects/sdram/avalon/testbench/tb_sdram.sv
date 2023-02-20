
/*

 Testbench sdram ip.

 Using mt48lc4m16a2 sdram model.
      2001 Micron Semiconductor Products, Inc.

*/


`timescale 1ns / 1ps



module tb_sdram;


 wire[15:0] dq;

 wire[11:0] address;

 wire[1:0] ba,
		 	  dqm;

 wire		  osc,
			  cs,
			  we,
			  ras,
			  cas;


 `define PAGE 		256				// 256x16.
 `define MAX_PAGE 16384				// 4x4096.

 enum { SET_DATA, WR0, WR1, RD0, RD1, RD2, CMP } st = SET_DATA;


 bit[8:0] i = 0,
			 nw = 0,
			 nr = 0,
			 bc = 1,				// new burstcount.
			 bc_wr = 1,			// burstcount wr.
			 bc_rd = 1,			// burstcount rd.
			 burstcount;

 bit      read = 1'b0,
			 write = 1'b0;

 wire 	 waitrequest,
			 readdatavalid;

 wire[15:0] readdata;

 bit[21:0] 	addr,
				addr_wr = 22'h000000,
				addr_rd = 22'h000000;

 bit[15:0]  writedata,
 				wr_data[`PAGE],
			   rd_data[`PAGE],
				value = 0,
				start = 0;

 int unsigned pc = 0;			// page counter.
 
 bit clk = 0;
 
 

 initial begin

	forever #5 clk = ~clk;

 end			  


 sdram sdram_dut(

// avalon_slave.

		.clk(clk),
      .reset(1'b1),

		.s_waitrequest(waitrequest),
		.s_readdata(readdata),
		.s_readdatavalid(readdatavalid),
		.s_burstcount(burstcount),
		.s_writedata(writedata),
		.s_address(addr),
		.s_write(write),
		.s_read(read),
		.s_byteenable(2'b11),

//sdram_if.

		.dq(dq),
		.address(address),
		.ba(ba),
		.dqm(dqm),
		.osc(osc),
		.cs(cs),
		.we(we),
		.ras(ras),
		.cas(cas),
		.led()
 );

 

  mt48lc4m16a2 mt48lc4m16a2_inst(.Dq(dq), .Addr(address), .Ba(ba), .Clk(osc), .Cke(1'b1),
  
											.Cs_n(cs), .Ras_n(ras), .Cas_n(cas), .We_n(we), .Dqm(dqm));



	
	always @(posedge clk)begin
	
	
		case(st)

		
			SET_DATA: begin
				
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
							
							addr <= addr_wr;
											
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
							
										addr_wr <= addr_wr + bc_wr;
										
									   st <= WR0;
									end
							end		
																						
						end						
												
// read.	

			RD0: 		if(!write) begin
			
							burstcount <= bc_rd;
							
							addr <= addr_rd;
					
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
										
												addr_rd <= addr_rd + bc_rd;
												
												st <= RD0;												
										end		
											
								end		
							end
						end
					  			

			CMP: 		begin
			
							if(i < `PAGE) begin
						
								if(rd_data[i] != wr_data[i]) begin
								
									$display("\n addr_wr = %x wr_data[%d] = %x addr_rd = %x rd_data[%d] = %x  error \n", addr_wr, i, wr_data[i],  addr_rd, i, rd_data[i]);
									$stop;
								end
								else begin
								
										i <= i + 1;
										
										$display("wr_data[%d] = %x  rd_data[%d] = %x  bc_wr = %d  bc_rd = %d start = %d  pass", i, wr_data[i], i, rd_data[i], bc_wr, bc_rd, start);
								end		
								
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
										
										if(start == 16'hFFFF) begin
								
											$display("\nTest finished.\n");
								
											$stop;
										end
										else start <= start + 1;
																										
										bc <= (bc == 24) ? 0 : bc + 1;	
							end							
// next page.							
							addr_wr <= addr_wr + bc_wr;
							addr_rd <= addr_rd + bc_rd;
													
							i <= 0;
							value <= 0;
							st <= SET_DATA;
							
						end
				end

	
			default: ;
	
	
		endcase
	
	end
				 
endmodule
