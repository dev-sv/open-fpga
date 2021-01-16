


module ls(input bit osc, output  bit clk_p, clk_n, red_p, red_n, green_p, green_n, blue_p, blue_n);


import t_string::*;

`include "char.inc"


wire[10:0] w_x, 
           w_y;

wire[7:0] w_red, 
          w_green, 
			 w_blue,
			 red1, green1, blue1,
			 red2, green2, blue2,
			 red3, green3, blue3,
			 red4, green4, blue4;
//			 red5, green5, blue5,
//			 red6, green6, blue6;
		 
wire s1, s2, s3, s4;//, s5, s6;


t_str	str_1 = '{

	x0:40, y0:540, 
   r0:8'hff, g0:8'hff, b0:8'h00,
	col:Lx - 1, row:0, nchar:0,
	en:0, r:0, g:0, b:0
};

t_str	str_2 = '{

	x0:200, y0:540, 
   r0:8'h00, g0:8'hff, b0:8'hff,
	col:Lx - 1, row:0, nchar:0,
	en:0, r:0, g:0, b:0
};

t_str	str_3 = '{

	x0:360, y0:540, 
   r0:8'hff, g0:8'h00, b0:8'h00,
	col:Lx - 1, row:0, nchar:0,
	en:0, r:0, g:0, b:0
};

t_str	str_4 = '{

	x0:10, y0:10, 
   r0:8'h00, g0:8'hff, b0:8'h00,
	col:Lx - 1, row:0, nchar:0,
	en:0, r:0, g:0, b:0
};

t_str	str_5 = '{

	x0:70, y0:110, 
   r0:8'h00, g0:8'hff, b0:8'h00,
	col:Lx - 1, row:0, nchar:0,
	en:0, r:0, g:0, b:0
};


							 

	hdmi hdmi_inst(.osc(osc), .red(w_red), .green(w_green), .blue(w_blue), .clk_p(clk_p), .clk_n(clk_n), 
	                          .red_p(red_p), .red_n(red_n), .green_p(green_p), .green_n(green_n), 
									  .blue_p(blue_p), .blue_n(blue_n), .x(w_x), .y(w_y)); 

																		
	grid grid_inst(.clk(clk_p), .x(w_x), .y(w_y), .r0(8'h00), .g0(8'h9f), .b0(8'hff), 
	               .red(red4), .green(green4),	.blue(blue4),. s(s4), .st(str_5));


	button button_1(.clk(clk_p), .x0(0), .y0(510), .l(150), .h(80), .x(w_x), .y(w_y), .r0(8'h00), .g0(8'h00), .b0(8'hff), 
	                .r(red1), .g(green1), .b(blue1), .s(s1), .st(str_1));
						 
   
	button button_2(.clk(clk_p), .x0(160), .y0(510), .l(150), .h(80), .x(w_x), .y(w_y), .r0(8'h00), .g0(8'h00), .b0(8'hff), 
	                .r(red2), .g(green2), .b(blue2), .s(s2), .st(str_2));

						
	button button_3(.clk(clk_p), .x0(320), .y0(510), .l(150), .h(80), .x(w_x), .y(w_y), .r0(8'h00), .g0(8'h00), .b0(8'hff), 
	                .r(red3), .g(green3), .b(blue3), .s(s3), .st(str_3));
						

						
	always @(posedge clk_p) begin
	
		set_string("ABBA", w_x, w_y, charr, str_1);
		set_string("BAAB", w_x, w_y, charr, str_2);
		set_string("ABAB", w_x, w_y, charr, str_3);		
		
		set_string("ABBBBAAAAA", w_x, w_y, charr, str_4);		
		
		set_string("AB", w_x, w_y, charr, str_5);
	
		case({str_4.en, s4, s3, s2, s1})		
		
			//8'b00000000: {w_red, w_green, w_blue} <= 0;
		
			8'b00000001: {w_red, w_green, w_blue} <= {red1, green1, blue1};
			
			8'b00000010: {w_red, w_green, w_blue} <= {red2, green2, blue2};
			
			8'b00000100: {w_red, w_green, w_blue} <= {red3, green3, blue3};
			
			8'b00001000: {w_red, w_green, w_blue} <= {red4, green4, blue4};
			
			8'b00010000: {w_red, w_green, w_blue} <= {str_4.r, str_4.g, str_4.b};
			
			//8'b00100000: {w_red, w_green, w_blue} <= {str_5.r, str_1.g, str_1.b};
			
			//8'b01000000: {w_red, w_green, w_blue} <= {str_2.r, str_2.g, str_2.b};
		   
			default: {w_red, w_green, w_blue} <= 0;
			
		endcase	
		
	end
	
									
/*
									
task automatic set_string(input string str, input bit[10:0] x, y, ref t_str st);
			
			
bit[$clog2(max_ch) - 1:0] len = str.len();	// number chars.							
bit[$clog2(max_ch) - 1:0] ms[max_ch];			// most significant tetrad.
bit[$clog2(max_ch) - 1:0] ls[max_ch];			// less significant tetrad.


	for(int j = 0; j < len; ++j) begin
	
		 ms[j] = ((str.getc(j) >> 4) & 8'h0f);
		 ls[j] = (str.getc(j) & 8'h0f);
	end	 
	
		
//	if( (x >= x0 && x < (x0 + 14)) && (y >= y0 && y < (y0 + 16)) ) begin

//	if( (x >= x0 && x < (x0 + (Lx * len))) && (y >= y0 && y < (y0 + Hy)) ) begin
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
*/	
endmodule: ls
