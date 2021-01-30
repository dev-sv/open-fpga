
package pkg_disp;

typedef struct{

int horz_front_porch;
int horz_sync;
int horz_back_porch;
int horz_pix;

int vert_front_porch;
int vert_sync;
int vert_back_porch;
int vert_pix;

} t_sync;

endpackage

/*
 sp sync params.
 
 Diagrams sync for different resolutions
 https://www.ibm.com/support/knowledgecenter/ru/POWER8/p8egb/p8egb_supportedresolution.htm
*/
module sync(input bit clk, output bit de = 1, output bit[1:0] vh = 0, output bit [10:0] x = 0, y = 0, 
            input pkg_disp::t_sync sp);

		
	always @(posedge clk) begin
	

		de <= (x < sp.horz_pix) && (y < sp.vert_pix);	
			
		x <= (x == (sp.horz_pix + sp.horz_front_porch + sp.horz_sync + sp.horz_back_porch - 1)) ? 0 : (x + 1);		
				
		if(x == (sp.horz_pix + sp.horz_front_porch + sp.horz_sync + sp.horz_back_porch - 1))
		   y <= (y == (sp.vert_pix + sp.vert_front_porch + sp.vert_sync + sp.vert_back_porch - 1)) ? 0 : (y + 1);
			
		vh[0] <= (x >= (sp.horz_pix + sp.horz_front_porch - 1) && x < (sp.horz_pix + sp.horz_front_porch + sp.horz_sync - 1));
						
		vh[1] <= (y >= (sp.vert_pix + sp.vert_front_porch - 1) && y < (sp.vert_pix + sp.vert_front_porch + sp.vert_sync - 1));

	end
		

endmodule: sync
