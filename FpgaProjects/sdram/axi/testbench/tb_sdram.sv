
/*

 Testbench sdram ip.

 Using mt48lc4m16a2 sdram model.
      2001 Micron Semiconductor Products, Inc.

*/


`timescale 1ns / 1ps

module tb_sdram;


 wire[15:0] dq;

 wire[11:0] address;

 wire[1:0]  ba,
		 	   dqm;

 wire		  osc,
			  cs,
			  we,
			  ras,
			  cas;
			  

 `define PAGE 		256				// 256x16.
 `define MAX_PAGE 16384				//	4x4096.

 enum { SET_DATA, S0, S1, S2, S3, S4, S5, S6, CMP, ERR } st = SET_DATA;
			 
			 
 bit[21:0] awaddr,
           addr_wr = 22'h000000;
 bit[7:0]  awlen;
 bit[2:0]  awsize;  
 bit[1:0]  awburst; 
 bit	     awvalid;
 wire	     w_awready; 				
 bit[15:0] wdata;
 bit    	  wvalid;
 bit    	  wlast;
 wire      w_wready;

 
 bit[21:0]  araddr, 
            addr_rd = 22'h000000;
 bit[7:0]   arlen;
 bit[2:0]   arsize;
 bit[1:0]   arburst;
 bit		   arvalid = 1'b0;
 wire       w_arready;
 wire[15:0] w_rdata;
 wire       w_rvalid;
 bit        rready;
 
 
 bit[8:0] i = 0,
			 nw = 0,
			 nr = 0,
			 len = 1,
			 len_wr = 1,
		    len_rd = 1;
			 
 bit[15:0]  value = 0,		// data value.
				start = 0;		// start data value.
				  
 int unsigned pc = 0;		// page counter.

 //string   str = "error"; 
 //bit[7:0] error = 8'h81;	// error code.
 
 bit[15:0] 	rd_data[`PAGE], 	// read data.
				wr_data[`PAGE];	// write data.
   
 bit clk = 0;
 

 initial begin

	forever #5 clk = ~clk;

 end			  


 sdram sdram_dut(

//sdram_if.

		.clk(clk),
      .reset(1'b1),
		
		.dq(dq),
		.address(address),
		.ba(ba),
		.dqm(dqm),
		.osc(osc),
		.cs(cs),
		.we(we),
		.ras(ras),
		.cas(cas),
		

// axi_if.
		
		.axi_awid(8'h00),
		.axi_awaddr(awaddr),
		.axi_awlen(awlen),
		.axi_awsize(awsize),  
		.axi_awburst(awburst), 
		.axi_awvalid(awvalid),
		.axi_awready(w_awready), 
				
		.axi_wdata(wdata),
		.axi_wstrb(2'b11),  
		.axi_wvalid(wvalid),
		.axi_wready(w_wready),
				
		//.axi_wlast(wlast),
		/*
		output wire[7:0]  axi_bid, 
		output wire	      axi_bvalid,
		input bit	      axi_bready, 
		*/
				
		.axi_arid(8'h00), 
		.axi_araddr(araddr),
		.axi_arlen(arlen), 
		.axi_arsize(arsize), 
		.axi_arburst(arburst),
		.axi_arvalid(arvalid),
		.axi_arready(w_arready),
				
		.axi_rdata(w_rdata),
		.axi_rvalid(w_rvalid), 
		.axi_rready(rready)
		//.axi_rlast(), 
		//.axi_rid(8'h00),		
 );

 

  mt48lc4m16a2 mt48lc4m16a2_inst(.Dq(dq), .Addr(address), .Ba(ba), .Clk(osc), .Cke(1'b1),
  
											.Cs_n(cs), .Ras_n(ras), .Cas_n(cas), .We_n(we), .Dqm(dqm));




	always @(posedge clk) begin
	
	
		case(st)
	
	
			SET_DATA: begin
						
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
				
		
// write data channel
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
						
					 araddr <= addr_rd;
					 
					 arlen <= len_rd - 1;
					 
					 arsize <= 3'b001;
					 
					 arburst <= 2'b01;
					
					 i <= 0;
					 
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
						
							$display("\n addr_wr = %x wr_data[%d] = %x addr_rd = %x rd_data[%d] = %x  error.\n", addr_wr, i, wr_data[i],  addr_rd, i, rd_data[i]);
							
							$stop;
							
            		end
						else begin
						
								i <= i + 1;
								
								$display("wr_data[%d] = %x  rd_data[%d] = %x  len_wr = %d len_rd = %d start = %x  pass", i, wr_data[i], i, rd_data[i], len_wr, len_rd, start);
						end
					   
					end
					else begin
					
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
								
								if(start == 16'hFFFF) begin
								
									$display("\nTest finished.\n");
								
									$stop;
								end
								else start <= start + 1;
								
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
	
			default: ;
			
	
		endcase
	
	end

endmodule
