


module max10_rpi(

					input wire 			clk, 
															  
					input wire        read,
					
					input wire        soc,
					
					output wire       ready,
					
					output wire[11:0] data,
					
					output wire[7:0]  led
);

 
 enum { RST, S0, S1, S2, S3 }   st = RST;

 enum { SRP0, SRP1, SRP2, ERR } st_rpi = SRP0;
 
 wire	rst; 
 wire w_clk;
 wire	w_aclk;

 bit 			adc_read = 1'b0;
 wire[15:0] w_adc_readdata;
 wire       w_adc_readdatavalid;
 
 bit[9:0]  j = 0;
 bit[9:0]  i = 0;
 bit	     read_sync; 
 bit[11:0] rd_data[1024];
 
 bit[7:0] err = 8'h00;


	pll	pll_inst(.inclk0(clk), .c0(w_clk), .c1(w_aclk), .locked(rst));
 
 
	avl_if avl_inst (
		
		.clk_clk(w_clk),		
		.reset_reset_n(rst),
		.aclk_aclk(w_aclk),
				
		.adc_readdata(w_adc_readdata),
		.adc_readdatavalid(w_adc_readdatavalid),
		.adc_burstcount(1'b1),
		.adc_writedata(),
		.adc_address(10'h000),
		.adc_write(1'b0),
		.adc_read(adc_read),
		.adc_byteenable(2'b11)
				
	);
 
 
 
// get adc data. 
 
  	always @(posedge w_clk)begin
		
		
		case(st)
		
		
			RST: if(rst) begin
			
					  ready <= 1'b0;	
					  
					  st <= S0;
				  end 	  
			        
					  
 			S0:  if(soc)			
					  st <= S1;  
							
				 
 			S1:  begin
																	
					adc_read <= 1'b1;
										
					st <= S2;
				  end
				 
												
			S2:  if(w_adc_readdatavalid) begin
			
					  adc_read <= 1'b0;	
						
					  rd_data[i] <= w_adc_readdata[11:0];
						
					  i <= i + 1'b1;
					
				     ready <= 1'b1;	
						
					  st <= S3;
						
				  end

				  
			S3:  if(!w_adc_readdatavalid)
					  st <= S0;
							
				 
			default: ;

		endcase
				
				
		if(ready && !read)
		   ready <= 1'b0;
 end


 
// rpi read data.
 
 always @(posedge w_clk)begin   	

 
		read_sync <= read;
       

		case(st_rpi)
	
	
			SRP0: if(rst) begin
						
					  j <= 0;	
					  
			        st_rpi <= SRP1;
				   end	
	
	
		  SRP1:  if(read_sync) begin
		  
						data <= rd_data[j];
						
					   st_rpi <= SRP2;
					end	
				  
				 
	
		  SRP2: if(!read_sync) begin
		  
		  
// set test in adc.sv file.

					  `ifdef HW_TEST
					  
							if(j != data) begin
					  
								err <= 8'h81;
								st_rpi <= ERR;  
							end
							else begin
							
						`endif	
					  
									j <= j + 1'b1;
											  
									st_rpi <= SRP1;
							
						`ifdef HW_TEST
						
							end
							
						`endif	
					  
				  end
				  				 				
				
		  default: led <= err;
	
		endcase
 
 end
 
 	
endmodule: max10_rpi
