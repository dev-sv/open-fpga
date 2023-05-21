


module stimulus #(parameter Nb) (

	
					 input wire       clk,
					 
					 input wire       sclk,
					 
					 inout        		sda,
					 					 					
					 input wire[7:0] 	dev_addr,
					 
					 input wire[7:0] 	addr,
					 
					 input wire  		wr_ready,
					 
					 input wire  		rd_ready,
					 					 					 
					 output bit[7:0]  wr_data,
					 					 
 					 output bit[1:0]	rw
					 					 
);

 `define Size 64

 
 bit[7:0] data = 8'h01;
 bit[7:0] addr_off;
 bit[7:0] wr_arr[`Size + 2];
 bit[7:0] rd_arr[`Size];
 
 int unsigned i = 0;
 int unsigned num = 0;
 int unsigned N = 0;
  
 enum { WR, RD_ADDR, RD_CMD } s = WR;
 
 enum { INI, LD, STOP, WR0, WR1, RD, RD0, RD1, FINISH } st = INI;



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
					

			WR1: begin
						
					if(wr_ready) begin
																				
						if(i < num)							
							st <= WR0;

						else begin
																		
								i <= 0;	
									
								if(rw == 2'b01) begin
								
								   st <= RD;
								end
								else begin											
											
										rw <= 2'b00;
																										
										st <= STOP;											
								end
						end		
												
					end	

				  end

				  
				  
		RD:  if(!wr_ready) begin
		
				 st <= RD0;
			  end
			  
		
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
																			
						if((addr_off + Nb) < `Size) begin

// load remnant.						
							if((`Size - (addr_off + Nb)) <= Nb)
								 N <= `Size - (addr_off + Nb);
								 
							addr_off <= addr_off + Nb;
							
							st <= LD;
							
						end
					   else st <= FINISH;
						
				end
				
			  end			
				  
									
		RD1: if(rd_ready) begin
				  						  					  
				  i <= i + 1'b1;
				  					 
				  st <= RD0;
			  end
			  
			
		default: ;
		
	endcase
 
 end


endmodule: stimulus
