
/*
 clk  - clock.
 in   - input data.
 np   - number of points.
 sel  - select channel.
 ch[] - array of points. 

*/					
					
module channel(input bit clk, in, input bit[9:0] n, np,  output bit ch[960], input bit sel_ch);

									
enum {S0, S1, S2} st = S0; 

int      i = 0;
longint  level = 200000000;
longint  hi = 0,
         low = 0;
bit[9:0] max = 960;		  
					
		

	
	always_ff @(posedge clk) begin
	
	
		max = sel_ch ? np : max; 
	
		level = 200000000 >> n;		
				
		
      if(in) 
		   low <= 0;

		if(!in && low < level)			
		   low <= low + 1;	

      if(!in) 
		   hi <= 0;
			
		if(in && hi < level)			
		   hi <= hi + 1;
				

				
		unique case(st)	
	
// Sync.			
         S0: begin
			        
			      if(in)
					   st <= S1;
                					  
					if(low >= level) begin
												
   					i <= 0;
				      st <= S2;
					end
					
				 end
									
			
			S1: begin
			  
		 	      if(!in)
			         st <= S2;							
										
					if(hi >= level) begin
												
   					i <= 0;
				      st <= S2;
					end
					
				 end
					
			
			S2: begin				  
			         						  
				   if(i < max) begin
					  		                      							
					   ch[i] <= in;
		            i <= i + 1;	
		         end					  
				   else begin
					  						
							 i <= 0;
							 st <= S0;
               end               
			    end	
					
	  endcase 				
								
	end
	
	
endmodule: channel
