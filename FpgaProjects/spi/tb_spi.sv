

`timescale 1ps / 1ps

module tb_spi;


`include "../tb.h"

`define	MODE_0
//`define	MODE_1
//`define	MODE_2
//`define	MODE_3


`ifdef MODE_0
	localparam int m = 0;
`elsif MODE_3
	localparam int m = 3;
`elsif MODE_1
	localparam int m = 1;	
`elsif MODE_2
	localparam int m = 2;	
`endif	


localparam int N_in = 1,
               N_out = 1;

										
bit clk = 0, en = 1,
    sclk, ss, mosi, miso; 
	 
bit [31:0] nwr = 1, nrd = 1;
logic[(N_in << 3) - 1:0] in_data = 8'h5a;
logic[(N_out << 3) - 1:0] out_data, buff = 0;

int i = 8,
	 j = 8;	 

	 
initial
begin
 
 $display("\nTestbench spi mode%d.\n", m);
  
	forever
		#10 clk = ~clk;
 
end
	 

	spi  #(.Ni(N_in), .No(N_out), .mode(m)) spi_mut(.clk(clk), .miso(miso), .en(en), .in_data(in_data), 
	                                                .sclk(sclk), .ss(ss), .mosi(mosi), .out_data(out_data), 
																	.nwr(nwr), .nrd(nrd)); 

`ifdef MODE_0 
	always @(posedge sclk) begin	
`elsif MODE_3 
	always @(posedge sclk) begin		
`elsif MODE_1 
	always @(negedge sclk) begin
`elsif MODE_2
	always @(negedge sclk) begin
	
`endif

		if(!ss) begin

		   if(i) begin
			
			   --i;
				buff <= buff | (mosi << i);
			end
			
         if(!i) begin
			
				if(j) begin
					    
				   --j;
					miso <= buff >> j;
				end
	      end
		   
		end
				
	end	
	

	always @(posedge clk) begin
	
		if(ss && !j) begin
		
			i <= 8;
			j <= 8;
			buff <= 0;
			
			`COMP(in_data, out_data, EQ);
			++in_data;
		end	
		
	end
				
																							
endmodule: tb_spi
