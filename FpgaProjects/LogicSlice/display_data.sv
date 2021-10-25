
/*
 Event manager interface(emi).
*/

module display_data(input bit clk, input bit[10:0] x, y, ls_if.dd emi); 


						  
`include "ascii.h"
			 			 
import t_string::*;


enum {INI, LOW_CH, HI_CH} st_sel_ch = INI;	// state select channel.

enum {LOW_CURS, HI_CURS} st_curs = LOW_CURS;	// state set cursor

bit       set_x = 0;



const bit[16:0] MaxTime = 99840;

bit[16:0] diff_val, 
          curr_val, val,
          prev_val = 0;			 
			 
bit[9:0]  prev_scan_n = 0,
			 prev_scan_data = 0,
			 first_curs_x = 0;
			 
t_str	str_title = '{

	en:0, r:0, g:0, b:0,
   r0:0, g0:8'h8f, b0:8'hff,
	col:Lx - 1, row:0, nchar:0
};


t_str	str_ch0 = '{

	en:0, r:0, g:0, b:0,
   r0:0, g0:8'h9f, b0:8'hff,	
	col:Lx - 1, row:0, nchar:0
};


t_str	str_ch1 = '{

	en:0, r:0, g:0, b:0,
   r0:0, g0:8'h9f, b0:8'hff,
	col:Lx - 1, row:0, nchar:0
};


t_str	str_ch2 = '{

	en:0, r:0, g:0, b:0,
   r0:0, g0:8'h9f, b0:8'hff,
	col:Lx - 1, row:0, nchar:0
};


t_str	str_ch3 = '{

	en:0, r:0, g:0, b:0,
   r0:0, g0:8'h9f, b0:8'hff,
	col:Lx - 1, row:0, nchar:0
};


t_str	str_curs_val = '{

	en:0, r:0, g:0, b:0,
   r0:0, g0:8'hff, b0:8'h00,
	col:Lx - 1, row:0, nchar:0
};


t_str	str_tm = '{

	en:0, r:0, g:0, b:0,
   r0:0, g0:8'hff, b0:8'h00,
	col:Lx - 1, row:0, nchar:0
};


t_str	str_tm_val = '{

	en:0, r:0, g:0, b:0,
   r0:0, g0:8'hff, b0:8'h00,
	col:Lx - 1, row:0, nchar:0
};


t_str	str_first_curs = '{

	en:0, r:0, g:0, b:0,
   r0:0, g0:8'hff, b0:8'h00,
	col:Lx - 1, row:0, nchar:0
};


t_str	str_ns = '{

	en:0, r:0, g:0, b:0,
   r0:0, g0:8'hff, b0:8'h00,
	col:Lx - 1, row:0, nchar:0
};		



	always_ff @(posedge clk) begin

	
// Current cursor value.						
		val <= (emi.scan_data > 8'd7) ? ((emi.curs_data * 8'd5)/(emi.scan_data - 8'd7)) : 
		            (emi.curs_data * 8'd5 * (1 << 8'd8 - emi.scan_data));

		curr_val  = val < 99999 ? val : MaxTime;
								
								
// Time interval.
		diff_val <= (emi.curs_data > first_curs_x) ? curr_val - prev_val : prev_val - curr_val;
		
		set_string(0, "Logic slice v1.0", x, y, charr, emi.sel_channel, str_title, 5, 20);
		set_string(0, "CH0", x, y, charr, emi.sel_channel, str_ch0, 5, 80);
		set_string(1, "CH1", x, y, charr, emi.sel_channel, str_ch1, 5, 190);
		set_string(2, "CH2", x, y, charr, emi.sel_channel, str_ch2, 5, 300);
		set_string(3, "CH3", x, y, charr, emi.sel_channel, str_ch3, 5, 410);

		
// Cursor value.
		set_string(curr_val, "\0", x, y, charr, emi.sel_channel, str_curs_val, emi.curs_data, 520);
								
		
// Set cursor.		
      if(emi.set_curs) begin
		
         set_string(prev_val, "\0", x, y, charr, emi.sel_channel, str_first_curs, first_curs_x, 540);
			
			if((prev_scan_data != emi.scan_data) || (prev_scan_n != emi.scan_n))
            emi.set_curs <= 0;
				
		end
		else begin
		
		       prev_scan_n <= emi.scan_n;
		       prev_scan_data <= emi.scan_data;
		       prev_val <= curr_val;
				 first_curs_x <= emi.curs_data;
		end 
		
		
// Time interval value.
      set_string(0, "Ti:", x, y, charr, emi.sel_channel, str_tm, 65, 570);

      set_string(0, "ns", x, y, charr, emi.sel_channel, str_ns, 200, 570);
						
      set_string(diff_val, "\0", x, y, charr, emi.sel_channel, str_tm_val, 120, 570);
				
				
// Button (select channel).

		unique case(st_sel_ch)
		
		       INI: begin
			
						  emi.sel_channel <= 4'b1111;
						  st_sel_ch <= LOW_CH;
	               end
						
				
		    LOW_CH: if(!emi.sel_ch_btn)			 
		               st_sel_ch <= HI_CH;
			    		 
		          
		     HI_CH: if(emi.sel_ch_btn) begin						
						
						   emi.sel_channel <= (emi.sel_channel == 4'b1000 || emi.sel_channel == 4'b1111) ? 4'b0001 : (emi.sel_channel << 1);
					      st_sel_ch <= LOW_CH;
                  end				  
	   endcase	
	


// Button (set cursor).		
		unique case(st_curs)
		
		   		
		    LOW_CURS: if(!emi.curs_set_btn) begin
			 							  
						     set_x <= (!emi.set_curs && ((emi.curs_data + 8'd64) > 8'd68)) ? 1'b1 : 1'b0;							  
		                 st_curs <= HI_CURS;
					     end	
			    		 
		          
		     HI_CURS: if(emi.curs_set_btn) begin
						
						     emi.set_curs <= set_x ? (emi.curs_data + 8'd64) : 1'b0;						
					        st_curs <= LOW_CURS;
                    end				  
	   endcase

	end
	
	
	
	always_comb begin	
	
	
		case({str_title.en, str_first_curs.en, str_ns.en, str_tm_val.en, str_tm.en, str_curs_val.en, 
		      str_ch3.en, str_ch2.en, str_ch1.en, str_ch0.en, emi.s_wave[3], emi.s_wave[2], emi.s_wave[1], emi.s_wave[0]})

					 
			16'h0001: {emi.red, emi.green, emi.blue} = {emi.r_wave[0], emi.g_wave[0], emi.b_wave[0]};
			
			16'h0002: {emi.red, emi.green, emi.blue} = {emi.r_wave[1], emi.g_wave[1], emi.b_wave[1]};

			16'h0004: {emi.red, emi.green, emi.blue} = {emi.r_wave[2], emi.g_wave[2], emi.b_wave[2]};
			
			16'h0008: {emi.red, emi.green, emi.blue} = {emi.r_wave[3], emi.g_wave[3], emi.b_wave[3]};			
			
			16'h0010: {emi.red, emi.green, emi.blue} = {str_ch0.r, str_ch0.g, str_ch0.b};
			
			16'h0020: {emi.red, emi.green, emi.blue} = {str_ch1.r, str_ch1.g, str_ch1.b};
			
			16'h0040: {emi.red, emi.green, emi.blue} = {str_ch2.r, str_ch2.g, str_ch2.b};
			
			16'h0080: {emi.red, emi.green, emi.blue} = {str_ch3.r, str_ch3.g, str_ch3.b};			
						
			16'h0100: {emi.red, emi.green, emi.blue} = {str_curs_val.r, str_curs_val.g, str_curs_val.b};
						
			16'h0200: {emi.red, emi.green, emi.blue} = {str_tm.r, str_tm.g, str_tm.b};
			
			16'h0400: {emi.red, emi.green, emi.blue} = {str_tm_val.r, str_tm_val.g, str_tm_val.b};
						
			16'h0800: {emi.red, emi.green, emi.blue} = {str_ns.r, str_ns.g, str_ns.b};
			
			16'h1000: {emi.red, emi.green, emi.blue} = {str_first_curs.r, str_first_curs.g, str_first_curs.b};
			
			16'h2000: {emi.red, emi.green, emi.blue} = {str_title.r, str_title.g, str_title.b};
		   
			 default: {emi.red, emi.green, emi.blue} = 0;
			
		endcase	
	
   end
	
		
endmodule: display_data
