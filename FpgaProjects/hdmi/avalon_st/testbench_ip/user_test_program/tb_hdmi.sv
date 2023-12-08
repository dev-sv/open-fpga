


`timescale 1ns / 1ps


`define SRC 		tb.hdmi_qsys_inst_st_in_bfm
`define RST 		tb.hdmi_qsys_inst_reset_bfm
`define HDMI 		tb.hdmi_qsys_inst_hdmi_bfm




module tb_hdmi();



 hdmi_st prm();

`define Np	(prm.horz_pix * prm.vert_pix)	// 1024x600.

`define Hsync (prm.horz_front_porch + prm.horz_sync + prm.horz_back_porch)
  
 wire ready_red;
 wire ready_green;
 wire ready_blue;

 bit[7:0] red_in  [`Np];
 bit[7:0] green_in[`Np];
 bit[7:0] blue_in [`Np];
 
 bit[7:0]  red_out  [`Np];
 bit[7:0]  green_out[`Np];
 bit[7:0]  blue_out [`Np];
  
 bit[23:0] data;
 
 
 
	
 initial begin

 
	int n = 0;
 
	`SRC.set_response_timeout(100);
 
	`SRC.init();	
	 
	wait(`RST.reset == 0);	 	
	
	
	for(int j = 0; j < prm.vert_pix; j++) begin
	
			
		data = 0;
	
		for(int i = 0; i < (prm.horz_pix + `Hsync); i++) begin
	

			`SRC.set_transaction_channel(0);
			`SRC.set_transaction_idles(0);
			`SRC.set_transaction_error(0);
			`SRC.set_transaction_empty(0);
			`SRC.set_transaction_sop(0);
			`SRC.set_transaction_eop(0);
	
			`SRC.set_transaction_data(data);
	
			`SRC.push_transaction();
		
	
			wait(`SRC.get_transaction_queue_size());
		

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
	
	$display("\nTestbench hdmi.\n");	
	
	
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
											  .clk_pix(`HDMI.sig_clk_pix_p),
											  .in_buff(`HDMI.sig_red_p),
											  .out_buff(red_out),
											  .ready(ready_red)
											);
 

 tmds_rx		#(.N(`Np))tmds_rx_green(
												 .clk_pix(`HDMI.sig_clk_pix_p),
												 .in_buff(`HDMI.sig_green_p),
												 .out_buff(green_out),
												 .ready(ready_green)
											  );
 
 
 tmds_rx		#(.N(`Np))tmds_rx_blue (
												 .clk_pix(`HDMI.sig_clk_pix_p),										
												 .in_buff(`HDMI.sig_blue_p),							
												 .out_buff(blue_out),
												 .ready(ready_blue)
											  );
											
	
endmodule
