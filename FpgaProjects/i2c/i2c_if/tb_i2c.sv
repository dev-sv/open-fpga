

`timescale 10 ns / 1 ps


module tb_i2c;

 
 
 enum { S0, S1, S2 } s = S0;
 
 enum { START, WR, LOW, Z, STOP, RD, HI, M_ACK, CMP } st = START;
 
 
 bit sw = 	 1'b0;  	// switch bus sda.
 bit sda =   1'b0; 	// sda var.
 bit clk =   1'b0; 	// clk  200 kHz.
 bit sclk =  1'b0; 	// sclk 100 kHz.
 bit s_fl =  1'b1;	// start flag.
 bit s_clk = 1'b0;	// slave clk. 
 bit start = 1'b0;	// start var.

 wire w_sda; 
 wire w_sclk;
 
 wire[1:0] w_rw;
 wire[7:0] w_wr_data;
 wire[7:0] w_rd_data;
 wire 	  w_wr_ready;
 wire 	  w_rd_ready;
 
 bit[7:0] rd_data;
 bit[7:0] dev_addr = 8'hd0;
 bit[7:0] ram_addr = 8'h00;
 
 string str;
 
 
 initial
 
	forever #250 clk = ~ clk;
  

 initial
 
	forever #125 s_clk = ~ s_clk;
 
 

 assign w_sda = sw ? sda : 1'bz;
 
 
 

 i2c i2c_dut(
					.clk(clk), 
										
					.rw(w_rw),
					
					.wr_data(w_wr_data), 
				
					.sda(w_sda), 
					
					.sclk(w_sclk),
					
					.rd_data(w_rd_data),
					
					.wr_ready(w_wr_ready),
					
					.rd_ready(w_rd_ready)					
 );

 

/* 
 
 Nb number bytes to write/read.
 
 max Nb = 64.
 
*/

 `define Nb	1
 
 stimulus #(.Nb(`Nb)) stimulus_inst (
 
	
					 .clk(clk),
					 					 
					 .sclk(w_sclk),
					 
					 .sda(w_sda),
					 								
					 .dev_addr(dev_addr),
					 
					 .addr(ram_addr),
								
					 .wr_ready(w_wr_ready),
					 
					 .rd_ready(w_rd_ready),
					 					 
					 .wr_data(w_wr_data),
					 					 					 
 					 .rw(w_rw)
					 
 );

  
/* 

 Slave. 
 
 ram memory 64 bytes.
 ram range addr 8'h00 - 8'h3F.
 
*/

// start.
 always @(negedge w_sda) begin
 
 
  if(s_fl) begin
	
	  if(w_sclk)		
		  start <= 1'b1;
  end
 
 end



 always @(posedge s_clk) begin: slave

 
 `define Size 64
 
 static bit[3:0] wr_nb = 8;
 static bit[3:0] rd_nb = 8;
 static int unsigned i = 0;
 
 bit      cmd; 
 bit[7:0] addr;
 bit[7:0] wr_buff;
 bit[7:0] ram[`Size + 2];
 bit[7:0] rd_buff[`Size + 2];

  
 
 
	case(st)
		
		
	   START: if(start)begin
								
					 start <= 1'b0;
					
					 s_fl <= 1'b0;
								
					 st <= WR;
				 end
		
		
// WRITE (recieve data).		
		WR: 	 begin
				
				  if(w_sclk)begin
		
				     if(wr_nb) begin
				
				        wr_buff[wr_nb - 1] <= w_sda;
					
					     wr_nb <= wr_nb - 1;
						  
						  st <= LOW;
				     end
				     else begin
								
								wr_nb <= 8;															 
// set ack to master.							 
																	
								sw <= 1'b1;
				 
								sda <= 1'b0;
								
								st <= Z;
								
								
								case(s)
							 
// get command wr/rd.							 
									S0: begin
																
											cmd <= wr_buff;
										
											s <= S1;
										 end
// get address.
																																
									S1: begin
																									
											addr <= wr_buff;
																				
											if(!cmd)										
												s <= S2;
										 end	
// write into ram.								      
							 
									S2: begin
											
			
											if(addr < `Size) begin
											
												ram[addr] <= wr_buff;											
																						
												addr <= addr + 1'b1;
											end
											
										 end	
										 
																		
									default: ;
							 
							 endcase
							 
				    end
				  
				  end
		
			    end
			 
			
			
		LOW:   if(!w_sclk)		
					 st <= WR;		
					 
				
// set sda to z.			 
		Z:     begin
						
					sw <= 1'b0;		
								
					st <= STOP;
				
				end
				
			 
		STOP: begin
			
					if(w_sclk && w_sda) begin
										
						s_fl <= 1'b1;
														
						s <= S0;
					
						st <= START;
					end
					else begin
						
							if(!cmd)
							   st <= WR;	
								
							else begin
												
									sw <= 1'b1;
																	
									st <= RD; 	
							end		
					end
					
				 end

			
// READ (send data to master).				
			 
		RD:    if(!w_sclk) begin
			 			 
				
					 if(rd_nb) begin
				 				
						 sda <= ram[addr][rd_nb - 1];
										
						 rd_nb <= rd_nb - 1'b1;		
				
					    st <= HI;					  
					  
				    end
				    else begin
														
								rd_nb <= 8;
// set sda to z.				
								sw <= 1'b0;
							
								st <= M_ACK;
				    end
			    end	
		
		
			
		HI:    if(w_sclk)				
				   st <= RD;	

			 
// ack from master.		  
		M_ACK: begin
		
		
					rd_buff[addr] <= w_rd_data;
								
					addr <= addr + 1'b1;
				
					if(w_sda == 1'b0) begin
												
						sw <= 1'b1;
						
						st <= RD;
						
					end 
					else begin
										 
							if(addr >= (`Size - 1)) begin
							  
								i <= ram_addr;
							  
							   st <= CMP;
							end
						   else st <= STOP;							
					end
					
				 end
				 
	

		CMP:   begin
						
					if(i < `Size) begin
			
						if(ram[i] != rd_buff[i])
							str = "error";	
							
						else str = "pass";
						
						$display("addr = %d wr = %h rd = %h %s", i, ram[i], rd_buff[i], str);
				
						i <= i + 1;
					end
					
				end
	
			
		default: ;
		 
	endcase
		

end	
	
	
endmodule: tb_i2c
