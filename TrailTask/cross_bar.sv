

import pkg_mst::t_mst;
import pkg_slv::t_slv;
import pkg_st::t_st;


module cross_bar(input bit clk, input t_mst mst_to_cross[2], output t_mst cross_to_slv[2], 
                 input t_slv rd_to_cross[2], output t_slv rd_to_mst[2], output bit mx0, mx1, input t_st st0, st1);
					  

enum {s0, s1} s = s0;
	 
initial
begin

mx0 = 0;
mx1 = 0;

end	 
	 
			
	always @(posedge clk) begin
	
// select slave 01, 10.
	
		if(mst_to_cross[0].addr[31] != mst_to_cross[1].addr[31]) begin
	 	
		   mx0 <= 1;
		   mx1 <= 1;
		 
			cross_to_slv[mst_to_cross[0].addr[31]] <= mst_to_cross[0]; 
			cross_to_slv[mst_to_cross[1].addr[31]] <= mst_to_cross[1]; 
						
			rd_to_mst[mst_to_cross[0].addr[31]] <= rd_to_cross[0];
			rd_to_mst[mst_to_cross[1].addr[31]] <= rd_to_cross[1];
			
		end
	   else begin		

// select slave 00, 11.

				case(s)
				
				  s0: if(st0 == pkg_st::CMD) begin
				
							mx0 <= 1;
							mx1 <= 0;
			            s <= s1;							            				
				      end	
						
						
				  s1: if(st0 == pkg_st::ADDR) begin				  
				  
							mx0 <= 0;
							mx1 <= 1;							
			            s <= s0;
			 	      end 
						
				  default: ;		
						
			   endcase				
							
			   cross_to_slv[mst_to_cross[0].addr[31]] <= mst_to_cross[~mx0];
			   rd_to_mst[~mx0] <= rd_to_cross[mst_to_cross[0].addr[31]];				
		end
				
	end

endmodule: cross_bar
