
/*
 Fclk = 143 MHz.
 T =    7ns. 
 Mode:  burst.
*/


package pkg_ini;

 typedef enum bit[0:0] {BR = 1'b0, SR = 1'b1}         enum_OC;
 typedef enum bit[2:0] {CL_2 = 3'b010, CL_3 = 3'b011} enum_CL;
 typedef enum bit[0:0] {SEQ = 1'b0, INR = 1'b1}       enum_BT;
 typedef enum bit[2:0] {BL_1 = 3'b000, BL_2 = 3'b001, BL_4 = 3'b010, BL_8 = 3'b011, FP = 3'b111} enum_BL;
 

 typedef struct packed {
 
   bit[1:0] rsv1;	
   enum_OC oc;
   bit[1:0] rsv0;	
   enum_CL cl;	
	enum_BT bt;
 	enum_BL bl;
 
 } LMR;
 
 typedef enum {ACTIVE, WR_CMD, RD_CMD, WR, RD, DELAY, RD_CL} state;
 
 typedef enum {F_50MHz = 50, F_75MHz = 75, F_143MHz = 143} F;

endpackage



import pkg_ini::*;
				 
module sdram(input bit osc, input F u_F, input LMR u_lmr, input bit[1:0] u_req, input bit[21:0] u_addr, 
             input bit[15:0] u_data[256], input bit[8:0] u_nw, output bit[15:0] rd_buff[256],
				 
				 inout logic[15:0] dq, output bit[11:0] addr, output bit[1:0] bs,
				 output bit clk, cke = 1'b0, cs, ras, cas, we, output bit[1:0] dqm = 2'b11, output state st_sdram);
		 


enum {S0, S1, S2, S3, S4, S5, S6, S7} st_tm = S0;

state st = pkg_ini::DELAY;				 
	
const bit[3:0] nop = 4'b0111,				 
					active = 4'b0011,				 
					read = 4'b0101,				 
					write = 4'b0100,				 
					//burst_term = 4'b0110, 
					precharge = 4'b0010,				 
					auto_refresh = 4'b0001,
					load_mode_rg = 4'b0000;
					
bit[3:0]  cmd = nop;		// command variable.

bit[8:0]  num,				// number of words to write or read.
          count_wr = 0,	// count write.
          count_rd = 0;	// count read.
bit[3:0]  count_cl = 0; // count cas latency.

bit[13:0] row = 0;		//[13:12] bank, [11:0] row.

bit sw_wr = 1'b1,       // switch data bus to write.
    sw_rd = 1'b0;			// switch data bus to read.

logic[15:0] wr_sdram,	// write data buffer.
            rd_sdram;   // read data buffer.
			 

// t_delays.
int t_RP;	  								// t_RP = 20ns        RAS precharge time.
int t_RFC; 									// t_RFC = 63ns		 Auto refresh period.
int t_MRD;	  								// t_MRD = (3 * t_CK) Delay after LMR (t_CK = 10ns).
int t_RCD; 									// t_RCD = 20			 ACTIVE-to-READ or WRITE delay.
    
// Initialization.
int unsigned count = 14300;   		// 100000 * F/1000 (F = 143) 14300  100us after power up.
int unsigned count_arf = 2;   		// 2 commands auto_refresh.

// Refresh.
int unsigned count_ref = 0;
int unsigned count_ref_row = 0;
longint      t_REF;		        		// t_REF = 64 ms    	  Refresh time.
int unsigned t_ROW_REF;	        		// t_ROW_REF = 15625 ns row refresh time.
const int unsigned Num_Rows = 4096;



initial
 cke = 1'b1;

	
	assign t_RP =  (u_F * 20)/1000 + 1;
	assign t_RFC = (u_F * 63)/1000 + 1;
	assign t_MRD = (u_F * 30)/1000 + 1;	
	assign t_RCD = (u_F * 20)/1000 + 1;	
	assign t_REF = (u_F * 64000000)/1000;	
	assign t_ROW_REF = (u_F * 15625)/1000;

	assign clk = osc;
	
	assign {cs, ras, cas, we} = cmd;
	
// data bus.
	assign rd_sdram = sw_rd ? dq : 16'hzzzz;
	
	assign dq = sw_wr ? 16'hzzzz : wr_sdram;
	
//	number words of burst.	
	assign num = (u_lmr.bl == pkg_ini::FP) ? ((u_nw > 9'h100) ? 9'h100 : u_nw) : (1 << u_lmr.bl);
	
		
		 
	always @(posedge osc) begin
		

		case(st)
		
							
		  ACTIVE:    begin
		  
							if(u_req == 2'b01 || u_req == 2'b10) begin
		  
							   cmd <= active;
							 
						      bs <= (!count_wr && !count_rd) ? u_addr[21:20] : row[13:12];							 
							   addr <= (!count_wr && !count_rd) ? u_addr[19:8] : row[11:0];
							
							   count <= t_RCD;
								
					         st <= DELAY;
								st_sdram <= DELAY;
							   st_tm <= S4;
						   end
						   else begin
// No WR nor RD for t_REF.						 
						          if(count_ref >= t_REF) begin
									 
										 count <= 1;
										 
										 st <= DELAY;
							          st_tm <= S5;										 
								    end					
			            end		
						 end
				
		  	     			
		  WR_CMD:    begin
		  
		               sw_wr <= 0;
						   dqm <= 2'b00;						  
						   cmd <= write;						  
							
  					      bs <= !count_wr ? u_addr[21:20] : row[13:12];							
							addr <= !count_wr ? u_addr[7:0] : 8'h00;
						   							
						   addr[10] <= 1'b0;
						  					  
						   wr_sdram <= u_data[count_wr];
						  
						   st_sdram <= WR; 							
						   st <= WR;
				       end	
					  
						
			WR:  	  begin						 
												
						 ++count_wr;
						 cmd <= nop;
						 
			          if(count_wr < num) begin						    						   
																					 							 
							 if(count_wr == (256 - addr[7:0])) begin
							 
							    row <= u_addr[19:8] + 12'h001;
								 
								 cmd <= precharge;
						       count <= t_RP;
								 
								 st <= DELAY;								 
								 st_sdram <= DELAY;							 
							    st_tm <= S5;								
							 end
							 else wr_sdram <= u_data[count_wr];
							 								 
						 end	 						 
			          else begin
						 
								  sw_wr <= 1;
					           dqm <= 2'b11;						 
								  count_wr <= 0;
								  row <= 0; 
								  
								  cmd <= precharge;
						        count <= t_RP;
								  
								  st <= DELAY;
								  st_sdram <= DELAY;
							     st_tm <= S5;
						 end		  
					  end 
					  					  
																
		   RD_CMD: begin
		 				 		  
		             cmd <= read;  
					    dqm <= 2'b00;
						 sw_rd <= 1;
						 
			          bs <= !count_rd ? u_addr[21:20] : row[13:12];
						 addr <= !count_rd ? u_addr[7:0] : 8'h00;						 
						 
					    addr[10] <= 1'b0;
						 
//					    count_cl <= (u_F == pkg_ini::F_143MHz) ? (u_lmr >> 4) : (u_lmr >> 4) - 1;
					    count_cl <= (u_F == F_143MHz) ? (u_lmr >> 4) : (u_lmr >> 4) - 1;
					    st <= pkg_ini::RD_CL;
					  end						

	
		   RD_CL:  begin
	
						 if(count_cl) begin
						 
						    cmd <= nop;
					       --count_cl;
						 end 	 
					    else begin
						 
						        st_sdram <= RD;
						        st <= RD;		
						 end 		  
						 
					  end
					  
					  
		  RD:    begin
		  
			        if(count_rd < num) begin
						 
						  cmd <= nop; 
						  
						  if(count_rd == (256 - addr[7:0])) begin
						  
							  row <= u_addr[19:8] + 12'h001;							  							  
							  cmd <= precharge;
						     count <= t_RP;
							  
							  st <= DELAY;
							  st_sdram <= DELAY;
							  st_tm <= S5;							  							  
						  end
						  else begin
						  							
					            rd_buff[count_rd] <= rd_sdram;
						         count_rd <= count_rd + 9'h001;									
						  end						  
					  end	
			        else begin
					  					  								
			               dqm <= 2'b11;
					         sw_rd <= 0;
								row <= 0;
								count_rd <= 0;
								
								cmd <= precharge;
						      count <= t_RP;
								
								st <= DELAY;
								st_sdram <= DELAY;
							   st_tm <= S5;
					  end
					  
					end  			      	
			
// t_TIME.
		  DELAY: begin
		         
					  --count;
					  cmd <= nop;
					  
					  if(!count) begin						 
					  
						  case(st_tm)
								
																   	
							 S0: begin
							 
							 		 cmd <= precharge; 
 							       count <= t_RP;														 
                            st_tm <= S1; 
									 
								  end	 
								  
										 								
							 S1: begin								  
								  
                            if(count_arf) begin
								   
									    --count_arf;
								  	    cmd <= auto_refresh;                       
						             count <= t_RFC;						 
                            end
									 
									 if(!count_arf)
									    st_tm <= S2; 								    
								  end
										
										
							 S2: begin
							
									 cmd <= load_mode_rg;
						          addr <= u_lmr;									 
		 						    count <= t_MRD;						 							     
									 st_tm <= S3;
								  end
								  
								  
							 S3: begin
							 
									 st_sdram <= ACTIVE;	 
							       st <= ACTIVE;							 								  
								  end
								  
								 
							 S4: begin
							 
							       if(u_req == 2'b01) begin
									  
									    st <= WR_CMD;
										 st_sdram <= WR_CMD;
									 end
									 else begin
									   
									        st <= RD_CMD;
										     st_sdram <= RD_CMD;
									 end
							     end								  
							 							 							
						    S5: begin								 
// Precharge before refresh.
		                      
							       if(count_ref >= t_REF) begin
									 					
									    count <= t_RP;
										 addr[10] <= 1'b1;  
										 cmd <= precharge;
										 st_tm <= S6;
									 end	
							       else begin
									 						
							              if(u_req == 2'b00) begin
											  
										        st_sdram <= ACTIVE;
									           st <= ACTIVE;
											  end	  
									 end	  
					           end				 
								  
// Refresh.				  		 
                      S6: begin 
							 
									 if(count_ref_row < Num_Rows) begin
									 
										 count <= t_ROW_REF;
										 count_ref_row <= count_ref_row + 1;
										 cmd <= auto_refresh;
									 end	
									 else begin
											  
											  count_ref_row <= 0;
											  count_ref <= 0;											  
											  
											  st_sdram <= ACTIVE;
											  st <= ACTIVE;
									 end
								  end
								  
								                            								
							 default: ;
							 
						  endcase								  
						  
					  end		
					  
					end
		   						
				
		  default: ;	
		
		endcase
	
	
// Refresh memory period.	
		if(count_ref < t_REF)
		   count_ref <= count_ref + 1;
			
	end


endmodule: sdram
