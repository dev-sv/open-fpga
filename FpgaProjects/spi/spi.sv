

/*
 Half-duplex mode.

 NByte max bytes. 
 nb_wr number bytes to write.
 nb_rd number bytes to read.
*/	

module spi #(parameter NByte = 1) (spi_if.spi _if, input bit clk, input bit[(NByte << 3) - 1:0] in_data, 
																					   output bit[(NByte << 3) - 1:0] out_data, 
                                                                  input bit [31:0] nb_wr, nb_rd, input bit[1:0] mode);
				
				
enum {START, S0, S1, STOP} state = START;


bit rd = 1'b0,			// flag to read from slave.
    sw_ss = 1'b1,    // switch slave select.
    sw_sclk = 1'b0;  // switch sclk.
	 
bit[31:0]  i = 0,
           j = 0;
			  
			  
		assign _if.ss = sw_ss;
		assign _if.sclk = !sw_sclk ? ((mode == 0 || mode == 1) ? 1'b0 : 1'b1) : ((mode == 0 || mode == 1) ? 1'b1 : 1'b0);
		

		
		always @(posedge clk) begin
				
		
		unique case(state)
		
			
			
				START: if(nb_wr) begin
							
							 sw_ss <= 1'b0;
							 
	 						 i <= nb_wr << 3;
							 j <= nb_rd << 3;
							 
							 state <= S0;	
						 end
						 
			 
				S0:    begin
				
											
							sw_sclk <= (mode == 0 || mode == 1) ? 1'b0 : 1'b1;
																					
						   if(i) begin
							
								--i;
								_if.mosi <= in_data[i];
								
						   end
							else rd <= 1'b1;
														
							state <= S1;
							
						 end
						 												
						 		 
				S1:    begin
				
				
						   sw_sclk <= (mode == 0 || mode == 1) ? 1'b1 : 1'b0;
													 						 						 
						   
							if(rd) begin
						 
								if(j) begin
							
								   --j;
								   out_data[j] <= _if.miso; 
							   end
							 		
							end
								
						   state <= (!i && !j) ? STOP : S0;	 
						 
					    end				
				
				
			  STOP:   begin
			  
						   rd <= 0;

						   sw_ss <= 1'b1;
						 													 						 
						   state <= START;

					    end					  		  	 			
			endcase
			
		end
				
		
endmodule: spi
