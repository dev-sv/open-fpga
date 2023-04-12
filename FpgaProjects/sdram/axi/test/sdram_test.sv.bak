


module sdram_test(

		input clk,
		inout  		[15:0] dq,
		output wire [11:0] address,
		output wire [1:0]  ba,
		output wire [1:0]  dqm,
		output wire        osc,
		output wire        cs,
		output wire        we,
		output wire        ras,
		output wire        cas,
		output wire [7:0]  led
 );
	

	
 enum { SET_DATA, S0, S1, S2, S3, S4, S5, CMP, ERR } st = SET_DATA;
 
 
 bit[21:0] araddr, 
           addr_rd = 22'h000000;
 bit[7:0]  arlen;
 bit[2:0]  arsize;
 bit[1:0]  arburst;
 bit		  arvalid = 1'b0;
 wire      w_arready;
 wire[15:0] w_rdata;
 wire      w_rvalid;
 bit       rready;

 bit[21:0] awaddr,
			  addr_wr = 22'h000000;
 bit[7:0]  awlen;
 bit[2:0]  awsize;
 bit[1:0]  awburst;
 bit		  awvalid = 1'b0;
 wire      w_awready;
 bit[15:0] wdata;
 bit       wlast;
 bit       wvalid = 1'b0;
 wire      w_wready;

 
 `define PAGE     256		// 256x16. 
 `define MAX_PAGE 16384		// 4 banks x 4096 pages.
 
 bit[8:0] i = 0,
          nr = 0,
			 nw = 0,
			 len = 1,
			 len_wr = 1,
		    len_rd = 1;
 
 bit[15:0] value = 0,
           start = 0,
			  rd_data[`PAGE],
			  wr_data[`PAGE];
			   
 int unsigned pc = 0;		// page counter.
 
 bit[7:0] error = 8'h00;	// error code.		
 
 wire w_clk;
 
 
 pll pll_inst (.inclk0(clk), .c0(w_clk));



 sdram_design sdram(
 
 
		.clk_clk(w_clk),
		.reset_reset_n(1'b1),
		
		.sdram_dq(dq),
		.sdram_address(address),
		.sdram_ba(ba),
		.sdram_dqm(dqm),
		.sdram_osc(osc),
		.sdram_cs(cs),
		.sdram_we(we),
		.sdram_ras(ras),
		.sdram_cas(cas),
		
// write address channel.		
		.user_awid(0),
		.user_awaddr(awaddr),
		.user_awlen(awlen),
		.user_awsize(awsize),
		.user_awburst(awburst),		
		.user_awvalid(awvalid),
		.user_awready(w_awready),
		
// write data channel.
		.user_wdata(wdata),
		.user_wstrb(2'b11),
		.user_wvalid(wvalid),
		.user_wready(w_wready),
		//.user_wlast(wlast),
		//.user_bid(),
		//.user_bresp(),
		//.user_bvalid(),
		//.user_bready(),
		
// read address channel.
		.user_arid(0),
		.user_araddr(araddr),
		.user_arlen(arlen),
		.user_arsize(arsize),
		.user_arburst(arburst),
		.user_arvalid(arvalid),
		.user_arready(w_arready),
		
// read data channel.		
		.user_rdata(w_rdata),		
		.user_rvalid(w_rvalid),
		.user_rready(rready)
		//.user_rid(),
		//.user_rresp(),
		//.user_rlast(),
		
		//.sdram_led(led)
	);

	

	
	always @(posedge w_clk) begin
	
	
		case(st)
	
	
			SET_DATA: begin
			
							led <= start;
			
							if(i < `PAGE) begin
							
								wr_data[i] <= value + start;
								
								i <= i + 1;
								
								value <= value + 1;
							end
							else begin
									
									pc <= pc + 1;
									
									st <= S0;
							end
			
						 end
			
// write addr channel.				  	
			S0: if(w_awready && w_arready)begin
			
					 awaddr <= addr_wr;
					 
					 awlen <= len_wr - 1;
					 
					 awsize <= 3'b001;
					 
					 awburst <= 2'b01;
					
					 wvalid <= 1'b0;
					 
					 i <= 0;
					 
				    awvalid <= 1'b1;
					
					st <= S1;
				 end	
		
	
			S1: if(!w_awready) begin	
					
					 awvalid <= 1'b0;
					 
					 st <= S2;
				 end
					
		
// write data channel.
			S2: begin	
																					
					if(w_wready) begin
					
					   if(i < len_wr) begin
						
							wvalid <= 1'b1;
							
							wdata <= wr_data[nw];
							
							i <= i + 1;
							
							nw <= nw + 1;
						end
						else begin
						
								wvalid <= 1'b0;
								
								if(nw == `PAGE) begin
								
								   nw <= 0;
									
								   st <= S3;
								end
							   else begin
																	
										addr_wr <= addr_wr + len_wr;
										
										st <= S0;
								end
						end
						
					end
					
				end	

			
// read address channel.
			S3: if(w_arready && w_awready)begin

					 i <= 0;
					 
					 araddr <= addr_rd;
					 
					 arlen <= len_rd - 1;
					 
					 arsize <= 3'b001;
					 
					 arburst <= 2'b01;
					 
				    arvalid <= 1'b1;			
					 
					 st <= S4;
				 end	
				 
				
			S4: if(!w_arready) begin	
					
					 arvalid <= 1'b0;
					 
					 rready <= 1'b1;
					 
					 st <= S5;
				 end
						
						
// read data channel.
			S5: begin
						
					if(w_rvalid) begin
							 
						if(i < len_rd) begin
					
							rd_data[nr] <= w_rdata;
							
							i <= i + 1;
							
							nr <= nr + 1;
						end
					end
					else if(i == len_rd) begin
					
							  rready <= 1'b0;
							
						 	  if(nr == `PAGE) begin
							
							     i <= 0;
								  
							     nr <= 0;
								  
							     st <= CMP;
							  end	
							  else begin
						
										addr_rd <= addr_rd + len_rd;
										
										st <= S3;
							  end
					end		
					
				end	
		
		
				
		CMP: begin
			
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
								case(len)
								
								
									0: begin
										
											len_wr <= 1;
											len_rd <= 1;
										end
										
									1: len_wr <= 2;
										
									2: begin
									
											len_wr <= 1;
											len_rd <= 2;
										end
										
									3: len_wr <= 2;										
										
									4: begin
									
											len_wr <= 4;
											len_rd <= 1;
										end
																				
									5: len_rd <= 2;
										
									6: len_rd <= 4;
										
									7: len_wr <= 1;
										
									8: len_wr <= 2;
									
									9: begin
									
											len_wr <= 8;
											len_rd <= 1;									
										end
										
								  10: len_rd <= 2;
										
								  11: len_rd <= 4;

								  12: len_rd <= 8;
										
								  13: len_wr <= 1;
										
								  14: len_wr <= 2;
										
								  15: len_wr <= 4;

								  16: begin
									
											len_wr <= 256;
											len_rd <= 1;
										end
										
								  17: len_rd <= 2;
										
								  18: len_rd <= 4;
										
								  19: len_rd <= 8;
										
								  20: begin
									
											len_rd <= 256;
											len_wr <= 1;
										end
										
								  21: len_wr <= 2;
										
								  22: len_wr <= 4;
										
								  23: len_wr <= 8;
										
								  24: len_wr <= 256;										
										
								  default: ;
									
								endcase	
																
					         pc <= 0;
								
								start <= start + 1;
																
								len <= (len == 24) ? 0 : len + 1;								
								
							end
// next page.							
							addr_wr <= addr_wr + len_wr;
							addr_rd <= addr_rd + len_rd;
													
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
