
/*
 Testbench sdram.
*/


`timescale 1 ps / 1 ps

import pkg_ini::*;



module tb_sdram;


state st_sdram;

F u_F = pkg_ini::F_143MHz;

enum {WR, WR_WAIT, RD, RD_WAIT, CMP, DELAY, STOP, NONE} st = WR;

bit         osc = 0; 

// user.
LMR         u_lmr;
bit[1:0]    u_req = 0;					  
bit[8:0]    u_nw = 256;					  
bit[21:0]   u_addr;
bit[15:0]   u_data[256];
bit[15:0]   rd_buff[256];

// chip.
logic[15:0] dq; 
bit[11:0]   addr; 
bit[1:0]    bs;
bit[1:0]    dqm;
bit         cke, cs, 
            ras, cas, we;


`define PageSize 256           
bit       pg = 0;
bit[8:0]  i = 0, BL = 0;
bit[21:0] va = 22'h000000;
bit[15:0] buff[2][256];

wire       w_clk, 
           w_cke,
           w_cs, 
			  w_ras, 
			  w_cas, 
			  w_we;
			  
wire[11:0] w_addr; 
wire[15:0] w_dq; 
wire[1:0]  w_dqm, 
           w_bs; 

			  
initial
begin

// load mode reg.
 u_lmr.rsv1 = 0;	
 u_lmr.oc = pkg_ini::BR;
 u_lmr.rsv0 = 0;	
 u_lmr.cl = pkg_ini::CL_2;
 u_lmr.bt = pkg_ini::SEQ;
 u_lmr.bl = pkg_ini::FP;
 
 BL = (u_lmr.bl == pkg_ini::FP) ? `PageSize : (1 << u_lmr.bl);
 
 
 for(int i = 0; i < 256; ++i) begin
  
     buff[0][i] = ((~(i << 8) & 16'hff00) | i);	  
     buff[1][i] = ~((~(i << 8) & 16'hff00) | i);
 end
 
/* 
 Fclk = 143 MHz.
 Tclk = 7ns. 
*/ 
$display("\nTestbench sdram.\n");

 forever
   #3.5 osc = ~osc;

end

	
   HY57V641620FTP_7 HY57V641620FTP_7_inst(.clk(w_clk), .cke(w_cke), .bs(w_bs), .addr(w_addr), .dq(w_dq),
                                       	.dqm(w_dqm), .cs(w_cs), .ras(w_ras), .cas(w_cas), .we(w_we));
							 
						 	 
	sdram sdram_dut(.osc(osc), .u_F(u_F), .u_lmr(u_lmr), .u_req(u_req), .u_addr(u_addr), .u_data(u_data), .u_nw(u_nw), .rd_buff(rd_buff), 
	                .dq(w_dq), .addr(w_addr), .bs(w_bs), .clk(w_clk), .cke(w_cke), .cs(w_cs), 
						 .ras(w_ras), .cas(w_cas), .we(w_we), .dqm(w_dqm),.st_sdram(st_sdram));
						 

						 
						 
	always @(posedge osc) begin

	
	   	case(st)
		
	
		     WR:      if(st_sdram == ACTIVE) begin
    
						     u_req <= 2'b01;
					        u_addr <= va;
					        u_data <= buff[pg];
						  
					        st <= WR_WAIT;			  
						  end 
					  

	        WR_WAIT: if(st_sdram == WR_CMD) begin
		  
							  u_req <= 2'b00;
							  
					        st <= RD;
                    end  
					  
                
		     RD:      if(st_sdram == ACTIVE) begin
		  
		                 i <= 0;
		                 u_req <= 2'b10;	
					        u_addr <= va;
						  
					        st <= RD_WAIT;					 
				        end
					  
		 			 
	        RD_WAIT: if(st_sdram == RD_CMD) begin
		  		  
		                 u_req <= 2'b00;
							  
					        st <= CMP;
                    end  
					  
					 
		     CMP:     if(st_sdram == ACTIVE)begin
		             						     		  
					        if(i < BL) begin
					  
					           if(rd_buff[i] != u_data[i]) begin

								     $display("rd_buff = %h u_data = %h addr = %h error.", rd_buff[i], u_data[i], va + i);
							        //st <= STOP;						  
						        end							  
							  	  else $display("rd_buff = %h u_data = %h addr = %h pass.", rd_buff[i], u_data[i], va + i);

		                    i <= i + 1;							  
					        end
				           else begin
														
 					               i <= 0;
								      pg <= ~pg;
								      va <= va + `PageSize;
							         st <= WR;		
					        end
							  
		              end 
					     
		     default: ;			  
					 
		endcase			 
						
  end
						 
				
endmodule: tb_sdram
