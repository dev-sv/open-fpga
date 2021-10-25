


module tmds_serial(input bit clk_x10, input logic[9:0] d, hdmi_if.pair pair); 


 bit[3:0] i = 0;
					

	ddio	ddio_inst(.outclock(clk_x10), .din({d[i + 1], d[i]}), .pad_out(pair.p));
	ddio	ddio_inst_inv(.outclock(clk_x10), .din({~d[i + 1], ~d[i]}), .pad_out(pair.n));


	always @(posedge clk_x10)

		i <= i[3] ? 4'h0 : (i + 4'h2);
		

endmodule: tmds_serial
