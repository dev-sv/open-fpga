



module w25q32(input bit clk, spi_if.spi spi, output bit[7:0] mem_data, output bit[23:0] addr_data);

																				  
enum {SS0, SS1} st = SS1;

enum {WEL, STATUS, ERASE, WR, WR_EN, RD, RD_DATA} state = WR_EN;

enum bit[1:0] {MEM_ERASE, MEM_WR} op = MEM_ERASE;



const bit[31:0] LOCK_TRANS = 0;

// Status bits.
const bit[7:0] WEL_BIT = 8'h02,
               BUSY_BIT = 8'h01;
					
// commands.				
const bit[7:0]  CMD_WR_EN = 8'h06;
const bit[7:0]  CMD_STATUS = 8'h05;
const bit[31:0] CMD_READ = 32'h03000000;
const bit[31:0] CMD_ERASE_SECTOR = 32'h20000000;
const bit[39:0] CMD_WRITE = 40'h0200000000;	
					
int unsigned delay = 0;		

const int unsigned MAX = 256;


bit[31:0] nb_wr = 0,
          nb_rd = 0;
	  
bit[39:0] spi_data;
             
bit[23:0] addr_rd = 24'h000000,				
          addr_wr = 24'h000000;
				
bit[7:0]  val = 8'h5a,
          data = 8'h00,
			 out_data = 0;



	spi	#(.NByte(5)) spi_inst(.clk(clk),  ._if(spi), .in_data(spi_data), 
	
	                            .out_data(out_data), .nb_wr(nb_wr), .nb_rd(nb_rd), .mode(0));



														
		always @(posedge clk) begin


			case(st)
			
//Start transaction spi.						  
			
				SS1: if(spi.ss) begin
				
							
				unique case(state)
					
		
								WR_EN:  begin
							 
										    nb_wr <= 1;
										    nb_rd <= 0;
										    spi_data <= CMD_WR_EN;
										 
										    st <= SS0;
									     end		
										  
								
					         STATUS: begin
																																	
											 nb_wr <= 1;
											 nb_rd <= 1;
										    spi_data <= CMD_STATUS;
										  	
										    st <= SS0;	
		                          end
										  
										  
							   WEL:    begin
								
								          if(!(out_data & BUSY_BIT)) begin
											 
										 
										       if(out_data & WEL_BIT) begin
												 
													 state <= !op ? ERASE : WR;						
													 
												 end
											    else state <= WR_EN;												 
												 
											 end	 
											 else state <= STATUS;
											
										  end
											 																			
											
							   ERASE:  begin
															 
							 				 nb_wr <= 4;
										    nb_rd <= 0;
										    spi_data <= CMD_ERASE_SECTOR;
											  
											 op <= MEM_WR;
							             st <= SS0;
										  end											
											
							
								WR:     begin
								 				
								          if(addr_wr < MAX) begin
											  
											    nb_wr <= 5;
										       nb_rd <= 0;
				             		       spi_data <= (CMD_WRITE | (addr_wr << 8) | data);
												  
												 addr_wr <= addr_wr + 1'b1;
												 data <= data + 1'b1;
												  
												 op <= MEM_WR;
												 st <= SS0;
											 end	  
										    else state <= RD;
											  											  
										  end	 
											
							
								RD:     begin
								 
											 if(delay < 20000000) begin
										 
						                   ++delay;	 											 	 
										    end	 
										    else begin
											 											 										 										 
										           nb_wr <= 4;
												     nb_rd <= 1;
												     spi_data <= (CMD_READ | addr_rd);
														
													  addr_data <= addr_rd;
													  addr_rd <= addr_rd + 1'b1;
												     delay <= 0;
													  st <= SS0;
											 end	

										  end
											
											
							  RD_DATA: begin
								
											 mem_data <= out_data;
											
									       if(addr_rd == MAX) begin
											  
											    addr_rd <= 0;  
											    addr_wr <= 0; 
												 val <= ~val;
												 data <= val; 
												 state <= WR_EN;
												 op <= MEM_ERASE;
												  
											 end 	  
                                  else state <= RD;
										        
										  end   
																	  
						 endcase			  
				
				     end 
					  
			   
				SS0: if(!spi.ss) begin
				        
//Lock next transaction spi.						  
						  nb_wr <= LOCK_TRANS;
						  
						  st <= SS1;
				
						  case(state)				
						  
						  
								WR_EN:      state <= STATUS;
						  
						      STATUS:     state <= (op == MEM_ERASE || op == MEM_WR) ? WEL : state;
																
						      WR, ERASE:  state <= WR_EN;
						     								
								RD:         state <= RD_DATA;
								
								
								default: ;
						  						  
						  endcase
				
					  end	
			
			endcase
								
								
		end						
		
endmodule: w25q32
