


module tmds_serial(input bit clk_x10, input bit[9:0] d, output bit p, n); 


 bit[3:0] i = 0;
					
   ddio	ddio_inst(.outclock(clk_x10), .datain_h(d[i]), .datain_l(d[i + 1]), .dataout(p));
	
   ddio	ddio_inst_inv(.outclock(clk_x10), .datain_h(~d[i]), .datain_l(~d[i + 1]), .dataout(n));
	

	always @(posedge clk_x10)

		i <= i[3] ? 4'h0 : (i + 4'h2);
		

endmodule: tmds_serial
