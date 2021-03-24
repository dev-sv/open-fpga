
/*
 Hardware test.
*/

import pkg_ini::*;

module sdram_top(input bit osc, inout wire[15:0] dq, output bit[11:0] addr, output bit[1:0] bs, output bit clk,
                 cke, cs, ras, cas, we, output bit[1:0] dqm, output  bit[3:0] led);
					  
LMR   lmr;

state st_sdram;

F  u_F = pkg_ini::F_143MHz;

					  
enum {WR, WR_WAIT, RD, RD_WAIT, CMP, STOP} st = WR;

bit[1:0]    u_req = 0;					  
bit[21:0]   u_addr;
bit[15:0]   u_data[256],
            rd_buff[256];
bit[8:0]    nw = 256;					  
wire        w_c0;

// Test.
`define PageSize 256           
bit       pg = 0;
bit[8:0]  i = 0;
bit[3:0]  error = 0;
bit[21:0] va = 22'h000000;
bit[15:0] buff[2][256];



initial
begin

// load mode reg.
 lmr.rsv1 = 0;	
 lmr.oc = pkg_ini::BR;
 lmr.rsv0 = 0;	
 lmr.cl = pkg_ini::CL_2;
 lmr.bt = pkg_ini::SEQ;
 lmr.bl = pkg_ini::FP;


 for(int i = 0; i < `PageSize; ++i) begin

     buff[0][i] = ((~(i << 8) & 16'hff00) | i);	  
     buff[1][i] = ~((~(i << 8) & 16'hff00) | i);
	  	  
 end	  
  
end


	pll pll_inst(.inclk0(osc), .c0(w_c0));

						  
	sdram sdram_inst(.osc(w_c0), .u_F(u_F), .u_lmr(lmr), .u_req(u_req), .u_addr(u_addr), .u_data(u_data), .u_nw(nw), 
	                 .rd_buff(rd_buff),

						  .dq(dq), .addr(addr), .bs(bs),
				        .clk(clk), .cke(cke), .cs(cs), .ras(ras), .cas(cas), .we(we), .dqm(dqm), .st_sdram(st_sdram));//, .led(led));


	assign led = ~error;

	
	always @(posedge w_c0) begin

	
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
		             
		  
					        if(i < `PageSize) begin
					  
					           if(rd_buff[i] != u_data[i]) begin

							        error <= 4'b0001;
								  
							        st <= STOP;						  
						        end							  
							  
		                    i <= i + 1'b1;							  
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
		
endmodule: sdram_top





			/*		  
			 CMP:      if(st_sdram == ACTIVE)
			              error <= rd_buff[5] >> 12; */
			 