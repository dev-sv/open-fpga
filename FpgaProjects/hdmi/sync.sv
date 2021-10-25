

module sync(input bit clk, hdmi_if.s_de_vh s, input pkg_disp::t_sync sp, output bit [10:0] x, y);
		
		
	always @(posedge clk) begin
	

		s.de <= (x < sp.horz_pix) && (y < sp.vert_pix);	
			
		x <= (x == (sp.horz_pix + sp.horz_front_porch + sp.horz_sync + sp.horz_back_porch - 1'b1)) ? 1'b0 : (x + 1'b1);
				
		if(x == (sp.horz_pix + sp.horz_front_porch + sp.horz_sync + sp.horz_back_porch - 1'b1))
		   y <= (y == (sp.vert_pix + sp.vert_front_porch + sp.vert_sync + sp.vert_back_porch - 1'b1)) ? 1'b0 : (y + 1'b1);
			
	end

	assign s.vh[0] = (x >= (sp.horz_pix + sp.horz_front_porch - 1'b1) && x < (sp.horz_pix + sp.horz_front_porch + sp.horz_sync - 1'b1));
						
	assign s.vh[1] = (y >= (sp.vert_pix + sp.vert_front_porch - 1'b1) && y < (sp.vert_pix + sp.vert_front_porch + sp.vert_sync - 1'b1));

endmodule: sync



