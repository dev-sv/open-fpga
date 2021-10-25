


module encoder(input bit clk, en, ls_if.e_in e, input pkg_encoder::e_param p, output bit[9:0] data);


enum {INI, E_0, E_1} st = INI;


	always_ff @(posedge clk) begin
 

		if(en) begin
 
			unique case(st)
 
 
				INI: if(e.clk && e.dt) begin
				
						  data <= p.ini;
						  st <= E_0;
					  end
		  
				
				E_0: if(e.clk && e.dt)
						  st <= E_1;
		        		
		
				E_1: begin
		  
						 if(!e.clk && e.dt) begin
						 
							 if(data < p.max)						
								 data <= data + p.step;
							
							 st <= E_0;
						
						 end	 
						 else if(e.clk && !e.dt) begin
								  								  
		  					      if(data > p.min)								  
					               data <= data - p.step;

						         st <= E_0;
								end	
						end				 
			endcase

	   end		
	
   end

endmodule: encoder
