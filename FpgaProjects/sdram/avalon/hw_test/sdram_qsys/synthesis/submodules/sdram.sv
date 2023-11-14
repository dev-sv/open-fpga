


module sdram #(parameter 

						WRITE_RECOVERY_TIME= 2,
					
						PRECHARGE_COMMAND_PERIOD= 2,
					
						AUTO_REFRESH_PERIOD = 7,
					
						LOAD_MODE_REGISTER = 3,
					
						ACTIVE_READ_WRITE = 2,
					
						REFRESH_PERIOD = 6400000
				  )
				  

				(
				
				 input bit 			clk,
										reset,
// avalon_if.								
				 input bit			s_read,
				 input bit			s_write,
             input bit[21:0]  s_address,
				 input bit[15:0]  s_writedata,
			    input bit[8:0]   s_burstcount,
			    input bit[1:0]   s_byteenable,
			    output bit       s_waitrequest,
				 output bit	      s_readdatavalid,
				 output bit[15:0] s_readdata,

//sdram_if.
				 inout     [15:0] dq,
				 output bit[11:0] address,
				 output bit[1:0]  ba,
				 output bit[1:0]  dqm,
				 output wire		osc,
				 output wire		cs,
				 output wire		we,
				 output wire		ras,
				 output wire		cas

				 );
				 

`define WR 			0
`define RD 			1
`define EN_WR 		1
`define EN_RD 		0
`define PAGE  		256
`define MAX_ROWS 	4096


// commands.
enum bit[3:0]{ LMR, REFRESH, PRECHARGE, ACTIVE, WRITE, 
               READ, BURST_TERMINATE, NOP, INHIBIT } cmd = LMR;

// states.
enum { INI, CMD_PRECHARGE, CMD_REF_INI, CMD_LMR, CMD_ACTIVE, 
		 CMD_WRITE, WR, CMD_READ, RD, RD_WR, RD_END, CMD_AREF, S0, S1 } st = INI;

		 

int unsigned t_count = 0;				// time count.
int unsigned t_aref = 0;
int unsigned row_count = 0;
int unsigned count_auto_ref = 0;


/* Mode register. *****************/

bit[2:0] burst_length = 3'b000;
bit      bt = 1'b0;
bit[2:0] cas_latency = 3'b010;
bit[1:0] op_mode = 2'b00;
bit		wb = 1'b0;

/*********************************/


bit      op = `WR; 				      // RD or WR operation flag.
bit      sw = `EN_RD;					// switch dq bus to wr or rd.

bit       power_up = 1'b1;				// power up flag.
bit       new_burstcount = 1'b0;		// new burst_count flag.

bit[8:0]  i = 0;
bit[8:0]	 j = 0;
bit[8:0]  bc = 0;  					  	// burst count(1, 2, 4, 8, 256);

bit[21:0] buff_addr;
bit[15:0] buff_wr;
bit[15:0] wr_data[256];
 
 
	assign osc = clk;

	assign {cs, ras, cas, we} = cmd;

	assign dq = sw ? buff_wr : 16'hzzzz;

	

	
 	always @(posedge clk) begin


		if(!t_count) begin


			case(st)


				INI: 				begin


										dqm <= 2'b11;

										s_waitrequest <= 1'b1;
										
										s_readdatavalid<= 1'b0;	
// 100us after power-up.
										t_count <= 10000;
										
										st <= CMD_PRECHARGE;
									end


				CMD_PRECHARGE:	begin
									
										cmd <= PRECHARGE;
										
										t_count <= PRECHARGE_COMMAND_PERIOD;

										if(new_burstcount || power_up)begin
										
										
											power_up <= 1'b0;
											
											count_auto_ref <= 0;
																							
										   address[10] <= 1'b1;

											st <= CMD_REF_INI;
											
										end
										else begin
																																		
// go to check time refresh.																							
												if(t_aref >= REFRESH_PERIOD)
													st <= CMD_AREF;
											
												else st <= S0;												
										end
				
									end
					
					
				CMD_REF_INI:  begin
										
										if(count_auto_ref < 2)begin
										
										   count_auto_ref <= count_auto_ref + 1'b1;
											
											cmd <= REFRESH;
											
											t_count <= AUTO_REFRESH_PERIOD;
										end
										else st <= CMD_LMR;
										
									end
									
									
				CMD_LMR:			begin
										
										cmd <= LMR;
										address[2:0] <= burst_length;
										address[3] <= bt;
										address[6:4] <= cas_latency;
										address[8:7] <= op_mode;
										address[9] <= wb;
																	
										t_count <= LOAD_MODE_REGISTER;
										
										st <= new_burstcount ? CMD_ACTIVE : S0;	
										
									end
									
														
				CMD_ACTIVE: 	begin
				
										cmd <= ACTIVE;
// set bank.									
										ba <= buff_addr[21:20];
// set row.										
										address <= buff_addr[19:8];
							  										
										t_count <= ACTIVE_READ_WRITE;
							  							  
										st <= RD_WR;
									end 
									
	
				RD_WR:	 		begin
																				
										dqm <= 2'b00;
										
										address[10] <= 1'b0;
										
// set start column.								
										address[7:0] <= buff_addr[7:0];

										new_burstcount <= 1'b0;
										
										
										if(op == `WR)begin	
										
										
											cmd <= WRITE;
											
											sw <= `EN_WR;	
											
											buff_wr <=  wr_data[0];
											
											i <= 1'b1;		
																		 
											st <= WR;
										end
										else begin									
															
												cmd <= READ;
																																											 
												t_count <= cas_latency;
							 
												st <= RD;
										end
										
									end
									
									
						  
				WR:     			begin
																
										if(i < bc)begin
									  
											cmd <= NOP;								  
																		  
											buff_wr <=  wr_data[i];
																							
											i <= i + 1'b1;	
										end
										else begin
							  			
										      i <= 0;
												
												dqm <= 2'b11;
							  							  
												sw <= `EN_RD;
																																																																									
												t_count <= WRITE_RECOVERY_TIME;
												
												st <= CMD_PRECHARGE;	
										end
							  
									end	
						  

				RD: 				begin
								
									
										if(j <  bc) begin
														
											cmd <= NOP;
																						
											s_readdatavalid <= 1'b1;
											
											s_readdata <= dq;
																						
											j <= j + 1'b1;
											
										end
										else begin										
										
												j <= 0;
							
												dqm <= 2'b11;
												
												s_readdatavalid<= 1'b0;
												
												s_waitrequest <= 1'b1;
																				
												st <= CMD_PRECHARGE;	
										end
									end


				CMD_AREF:		begin

										if(row_count < `MAX_ROWS) begin

											row_count <= row_count + 1'b1;

											cmd <= REFRESH;
											
											t_count <= AUTO_REFRESH_PERIOD;
										end
										else begin

												row_count <= 0;

												t_aref <= 0;

												st <= S0;
										end	
										
									end

									
/******************************************************************************************************

 avalon_if.
 
*******************************************************************************************************/


				S0: begin
				
						ba <= 0;						
						
						if(s_write || s_read) begin
						
												
							buff_addr <= s_address;
														
						
							if(bc != s_burstcount) begin
											
								new_burstcount <= 1'b1;
								
								bc <= s_burstcount;
								
								
								case(s_burstcount)
								
								
									9'h001: burst_length <= 3'b000;								
					
									9'h002: burst_length <= 3'b001;
							
									9'h004: burst_length <= 3'b010;
										  	
									9'h008: burst_length <= 3'b011;
										 	
									9'h100: burst_length <= 3'b111;
											  
									default: bc <= 0;

								endcase
								
					
							end
												
						   st <= S1;
					
						end
						
					 end
					 
				 
				S1: if(bc) begin
				
				
						 s_waitrequest <= 1'b0;
						
						 if(s_read) begin
						 																														
							 op <= `RD;
						
							 st <= new_burstcount ? CMD_PRECHARGE : CMD_ACTIVE; 	  
							  			 
						 end
						 else begin
						 
						 
									if(s_write) begin
									
																  										
										if((buff_addr + i) == s_address) begin
									  											
											wr_data[i] <= s_writedata;	
																			
											i <= i + 1'b1;
										end
									  
									end
									else begin 
											 											 
											i <= 0;
						 						
											op <= `WR;
																																																				
											s_waitrequest <= 1'b1;
																				
											st <= new_burstcount ? CMD_PRECHARGE : CMD_ACTIVE;
									end
						 end
						
					 end
					 
	
				default: ;	
				
				endcase

		end
		else begin
		
				cmd <= NOP;
				
				t_count <= t_count - 1'b1;				
		end


// auto refresh period.
		
		if(!power_up)begin
		
			if(t_aref < REFRESH_PERIOD)
			   t_aref <= t_aref + 1'b1;
			
		end
		
		
	end //always		

			  
endmodule: sdram