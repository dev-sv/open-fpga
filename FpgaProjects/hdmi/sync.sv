


module sync(input bit clk, output bit de = 1, output bit[1:0] vh = 0, output bit [10:0] x = 0, y = 0);


parameter horz_front_porch = 24;
parameter horz_sync = 136;
parameter horz_back_porch = 160;
parameter horz_pix = 1024;

parameter vert_front_porch = 5;//10
parameter vert_sync = 8;//50;//6;//3;		 
parameter vert_back_porch = 15;//29;//21;
parameter vert_pix = 600;

/*
parameter horz_front_porch = 60;//24
parameter horz_sync = 160;//6;
parameter horz_back_porch = 200;//170;
parameter horz_pix = 1024;

parameter vert_front_porch = 1;//
parameter vert_sync = 2;//		 
parameter vert_back_porch = 6;
parameter vert_pix = 600;
*/
/*
parameter horz_front_porch = 16;//40;//24
parameter horz_sync = 80;//128;//6;
parameter horz_back_porch = 160;//88;//170;
parameter horz_pix = 800;

parameter vert_front_porch = 1;//
parameter vert_sync = 3;//4;//		 
parameter vert_back_porch = 21;//23;
parameter vert_pix = 600;
*/
		
	always @(posedge clk) begin
	
	/*
		de <= (x < 1024) && (y < 600);	 

		x <= (x == 1343) ? 0 : (x + 1);		

		if(x == 1343)
		   y <= (y == 805) ? 0 : (y + 1);

		vh[0] <= (x >= 1048 && x < 1184);
		vh[1] <= (y >= 771 && y < 777);		
		*/

/*
		de <= (x < 640) && (y < 480);	 

		x <= (x == 799) ? 0 : (x + 1);		

		if(x == 799)
		   y <= (y == 524) ? 0 : (y + 1);

		vh[0] <= (x >= 656 && x < 752);
		vh[1] <= (y >= 490 && y < 492);		
	
*/
			
		de <= (x < horz_pix) && (y < vert_pix);	
			
		x <= (x == (horz_pix + horz_front_porch + horz_sync + horz_back_porch - 1)) ? 0 : (x + 1);		
				
		if(x == (horz_pix + horz_front_porch + horz_sync + horz_back_porch - 1))
		   y <= (y == (vert_pix + vert_front_porch + vert_sync + vert_back_porch - 1)) ? 0 : (y + 1);
			
		vh[0] <= (x >= (horz_pix + horz_front_porch - 1) && x < (horz_pix + horz_front_porch + horz_sync - 1));
						
		vh[1] <= (y >= (vert_pix + vert_front_porch - 1) && y < (vert_pix + vert_front_porch + vert_sync - 1));
		
	end
		

endmodule: sync
