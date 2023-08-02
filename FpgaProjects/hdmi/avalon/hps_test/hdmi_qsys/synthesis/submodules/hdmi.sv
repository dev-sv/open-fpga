

/* 

pll_0. 

outclk0 = 60000000  MHz	 sdram    clock.
outclk1 = 300000000 MHz	 hdmi_x10 clock.
outclk2 = 60000000  MHz	 hdmi_pix clock.	

*/
				
module hdmi #(
					parameter horz_front_porch = 20,
								 horz_sync = 60,
								 horz_back_porch = 110,
								 horz_pix = 1024,

								 vert_front_porch = 30,
								 vert_sync = 80,
								 vert_back_porch = 110,
								 vert_pix = 600 
				 )
				 

				 (
					input wire        clk,
					input wire        reset,
					
// avalon_if.													
					output bit			 m_read,
					output bit			 m_write,
					output bit[29:0]   m_address,
					output wire[31:0]  m_writedata,
					input  wire[31:0]  m_readdata,
					input  wire		    m_readdatavalid,
					output bit[3:0]	 m_byteenable,
					output bit[10:0]	 m_burstcount,
					input  wire	 		 m_waitrequest,
															
					input wire			s_write,
					input wire[11:0]  s_address,
					input wire[31:0]  s_writedata,
					input wire		   s_chipselect,
					
// hdmi_if.		
					input wire clk_x10, 	
					input wire clk_pix, 	
		 					
					output bit clk_pix_p,
					output bit clk_pix_n,
					
					output bit 	red_p,
					output bit 	red_n,
					
					output bit	green_p,
					output bit 	green_n,
					
					output bit 	blue_p,
					output bit 	blue_n
															
				 );
				
				
				
 wire[9:0] w_red;
 wire[9:0] w_green;
 wire[9:0] w_blue;
 
 bit       de;
 bit[1:0]  vh;
 bit[7:0]  red;
 bit[7:0]  green;
 bit[7:0]  blue;
  
 bit[31:0] fb_addr;
 bit[31:0] fb[horz_pix];
 bit[31:0] addr_off = 0;
  
 bit[9:0]  i = 0; 
 bit[10:0] y = 0; 
 bit[10:0] x = horz_pix;
 bit       valid = 1'b0;

 
 const int unsigned max = (horz_pix * vert_pix);
 const int unsigned Vs = vert_front_porch + vert_sync + vert_back_porch + vert_pix;
 const int unsigned Hs = horz_front_porch + horz_sync + horz_back_porch + horz_pix;
 
 int unsigned 		  n = 0;
 int unsigned 		  size = max;
   
 enum { SS, S0, S1, S2, S3, S4 } st = SS;
 
 
 wire w_pix;
 wire w_red_p;
 wire w_red_n;
 wire w_green_p;
 wire w_green_n;
 wire w_blue_p;
 wire w_blue_n;
 
  
 buf buf_pix(w_pix, clk_pix);
 
 buf buf_red_p(red_p, w_red_p);
 buf buf_red_n(red_n, w_red_n);
 
 buf buf_green_p(green_p, w_green_p);
 buf buf_green_n(green_n, w_green_n);
 
 buf buf_blue_p(blue_p, w_blue_p);
 buf buf_blue_n(blue_n, w_blue_n);
 
				
		
	
	assign clk_pix_p = w_pix,
	
			 clk_pix_n = ~w_pix;
		

	assign vh[0] = (x >= (horz_pix + horz_front_porch - 1'b1) && x < (horz_pix + horz_front_porch + horz_sync - 1'b1)),
						
			 vh[1] = (y >= (vert_pix + vert_front_porch - 1'b1) && y < (vert_pix + vert_front_porch + vert_sync - 1'b1));
	
	
	tmds_encoder tmds_encoder_red(.clk(clk_pix), .de(de), .vh(vh), .color(red), .out(w_red));
	
	tmds_serial  tmds_serial_red(.clk_x10(clk_x10), .d(w_red), .p(w_red_p), .n(w_red_n)); 

	
	tmds_encoder tmds_encoder_green(.clk(clk_pix), .de(de), .vh(vh), .color(green), .out(w_green));
	
	tmds_serial  tmds_serial_green(.clk_x10(clk_x10), .d(w_green), .p(w_green_p), .n(w_green_n)); 

	
	tmds_encoder tmds_encoder_blue(.clk(clk_pix), .de(de), .vh(vh), .color(blue), .out(w_blue));
	
	tmds_serial  tmds_serial_blue(.clk_x10(clk_x10), .d(w_blue), .p(w_blue_p), .n(w_blue_n)); 
	
	

	always @(negedge reset)begin

		m_write <= 1'b0;
					 
		m_byteenable <= 4'b1111;
					 
		m_burstcount <= 1024;
	
	end
	
	
	
	always @(posedge clk)begin

		
		if(valid) begin
			
			
		   de <= (x < horz_pix) && (y < vert_pix);	
			
			x <= (x == (Hs - 1'b1)) ? 1'b0 : (x + 1'b1);
				
		   if(x == (Hs - 1'b1))
 			   y <= (y == (Vs - 1'b1)) ? 1'b0 : (y + 1'b1);			

						  
			if(x < horz_pix) begin	  
						  
			   {red, green, blue} <= fb[i];
					  
				i <= i + 1'b1;
									  
			end
					  
		end
		
		
		
// avalon if.		
		
		case(st)

		
// get address fb.	
		
			SS: if(s_chipselect && s_write) begin
						
					 fb_addr <= s_writedata >> 2;

					 st <= S0;
					  
				 end
		
		
		
			S0: begin
			
					 addr_off <= fb_addr;
					 
					 st <= S1;
			
				 end


				 
			S1: if(x == horz_pix) begin
					
					 m_address <= addr_off;
			
					 m_read <= 1'b1;
					
					 st <= S2;
					 
				 end	
			
			
			
			S2: if(m_waitrequest == 1'b0) begin
					
					 m_read <= 1'b0;
												 
					 st <= S3;
				 end	 
				 				 
			
			
			S3: begin
			
					if(m_readdatavalid) begin
						
					   fb[n] <= m_readdata;
												
						n <= n + 1'b1;
					end
															
										
					if(n == (horz_pix - 1)) begin
											
						n <= 0;
																								
						valid <= 1'b1;
						
		 				size <= size - horz_pix;
													 							 
						st <= S4;
						
					end
					
				 end
				 				 
				 
				 
			S4: begin
			
					if(size) begin
										 
						addr_off <= addr_off + m_burstcount;
							
						st <= S1;
// Vsync.														
					end						
					else if(y == (Vs - 1)) begin
											
							  addr_off <= fb_addr;
			
							  size <= max;								  
																
							  st <= S1;
							  
						  end					
				 end
						
								 
			default: ;
			
		endcase
		
	end
	
		
endmodule: hdmi
