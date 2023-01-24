


module sdram(input bit clk,
                       reset,
								
				 input bit			s_read,
										s_write,
             input bit[22:0]  s_address,
				 input bit[15:0]  s_writedata,
			    input bit[8:0]   s_burstcount,
			    input bit[1:0]   s_byteenable,
			    output bit       s_waitrequest,
									   s_readdatavalid,
				 output bit[15:0] s_readdata,

//sdram_if.
				 inout     [15:0] dq,
				 output bit[11:0] address,
				 output bit[1:0]  ba,
				                  dqm,
				 output wire		osc,
										cs,
										we,
										ras,
										cas,

				 output bit[7:0]  led

				 );

`define WR 0
`define RD 1
`define EN_WR 1
`define EN_RD 0
`define PAGE  256
`define MAX_ROWS 4096

// commands.
enum bit[3:0]{ LMR, REFRESH, PRECHARGE, ACTIVE, WRITE, READ, BURST_TERMINATE, NOP, INHIBIT } cmd = LMR;

// states.
enum { INI, CMD_PRECHARGE, CMD_REF_INI, CMD_LMR, CMD_ACTIVE, CMD_WRITE, WR,
       CMD_READ, RD, RD_END, RD_WR, CMD_AREF, S0, S1, S2, S3, S4 } st = INI;

		 
// t_delays params.
localparam t_WR = 2; 				 	// t_WR = 20ns(15ns).
localparam t_RP = 2;	  				 	// t_RP = 20ns         precharge time.
localparam t_RFC = 7; 				 	// t_RFC = 70ns(66ns)  Auto refresh.
localparam t_MRD = 3;	   		 	// t_MRD = 30ns		  Delay after LMR.
localparam t_RCD = 2; 				 	// t_RCD = (20 / t_CK) ACTIVE READ or WRITE.
localparam t_REFRESH = 6400000;     // 64 ms.

int unsigned t_count = 0,				// time count.
				 t_aref = 0,
				 row_count = 0,
				 count_auto_ref = 0;		// auto_refresh count.

/* Mode register. *****************/

bit[2:0] burst_length = 3'b000;
bit      bt = 1'b0;
bit[2:0] cas_latency = 3'b010;
bit[1:0] op_mode = 2'b00;
bit		wb = 1'b0;

/*********************************/

bit      op = `WR, 				      // RD or WR operation flag.
         sw = `EN_RD;					// switch dq bus to wr or rd.

bit       power_up = 1'b1,				// power up flag.
          new_burstcount = 1'b0;		// new burst count flag.

bit[8:0]  bc,  					   	// burst count(1, 2, 4, 8, 256);
			 i = 0,
			 j = 0;

bit[1:0]  buff_ba;
bit[8:0]  buff_col;
bit[11:0] buff_row;			 

bit[15:0] buff_wr,
          rd_data[256],
          wr_data[256];

 
 
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

										t_count <= t_RP;

										if(new_burstcount || power_up)begin

											power_up <= 1'b0;
											count_auto_ref <= 0;
																							
										   address[10] <= 1'b1;

											st <= CMD_REF_INI;

										end
										else begin

												s_waitrequest <= 1'b1;
					
												ba <= buff_ba;
// go to check time refresh.											
												if(t_aref >= t_REFRESH)
													st <= CMD_AREF;
												
												else st <= S0;
										end
				
									end
					
					
				CMD_REF_INI:  begin
			
										if(count_auto_ref < 2)begin
										
										   count_auto_ref <= count_auto_ref + 1;
											cmd <= REFRESH;
											t_count <= t_RFC;
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
							
										t_count <= t_MRD;
										
										st <= new_burstcount ? CMD_ACTIVE : S0;	
									end
									
														
				CMD_ACTIVE: 	begin
				
										cmd <= ACTIVE;
// set bank.									
										ba <= buff_ba;
// set row.										
										address <= buff_row;
							  
										t_count <= t_RCD;
							  
										st <= RD_WR;
									end 
									
	
				RD_WR:	 		begin
																				
										dqm <= 2'b00;
										
										address[10] <= 1'b0;
										
// set start column.								
										address[8:0] <= buff_col;

										new_burstcount <= 1'b0;
										
										if(op == `WR)begin																						
										
											cmd <= WRITE;
											
											sw <= `EN_WR;	
											
											buff_wr <= wr_data[0];
											i <= 1;		
																		 
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
							  
											buff_wr <= wr_data[i];
											
											i <= i + 1'b1;
										end
										else begin
							  			
										      i <= 0;
												
												dqm <= 2'b11;
							  							  
												sw <= `EN_RD;
																																					
												t_count <= t_WR;

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
											
												st <= RD_END;
										end	
									end
									
								
				RD_END:			begin
								
										s_readdatavalid<= 1'b0;										
										st <= CMD_PRECHARGE;	
									end


				CMD_AREF:		begin

										if(row_count < `MAX_ROWS) begin

											row_count <= row_count + 1;

											cmd <= REFRESH;

										   t_count <= t_RFC;
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
						
						if(s_write || s_read) begin

							buff_ba <= s_address[22:21];
							buff_row <=  s_address[20:9];
							buff_col <=  s_address[8:0];
							   							
						
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
					
						   st <= S2;
					
						end
						
					 end
					 
	
				 
				S2: if(bc) begin
				
							
						 if(s_read) begin
						 															
							 s_waitrequest <= 1'b0;
															
							 op <= `RD;
						
							 st <= new_burstcount ? CMD_PRECHARGE : CMD_ACTIVE; 	  
							  			 
						 end
						 else if(s_write) begin
							  							  
						 		   s_waitrequest <= 1'b1;
								  
								   wr_data[i] <= s_writedata;
								  
								   i <= i + 1;
								  								  
							      st <= S3;
						 end
					 					 
					 end
				 

				S3: begin
			
						s_waitrequest <= 1'b0;
												
						if(!s_write)begin
														
							if(i < bc)
								st <= S2; 

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
				
				t_count <= t_count - 1;				
		end


// auto refresh period.
		
		if(!power_up)begin
		
			if(t_aref < t_REFRESH)
			   t_aref <= t_aref + 1;
			
		end
		
		
	end //always		

			  
endmodule: sdram