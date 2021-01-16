


module w25q32(input bit clk, miso, output bit sclk, ss, mosi, output logic[7:0] mem_data,
																				  output logic[23:0] addr_data);

																				  
enum {STATUS, WR, WR_EN, RD, BUSY, ERASE, WR_NEXT, NONE} state = WR_EN;

localparam MAX = 1024;

bit  fl = 0,
     en = 0,
	  ers = 1;

bit[31:0] nwr = 0,
          nrd = 0;
	  
int  i = 0, delay = 0;		
	  
logic[39:0] spi_data;
             
logic[23:0] addr_rd = 24'h000000,				
            addr_wr = 24'h000000;
				
logic[7:0]  data = 8'h00,
            val = 8'h01;
	
	  


	spi	#(.Ni(5), .No(1), .mode(0)) spi_inst(.clk(clk), .miso(miso), .en(en), .in_data(spi_data), 
	                                   .sclk(sclk), .ss(ss), .mosi(mosi), .out_data(mem_data), .nwr(nwr), .nrd(nrd));
												  
												  
		
		always @(posedge clk) begin
		
			
			if(!ss) begin
		
				fl <= 0;
				en <= 0;
			end
		
			if(!fl && ss) begin
		
				if(i) begin
			
					fl <= 1;			
					en <= 1;
					i <= 0;
				end	
				else begin
							
						case(state)
						
						
							 WR_EN: begin
			
										 nwr <= 1;
										 nrd <= 0;
										 spi_data <= (8'h06);
										 i <= 1;
										 
							          state <= ers ? ERASE : WR;
									  end
						
			
							STATUS: begin
							
										 nwr <= 1;
										 nrd <= 1;
										 spi_data <= 8'h05;
										 i <= 1;
										 
							          state <= BUSY;
						           end
									  
			
							  BUSY: begin
							  
										 if(!(mem_data & 8'h01))
										    state <= WR_EN;	
											 
							          else state <= STATUS;
						           end
								
								
							 ERASE: begin
							 
										 nwr <= 4;
										 nrd <= 0;
										 spi_data <= (32'h20000000 | addr_wr);
										 i <= 1;
										 ers <= 0;
							          state <= STATUS;							
									  end	 
					
						 
								 WR: begin
								 
										 nwr <= 5;
										 nrd <= 0;
				             		 spi_data <= (40'h0200000000 | (addr_wr << 8) | data);
					                i <= 1;
										 state <= WR_NEXT;										 
									  end
									  
						  WR_NEXT: begin
						  
									    if(addr_wr < (MAX - 1)) begin
										 
										    ++addr_wr;
											 ++data;
											 
											 state <= STATUS;
							          end		
										 else state <= RD;
						  						  
									  end
						 
								 RD: begin
								 
										 if(delay < 7000000)
						                ++delay;
											 
										 else begin	 
										 
										        if(addr_rd < MAX) begin
										 
										           nwr <= 4;
												     nrd <= 1;
												     spi_data <= (32'h03000000 | addr_rd);
										           i <= 1;
													  addr_data <= addr_rd;
												     ++addr_rd;
												     delay <= 0;
												  end
												  else begin
												  
															i <= 0;
															fl <= 0;
															en <= 0;
															ers <= 1;
															data <= val;
															++val;
															addr_wr <= 0;
															addr_rd <= 0;
															
										               state <= WR_EN;						
												  end
										 end
									  end
												
				
								 default: state <= RD;
					
						endcase
			
				end
				
			end
			
		end

endmodule: w25q32
