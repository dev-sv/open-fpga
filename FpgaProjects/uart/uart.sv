

package conf_t;
	
	//bit  odd;				
	//enum {one = 1, two} stop;	
				
typedef	enum {
						br_115200 = 115200, 
				      br_57600 = 57600, 
						br_38400 = 38400,
						br_19200 = 19200,
						br_9600 = 9600,
						br_4800 = 4800,
						br_2400 = 2400,
						br_1200 = 1200,
						br_600 = 600,
						br_300 = 300 } br;
				
endpackage



module uart #(parameter sz = 1)(input bit osc, input logic[7:0] tx_data[sz], output bit tx = 1'b1, input bit en_tx, output bit tx_busy, 
				                    output logic[7:0] rx_data[sz],  input bit rx, output bit rx_full, input conf_t::br baud);		
		

localparam bit[31:0] Fosc = 50000000;


enum {RX_START, RX} 			st_rx = RX_START;
enum {INI, TX_EN, TX_START, TX} st_tx = TX_EN;

wire 	w_c0;
bit   sclk = 0;
 
int	n_tx = 8, 
      n_rx = 0,
		count = 0,
		rx_id = 0,
      tx_id = 0;
			  

	
	pll	pll_inst(.inclk0(osc), .c0(w_c0));
		
	
	always @(posedge w_c0) begin
	
	
			
		count <= count + 1; 
		
		if(count == ((Fosc/baud) - 1)) begin
		
			count <= 0;
		   sclk <= 0;	
		end
	   else sclk <= 1;
		
	end


// Tx.	
	always @(posedge sclk) begin	

	
		case(st_tx)
		
		
			  INI:      begin
			  
							  tx <= 1'b1;	
							  st_tx <= TX_EN;
							  
							end 			
							
							
			  TX_EN:    if(en_tx) begin
			  
							   st_tx <= TX_START;
							end	
						  	 
							  					
			  TX_START: begin
			  							  
			              tx_busy <= 1'b1;
			              tx <= 1'b0;							  
							  n_tx <= 0;
						     st_tx <= TX;							  
					      end	
					 
			
			  TX: 		begin
										   	
								  if(n_tx < 8) begin
					
								     tx <= tx_data[tx_id] >> n_tx;									  
								     ++n_tx;
								  end								  
								  else begin
// set stop bit.																						
											tx <= 1'b1;	 
											
											if(tx_id < (sz - 1)) begin
											
												++tx_id;		
											   st_tx <= TX_START;
										   end													
											else begin
											
											       tx_busy <= 0;											
													 tx_id <= 0;
													 st_tx <= TX_EN;
										   end	
											
								  end		
								  
							end		 
														
			default: ;
			
		endcase
	
	
		
		case(st_rx)
		
						
			
			RX_START:  begin
						
							 n_rx <= 0;
// start bit.							 
							 if(!rx) begin
							 
								 rx_full <= 0;
							  	 rx_data[rx_id] <= 0;
							    st_rx <= RX; 
							 end	 
						  end
						 
						 
			RX:        begin
										 
                      if(n_rx < 8) begin
							
							    rx_data[rx_id] <= rx_data[rx_id] | (rx << n_rx); 
								 ++n_rx;
							 end															 
							 else begin 
// stop bit.							 
							        if(rx) begin
									  									    										  
	           					     if(rx_id < (sz - 1)) begin
										    
											  ++rx_id;	
										     n_rx <= 0;			
										  end	
										  else begin
										         
													rx_id <= 0;
										         rx_full <= 1; 
										  end			
																					  
										  st_rx <= RX_START;    
										 
									  end							  
							 end		
							 
						  end
						  						  							
			default: ;
			
	   endcase
	  
	end 	

endmodule: uart
