
/*

 chip ds1307 used.
 
 dev_addr:  8'hd0
 
 rtc range: 8'h00 - 8'h07
 
 ram range: 8'h08 - 8'h3F

 ram (56 bytes) used for test.

*/

module hw_test #(parameter Nb) (

	
					 input wire       clk,
					 
					 input wire       sclk,
					 
					 inout        		sda,
					 					 					
					 input wire[7:0] 	dev_addr,
					 
					 input wire[7:0] 	addr,
					 
					 input wire  		wr_ready,
					 
					 input wire  		rd_ready,
					 					 					 
					 output bit[7:0]  wr_data,
					 
					 input  wire[7:0]	rd_in,
					 					 
 					 output bit[1:0]	rw,
					 
					 output bit[3:0] 	led
);

 `define Size 64
 
 
 bit[7:0] i = 0;
 bit[7:0] data = 8'h01;
 bit[7:0] addr_off;
 bit[7:0] wr_arr[`Size + 2];
 bit[7:0] rd_arr[`Size];
 bit[3:0] err = 4'b1001;
 
 int unsigned N = 0;
 int unsigned num = 0;
 
 
 enum { WR, RD_ADDR, RD_CMD } s = WR;
 
 enum { INI, LD, STOP, WR0, WR1, RD, RD0, RD1, CMP, ERR } st = INI;




	always @(posedge clk) begin

	
 
		case(st)
		

			INI: begin
			
					addr_off <= addr;
					
					N <= Nb;
					
					st <= LD;
				  end	

		
		
			LD: begin
			
					wr_arr[0] <= dev_addr;
					wr_arr[1] <= addr_off;						

					if(i < N) begin
					
					   wr_arr[i + 2] <= data;
						
						data <= data + 1'b1;
						
						i <= i + 1'b1;
					end	
					else begin
														
							i <= 0;
							
							num <= N + 2;
							
							st <= STOP;
					end	
			
				  end	

				  
				  
		   STOP: if(sclk && sda) begin
			
						
						st <= WR0;
		
						case(s)
						
							
							WR: 		begin
														
											rw <= 2'b10;
												
											s <= RD_ADDR;																						
									   end
										
								 
							RD_ADDR: begin
												
											num <= 2;
								
											wr_arr[0] <= dev_addr;
								
											wr_arr[1] <= addr_off;
								
											rw <= 2'b10;
								
											s <= RD_CMD;									
										end
										
							
							RD_CMD: 	begin
							
											num <= 1;
								
											wr_arr[0] <= (dev_addr | 8'h01);
						
											rw <= 2'b01;
								
											s <= WR;									
										end
							 
							 
							default: ;
		
						endcase
						
					end
					
					
		
			WR0: if(!wr_ready) begin
											  
					  wr_data <= wr_arr[i]; 	
						  
					  i <= i + 1'b1;	
						  							  
					  st <= WR1;
				  end	
					

			WR1: if(wr_ready) begin
																				
						if(i < num)							
							st <= WR0;

						else begin
																		
								i <= 0;	
									
								if(rw == 2'b01)										
								   st <= RD;

								else begin											
											
										rw <= 2'b00;
																										
										st <= STOP;											
								end
						end		
												
				  end	

				  		  
// wait finish writing.

			RD:  if(!wr_ready)
				    st <= RD0;	
		
		
			RD0: begin
		
					if(i < N) begin
		
						if(!rd_ready) begin
					
// set finish of reading before last byte.
					
							if(i == (N - 1))
								rw <= 2'b00;
						
							st <= RD1;
						end
					end
					else begin
						
							i <= 0;
													
							st <= CMP;						
					end
				
				  end			
				  
									
			RD1: if(rd_ready) begin
				  	
					  rd_arr[i] <= rd_in;
					 
				     i <= i + 1'b1;
					  
				     st <= RD0;
			     end
			  				
							
			CMP: begin
		
					if(i < N) begin
		
						if(wr_arr[i + 2] != rd_arr[i])
													
							st <= ERR;

						else begin
						
								i <= i + 1'b1;
																
								led <= ~4'b0000;
						end		
						
					end	
					else begin
					
							i <= 0;
							
							if((addr_off + Nb) < `Size) begin

// load remnant.					
								 if((`Size - (addr_off + Nb)) <= Nb)
								     N <= `Size - (addr_off + Nb);
								 
								 addr_off <= addr_off + Nb;
							
								 st <= LD;
							
							end
							else st <= INI;														
					end
					
				  end	
				
				
			ERR: led <= ~err;
					
			
			default: ;
		
		endcase
 
 end


endmodule: hw_test
