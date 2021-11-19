


package pkg_encoder;

 typedef struct{

 bit[9:0] ini, 
          max, 
			 min, 
			 step;
			 
 } e_param;
 
endpackage


package pkg_wave;


 typedef struct{
 
 
	bit[2:0][7:0] curs_color,  	
	              wave_color,  
	              zero_coord_color;  

	bit[10:0] y_min, 
	          y_max, 
				 y0, y1;
			 
 } w_param;

endpackage




package t_string;


localparam int Lx = 15; // number of bits for x.
localparam int Hy = 16; // number of bits for y.
localparam int ln = 16; // max number of chars.


typedef struct {

	bit      en;
	bit[7:0] r,  g,  b,
	         r0, g0, b0,
				col, row, nchar;
} t_str;



// comment this task before running scripts .do

task automatic set_string(input bit[16:0] v, input string s, input bit[10:0] x, y, input bit[Lx - 1:0] charr[8][16][Hy], 
                          input bit[3:0] ch, ref t_str st, input bit[9:0] x0, y0);			

								  								  
int       len = ln; 	
bit[19:0] tmp = 0, 								
			 e0_1000 = 0,
			 e1_1000 = 0,
			 e0_10000 = 0,
			 e1_10000 = 0;
			 
bit[3:0] ms[ln];	// most significant tetrad.
bit[3:0] ls[ln];	// less significant tetrad.



		 for(int i = 0; i < ln; ++i) begin

			  ms[i] = 4'h2;
		     ls[i] = 4'h0;
	    end
	

	
		 if(s == "\0") begin	
	
// up to 1000.	
	       e0_1000 = v/10'd1000;
			 e1_1000 = e0_1000 * 12'd1536;
// up to 10000.			 
	       e0_10000 = v/16'd10000;
			 e1_10000 = e0_10000 * 16'd24576;
			 
	
          tmp = ((8'd156 * (v/8'd100)) + v + ( ((v - ((v/8'd100) * 8'd100))/4'd10) ) * 4'd6) + e1_1000 + e1_10000;

			 if(v < 100000) begin
				 
				 
			 	 if(v > 9999) begin
					 
		 		    ms[0] = 4'h3;
		          ls[0] = tmp[19:16];
				 end	 

					 
				 if(v > 999) begin
					 
		 		    ms[1] = 4'h3;
		          ls[1] = tmp[15:12];
				 end	 
					 
					 
				 if(v > 99) begin
					 
		 		    ms[2] = 4'h3;
		          ls[2] = tmp[11:8];	
				 end 	 
					 

				 if(v > 9) begin

		 		    ms[3] = 4'h3;
		          ls[3] = tmp[7:4];
				 end	 
					 	 
		 		 ms[4] = 4'h3;
		       ls[4] = tmp[3:0];
				 
		    end				 
			 
	    end	   
	    else begin
 
			     len = s.len();
 
				  for(int i = 0; i < len; ++i) begin
	
	               ms[i] = ((s.getc(i) >> 8'h04) & 8'h0f);
		            ls[i] = (s.getc(i) & 8'h0f);
	           end
	    end 
					
		
		 if( (x >= x0 && x < (x0 + (Lx * len))) && (y >= y0 && y < (y0 + Hy)) ) begin
	
	
			 if((ch == 4'h1 && y0 == 80) || (ch == 4'h2 && y0 == 190) || 
		       (ch == 4'h4 && y0 == 300) || (ch == 4'h8 && y0 == 410))
		
		       {st.r, st.g, st.b, st.en} <= (charr[ms[st.nchar]][ls[st.nchar]][st.row] & (1 << st.col)) ? {8'hff, 8'h4f, 8'h4f, 1'b1} : 1'b0;
			
          else {st.r, st.g, st.b, st.en} <= (charr[ms[st.nchar]][ls[st.nchar]][st.row] & (1 << st.col)) ? {st.r0, st.g0, st.b0, 1'b1} : 1'b0;
		
          		
		    st.col <= !st.col ? (Lx - 1'b1) : (st.col - 1'b1);
		
		    st.nchar <= !st.col ? (st.nchar + 1'b1) : st.nchar;
						
		    if(len == st.nchar) begin
			
			    st.row <= st.row + 1'b1;
			    st.nchar <= 0;
		    end
				
		 end
	    else st.en <= 1'b0;
					
endtask
	
		
endpackage




interface ls_if();


 bit[10:0] x, y;
 bit       clk_pix;

 
/* encoder if */

 import pkg_encoder::*;

 e_param p;

 bit[9:0] data;
 bit      clk, dt;

 modport e_in(input clk, dt);
 
 
/* debouncer if */
  
 bit[31:0] delay;
 bit       in, out; 
 
 
/* channel if */

 bit[9:0] n, np;
 
 bit      sel_ch, 
          ch[960];	 
 
 
/* wave if */

 import pkg_wave::*;

 w_param  wp;

 bit      s;			
 bit[9:0] scan_data, 
          curs_data, 
			 set_curs;
			
 bit[7:0] red, 
          green, 
			 blue;

	
/* display_data */

 bit s_wave[4],  
     sel_ch_btn, 
	  curs_set_btn; 
			 
 bit[3:0] sel_channel;
 bit[9:0] scan_n;
 
 bit[7:0] r_wave[4], 
          g_wave[4], 
	  		 b_wave[4];

 modport dd(input   r_wave, g_wave, b_wave, s_wave, curs_data,
                    sel_ch_btn, curs_set_btn, scan_n, scan_data,
				 output sel_channel, set_curs, red, green, blue);
				 
endinterface
