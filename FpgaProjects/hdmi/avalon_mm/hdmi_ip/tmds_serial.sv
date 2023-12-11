


module tmds_serial(input wire clk_x10, input wire[9:0] d, output wire p, n); 


 bit[3:0] i = 0;					
 bit[9:0] s, sd;
 
 
	ddio	ddio_inst(.outclock(clk_x10), .din({sd[i+1], sd[i]}), .pad_out(p));
	
	ddio	ddio_inst_inv(.outclock(clk_x10), .din({~sd[i+1], ~sd[i]}), .pad_out(n));
	
	
	always @(posedge clk_x10) begin
	
		s <= d;
		sd <= s;
		
		i <= i[3] ? 4'h0 : (i + 4'h2);
	end	
	
endmodule: tmds_serial
