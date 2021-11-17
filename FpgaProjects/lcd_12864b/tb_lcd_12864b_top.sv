
`timescale 1 ps / 1 ps


module tb_lcd_12864b_top;


`include "../tb.h"


bit clk, rs, rw, e; 
logic [7:0] data,
            in_data[73];
int i = 0;


initial
begin

 $display("\nTestbench lcd_12864b_top\n");
  
 in_data[0] = 8'h30;
 in_data[1] = 8'h0f;
 in_data[2] = 8'h30;
 in_data[3] = 8'h01;
 in_data[4] = 8'h06;				
 
 in_data[5] = 8'h80;				
 
 for(int i = 6; i < 22; ++i)
     in_data[i] = (i - 6);
	  
 in_data[22] = 8'h90;				

 for(int i = 23; i < 39; ++i)
     in_data[i] = i - 7;
 
 in_data[39] = 8'h88;				

 for(int i = 40; i < 56; ++i)
     in_data[i] = i - 8;

 in_data[56] = 8'h98;				

 for(int i = 57; i < 73; ++i)
     in_data[i] = i - 9;
	  
 
 clk = 0;

 forever
   #10 clk = ~clk;
	
end


	lcd_12864b_top		lcd_12864b_top_dut(.osc(clk), .rs(rs), .rw(rw), .e(e), .data(data));

	
	always @(negedge e) begin
	
		`COMP(data, in_data[i], EQ);
		++i;		
	end 
	
endmodule
