

`timescale 1ps / 1ps

import pkg_mst::t_mst;
import pkg_slv::t_slv;
import pkg_st::t_st;


module tb_cross_bar;

`include "tb.h"


`define WR 1
`define RD 0

bit clk = 0,
    w_mx0, 					// mux master to slave.
    w_mx1;              //

bit[31:0] buff0[8],	   // read buffer for master 0.
			 buff1[8];	   // read buffer for master 1.
  
t_mst	in_mst[2],			// input data master.
      out_mst[2],       // output data master -> cross_bar.
		slv[2];           // cross_bar -> slave.
		 
t_slv	rd_slv[2],        // read data slave -> cross_bar.
      mst_rd[2];        // read data cross_bar -> master.
	
t_st st0, st1;          // states of master. 

/****************************  
 test data.
****************************/  

enum {SS0, SS1, SS2, SS3, SS4, SS5, SS6} st = SS0;

bit[4:0]  i = 0;

bit       op = `WR, 
          en0 = 0, 
          en1 = 0;
  	 
bit[31:0] a0 = 32'h00000000,
          a1 = 32'h00000000,
			 
			 d[16] = '{32'h00000011, 32'h00000012, 32'h00000013, 32'h00000014,
			           32'h00000015, 32'h00000016, 32'h00000017, 32'h00000018, 						  
			           32'h00000019, 32'h0000001a, 32'h0000001b, 32'h0000001c,
			           32'h0000001d, 32'h0000001e, 32'h0000001f, 32'h00000020}, 
							 
			 dd[2][8] = '{'{32'h00000051, 32'h00000052, 32'h00000053, 32'h00000054,
			                32'h00000055, 32'h00000056, 32'h00000057, 32'h00000058}, 
						  
			              '{32'h000000a1, 32'h000000a2, 32'h000000a3, 32'h000000a4,
			                32'h000000a5, 32'h000000a6, 32'h000000a7, 32'h000000a8}}; 					  
initial
begin

 $display("\nTestbench Cross_Bar.\n");
  
 forever
	#10 clk = ~clk;

end
	  
	
	master master_0(.clk(clk), .in_mst(in_mst[0]), .rd(mst_rd[0]), .mx0(w_mx0), .buff(buff0), .out_mst(out_mst[0]), .st(st0), .en(en0));	
	master master_1(.clk(clk), .in_mst(in_mst[1]), .rd(mst_rd[1]), .mx0(w_mx1), .buff(buff1), .out_mst(out_mst[1]), .st(st1), .en(en1));
	
	cross_bar cross_bar_dut(.clk(clk), .mst_to_cross(out_mst), .cross_to_mst(slv), .rd_to_cross(rd_slv), .rd_to_mst(mst_rd), .mx0(w_mx0), .mx1(w_mx1), .st0(st0), .st1(st1));
	
	slave slave_0(.clk(clk), .in_slv(slv[0]), .rd(rd_slv[0]));
	slave slave_1(.clk(clk), .in_slv(slv[1]), .rd(rd_slv[1]));

		
   always @(posedge clk) begin
	
		
		case({a0[31], a1[31]})
		
		 
			2'b00, 
			2'b11: case(st)
													
					      SS0: if(st0 == pkg_st::ADDR || st1 == pkg_st::ADDR) begin	

									  if(i < 16) begin
									
										  en0 <= 1;
										  in_mst[0].cmd <= op; 
										  in_mst[0].addr <= (a0 + i);
										  in_mst[0].data <= d[i];
																						   
										  en1 <= 1;
										  in_mst[1].cmd <= op; 
										  in_mst[1].addr <= (a1 + i + 1);
										  in_mst[1].data <= d[i + 1];
											  
										  i <= i + 2;																									
										  st <= SS1;
									  end											
									  else begin
													
												i <= 0;												   		
												en0 <= 0;
												en1 <= 0;
													
												if(op == `WR) begin
													
													op <= `RD;
													st <= SS0;
												end
												else st <= SS6;
									  end											
								  end
									 										

							SS1: if(st0 != pkg_st::ADDR) begin
							
							        en0 <= 0;
									  st <= SS2;
							     end		  
									  
							SS2: if(st0 == pkg_st::ADDR)
									  st <= SS3;									  									  

							SS3: if(st1 != pkg_st::ADDR) begin
							
							        en1 <= 0;
									  st <= SS4;
								  end	  

							SS4: if(st1 == pkg_st::ADDR)
								     st <= SS0;
									  
														
							SS6: begin								 											
									   									  
									  $display("\nMaster[0] -> Slave[%b]", a0[31]);
									  $display("Master[1] -> Slave[%b]\n", a0[31]);
									
									  for(int i = 0; i < 8; ++i) begin
									  
									      `COMP(d[i + i], buff0[i], EQ);											
									      `COMP(d[i + i + 1], buff1[i], EQ);
									  end
																				
									  ++{a0[31], a1[31]};										 										 
									  op <= `WR;
 									  st <= SS0;												 
								  end																		    			
						   default: ;
							  
					 endcase
					 			
		   2'b01, 
			2'b10: case(st)
													
					      SS0: if(st0 == pkg_st::ADDR && st1 == pkg_st::ADDR) begin	
								 
									  if(i < 8) begin
									
									     en0 <= 1;
									     in_mst[0].cmd <= op; 
										  in_mst[0].addr <= (a0 + i);
										  in_mst[0].data <= dd[0][i];
										
									     en1 <= 1;
										  in_mst[1].cmd <= op; 
										  in_mst[1].addr <= (a1 + i);
										  in_mst[1].data <= dd[1][i];
										
									     i <= i + 1;	
										  st <= SS1;
									  end
									  else begin
									
												i <= 0;
												en0 <= 0;
												en1 <= 0;
											
												if(op == `WR) begin
																										
													op <= `RD;
													st <= SS0;
												end
												else st <= SS2;																						
										end																												
								  end							 
																
								
							SS1: if(st0 != pkg_st::ADDR && st1 != pkg_st::ADDR) begin
																
									  en0 <= 0;
									  en1 <= 0;
									  st <= SS0;										  
								  end
									  
					
							SS2: if(st0 == pkg_st::ADDR && st1 == pkg_st::ADDR) begin	
																	
									  $display("\nMaster[0] -> Slave[%b]", a0[31]);		
									  $display("Master[1] -> Slave[%b]\n", a1[31]);		
									  
									  for(int i = 0; i < 8; ++i) begin
									  
									      `COMP(dd[0][i], buff0[i], EQ);											
									      `COMP(dd[1][i], buff1[i], EQ);
									  end									  
																				 									 
	 								  ++{a0[31], a1[31]};										  
									  op <= `WR;
 									  st <= SS0;													 
								   end	  
										 									  
							default: ;
					
					 endcase
												
				default: ;		
		  endcase
		
	end
	
	
endmodule: tb_cross_bar
