


import t_string::t_str;

module grid(input bit clk, input bit[10:0] x, y, input bit[7:0] r0, g0, b0, output bit[7:0] red, green, blue, 
            output bit s, input t_str st);


localparam bit[10:0] x0 = 0,
                     y0 = 100,
			            ch = 4,
							x_step = 64,
			            y_step = 100,
						   x_max = 1024,
						   y_max = (y0 + (y_step * ch));

bit[10:0] dx = 0,
          dy = 0;
			 
	
	always @(posedge clk) begin
				
		
		if ( (x <= x_max) && (y >= y0 && y <= y_max) ) begin 						
		
				s <= 1'b1;
				
			   if(y == (y0 + dy)) begin				
					
					{red, green, blue} <= {r0, g0, b0};
					
					dy <= (y == y_max) ? 0 : (dy + y_step);

				end
				else begin			 
				
						 if(y > dy && y < (dy + y_step)) begin
				
						    if(x == (dx + x_step)) begin
							 
								 {red, green, blue} <= {r0, g0, b0};
							 
								 dx <= (x == x_max) ? 0 : (dx + x_step);
								 
						    end							 
//							 else {red, green, blue} <= {8'h00, 8'hff, 8'h00};
							 else {red, green, blue} <= st.en ? {st.r0, st.g0, st.b0} : 0;
							 
						 end
				end		
					
		end
		else {red, green, blue, s} <= 0;
		
	end

endmodule: grid
