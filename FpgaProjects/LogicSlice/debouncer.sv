



module debouncer(input bit clk, in, input bit[31:0] delay, output bit out);


enum {GET, WAIT} st = WAIT;

int unsigned  count = 0;



	always @(posedge clk) begin
	
	
		unique case(st)
	
		  
			GET: begin
		  
		          out <= in;
		          st <= WAIT;
					
				  end	  
				  
		  
		  WAIT: begin

		          if(count < delay)
						 count <= count + 1; 
					    
					 else begin
					 
						     count <= 0;  
					        st <= GET;					 
					 end
					 
		        end						  				  
		endcase
	
	end

endmodule: debouncer