


module hdmi_test(	
						input wire osc,

						output wire clk_pix_p,
						output wire clk_pix_n,
					
						output wire	red_p,
						output wire	red_n,
					
						output wire	green_p,
						output wire	green_n,
					
						output wire	blue_p,
						output wire	blue_n

					 );
					 

`define N   8
					 
 wire[10:0] x;				 
 wire[10:0] y;					 
 wire[10:0] vert;
 wire[10:0] horz;
 wire       clk_mm;
 
 bit        write = 1'b0;
 bit[9:0]	address = 0;
 bit[31:0]  data;
 wire       waitrequest;


 
 bit[2:0]     i = 0;
 bit[16:0] 	  max;
 int unsigned cnt = 0;
 
 
 bit[7:0]rgb[`N][3] = '{ '{8'h00, 8'h00, 8'h00}, '{8'hFF, 8'h00, 8'h00}, '{8'h00, 8'hFF, 8'h00}, 
                         '{8'hFF, 8'hFF, 8'h00}, '{8'h00, 8'h00, 8'hFF}, '{8'hFF, 8'h00, 8'hFF},	
								 '{8'h00, 8'hFF, 8'hFF}, '{8'hFF, 8'hFF, 8'hFF} };
 
 
	
	assign max = (horz * (vert/`N)) - 1'b1;
 
 
	hw_qsys hw_qsys_inst(
	
	
		.clk_clk(osc),		
		.reset_reset_n(1'b1),

// hdmi_if.		
  	   .hdmi_clk_mm(clk_mm),
		.hdmi_clk_pix_n(clk_pix_n),
		.hdmi_clk_pix_p(clk_pix_p),
		.hdmi_blue_n(blue_n),
		.hdmi_blue_p(blue_p),
		.hdmi_green_n(green_n),
		.hdmi_green_p(green_p),
		.hdmi_red_n(red_n),
		.hdmi_red_p(red_p),
		
		.hdmi_x(x),
		.hdmi_y(y),
		.hdmi_vert(vert),
		.hdmi_horz(horz),
		
// avalon_if.
		.slave_read(1'b0),
		.slave_write(write),
		.slave_address(address),
		.slave_writedata(data),
		.slave_burstcount(1),
		.slave_byteenable(4'b1111),
		.slave_waitrequest(waitrequest)
	);

	
	
	
	always @(posedge clk_mm) begin
			
			
				
		if((x < horz) && (y < vert))  begin
		
			if(!waitrequest) begin
		
				data[7:0] <= rgb[i][0];	
					 
				data[15:8] <= rgb[i][1];	
					 
				data[23:16] <= rgb[i][2];	
					
				write <= 1'b1;		
					
					
			if(cnt < max)														
				cnt <= cnt + 1'b1;
						
			else begin
								
					i <= i + 1'b1;
							
					cnt <= 0;
			end
					
					
			end
			
		end
		else write <= 1'b0;
							
	end


endmodule: hdmi_test
