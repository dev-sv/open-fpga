



module ds1307(input bit clk, inout sda, output bit sclk, output lcd_t::lcd_1602 out_ds1307);


 localparam [7:0] addr_dev = 8'b11010000;
 
 enum_t::i2c_t st;
 enum_t::en_t  en = enum_t::EN_WR;

 
 enum {INI, FREE, BUSY, LOAD, NONE}     state = INI;
 enum {GET, OUT, ADDR, READ, WRITE, NO} op = ADDR;

 int        i = 0, 
            max = 9;
 
 bit[2:0]   addr = 3'b000;
 
 logic[7:0] data, 
            out_i2c,
				buff[10],
				tmp[8];  
         

			
	i2c	i2c_inst(.clk(clk), .sda(sda), .sclk(sclk), .data(data), .en(en), .st(st), .out_i2c(out_i2c));
	

	always @(negedge clk) begin
	
	
		case(state)
		
		
			INI:   begin
			
						buff[0] = addr_dev;    	// dev addr.
						buff[1] = 8'b00000000;	// addr. 
						buff[2] = 8'b00110000;	// sec.
						buff[3] = 8'b01011001; 	// min.
						buff[4] = 8'b00100011; 	// hour. 
						buff[5] = 8'b00000011; 	// day.
						buff[6] = 8'b00010101; 	// date.
						buff[7] = 8'b00010001; 	// month.
						buff[8] = 8'b00100001; 	// year. 
						buff[9] = 8'b10010000; 	// out			
			
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
						

						case(op)
					
				        GET:  begin
						  						  
								    tmp[addr] <= out_i2c;
									 
									 ++addr;
									 
									 op <= !addr ? OUT : ADDR;
									 
								  end 
								  
						  OUT:  begin
				
									 out_ds1307.rtc[0] <= (8'h30 | tmp[6] >> 4); 
									 out_ds1307.rtc[1] <= (8'h30 | (tmp[6] & 8'h0F));
									 out_ds1307.rtc[2] <= ".";
									 out_ds1307.rtc[3] <= (8'h30 | tmp[5] >> 4); 
									 out_ds1307.rtc[4] <= (8'h30 | (tmp[5] & 8'h0F));
									 out_ds1307.rtc[5] <= ".";
									 out_ds1307.rtc[6] <= (8'h30 | tmp[4] >> 4); 
									 out_ds1307.rtc[7] <= (8'h30 | (tmp[4] & 8'h0F));
									 
									 out_ds1307.rtc[8] <= (8'h30 | tmp[2] >> 4); 
									 out_ds1307.rtc[9] <= (8'h30 | (tmp[2] & 8'h0F));
									 out_ds1307.rtc[10] <= ":";
									 out_ds1307.rtc[11] <= (8'h30 | tmp[1] >> 4);
									 out_ds1307.rtc[12] <= (8'h30 | (tmp[1] & 8'h0F));
									 out_ds1307.rtc[13] <= ":";
									 out_ds1307.rtc[14] <= (8'h30 | tmp[0] >> 4);
									 out_ds1307.rtc[15] <= (8'h30 | (tmp[0] & 8'h0F));									 
									
				                op <= ADDR;
                          end												  								  
						
						  ADDR: begin
						  
                            buff[0] <= addr_dev;
                            buff[1] <= addr;
									 max <= 2;
									 
									 i <= 0;
									 op <= READ;
									 state <= FREE;
									 en <= enum_t::EN_WR;
						        end
						
						  READ: begin
						  
                            buff[0] <= addr_dev | 1'b1;
									 max <= 1;
									 
									 i <= 0;
						          op <= GET;
									 state <= FREE;
									 en <= enum_t::EN_RD;
						        end 
						
						  default: ;
						  						
						endcase
												
					end
			
			default: ;		
			
		endcase	

	end

endmodule: ds1307