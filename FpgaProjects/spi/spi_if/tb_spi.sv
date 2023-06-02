


`timescale 1 ns / 1 ps


module tb_spi;


 `define MODE_00 2'b00
// `define MODE_01 2'b01
// `define MODE_10 2'b10
// `define MODE_11 2'b11


 `define SEND 2'b10
 `define RECV 2'b01
 `define STOP 2'b00

 enum { S0, S1, S2, S3, S4, CMP } st = S0;

 bit 		 clk;								
 wire		 ss;
 wire		 sclk;
 wire		 mosi;	
 bit 	 	 miso;
								
 wire[3:0] w_sb;				
 wire[3:0] w_rb;				
				 
 bit[7:0] in_data; 
 bit[7:0] in_buff[32] = '{ 90, 12, 33, 47, 5, 16, 79, 8, 94, 10, 11, 102, 13, 148, 15, 0,
								 	255, 201, 123, 98, 45, 61, 79, 80, 99, 107, 111, 126, 132, 141, 155, 167 };
 wire[7:0] w_out_data;
 bit[7:0]  out_buff[32];

 bit[1:0] 		mode;
 bit[1:0] 		op = 2'b00; 
 int unsigned 	num = 32;
 string       	str;
 int unsigned 	i = 0;
 
 
/* 

slave vars.

*/

 enum { SR0, SR1, SR2 } st_r = SR0; // states receve.
 enum { SS0, SS1, SS2 } st_s = SS0; // states send.
 
 bit[3:0]  s_rb = 8;						// count bits to receive.
 bit[3:0]  s_sb = 8;				      // count bits to send.
 bit[7:0]  s_recv_buff[32];			// receive buffer.
 
 int unsigned nr = 0;					// count bytes to receive.
 int unsigned ns = 0;					// count bytes to send.

 
 
 initial begin

	`ifdef MODE_00
	
		mode = 2'b00;
			
	`elsif MODE_01
	
		mode = 2'b01;
		
	`elsif MODE_10
	
		mode = 2'b10;
		
	`elsif MODE_11
	
		mode = 2'b11;
		
	`endif	
	
	
   $display("spi mode %b\n", mode);	
	
 
	forever #1 clk = ~ clk;
 
 end
 
 
 
	spi spi_dut(

					.clk(clk),
								
					.ss(ss),
				
					.sclk(sclk),
				
					.mosi(mosi),
				
				   .miso(miso),
				
					.op(op),
					
					.sb(w_sb),
				
					.rb(w_rb),
				
					.in_data(in_data), 
				
					.out_data(w_out_data),
					
					.mode(mode)
);				



/********************************
 
 slave.

********************************/
	
	always @(posedge clk) begin
	
	
// receive data.
	
		case(st_r)
	
			
			SR0: if(!ss) begin
			
				  `ifdef MODE_00
				  
					  if(sclk) begin
					  
				  `elsif	MODE_01
					
					  if(!sclk) begin
					  
				  `elsif	MODE_10
					
					  if(!sclk) begin
					  
				  `elsif MODE_11
				  
					  if(sclk) begin
					  
				  `endif  
		
						  s_recv_buff[nr][s_rb - 1] <= mosi;
			
						  s_rb <= s_rb - 1'b1;
								
						  st_r <= SR1;
					  end
				  end
				  				  

			SR1: begin
						
				  `ifdef MODE_00
				  
					  if(!sclk) begin
					  
				  `elsif	MODE_01
					
					  if(sclk) begin
					  
				  `elsif	MODE_10
					
					  if(sclk) begin
					  
				  `elsif MODE_11
				  
					  if(!sclk) begin
					  
				  `endif  
						
					   if(!s_rb) begin
																						
							if(nr < (num - 1)) begin
									
								s_rb <= 8;
										
								nr <= nr + 1'b1;
										
								st_r <= SR0;
							end		
							else st_r <= SR2;
								
						end
						else st_r <= SR0;
								
				   end						
					
			  end
				  
				
			default: ;
		
		endcase
				
				
// send data.				
		
		case(st_s)	
			
				
				SS0: if(!ss) begin
			
						`ifdef MODE_00
				  
							if(!sclk) begin
					  
						`elsif MODE_01
					
							if(sclk) begin
					  
						`elsif MODE_10
					
							if(sclk) begin
					  
						`elsif MODE_11
				  
							if(!sclk) begin
					  
						`endif  
						  
							  if(nr == (num - 1)) begin
						  
							     if(s_rb < 2) begin
							  		
								     miso <= s_recv_buff[ns][s_sb - 1];
						
							        s_sb <= s_sb - 1'b1;
		
						           st_s <= SS1;
							     end
							  
							  end
						  
						  end
			
						end	
				  
				  
				  `ifdef MODE_00
				  
					  SS1: if(sclk) begin
					  
				  `elsif	MODE_01
					
					  SS1: if(!sclk) begin
					  
				  `elsif	MODE_10
					
					  SS1: if(!sclk) begin
					  
				  `elsif MODE_11
				  
					  SS1: if(sclk) begin
					  
				  `endif  
			
						  if(s_sb)	
                       st_s <= SS0;
						  
					     else begin
						  
									if(ns < (num - 1)) begin
									
										ns <= ns + 1'b1;
										
										s_sb <= 8;
										
										st_s <= SS0;
									end
								   else st_s <= SS2;	
						  end
						  
				     end

		
				default: ;
		
		endcase
			
	end
	
/*******************************/



	always @(posedge clk) begin
	
		
		case(st)
		
			
			S0: if(!w_sb)begin
			
					 in_data <= in_buff[i];
	
					 op <= `SEND;
					 
					 i <= i + 1'b1;
				
					 st <= S1;
				 end
					 
				 
			S1: if(w_sb) begin
			
					 if(i < num)
					    st <= S0;
							 
					 else begin
						 
					       i <= 0; 
			
							 st <= S2; 
					 end 
					 
				 end	
				 				 

// wait send last byte.					 
			S2: if(!w_sb) begin
								
					 op <= `RECV;
					 					 
					 st <= S3;
				 end
		
	
			S3: if(w_rb)					 
					 st <= S4;
					 
					 
			S4: if(!w_rb) begin
									  												 
					 out_buff[i] <= w_out_data;

					 if(i == (num - 1)) begin
					 
						 i <= 0;
						 
					    op <= `STOP;
					
						 st <= CMP;
					 end	
					 else begin 
					 
							 i <= i + 1'b1;
							 
							 st <= S3;
					 end		 
						 
				 end 	
				 	
	
			CMP: if(i < num) begin
					  
					  if(in_buff[i] != out_buff[i]) begin
						  
						  str = "error";
					  end
					  else str = "pass";
						     						    
					  $display("%d in_buff = %h out _data = %h %s", i, in_buff[i], out_buff[i], str);
						  
					  i <= i + 1'b1;

				  end
				
	
			default: ;	 
	
		endcase			
	
	end

endmodule: tb_spi