

				
module hdmi_st #(
						parameter	horz_front_porch = 18,
										horz_sync = 60,
										horz_back_porch = 112,
										horz_pix = 1024,

										vert_front_porch = 18,
										vert_sync = 60,
										vert_back_porch = 112,
										vert_pix = 600
					)


				  (				 
// hdmi_st.				 
					input wire        	clk,	
					input wire        	reset,
					
					input  wire [23:0] 	data,
					output bit           ready,
					input  wire          valid,
					
// hdmi_if.					
					input  wire	clk_pix,		// 80 MHz.
					input  wire	clk_x10,		// 400 MHz.
					output wire clk_st,		
					
					output wire clk_pix_p,
					output wire clk_pix_n,
					
					output wire	red_p,
					output wire	red_n,
					
					output wire	green_p,
					output wire	green_n,
					
					output wire	blue_p,
					output wire	blue_n,
										
					output bit[10:0] x,
					output bit[10:0] y,
					output wire[10:0] horz,
					output wire[10:0] vert			
															
					);
				

				
				
 
 wire[9:0] w_red;
 wire[9:0] w_green;
 wire[9:0] w_blue;
 
 bit       de; 
 bit[1:0]  vh; 
 bit[7:0]  red;
 bit[7:0]  green;
 bit[7:0]  blue;
 
 wire		  clk_10;
 bit 		  en = 1'b0;
 	
	
	
	assign clk_10 = en ? clk_x10 : 1'b0;
		
	assign clk_pix_p = en ? clk_pix : 1'b0;
	
	assign clk_pix_n = en ? ~clk_pix : 1'b0;
	
	assign clk_st = clk_pix;
		
	assign ready = 1'b1;
	
	assign vert = vert_pix[10:0];
	assign horz = horz_pix[10:0];



	always @(negedge clk_pix) begin	

	 if(valid)
		 en <= 1'b1;
	end

	
	
	always @(posedge clk_pix_p) begin
	

		de <= (x < horz_pix) && (y < vert_pix);	
			
		x <= (x == (horz_pix + horz_front_porch + horz_sync + horz_back_porch - 1'b1)) ? 1'b0 : (x + 1'b1);
				
		if(x == (horz_pix + horz_front_porch + horz_sync + horz_back_porch - 1'b1))
		   y <= (y == (vert_pix + vert_front_porch + vert_sync + vert_back_porch - 1'b1)) ? 1'b0 : (y + 1'b1);
			
	end

	assign vh[0] = (x >= (horz_pix + horz_front_porch - 1'b1) && x < (horz_pix + horz_front_porch + horz_sync - 1'b1));
						
	assign vh[1] = (y >= (vert_pix + vert_front_porch - 1'b1) && y < (vert_pix + vert_front_porch + vert_sync - 1'b1));
	
	
	
	tmds_encoder tmds_encoder_red(.clk(clk_pix_p), .de(de), .vh(vh), .color(red), .out(w_red));
	
	tmds_serial  tmds_serial_red(.clk_x10(clk_10), .d(w_red), .p(red_p), .n(red_n)); 

	
	tmds_encoder tmds_encoder_green(.clk(clk_pix_p), .de(de), .vh(vh), .color(green), .out(w_green));
	
	tmds_serial  tmds_serial_green(.clk_x10(clk_10), .d(w_green), .p(green_p), .n(green_n)); 
	

	tmds_encoder tmds_encoder_blue(.clk(clk_pix_p), .de(de), .vh(vh), .color(blue), .out(w_blue));
	
	tmds_serial  tmds_serial_blue(.clk_x10(clk_10), .d(w_blue), .p(blue_p), .n(blue_n)); 
			
	
		
	always @(posedge clk_pix_p) begin
		
	
		if(valid)begin
							
			red <= data[7:0]; 
					 
			green <= data[15:8]; 
					 
			blue <= data[23:16]; 
					 
		end				
		
	end
	
		
endmodule: hdmi_st
