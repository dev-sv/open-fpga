


module queue #(parameter N = 8)(input bit clk, input logic[$clog2(N) - 1:0] pWR, input[7:0] in_data, 
                                output bit full, output bit [7:0] qcount, output logic[7:0] out_queue, 
										  input bit query);


logic[7:0]             buff[N];				 
logic[$clog2(N) - 1:0] pRD = (N - 1),
                       wr = 0,                       
                       prv = 1;
                       				 	
		
		always @(posedge clk) begin
			
				wr = (pWR + 1);
												
				if(wr == pRD)
					full <= 1;
									
//Put data in queue.		    				

				if(pWR != prv) begin
							   
				   buff[pWR] <= in_data;
					++qcount;
					prv <= pWR;
				end
											
											
// GET data of queue.						
				if(query) begin
				
					if(qcount) begin
							
				      --qcount;
						out_queue <= buff[++pRD];
						full <= 0;	
					end
				
				end
									
		end
		
endmodule: queue
