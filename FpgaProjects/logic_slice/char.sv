


package t_string;

// size of char.
localparam Lx = 15; 				// number of bits for x.
localparam Hy = 16;     		// number of bits for y.
localparam max_ch = 16; 		// max number of chars.


typedef struct {

	bit[10:0] x0, y0;				// start coords.
	bit[7:0]  r0, g0, b0;		// string color.
	bit[3:0]  col, row, nchar;

	bit en;
	bit[7:0] r, g, b;
	
} t_str;



task automatic set_string(input string str, input bit[10:0] x, y, input bit[Lx - 1:0] charr[5][3][Hy], ref t_str st);			
			
bit[$clog2(max_ch) - 1:0] len = str.len();	// number chars.							
bit[$clog2(max_ch) - 1:0] ms[max_ch];			// most significant tetrad.
bit[$clog2(max_ch) - 1:0] ls[max_ch];			// less significant tetrad.


	for(int j = 0; j < len; ++j) begin
	
		 ms[j] = ((str.getc(j) >> 4) & 8'h0f);
		 ls[j] = (str.getc(j) & 8'h0f);

	end	 
	
	
	if( (x >= st.x0 && x < (st.x0 + (Lx * len))) && (y >= st.y0 && y < (st.y0 + Hy)) ) begin
		
		
		{st.r, st.g, st.b, st.en} <= (charr[ms[st.nchar]][ls[st.nchar]][st.row] & (1 << st.col)) ? {st.r0, st.g0, st.b0, 1'b1} : 0;	

//		i <= !i ? 13 : (i - 1);
		st.col <= !st.col ? (Lx - 1) : (st.col - 1);
		
		st.nchar <= !st.col ? (st.nchar + 1) : st.nchar;
						
		if(len == st.nchar) begin
			
			st.row <= st.row + 1;
			st.nchar <= 0;
		end
				
	end
	else begin
	
//       	{st.r, st.g, st.b, st.s} <= {8'h00, 8'h00, 8'hff, 1'b0};
       	//{st.r, st.g, st.b, st.s} <= {st.br, st.bg, st.bb, 1'b0};
			st.en <= 1'b0;
	end		
		
endtask
	
endpackage


