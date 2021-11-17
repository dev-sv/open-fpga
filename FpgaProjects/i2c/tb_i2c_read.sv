
/*
 comment RD_ONE_BYTE for sequential writing. 
*/

`timescale 1 ps / 1 ps


module tb_i2c_read;


`include "../tb.h"


`define RD_ONE_BYTE

	
localparam bit[4:0]   mem_max = 16;															 // amount of memory. 	
localparam logic[7:0] addr_dev = 8'b10100000;											 // device address.

enum_t::i2c_t st;																					 // i2c states.
enum_t::en_t  en = enum_t::EN_WR;															 // enable enum.	
enum {FREE, BUSY, SET_RD, RD, NEXT, LAST, RD_LAST, COMP, NONE} state = FREE;	 // master's states.
enum {S_START, S_GET, S_SEND, S_NEXT, S_NONE}                  st_s = S_START; // slave's states.

	 
int   	i = 0, 
			j = 0,
			n = 0,			
			max = 2;
		
bit[3:0] nr = 8,
         ns = 8;
		 
bit   	sclk,
			clk = 0, 
			sw = 0;
					
logic[7:0] data,
			  out_i2c,
           buff[2],           // master buff to send. 
			  s_buff[2],			// slave buff.
			  mem[mem_max],		// memory arry.
			  m_buff[mem_max];	// master buff to recieve.

wire  	  sda;
logic      t_sda = 1'bz;

			  	
			  
initial
begin
 
 buff[0] = addr_dev;
 buff[1] = 8'h00;
 
 s_buff[0] = 0;
 s_buff[1] = 0;
 
 for(int i = 0; i < mem_max; ++i)
     mem[i] = i + 8'h96;
	  
 
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
							
							else begin 
								 
								    if(!(buff[0] & 8'h01)) begin
								 
									    state <= SET_RD;
									    en <= enum_t::EN_STOP;
								    end	 									 
							       else begin 
								 
								           `ifdef RD_ONE_BYTE
										  
													state <= RD_LAST;								 
													en <= enum_t::EN_STOP;
												
												`else state <= RD;
											
												`endif	
								    end
						     end		 
					   end
					
					
			SET_RD:  if(st == enum_t::STOP) begin

						   buff[0] <= addr_dev | 1;
						   i <= 0;		 
						   max <= 1;
						
						   state <= FREE;
						   en <= enum_t::EN_RD;
					   end
						

			RD:      if(st == enum_t::Z) begin
									 
						  m_buff[n] <= out_i2c;
						
						  ++n;
				      
		              if(n == (mem_max - 1))						
							  state <= LAST;
							
						  else state <= NEXT;
					   end
						
					
			NEXT:    if(st != enum_t::Z)						
						   state <= RD;
											
			
	      LAST:    if(st == enum_t::RD) begin
		  
				         en <= enum_t::EN_STOP;
							state <= RD_LAST;		  
					   end
					
					
			RD_LAST: if(st == enum_t::STOP)begin
			
						   m_buff[n] <= out_i2c;
							state <= COMP;							
					   end
			
			
			COMP: 	begin
			
						  `ifdef RD_ONE_BYTE
		  
								i <= 0;
								++n;
								max <= 2;
								state <= FREE;
								buff[0] <= addr_dev;
								++buff[1];
								
								if(n < mem_max)
								   en = enum_t::EN_WR;
									
								else begin 
								
										 $display("Testbench i2c for one byte reading.\n");
										 
								       en = enum_t::EN_STOP;
										 
										 for(int i = 0; i < mem_max; ++i) begin
					 
											  `COMP(m_buff[i], mem[i], EQ);
										 end
								end
								
						  `else $display("Testbench i2c for sequential reading.\n");
						  
								  for(int i = 0; i < mem_max; ++i) begin
					 
									   `COMP(m_buff[i], mem[i], EQ);
								  end
						  
						        state <= NONE;
						  
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
				
  		s_buff[0] <= 0;
		s_buff[1] <= 0;
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
										
							  ++j;
			
							  if(j == max)				
								  j <= 0;					
// set ack.				
							  sw <= 1;
							  nr <= 8;				
						  end								
					  end
					end
					
							
		S_SEND:  if(ns) begin
		
						--ns;
						t_sda <= (mem[s_buff[1]] >> ns);			
					end
										
					
		S_NEXT:  if(s_buff[1] < mem_max) begin	
		
					   ns <= 8;
						
						`ifndef RD_ONE_BYTE
						
							++s_buff[1];
							st_s <= S_SEND;
							
						`else st_s <= S_START;	
						
						`endif
					end
					
		default: ;
 
	endcase
	
 end


// sets bus to z state.	
 always @(negedge sclk) begin	
	
	if(sw) begin	
	
	   sw <= 0;
		t_sda <= 1'bz;	
		
//	read op.
		if((s_buff[0] & 8'h01))
		    st_s <= S_SEND;			 
   end

	if(!ns) begin
	
		sw = 0; 
		t_sda = 1'bz;
		st_s <= S_NEXT;
	
	end	

 end
 
  
 endmodule: tb_i2c_read
