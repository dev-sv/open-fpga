



module ls(input bit osc, hdmi_if.pair clk_p, hdmi_if.pair red_p, hdmi_if.pair green_p, hdmi_if.pair blue_p,
			 input bit ec0_sw, ec0_dt, ec0_clk, ec1_sw, ec1_dt, ec1_clk, ec2_sw, ec2_dt, ec2_clk, input bit[3:0]in);


			 
wire	w_osc, 
      w_smp, 
		w_pix, 
      w_clk_x10, 
		w_clk_pix;

		
wire[10:0] w_x, w_y;
			
wire[14:0] w_smp_mux;	
		 			 
wire[9:0] w_scan_n,
          w_sync_data[4];

wire		 w_clk_smp,
          w_ch[4][960];
				 
bit[3:0]  in_tmp, 
          sync_in;		
			 
bit       en_ch[4]; 


			 
// Interfaces.

ls_if emi();

ls_if ec_curs();      

ls_if ec_scan();

ls_if ec_sync();


import pkg_encoder::e_param;

e_param curs_param = '{

 ini:4, max:950, min:0, step:1
};


e_param scan_param = '{

 ini:8, max:87, min:1, step:1
};


e_param sync_param = '{

 ini:960, max:960, min:800, step:1
};


import pkg_wave::w_param;


w_param w0_param = '{

 curs_color:'{8'h00, 8'h9f, 8'hff},  
 wave_color:'{8'hff, 8'hd7, 8'h00},
 zero_coord_color:'{8'haa, 8'haa, 8'haa},  

 y_min:80 , y_max:150, y0:64, y1:190
};			 
			 

w_param w1_param = '{

 curs_color:'{8'h00, 8'h9f, 8'hff},  
 wave_color:'{8'hff, 8'hd7, 8'h00},
 zero_coord_color:'{8'haa, 8'haa, 8'haa},  

 y_min:190 , y_max:260, y0:190, y1:261
};			 
			 

w_param w2_param = '{

 curs_color:'{8'h00, 8'h9f, 8'hff},  
 wave_color:'{8'hff, 8'hd7, 8'h00},
 zero_coord_color:'{8'haa, 8'haa, 8'haa},  

 y_min:300 , y_max:370, y0:261, y1:371
};			 


w_param w3_param = '{

 curs_color:'{8'h00, 8'h9f, 8'hff},  
 wave_color:'{8'hff, 8'hd7, 8'h00},
 zero_coord_color:'{8'haa, 8'haa, 8'haa},  

 y_min:410 , y_max:480, y0:371, y1:511
};			 
			 
			 
				
   buf buf_pix(w_clk_pix, w_pix);
			
	assign w_clk_smp = (w_scan_n == 0) ? w_smp : w_smp_mux[w_scan_n - 1];

	counter_smp counter_smp_inst(.clock(w_smp), .q(w_smp_mux)); 
		
	pll_hdmi	pll_hdmi_inst(.inclk0(osc), .c0(w_clk_x10), .c1(w_pix), .c2(w_smp));
	
	
	hdmi hdmi_inst(.clk_x10(w_clk_x10), .clk_pix(w_clk_pix), .red(emi.dd.red), .green(emi.dd.green), .blue(emi.dd.blue),
	               .red_p(red_p), .green_p(green_p), .blue_p(blue_p), .clk_p(clk_p), .x(w_x), .y(w_y)); 

			 	
   debouncer debouncer_clk0(.clk(w_clk_pix), .in(ec0_clk), .delay(50000), .out(ec_curs.clk));	
   debouncer debouncer_dt0 (.clk(w_clk_pix), .in(ec0_dt), .delay(50000), .out(ec_curs.dt));	
   debouncer debouncer_sw0 (.clk(w_clk_pix), .in(ec0_sw), .delay(2000000), .out(emi.dd.curs_set_btn));	

   debouncer debouncer_clk1(.clk(w_clk_pix), .in(ec1_clk), .delay(50000), .out(ec_scan.clk));
   debouncer debouncer_dt1(.clk(w_clk_pix), .in(ec1_dt), .delay(50000), .out(ec_scan.dt));
   //debouncer debouncer_sw1 (.clk(w_clk_pix), .in(ec1_sw), .delay(2000000), .out());	
	
   debouncer debouncer_clk2(.clk(w_clk_pix), .in(ec2_clk), .delay(50000), .out(ec_sync.clk));
   debouncer debouncer_dt2(.clk(w_clk_pix), .in(ec2_dt), .delay(50000), .out(ec_sync.dt));	
   debouncer debouncer_sw2(.clk(w_clk_pix), .in(ec2_sw), .delay(2000000), .out(emi.dd.sel_ch_btn));	
	

	
	wave wave_0(.clk_pix(w_clk_pix), .x(w_x), .y(w_y), .p(w0_param), .scan_data(emi.dd.scan_data),
	
 	            .curs_data(emi.dd.curs_data + 64), .set_curs(emi.dd.set_curs), .np(w_sync_data[0]), .ch(w_ch[0]), 
					
					.red(emi.dd.r_wave[0]), .green(emi.dd.g_wave[0]), .blue(emi.dd.b_wave[0]), .s(emi.dd.s_wave[0]), .sel_ch(emi.dd.sel_channel[0]));
	

	wave wave_1(.clk_pix(w_clk_pix), .x(w_x), .y(w_y), .p(w1_param), .scan_data(emi.dd.scan_data), 
	
	            .curs_data(emi.dd.curs_data + 64), .set_curs(emi.dd.set_curs), .np(w_sync_data[1]), .ch(w_ch[1]), 
					
					.red(emi.dd.r_wave[1]), .green(emi.dd.g_wave[1]), .blue(emi.dd.b_wave[1]), .s(emi.dd.s_wave[1]), .sel_ch(emi.dd.sel_channel[1]));


	wave wave_2(.clk_pix(w_clk_pix), .x(w_x), .y(w_y), .p(w2_param), .scan_data(emi.dd.scan_data), 
	
	            .curs_data(emi.dd.curs_data + 64), .set_curs(emi.dd.set_curs), .np(w_sync_data[2]), .ch(w_ch[2]), 
					
					.red(emi.dd.r_wave[2]), .green(emi.dd.g_wave[2]), .blue(emi.dd.b_wave[2]), .s(emi.dd.s_wave[2]), .sel_ch(emi.dd.sel_channel[2]));
					  

	wave wave_3(.clk_pix(w_clk_pix), .x(w_x), .y(w_y), .p(w3_param), .scan_data(emi.dd.scan_data), 
	
	            .curs_data(emi.dd.curs_data + 64), .set_curs(emi.dd.set_curs), .np(w_sync_data[3]), .ch(w_ch[3]), 
					
					.red(emi.dd.r_wave[3]), .green(emi.dd.g_wave[3]), .blue(emi.dd.b_wave[3]), .s(emi.dd.s_wave[3]), .sel_ch(emi.dd.sel_channel[3]));
	

	
	always_ff @(posedge w_clk_smp) begin	
	
		in_tmp <= in;		
		sync_in <= in_tmp;	
	end
		
	
	channel channel_0(.clk(w_clk_smp), .in(sync_in[0]), .n(w_scan_n), .np(w_sync_data[0]), .ch(w_ch[0]), .sel_ch(emi.dd.sel_channel[0]));	
	channel channel_1(.clk(w_clk_smp), .in(sync_in[1]), .n(w_scan_n), .np(w_sync_data[1]), .ch(w_ch[1]), .sel_ch(emi.dd.sel_channel[1]));	
	channel channel_2(.clk(w_clk_smp), .in(sync_in[2]), .n(w_scan_n), .np(w_sync_data[2]), .ch(w_ch[2]), .sel_ch(emi.dd.sel_channel[2]));
	channel channel_3(.clk(w_clk_smp), .in(sync_in[3]), .n(w_scan_n), .np(w_sync_data[3]), .ch(w_ch[3]), .sel_ch(emi.dd.sel_channel[3]));
	
	
   assign w_scan_n = emi.dd.scan_data < 8 ? (8 - emi.dd.scan_data) : 0;

	encoder encoder_scan(.clk(w_clk_pix), .en(1), .e(ec_scan.e_in), .p(scan_param), .data(emi.dd.scan_data));
 
	encoder encoder_curs(.clk(w_clk_pix), .en(1), .e(ec_curs.e_in), .p(curs_param), .data(emi.dd.curs_data));

	assign en_ch[0] = emi.dd.sel_channel[0];
	assign en_ch[1] = emi.dd.sel_channel[1];
	assign en_ch[2] = emi.dd.sel_channel[2];
	assign en_ch[3] = emi.dd.sel_channel[3];
	  
	encoder encoder_sync[4](.clk(w_clk_pix), .en(en_ch), .e(ec_sync.e_in), .p(sync_param), .data(w_sync_data));


	display_data display_data_inst(.clk(w_clk_pix), .x(w_x), .y(w_y), .emi(emi));
		

endmodule: ls


