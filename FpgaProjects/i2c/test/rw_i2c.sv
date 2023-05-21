


module rw_i2c #(parameter Nw, Nr) (

	
					 input wire       clk,
					 
					 input wire       sclk,
					 inout        		sda,
					 					
					 input wire  		wr_ready,
					 input wire  		rd_ready,
					 					 
					 output bit			wr_end,
					 output bit			rd_end,
					 
					 input  bit[7:0]	wr_in[Nw],
					 output bit[7:0]  wr_out,

					 input  bit[31:0]	num,

					 
					 input  wire[7:0]	rd_in,
					 output bit[7:0]	rd_out[Nr],
					 
 					 input  wire[1:0]	rw_in,
 					 output bit[1:0]	rw_out
					 
					 //output wire[3:0] led
					 
);


 int unsigned i = 0, cnt = 0;

  //bit[7:0] buff[4] = '{1,2,3,4};
 
 enum { IDLE, WR0, WR1, WR2, RD0, RD1, RD2, RD3, STOP } st = IDLE;

 
	//assign op_out = op_in;
 
 
	always @(posedge clk) begin

	
		//rw_out <= rw_in;
	
	
		case(st)
					

		
		IDLE: begin//if(sclk && sda)begin
							
					wr_end <= 1'b1;
					
					rd_end <= 1'b1;
					
				
					if(rw_in == 2'b10 || rw_in == 2'b01) begin
	
						rw_out <= 2'b10;//`OP_WR;
					
						st <= WR0;
					end
				end	
		
			
		WR0: 	begin
		
				if(!wr_ready) begin
				
				   wr_end <= 1'b0;
								
					wr_out <= wr_in[i];
	
				   st <= WR1;
				  
			  end	
			  end
					

		WR1: begin
			
				if(wr_ready) begin
										
					if(i < num) begin
						
						i <= i + 1'b1;
					
						//cnt <= cnt + 1;
						
						st <= WR0;
					end
					else begin
									
							i <= 0;	
														
							wr_end <= 1'b1;
							
							//cnt <= cnt + 1;
							
							if(rw_in == 2'b01) begin
							//if(wr_in[0][0] == 2'b01) begin
								
								//cnt <= cnt + 1;		
								rd_end <= 1'b0;
								
							   st <= RD0;
				         end
							else begin
							
									//if(wr_in[0][0] == 1'b0)
									//cnt <= cnt + 1;
							
									rw_out <= 2'b00;//`OP_NO;
							
									
									    st <= STOP;//IDLE;//WR2;
							end	
					end		
												
				end	

			  end
			  
		
//		STOP: if(rw_in == 2'b00)
		STOP: if(sclk && sda)
					st <= IDLE;
			  
			  
			  
		RD0: if(!rd_ready)
		        st <= RD1;
					
				
		RD1: if(rd_ready) begin

				//led <= ~cnt;
				  
				  
				  rd_out[i] <= rd_in;
				 
				  //if(i < (num - 1)) begin
				  if(i < 3) begin
				  					  
					  i <= i + 1'b1;
					  
					  st <= RD0; 
					  
					end 
					else begin
				  			
				
							//led <= ~cnt;
							
							i <= 0;
													
							rw_out <= 2'b00;//`OP_NO;													
								
							rd_end <= 1'b1;
							
							st <= RD2;
					end
				  
				end  
			  
			default: ;//led <= ~cnt;  

		endcase	  
end		
			  
endmodule: rw_i2c