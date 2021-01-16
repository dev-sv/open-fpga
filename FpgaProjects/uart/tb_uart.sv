
`timescale 10 ps / 10 ps


module tb_uart;


`include "../tb.h"


localparam int       sz = 4;
localparam bit[31:0] Fosc = 50000000;

conf_t::br baud = conf_t::br_115200;

enum {TX, TX_BUSY, RX_WAIT, RX} st = TX;

bit        osc,
			  tx_busy,
			  rx_full,
			  en_tx = 0,
			  tx, rx;
			  
logic[7:0] val = 8'h31,
			  tx_data[sz],
           rx_data[sz];
			  
int        tx_id = 0,
           rx_id = 0; 


initial
begin

	forever
		#1 osc = ~osc;

end


	assign rx = tx;

	uart	#(.sz(sz))uart_mut(.osc(osc), .tx_data(tx_data), .tx(tx), .en_tx(en_tx), .tx_busy(tx_busy),
	                         .rx_data(rx_data), .rx(rx), .rx_full(rx_full), .baud(baud));


									 
	always @(posedge osc) begin
	
		
		case(st)
						 
				 
		   TX: 	   if(!tx_busy) begin
				 					 
							if(tx_id < sz) begin
					 					 
								tx_data[tx_id] <= val;
								++tx_id;
								++val;						 						 
							end
							else begin
// enable tx.					 
								    en_tx <= 1;							  
								    st <= TX_BUSY;
							end					 
						end
				 				 
				 
			TX_BUSY: if(tx_busy) begin
						
							en_tx <= 0;
							st <= RX_WAIT;
	               end
						
				 
		   RX_WAIT:	if(!rx_full)
						   st <= RX;
	 
				 				 
			RX:      if(rx_full) begin
								 					 
					      if(rx_id < sz) begin
						
						      `COMP(tx_data[rx_id], rx_data[rx_id], EQ);	
						       ++rx_id;
					      end
				         else begin
						
									rx_id <= 0;
									tx_id <= 0;							  
									st <= TX;
							end
						end
							 			  
		   default: ;			
				 
		endcase
		
	end

 
endmodule: tb_uart
