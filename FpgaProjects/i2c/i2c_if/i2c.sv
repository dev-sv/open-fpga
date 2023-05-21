



 module i2c(
 
				input wire 		 clk, 
												
				input wire[1:0] rw,
								
				input wire[7:0] wr_data, 
				
				inout 	 		 sda, 
				
				output bit		 sclk,
				
            output bit[7:0] rd_data,
				
            output bit 		 wr_ready,
				
            output bit 		 rd_ready								
 );


 `define OP_WR 2'b10
 `define OP_RD 2'b01
 `define OP_NO 2'b00
			 
			 
 enum { IDLE, WR, HI, S_ACK, RD, LOW, Z } st = IDLE;
			  			  
 bit		 sw = 1'b1; 
 bit  	 en = 1'b0; 
 bit 		 sda_bit = 1'b1;
 bit[3:0] wr_nb = 8;
 bit[3:0] rd_nb = 8; 
 
 
  
 
	assign sda = sw ? sda_bit : 1'bz;
	
	assign rd_ready = rd_nb ? 1'b0 : 1'b1;
	
	assign wr_ready = wr_nb ? 1'b0 : 1'b1;
	
				
		
// sclk 100 kHz.	
	always @(negedge clk)
		sclk <= en ? ~sclk : 1'b1;
	



		
	always @(posedge clk) begin			
	
		
		
		case(st)
		

		
			IDLE: if(rw == `OP_WR || rw == `OP_RD) begin			
// start.							
						en <= 1'b1;	
							
						sda_bit <= 1'b0;
							
						st <= WR;								
					end

					 
					 					 
			WR:   if(!sclk) begin
						
						
						if(wr_nb) begin
						 							 
						   sw <= 1'b1;

					      sda_bit <= wr_data[wr_nb - 1];
							 
							wr_nb <= wr_nb - 1'b1;
							 
							st <= HI;							 
						end
					   else begin
						  						
												
								wr_nb <= 8;
									
								sw <= 1'b0;
									
								st <= S_ACK;
						end
						  
					end			
				

			HI: 	 if(sclk)
					    st <= WR;

					
// get ACK from slave.

		   S_ACK: if(!sda) begin
														
// finish writing.								
						 if(rw == `OP_NO) begin		
							
							
							 en <= 1'b0;
							
							 sw <= 1'b1;
						
							 sda_bit <= 1'b1;
							 
						 	 st <= IDLE;
							
						 end
						 else st <= (rw == `OP_WR) ? WR : RD;									
						 
				    end
					 					
			
							
			RD:    if(sclk) begin	
							
							
					    rd_data[rd_nb - 1] <= sda;							
							
						 rd_nb <= rd_nb - 1'b1;
						 						 
					    st <= LOW;
				    end					
					

									
										
			LOW:   if(!sclk) begin
			
						 if(rd_nb)
						    st <= RD;
							
						 else begin
						
								 rd_nb <= 8;										
// finish reading.			
								
								 if(rw == `OP_NO) begin
										
									 en <= 1'b0;	
							
									 sw <= 1'b1;	
						 
									 sda_bit <= 1'b1;	
									
								    st <= IDLE;
								 end									
								 else begin
								
// set ACK to slave.				
										 sw <= 1'b1;	
						 
										 sda_bit <= 1'b0;
									
										 st <= Z;
																			
								 end
						 end 
						
					 end	
			
							
// set sda to z.					 
			Z:     if(!sclk) begin									
									
					    sw <= 1'b0;

					    st <= RD;
					 end			
					 		
					
		   default: ;
		
		endcase
		
	end

endmodule: i2c
