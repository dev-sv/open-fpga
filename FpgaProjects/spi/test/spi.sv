

/*

*/	

module spi(

				input wire	clk,
				
				output bit  ss, 
				output bit  sclk, 
				output bit  mosi, 
				input  wire miso, 
											
				input wire[1:0] rw,
												
				input wire[7:0] in_data, 
												
				output bit[7:0] out_data, 

				output bit[3:0] wr_n, 
				
				output bit[3:0] rd_n, 
											
				input wire[1:0] mode
);
				
				
enum { INI, START, S0, S1 } st = INI;

		

		
		always @(posedge clk) begin
				
		
			case(st)
		
			
				INI:    begin
// initial state.
							ss <= 1'b1;
							
							wr_n <= 0;
							rd_n <= 0;
							
							sclk <= (mode == 0 || mode == 1) ? 1'b0 : 1'b1;
							
							st <= START;
						  end 	
			
			
			
				START: if(rw == 2'b10 || rw == 2'b01) begin
							
							 //sw_ss <= 1'b0;
							 ss <= 1'b0;
							 
							 wr_n <= 8;
							 
							 rd_n <= 8;
							 							 
							 st <= S0;	
						 end
						 
			 
				S0:    begin
															
							sclk <= (mode == 0 || mode == 1) ? 1'b0 : 1'b1;
							
							
						   if(wr_n) begin
															
								mosi <= in_data[wr_n - 1];
								
								wr_n <= wr_n - 1'b1;
								
						   end
								
							st <= S1;
							
						 end
						 												
						 		 
				S1:    begin
								
						   sclk <= (mode == 0 || mode == 1) ? 1'b1 : 1'b0;
														
													 						 						 
							if(rw == 2'b01) begin
						 
								if(rd_n) begin
																
								   out_data[rd_n - 1] <= miso; 
									
									rd_n <= rd_n - 1;
									
									st <= S0;
									
							   end
								else begin
																		
										rd_n <= 8;
										
										st <= (rw == 2'b00) ? INI : S1;
								end		
							 		
							end
							else begin
							
									if(!wr_n)										
										wr_n <= 8;
																					
									st <= (rw == 2'b00) ? INI : S0;
							end		
														 
					    end	
						 
				
				default: ;			 
						 
			endcase
			
		end
				
		
endmodule: spi
