


module tmds_serial(input bit clk_x10, input logic[9:0] d, output bit p, n); 

 bit[3:0] i = 0;
			
	ddio	ddio_inst(.outclock(clk_x10), .datain_h(d[i]), .datain_l(d[i + 1]), .dataout(p));
	ddio	ddio_inst_inv(.outclock(clk_x10), .datain_h(~d[i]), .datain_l(~d[i + 1]), .dataout(n));
			
	always @(posedge clk_x10) begin

			i <= i[3] ? 0 : (i + 2);
		
	end
	
endmodule: tmds_serial
