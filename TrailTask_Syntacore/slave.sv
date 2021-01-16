


import pkg_mst::t_mst;
import pkg_slv::t_slv;


module slave(input bit clk, input t_mst in_slv, output t_slv rd);


enum {REQ, WR, RD, RET} st = REQ;


bit[31:0] mem[16];

							
initial
begin

 rd.ack = 1'b0;
 
end

	
	always @(posedge clk) begin
			
		
		case(st)
		
		
			REQ: if(in_slv.req)
					  st <= WR;
					  
					  
			WR:  begin
		
					 if(in_slv.cmd) begin
					 
					    mem[in_slv.addr & 32'h7fffffff] <= in_slv.data; 					 
						 st <= RET;
					 end
				    else st <= RD;
						 					
					 rd.ack <= 1'b1; 						
				  end					  
				  
			RD:  begin			
			
				    if(!in_slv.cmd)			 
					    rd.data <= mem[in_slv.addr & 32'h7fffffff];			 
										 	 
					 st <= RET;
				  end
			
			RET: if(!in_slv.req) begin					 
												  
					  rd.ack <= 1'b0;										
					  st <= REQ;
				  end	  
				 
		   default: ;		 
				 
		endcase
			
	end

endmodule: slave