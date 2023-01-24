
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

 bit clk = 0;


 
/* Avalon */

 `define PAGE 		256				// 256x16.
 `define MAX_PAGE 15					

 enum { SET_DATA, WR0, WR1, RD0, RD1, RD2, CMP, NEXT, CH_DATA, ERR, STOP } st = SET_DATA;


 bit[8:0] i = 0,
			 nw = 0,
			 nr = 0,
			 bc_wr = 1,			// burstcount wr.
			 bc_rd = 1,				// burstcount rd.
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
				arr_wr[`PAGE],				// array writing.
			   arr_rd[`PAGE],				// array reading.
				value = 16'ha596,			// write data.
				start_value = 0;

bit[7:0] 	 err = 8'h81;				// error code.
int unsigned pc = 0,						// page counter.
             all_banks = 0,			// all banks counter.
             err_count = 0;

string str = "Error"; 
 
 
 

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
							
										wr_addr <= wr_addr + bc_wr;
										
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

											$display("\n bc_wr = %d  bc_rd = %d \n", bc_wr, bc_rd);
											
										end
										else begin
										
												rd_addr <= rd_addr + bc_rd;
												
												st <= RD0;												
										end		
											
								end		
							end
						end
						
						
					  				  			
			CMP: 		begin
			
			
							for(i = 0; i < `PAGE; i++) begin
							
								if(arr_rd[i] != arr_wr[i]) begin
								
									str = "Error";
									err_count++;
								end	
								else str = "Pass ";
							
							   $display("%s:  wr[%d] = %x   rd[%d ] = %x  bc_wr = %d  bc_rd = %d", str, i, arr_wr[i], i, arr_rd[i],  bc_wr, bc_rd);
							end	
							
							st <= NEXT;
														
						end	
						
													
// next page and new burstcount.
					
			NEXT:		begin
												
							i <= 0;									

							
							if(pc < `MAX_PAGE) begin

							
								wr_addr <= wr_addr + bc_wr;
								rd_addr <= rd_addr + bc_rd;											
									 											
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
								
								
								start_value <= start_value + 1;
											
								st <= SET_DATA;
											
							end
							else begin
					
									$display("\nError_count:%d\n", err_count);
									$stop;
							end
							
						end	
	
	
			default: ;
	
	
		endcase
	
	end

				 
endmodule
