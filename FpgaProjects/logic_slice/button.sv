


import t_string::t_str;

module button(input bit clk ,input bit[10:0] x0, y0, l, h, x, y, input bit[7:0] r0, g0, b0, 
              output bit[7:0] r, g, b, output bit s, input t_str st);
				  
	//assign {r, g, b, s} = (x >= x0 && x < (x0 + l)) && (y >= y0 && y < (y0 + h)) ? (en_str ? {8'hff, 8'hff, 8'h00, 1'b1} : {r0, g0, b0, 1'b1}) : 0;
		
	always @(posedge clk) begin
		
		{r, g, b, s} <= (x >= x0 && x < (x0 + l)) && (y >= y0 && y < (y0 + h)) ? (st.en ? {st.r0, st.g0, st.b0, 1'b1} : {r0, g0, b0, 1'b1}) : 0;
	end
		
endmodule: button