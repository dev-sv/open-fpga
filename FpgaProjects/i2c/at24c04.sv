





module at24c04(input bit clk, inout sda, output bit sclk, output lcd_t::lcd_1602 out_at24c04);


 localparam [7:0] pg = 8'h10;
 localparam [7:0] p0 = 8'h02;

 enum_t::i2c_t st;
 enum_t::en_t  en = enum_t::EN_STOP;

 enum {SET_WR, SET_RD, RD_ADDR} op = SET_WR; 
 enum {FREE, BUSY, LOAD, RD_DATA, WAIT, SHOW, DLY} state = LOAD;
 
 
 int        i = 0,
            j = 0,  
            max = 0,
				count = 0;
				
 bit[8:0]   rd_addr = 0,
          	wr_addr = 0; 
 
 logic[7:0] data,
				x = 8'hff,
            out_i2c,
				buff[pg + 2] = '{default: 0},
				buff_data[pg],
				addr_dev = 8'b10100000;

				
 i2c	i2c_inst(.clk(clk), .sda(sda), .sclk(sclk), .data(data), .en(en), .st(st), .out_i2c(out_i2c));

 
 always @(negedge clk) begin 
 
		
		case(state)
					
			
			  FREE:    if(st == enum_t::ACK || !i) begin
					  						  
			              data <= buff[i];
						     state <= BUSY;							
					     end						  
					

			  BUSY:    if(st == enum_t::WR) begin
					  
					        ++i;
						
						     if(i < max)
					           state <= FREE;
														
						     else begin
								 
						            if(!(buff[0] & 8'h01)) begin
								 
								         en <= enum_t::EN_STOP;
				   		            state <= LOAD;
								      end	 								 	 
								      else state <= RD_DATA;	
						     end
						
					     end
					
				
		     LOAD:    if(st == enum_t::STOP) begin
						
						     case(op)									                           	
							  						
					             SET_WR: begin									 
						  									
												  buff[0] <= addr_dev;
												  buff[1] <= wr_addr;

												  buff[2] <= x - 0;
												  buff[3] <= x - 1;
												  buff[4] <= x - 2;
												  buff[5] <= x - 3;
												  buff[6] <= x - 4;
												  buff[7] <= x - 5;									 
												  buff[8] <= x - 6;
												  buff[9] <= x - 7;
												  buff[10] <= x - 8;
												  buff[11] <= x - 9;
												  buff[12] <= x - 10;
												  buff[13] <= x - 11;								 
												  buff[14] <= x - 12;
												  buff[15] <= x - 13;
												  buff[16] <= x - 14;
												  buff[17] <= x - 15;
												  
												  x <= (x - 8'h10);
												  
												  max <= 18;									 
												  i <= 0;
												  en <= enum_t::EN_WR;
												  state <= FREE;
												  op <= RD_ADDR;												  												  
						                   end
								  
					             RD_ADDR: begin

													buff[0] <= addr_dev;
													buff[1] <= rd_addr;
									 
													max <= 2;									 
													i <= 0;
													en <= enum_t::EN_WR;
													state <= FREE;						        																			 
													op <= SET_RD;
												 end
						
				                SET_RD:  begin
						  
													buff[0] <= addr_dev | 1'b1;
											  
													max <= 1;									 
													i <= 0;
													en <= enum_t::EN_RD;
													state <= FREE;						        																			 
												 end 
						
						          default: ;
						  						
						     endcase
						
					     end

			
			  RD_DATA: if(st == enum_t::Z) begin	
							  									    										 
							  buff_data[j] <= out_i2c;
							  ++j;										 
							  state <= WAIT; 	
			           end
						
			  
			  WAIT:    begin
			  
			             if(j == pg) begin
						  
							    en <= enum_t::EN_STOP;
							    j <= 0; 
							    state <= SHOW;						  
						    end
			             else if(st != enum_t::Z)			  
				                  state <= RD_DATA;					  	  
					     end		
							
							
			  SHOW:    begin
					
						    out_at24c04.mem[0] <= " ";
						    out_at24c04.mem[1] <= "A";
						    out_at24c04.mem[2] <= ".";
							 out_at24c04.mem[3] <= "0";
							 out_at24c04.mem[4] <= "x";									 
									 
							 out_at24c04.mem[8] <= " ";
							 out_at24c04.mem[9] <= "D";
							 out_at24c04.mem[10] <= ".";
							 out_at24c04.mem[11] <= "0";
							 out_at24c04.mem[12] <= "x";
							 out_at24c04.mem[13] <= "0";	

							 out_at24c04.mem[5] <= ((rd_addr & 9'h100) >> 8) + 8'h30;                               
	
						    if(((rd_addr & 8'hF0) >> 4) > 9)											
						         out_at24c04.mem[6] <= ((rd_addr & 8'hF0) >> 4) + 8'h37;
						    else out_at24c04.mem[6] <= ((rd_addr & 8'hF0) >> 4) + 8'h30;	

						    if((rd_addr & 8'h0F) > 9)											
						        out_at24c04.mem[7] <= (rd_addr & 8'h0F) + 8'h37;
						    else out_at24c04.mem[7] <= (rd_addr & 8'h0F) + 8'h30;	
									 
						    if(((buff_data[j] & 8'hF0) >> 4) > 9)											
						         out_at24c04.mem[14] <= ((buff_data[j] & 8'hF0) >> 4) + 8'h37;
						    else out_at24c04.mem[14] <= ((buff_data[j] & 8'hF0) >> 4) + 8'h30;	

						    if((buff_data[j] & 8'h0F) > 9)											
						        out_at24c04.mem[15] <= (buff_data[j] & 8'h0F) + 8'h37;
						    else out_at24c04.mem[15] <= (buff_data[j] & 8'h0F) + 8'h30;										 
						  
						    state <= DLY;
						  
				        end
						
						
			  DLY:     begin
		
						    if(count < 200000)
						       ++count;
							 else begin
						 
									  count <= 0;
								     ++j;
								     ++rd_addr;
								  
									  if(j == pg) begin
								    
									     j <= 0;
									     wr_addr <= wr_addr + pg;
								  
										  if(wr_addr & 9'h100)
											  addr_dev <= addr_dev | p0;
											  
										  else addr_dev <= addr_dev & (~p0);
									  
									     op <= SET_WR;
									     state <= LOAD;
								     end								  
								     else state <= SHOW;
						    end
						 
                    end
					  										
			  default: ;		
			
		endcase	

	end
	
endmodule: at24c04
