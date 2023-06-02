

/*

 op operation send/resv/stop.

 sb send bits 8.
 
 rb receive bits 8.
 
 mode 00, 01, 10, 11.
 
*/	

module spi(

				input wire	clk,
				
				output bit  ss, 
				output bit  sclk, 
				output bit  mosi, 
				input  wire miso, 
											
				input wire[1:0] op,
												
				input wire[7:0] in_data, 
												
				output bit[7:0] out_data, 

				output bit[3:0] sb, 
				
				output bit[3:0] rb, 
											
				input wire[1:0] mode				
);
				

 `define SEND 2'b10
 `define RECV 2'b01
 `define STOP 2'b00
 				
 enum { INI, START, S0, S1 } st = INI;

 
		
		always @(posedge clk) begin				
				
		
			case(st)
		
			
				INI:    begin
// initial state.
							ss <= 1'b1;
							
							sb <= 0;
							
							rb <= 0;
							
							sclk <= (mode == 0 || mode == 1) ? 1'b0 : 1'b1;
							
							st <= START;
						  end 				
			
			
				START: if(op == `SEND) begin
							
							 ss <= 1'b0;
							 
							 sb <= 8;
							 
							 rb <= 8;
							 							 
							 st <= S0;	
						 end
						 
			 
				S0:    begin
																											
							sclk <= (mode == 0 || mode == 3) ? 1'b0 : 1'b1;
																					
							if(op == `SEND) begin
							
								if(sb) begin
															
									mosi <= in_data[sb - 1];
								
									sb <= sb - 1'b1;
																
								end
								
							end	
							else if(!rb)
							        rb <= 8;
							
								
							if(op == `STOP) begin
																
								ss <= 1'b1;
																				
								sclk <= (mode == 0 || mode == 1) ? 1'b0 : 1'b1;
										
								st <= INI;
									
							end
							else st <= S1;
														
						 end
						 												
						 		 
				S1:    begin
								
							sclk <= (mode == 0 || mode == 3) ? 1'b1 : 1'b0;											
											
							if(op == `RECV) begin
						 								
								if(rb) begin
																
								   out_data[rb - 1] <= miso; 
									
									rb <= rb - 1'b1;
									
							   end	
										
							end
							else if(!sb)
									  sb <= 8;
													
							st <= S0;								 
					    end	
						 
				
				default: ;			 
						 
			endcase
			
		end
				
		
endmodule: spi
