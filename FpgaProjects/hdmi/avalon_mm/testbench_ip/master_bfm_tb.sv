


`timescale 1ns / 1ps


module master_bfm_tb();


 import avalon_mm_pkg::*;
 
  
 hdmi_mm prm();

`define Np	(prm.horz_pix * prm.vert_pix)	// 1024x600.

`define Hsync (prm.horz_front_porch + prm.horz_sync + prm.horz_back_porch)
 
  
`define MSTR_BFM tb.master_bfm
`define HDMI 	  tb.hdmi_mm
  
 
 bit  clk = 1'b0;
 bit  rst = 1'b0;
 bit  clk_x10 = 1'b0;
 
 bit[0:0]  bc = 1'b1;
 bit[9:0]  addr = 0;
 bit[31:0] data;
 
 wire ready_red;
 wire ready_green;
 wire ready_blue; 
 
 bit[7:0] red_in  [`Np];
 bit[7:0] green_in[`Np];
 bit[7:0] blue_in [`Np]; 
 
 bit[7:0] red_out  [`Np];
 bit[7:0] green_out[`Np];
 bit[7:0] blue_out [`Np];
 
     
  
  
	hdmi_qsys tb(
	
			.clk_clk(clk),
			.clk_x10_clk(clk_x10),
			.reset_reset_n(rst)
	);
  
  
	
// 80 Mhz.	
initial
	forever #6.25 clk = ~clk;

// 400 MHz.	
initial
	forever #1.25 clk_x10 = ~clk_x10;
	

initial
	#50 rst = 1'b1;

			


 initial begin
 
 
	int n = 0;
 
  	
	`MSTR_BFM.set_command_timeout(100);
	
	
//initialize the master BFM
	`MSTR_BFM.init();		 
	
	wait(`MSTR_BFM.reset == 0);
	 
	$display("\nTestbench hdmi.\n");
	
	
	for(int j = 0; j < prm.vert_pix; j++) begin
	
		data = 0;
	
		for(int i = 0; i < (prm.horz_pix + `Hsync); i++) begin
		

			`MSTR_BFM.set_command_request(REQ_WRITE);
			`MSTR_BFM.set_command_address(addr);    
			`MSTR_BFM.set_command_byte_enable(2'b1111, 0);
			`MSTR_BFM.set_command_burst_count(bc);
			`MSTR_BFM.set_command_burst_size(bc);
			`MSTR_BFM.set_command_idle(0, 0);
			`MSTR_BFM.set_command_init_latency(0);

			`MSTR_BFM.set_command_data(data, 0);	

			`MSTR_BFM.push_command();

			wait(`MSTR_BFM.get_response_queue_size() == 0);
		
		
			if(i < prm.horz_pix) begin
		
				red_in[n] = data[7:0]++;
		
				green_in[n] = data[15:8]++;
		
				blue_in[n] = data[23:16]++;
			
				n++;
			
			end
		
		end
	
	end
	
	
 end

 
 
 initial begin

  
	string str;
   int    err = 0;
	

	wait(ready_red && ready_green && ready_blue);
		
	
	for(int i = 0; i < `Np; i++) begin
	
		
		 str = "pass";
		
		 if( (red_in[i] != red_out[i])	  ||	
		     (green_in[i] != green_out[i]) ||
			  (blue_in[i] != blue_out[i]) ) begin
		 
			 err++;
			 
			 str = "error";
		 end
		 
		 $display("%d   red_in = %.3h red_out = %.3h    green_in = %.3h green_out = %.3h    blue_in = %.3h blue_out = %.3h %s"
					 , i, red_in[i], red_out[i], green_in[i], green_out[i],  blue_in[i], blue_out[i], str);
					 
	end
		
	$display("\n errors:%.6d   passes:%.6d", err, `Np);
 
 end
 
 
 
 
 tmds_rx		#(.N(`Np))tmds_rx_red(
											  .clk_pix(`HDMI.clk_pix_p),
											  .in_buff(`HDMI.red_p),
											  .out_buff(red_out),
											  .ready(ready_red)
											);
 
 
 tmds_rx		#(.N(`Np))tmds_rx_green(
												 .clk_pix(`HDMI.clk_pix_p),
												 .in_buff(`HDMI.green_p),
												 .out_buff(green_out),
												 .ready(ready_green)
											  );
 
 
 tmds_rx		#(.N(`Np))tmds_rx_blue (
												 .clk_pix(`HDMI.clk_pix_p),
												 .in_buff(`HDMI.blue_p),						
												 .out_buff(blue_out),
												 .ready(ready_blue)
											  );
   
  		  
endmodule
