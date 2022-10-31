

module sync(input bit clk, hdmi_if.s_de_vh s, input pkg_disp::t_sync sp, input bit [10:0] x, y);


	always @(posedge clk) begin
	
		s.de <= (x < sp.horz_pix) && (y < sp.vert_pix);
		
	end

	assign s.vh[0] = (x >= (sp.horz_pix + sp.horz_front_porch - 1'b1) && x < (sp.horz_pix + sp.horz_front_porch + sp.horz_sync - 1'b1));

	assign s.vh[1] = (y >= (sp.vert_pix + sp.vert_front_porch - 1'b1) && y < (sp.vert_pix + sp.vert_front_porch + sp.vert_sync - 1'b1));

endmodule: sync



