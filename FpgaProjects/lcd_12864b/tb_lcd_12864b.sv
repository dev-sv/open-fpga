

`timescale 1 ps / 1 ps


module tb_lcd_12864b;

`include "../tb.h"


localparam N = 32;
localparam QS = 8;

bit clk, full, 
    rs, rw, e, cmd = 0;

logic[$clog2(QS) - 1:0] pWR, 
                        p = 0;
logic[7:0] in_data, 
           out_data,
			  data[N];

			  
int j = 0,
    i = 0,
    num = N;
			
	
initial
begin

 $display("\n Testbench lcd_12864b.\n");

 clk = 0;
 
 for(int i = 0; i < N; ++i) 
     data[i] = i;
 

 forever
   #10 clk = ~clk;
 
end
	


	lcd_12864b	#(QS)lcd_12864b_mut(.clk(clk), .in_data(in_data), .cmd(cmd), .pWR(pWR), .rs(rs), .rw(rw), .e(e), 
						  				     .out_data(out_data), .full(full));



	always @(posedge clk) begin
	
		if((j < num) && !full) begin

   		in_data <= data[j++];
		   pWR <= p++;		
		end
			
	end
	
	
	always @(negedge e) begin
		
		`COMP(out_data, data[i], EQ);
		++i;
	end
											  
endmodule: tb_lcd_12864b
