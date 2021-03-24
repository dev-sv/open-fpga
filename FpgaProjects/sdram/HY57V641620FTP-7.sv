

/*
 HY57V641620FTP-7 
 Fclk = 143 MHz.
 Tclk = 7ns. 
 
 no interleave.
 no auto_precharge.
*/



module HY57V641620FTP_7(input bit clk, cke, input bit[1:0] bs, input bit[11:0] addr, inout logic [15:0] dq, 
                        input bit[1:0] dqm, input bit cs, ras, cas, we);

// commands.				  
const bit[3:0] nop = 4'b0111,				 
					active = 4'b0011,				 
					read = 4'b0101,				 
					write = 4'b0100,				 
					precharge = 4'b0010,				 
					auto_refresh = 4'b0001,
					load_mode_rg = 4'b0000;

// delay times.					
const int unsigned t_RP = 2;
const int unsigned t_RFC = 8;
const int unsigned t_RCD = 3;
const int unsigned t_MRD = 5;

// refresh times.
const int unsigned F = 143;							   // Fclk = 143 MHz.
const longint      t_REF = (F * 64000000)/1000;		// 64ms refresh time.
const int unsigned t_ROW_REF = (F * 15625)/1000;   // row refresh time.
const int unsigned t_PWR_UP = 14300;               // >= 100us after power up.
const int unsigned Num_Rows = 4096;						// num rows.

					
int unsigned count_power_up = 0,
             count_active = 0,		
             count_precharge = 0,	
				 count_load_mode_rg = 0,
				 count_row = 0,
             count_ref = 0, 
             count_auto_refresh = 0; 
				 
int 		 i = 0;
bit       _clk, 
          ini = 1'b1;					// init flag.
				 				 
bit[3:0]  cmd;								// command.
bit[1:0]  cl = 0,							// cas latency.
          count_cl = 0;          	// count cas latency.
bit[8:0]  bl = 0;                	// burst length.  
bit       bt = 0;                	// burst type.
bit       oc = 0;                	// operating code.
bit[11:0] n_row;               		// number of row.
bit[15:0] mem[4][4096][256];     	// memory array.
bit[15:0] wr_buff, 						// buffers.
          rd_buff;               	//
bit[4095:0] row[4] = '{1, 1, 1, 1};	// active or deactive of row.



	assign _clk = cke ? clk : 1'b0;
	
//	command decoder.				 					 
   assign cmd = ( ({cs, ras, cas, we} == write) ? write : ({cs, ras, cas, we} == read) ? read : 
	               ({cs, ras, cas, we} == load_mode_rg) ? load_mode_rg : ({cs, ras, cas, we} == active) ? active : 
					   ({cs, ras, cas, we} == precharge) ? precharge : 
					   ({cs, ras, cas, we} == auto_refresh) ? auto_refresh : cmd );
					 
// data bus.
	assign wr_buff = (!dqm && cmd == write) ? dq : wr_buff; 
	
	assign dq = (!dqm && cmd == read) ? rd_buff : 16'hzzzz; 


	
	
	always @(posedge _clk) begin

	
// wait >= 100us after power up.			
		if((count_power_up < t_PWR_UP) && ini) begin
		
		    if({cs, ras, cas, we} == nop)
		       count_power_up <= count_power_up + 1;	
				 
			 else count_power_up <= 0;
	   end
		
// refresh memory period 64ms.		
		if(count_ref <= t_REF)
		   count_ref <= count_ref + 1;
			
	
	
		case(cmd)
		
				
		  load_mode_rg: if(count_auto_refresh >= (t_RFC << 1)) begin
		  															
								 if({cs, ras, cas, we} == nop)
								    ++count_load_mode_rg;
									 									  
								 if(count_load_mode_rg >= t_MRD) begin
								 								 								 
									 ini <= 1'b0;  
									 cl <= (addr[6:4] == 2 || addr[6:4] == 3) ? (addr >> 4) : 0;
									 bt <= (addr >> 3);
									 oc <= (addr >> 9);
									 bl <= (addr[2:0] == 3'b111) ? 256 : (addr[2:0] < 3'b100 ? (1 << addr[2:0]) : 0);
									 count_auto_refresh <= 0;				 
								 end
		                end
					  
 					  
		  auto_refresh: if(count_precharge >= t_RP) begin
		  		  															

  								 if({cs, ras, cas, we} == nop)
									 ++count_auto_refresh;
									 
									
		                   if(!ini) begin
								 
								    if(!row[0] && !row[1] && !row[2] && !row[3]) begin
// refresh count_ref.									 
								       count_ref <= 0;
								 
								       if(count_auto_refresh >= t_ROW_REF) begin
										    									 
										    count_auto_refresh <= 0;
										 
										    ++count_row;
														
								          if(count_row == Num_Rows)										 
											    count_row <= 0;
										    	 
									    end
									 end
								 end
								 else if(count_auto_refresh >= (t_RFC << 1))
								         count_precharge <= 0;			
							 end
					  
					  
		  precharge:    if(count_power_up >= t_PWR_UP) begin
						
						
							    count_active <= 0;
						
								 if(count_precharge < t_RP) begin
								 
							       if({cs, ras, cas, we} == nop)
								       ++count_precharge;
								 end
								 else begin
								 								 
       						        if(ini) begin
										  
									        row[0] <= 0;
											  row[1] <= 0;
										     row[2] <= 0;
									        row[3] <= 0;
										  end
								        else begin
										 
								               if(addr[10]) begin
																										
														row[0] <= 0;
														row[1] <= 0;
														row[2] <= 0;
														row[3] <= 0;
														count_auto_refresh <= 0;
														count_precharge <= 0;
														
														$display("Refresh memory..................................");
                                       end													  
									            else row[bs][addr[11:0]] <= 1'b0;
									     end		  
								 end								 
						
						    end
					  
					  
		  active: 	    if((count_precharge >= t_RP || count_load_mode_rg >= t_MRD) && !ini) begin
		  
		  														
							    if({cs, ras, cas, we} == nop)
								    ++count_active;										 
								
								 if(count_active >= t_RCD) begin 	 
									 
									 i <= 0;
								    count_cl <= 0; 
								    n_row <= addr[11:0];
								    row[bs][addr[11:0]] <= 1'b1;
								    count_load_mode_rg <= 0;
								    count_precharge <= 0;
								 end
						    end

					
		  write:        if(count_active >= t_RCD && !ini) begin
		              
		                   if( (cmd == write || {cs, ras, cas, we} == nop) && (row[bs] & (1 << n_row)) ) begin
						
								    if(i < bl) begin
									 
// damage memory, if count_ref > t_REF.			
									    mem[bs][n_row][i] <= (count_ref > t_REF) ? 16'h5a5a : wr_buff;
//									    mem[bs][n_row][i] <= wr_buff;
									    i <= i + 1;										 
								    end	
							    end	
						    end	 
					  
					  
		  read: 	       if(count_active >= t_RCD && !ini) begin
		  		  		  
		                   if( (cmd == read || {cs, ras, cas, we} == nop) && (row[bs] & (1 << n_row)) ) begin

								    if(count_cl < cl)
									    count_cl <= count_cl + 1; 
										 
								    else begin
									
										     if(i < bl) begin
		
											     rd_buff <= mem[bs][n_row][i]; 
											     i <= i + 1;
				   	                 end
						          end 
							    end	
						    end	 
							 
 		
		  default: ;		
		
		endcase
				
	end

endmodule: HY57V641620FTP_7