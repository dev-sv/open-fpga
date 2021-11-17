

module lcd_12864b_top(input bit osc, output bit rs, rw, e, output logic [7:0] data);
	

`include "type.h"
	
localparam int MaxDelay = 300000;
localparam int QS = 8;	   			//	queue size.				  
localparam int N = 16;	   			//	buffer size.				  

enum {READY, BUSY}           state_lcd = READY;
enum {POS, DATA, LOAD, PAGE} state_data = POS;


logic[7:0] buff = 0,

// Start of strings.		
	        pos_curs[4] = '{8'b10000000, 8'b10010000,
									8'b10001000, 8'b10011000}; 
			  			  
logic[$clog2(QS) - 1:0] pWR, 
                        p = 0;			  


bit      full,
         cmd = 0, 
			unlock = 0;
						
wire      w_c0; 
wire[2:0] w_q;			

int   i = 0, 
		j = 0,
      n = 5, 
	   delay = 0;

		
// Test data. 
t_str    lcd_data = '{8'b00110000, 8'b00001100, 8'b00110000, 
                      8'b00000001, 8'b00000110, 8'hFF, 8'hFF, 
							 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF, 8'hFF,
			   			 8'hFF, 8'hFF, 8'hFF};
bit[6:0] ascii = 0;
bit[1:0]	str = 0; 
		

		
	pll_osc	pll_inst(.inclk0(osc), .c0(w_c0));
		
	counter	counter_inst(.clock(w_c0), .q(w_q));

	lcd_12864b	#(QS)lcd_12864b_inst(.clk(w_q[2]), .in_data(buff), .cmd(cmd), .pWR(pWR),
	                                 .rs(rs), .rw(rw), .e(e), .out_data(data), .full(full));
	  


	always @(posedge w_q[2]) begin
			
		
		if((j < n) && !full) begin

   		buff <= lcd_data[j++];
		   pWR <= p++;		
		end
						
			
		case(state_lcd)
		
			
			  READY: begin
				
			           if(i < n) begin
			
				           if(e) begin
							  
						        ++i;
							     state_lcd <= BUSY;
				           end	
		              end
		              else unlock <= 1;
						  
				      end
					 
			  BUSY:  if(!e)
					      state_lcd <= READY;				
					
			  default: ;		

		endcase
						

// Load data for lcd.
		if(unlock) begin
		

		   case(state_data)
						

		        POS:  begin									  
			
			             i <= 0;
			             j <= 0;
			             n <= 1;
			             cmd <= 0;
				          unlock <= 0;
				          lcd_data[0] <= pos_curs[str];	
											 
		                state_data <= LOAD;
			           end
						
			     LOAD: begin
			
					       i <= 0;
							 j <= 0;
							 n <= N;
							 cmd <= 1;
							 unlock <= 0;
// ascii simbols.					  					 
							 for(int i = 0; i < N; ++i)
	       				     lcd_data[i] <= ascii++;
							 								  
				          ++str;
						
				          if(!str) begin
							 
								 delay <= 0; 
		                   state_data <= PAGE;
							 end 			  
					       else state_data <= POS;							 
					  
				        end
						  
				  PAGE: begin
							
							 if(delay < MaxDelay)							 
							    ++delay;
// Clear display.								 
							 else begin 
							 
			                    i <= 0;
			                    j <= 0;
									  n <= 1;
			                    cmd <= 0;
				                 unlock <= 0;
				                 lcd_data[0] <= 8'h01;	
							 							 
							        state_data <= POS;	 
							 end 		  
						  end	
		
		        default: ;

		   endcase
			
	   end				
						
	end			


endmodule: lcd_12864b_top
