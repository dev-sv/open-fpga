

module wave(input bit clk_pix, input bit[10:0] x, y, input pkg_wave::w_param p, input bit[9:0] scan_data, 
             input bit[9:0] curs_data, set_curs, np, input bit ch[960], output bit[7:0] red, green, blue, output bit s, 
				 input bit sel_ch);
				
							 
enum {S0, S1, S2} st = S0; 			
				 				 
const bit[10:0]     x0 = 64;

int       i = 0;
bit[10:0] n = 65;
bit[9:0]  max = 960,
          scale = 1; 		  
				 	

	
	always_ff @(posedge clk_pix) begin
	
	
		scale <= scan_data > 7 ? (scan_data - 7) : 1;	
	
		max <= sel_ch ? np : max; 
		
					
		if( (x >= x0 && x < 1024) && (y >= p.y0 && y < p.y1) ) begin 						
		
	      s <= 1'b1;
			
			{red, green, blue} <= (x == curs_data || x == set_curs) ? p.curs_color : (x == x0) ? p.zero_coord_color : 1'b0;
							
	   end
		else s <= 1'b0;

	
		
		unique case(st)
		
			
			S0: if(x == (x0) && (y >= p.y_min && y <= p.y_max)) begin
				 
					 st <= S1;
					
				 end
				 
 
		   S1: begin
							            
					if(x == curs_data  || x == set_curs)
		            {red, green, blue} <= p.curs_color;

					else {red, green, blue} <= (y == p.y_min && ch[i]) || (y == p.y_max && !ch[i]) ? p.wave_color :
							                     (x == n) ? ((ch[i] != ch[i + 1'b1]) ? p.wave_color : 1'b0) : 1'b0;																												
             end				 

		endcase
		
																			
		if(x == (max + 63)) begin
										
		   n <= 65;
			i <= 0;			
			st <= S0;
			
		end
		else if(x == n) begin
												
				  i <= i + 1;
				  n <= n + scale;									
			  end 		
							
   end	
	 	 
endmodule: wave

