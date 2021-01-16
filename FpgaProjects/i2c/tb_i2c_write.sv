
/*
 comment WR_ONE_BYTE for sequential writing. 
*/

`timescale 1 ps / 1 ps


module tb_i2c_write;


`include "../tb.h"

`define WR_ONE_BYTE
	
localparam bit[4:0]   s_max = 16;												 // slave buff.  	
localparam logic[7:0] addr_dev = 8'b10100000;								 // device address.

enum_t::i2c_t st;																		 // i2c states.
enum_t::en_t  en = enum_t::EN_WR;												 // enable enum.	
enum {S_START, S_GET} st_s = S_START; 											 // slave's states.
enum {FREE, BUSY, SET_RD, RD, NEXT, LAST, COMP, NONE} state = FREE;	 // master's states.

	 
int   	i = 0,
			j = 0,
			n = 0,
			max = 3;
		
bit[3:0] nr = 8,
         ns = 8;
		 
bit   	sclk,
			sw = 0,
			clk = 0, 			
		 	fl_stop = 0;
					
logic[7:0] data,
			  out_i2c,
			  t_data[s_max],		// test data.
           buff[s_max + 2],   // master buff to send. 
			  s_buff[s_max],	   // slave buff.
			  mem[s_max];		   // memory arry.

wire  	  sda;
logic      t_sda = 1'bz;
	
			  
initial
begin

 `ifndef WR_ONE_BYTE
 
 	 max = s_max;
 `endif  	
 
 buff[0] = addr_dev;
 buff[1] = 8'h00;
 
// Test data. 
 for(int i = 0; i < s_max; ++i) begin
 
     t_data[i] = i + 8'h96;
	  buff[i + 2] = t_data[i];
 end	  
 
 for(int i = 0; i < s_max; ++i)
     mem[i] = 8'hff;
	  
 forever
	#10 clk = ~clk;

end


	assign sda = !sw ? t_sda : 0;

	i2c	i2c_inst(.clk(clk), .sda(sda), .sclk(sclk), .data(data), .en(en), .st(st), .out_i2c(out_i2c));


/****************************************************************************************
	Master device.
****************************************************************************************/
	
 always @(negedge clk) begin
	
	
		case(state)
			

			FREE:   if(st == enum_t::ACK || !i) begin
						
						  data <= buff[i];
						  state <= BUSY;													   	
					   end	
					  					

			BUSY:    if(st == enum_t::WR) begin
					  
					      ++i;
						
							if(i < max)
								state <= FREE;
															
							else if(!(buff[0] & 8'h01)) begin
								 
									  state <= NEXT;
									  en <= enum_t::EN_STOP;
								  end	 									 	 
					   end
					
					
			NEXT: 	if(st == enum_t::STOP)begin
							
						   `ifdef WR_ONE_BYTE
							
								i <= 0;
								max <= 3;
								state <= FREE;
								en <= enum_t::EN_WR;
								buff[0] <= addr_dev;
								++buff[1];			
								buff[2] <= t_data[buff[1]];
														
								if(buff[1] == s_max)
									en <= enum_t::EN_STOP;									
									
							`endif							
					   end			
						
			default: ;			
					
		endcase
 end

		
/****************************************************************************************
	Slave device.
****************************************************************************************/

// catch start.	
 always @(sclk, sda) begin
 
	if(sclk && !sda && st_s == S_START)	begin		
		
		j <= 0;
		
		for(int i = 0; i < s_max; ++i)
  		    s_buff[i] <= 0;
			 
		st_s <= S_GET;			
		
	end
 end

 
 always @(posedge sclk) begin

 
	case(st_s)
	
		
		S_GET:   begin
		
					  if(nr && sda !== 1'bz) begin
			   
						  --nr;
						  s_buff[j] <= s_buff[j] | (sda << nr);						  
					  end

					  if(!nr) begin
					  
						  if(sda === 1'bz) begin	
						  							  
							  `ifdef WR_ONE_BYTE
							  
									if(j > 0)
										mem[s_buff[1]] <= s_buff[2];										
							  `else							  
							  
								  if(j > 1)
							        mem[s_buff[1] - 2] <= s_buff[j];	
									  
								  ++s_buff[1];							  
								  
							  `endif	
							  
								++j;  							  
// set ack.				
							  sw <= 1;
							  nr <= 8;				
						  end								
					  end
					end
					
		default: ;
 
	endcase
	
 end


 // sets bus to z state.	
 always @(negedge sclk) begin	
	
	if(sw) begin	
	
	   sw <= 0;
		t_sda <= 1'bz;			
		st_s <= S_GET;
   end
 end
 

// catch stop. 
 always @(posedge sclk)
	fl_stop <= 1;
	
 always @(negedge sclk)
	fl_stop <= 0;
	
	
 always @(posedge sda) begin: stop

   int MAX;
	
	MAX = 0;
 
	if(fl_stop) begin
			
	   st_s <= S_START;
				
		`ifdef WR_ONE_BYTE
					
		   if(s_buff[1] == (s_max - 1)) begin
			
				$display("Testbench i2c for one byte writing.\n");
		      MAX = s_max;
			end	
			
		`else
					
		   if(s_buff[1] == s_max) begin
			
				$display("Testbench i2c for sequential writing.\n");
				MAX = (s_max - 2);				
			end	
			
		`endif	
					
		
		if(MAX) begin
		
			for(int i = 0; i < MAX; ++i) begin			
				`COMP(t_data[i], mem[i], EQ);
			end				
		end
	
	end
	
 end	
 
  
 endmodule: tb_i2c_write
