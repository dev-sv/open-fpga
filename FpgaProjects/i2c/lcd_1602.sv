
package lcd_t;

 typedef struct {
 
             logic[7:0] rtc[16];
             logic[7:0] mem[16];
				 
			} lcd_1602;

endpackage


module lcd_1602(input bit clk, inout sda, output bit sclk, input lcd_t::lcd_1602 ch0, input lcd_t::lcd_1602 ch1);


enum_t::i2c_t st;
enum_t::en_t  en = enum_t::EN_WR;

enum {INI, FREE, BUSY, CMD, LOAD} state = INI;

localparam int      N = 33;
localparam bit[7:0] STR_1 = 8'h80,
                    STR_2 = 8'hc0,
						  STR_3 = 8'h88,
                    STR_4 = 8'hc8;
						  

bit[1:0]   n = 0;			  
bit[3:0]   ir = 0, 
           im = 0;
bit[2:0]   pos = 4;

int        i = 0,			   
           max = 23;			  
           
logic[7:0] data, tmp,                         	 
			  buff[N], 
           out_i2c, 
           str = STR_1;

	

	
	i2c	i2c_inst(.clk(clk), .sda(sda), .sclk(sclk), .data(data), .en(en), .st(st), .out_i2c(out_i2c));


	always @(negedge clk) begin
	
	
	
		case(state)
		
		
			INI:   begin
			
						$readmemb("lcd_1602.ini", buff, 0, 22); 
                  state <= FREE;  
			       end
			

			FREE: if(st == enum_t::ACK || !i) begin
																  
 	               data <= buff[i];
						state <= BUSY;							
					end					
					

			BUSY: if(st == enum_t::WR) begin
					  
					   ++i;
						
						if(i < max)
					      state <= FREE;
							
						else begin
						
		                   en <= enum_t::EN_STOP;
  		                   state <= LOAD;								 
					   end					  
					end										
										
				
			LOAD: if(st == enum_t::STOP) begin
			
			
			         case(pos)
			
							0,1: begin
									 
									 channel(0, ir);

									 ++n;
								    ir <= ir + 4'b1000;			
									 pos <= 4;									  
								  end
									
						
						   2,3: begin
									  
  									 channel(1, im);

									 ++n;
									 im <= im + 4'b1000;
									 pos <= 4;									  
								  end
						
						   						
						     4: begin
									  							
									 pos <= n;
									  
									 str <= ((str == STR_1) ? STR_2 : (str == STR_2) ? STR_3 : (str == STR_3) ? STR_4 : (str == STR_4) ? STR_1 : STR_1);
									  
								    buff[1] <= (str & 8'hF0) | 4'b1100;
						          buff[2] <= (str & 8'hF0) | 4'b1000;
						          buff[3] <= ((str & 8'h0F) << 4) | 4'b1100;
						          buff[4] <= ((str & 8'h0F) << 4) | 4'b1000;
									 max <= 5;
							     end									 
							
						   default: ;	
						 		
						endcase
							
					   i <= 0;	
					   en <= enum_t::EN_WR;							
					   state <= FREE;												 					
																																					   			          					
			      end
					
			default: ;
									  
		endcase
		
	end

	
task channel(input bit ch, input bit[3:0] id);
 
 for(int i = 1; i < 30; i = i + 4) begin
 
 	  buff[i + 0] = !ch ? (ch0.rtc[id] & 8'hF0) | 4'b1101 : (ch1.mem[id] & 8'hF0) | 4'b1101;
	  buff[i + 1] = !ch ? (ch0.rtc[id] & 8'hF0) | 4'b1001 : (ch1.mem[id] & 8'hF0) | 4'b1001;		  
	  buff[i + 2] = !ch ? ((ch0.rtc[id] & 8'h0F) << 4) | 4'b1101 : ((ch1.mem[id] & 8'h0F) << 4) | 4'b1101;		  
	  buff[i + 3] = !ch ? ((ch0.rtc[id] & 8'h0F) << 4) | 4'b1001 : ((ch1.mem[id] & 8'h0F) << 4) | 4'b1001;
	  ++id;
 end 
 
 max = N;									  
endtask	

	
endmodule: lcd_1602
