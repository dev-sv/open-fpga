

import pkg_mst::t_mst;
import pkg_slv::t_slv;
import pkg_st::t_st;


module master(input bit clk, input t_mst in_mst, input t_slv rd, input bit mx0, output bit[31:0] buff[8], 
              output t_mst out_mst, output t_st st = pkg_st::ADDR, input bit en);

bit[2:0] i = 0;

initial
begin
 out_mst.req = 1'b0;	
 
end


   always @(posedge clk) begin
		
	
		case(st)
		
		
		   pkg_st::ADDR: if(en) begin
			
								  out_mst.addr <= in_mst.addr;
								  out_mst.data <= in_mst.data;
					           out_mst.cmd <= in_mst.cmd;
							  st <= pkg_st::CMD; 
							  end
				  

			pkg_st::CMD:  if(mx0)begin			
			
								  out_mst.req <= 1'b1;
					           st <= pkg_st::ACK;                 					 					 
							  end
				  

			pkg_st::ACK:  if(rd.ack) begin
					 
					           out_mst.req <= 1'b0;
					           st <= pkg_st::RD;					 
				           end
				  
				     
			pkg_st::RD:   begin
			
					          if(!in_mst.cmd) begin
					  
					             buff[i] <= rd.data;						  
						          i <= i + 1;
					          end					  
					  
					          st <= pkg_st::ADDR;
				           end 
			
		   default: ;	
				  
		endcase
		
	end
	
endmodule: master
