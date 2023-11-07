

/*

 Hardware test.
 
*/
module sdram_test(

						input  wire			clk,
						output wire      	osc,
						output wire       cs,
						output wire  		ras,
						output wire	   	cas,
						output wire			we,												
						output wire[1:0]  ba,
						output wire[1:0]	dqm,
						output wire[11:0] address,	
						inout  	  [15:0] dq,
			
						output wire[7:0] led
);

 
 
 `define BURST_COUNT 256	// 1, 2, 4, 8, 256.
  
 enum { SET_DATA, WR0, WR1, RD0, RD1, CMP, ERR } st = SET_DATA;

  
 wire 		w_clk;
 
 bit[8:0] 	i = 0;
 bit      	read = 1'b0;
 bit 		 	write = 1'b0; 
 bit[8:0] 	burstcount; 
 wire			waitrequest;
 wire			readdatavalid;
 wire[15:0] readdata;
				
 bit[21:0] 	addr;
 bit[21:0]	wr_addr = 22'h000000;
 bit[21:0]	rd_addr = 22'h000000;
 bit[15:0]  writedata;
 bit[15:0]	wr_data[256];
 bit[15:0]  rd_data[256];
 bit[15:0]	value = 16'h0000;
 
 bit[7:0] 	error = 8'h00;
				 

		  
	pll pll_inst(.inclk0(clk), .c0(w_clk));

	
	
sdram_qsys  sdram_inst(


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
 );
	

	
	assign led = error;

	
	always @(posedge w_clk)begin
	
	
		case(st)

		
			SET_DATA: begin
				
							if(i < `BURST_COUNT) begin
							
							   wr_data[i] <= value;
								
								i <= i + 1'b1;
								
								value <= value + 1'b1;
							end
						   else begin	
								
									i <= 0;	
																		
									st <= WR0;
							end		
						 end	
					  
// write.	
	
			WR0: 		if(!read)begin
			

							burstcount <= `BURST_COUNT;
							
							addr <= wr_addr;
											
							write <= 1'b1;
							
							writedata <= wr_data[i];
						
							i <= i + 1'b1;
														
							wr_addr <= wr_addr + 1'b1;
								
							st <= WR1;											
						end
						
	
			WR1:    if(!waitrequest) begin
			

						  if(i < `BURST_COUNT) begin							
							
							  st <= WR0;
						  end	
						  else begin
								
									i <= 0;
																											
									write <= 1'b0;
	
									st <= RD0;
						  end		
																						
						end
																		
// read.	

			RD0: 		if(!write) begin
			
							burstcount <= `BURST_COUNT;
							
							addr <= rd_addr;
					
							read <= 1'b1;
		
							st <= RD1;							
						end
				  												

			
			RD1:		if(!waitrequest) begin
			
							if(readdatavalid) begin
							
				  
								if(i < `BURST_COUNT) begin

								
									rd_data[i] <= readdata;
														  
									i <= i + 1'b1;
																	
								end
								
							end
							else if(i == `BURST_COUNT) begin
									
									
										i <= 0;
																				
										read <= 1'b0;
										
										rd_addr <= rd_addr + `BURST_COUNT;
										
										st <= CMP;
									
									end
							
						end
						
												

			CMP: 		begin
			
							
							if(i < `BURST_COUNT) begin
						
								
								if(rd_data[i] != wr_data[i]) begin
						
									error <= 8'h81;
									
									st <= ERR;
								end
								else begin	

// pass bank.							
										error <= rd_addr[21:20];
													
										i <= 0;
																		
										st <= SET_DATA;							
								end
								
							end
							
						end

	
			default: ;
	
	
		endcase
	
	end
	

endmodule: sdram_test
