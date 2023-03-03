


`timescale 1 ns / 1 ps


module tb_adc;


 enum { RD0, RD1, RD2 } st = RD0;


 bit clk = 0,
     adc_clk = 0, 
     read = 1'b0;
							 
 bit[0:0] address;
			  			  			  
 wire[15:0] readdata;
		  
 wire readdatavalid;

		
		
 initial
	forever #5 clk = ~clk;

 initial
	forever #250 adc_clk = ~adc_clk;
	
	

 adc adc_dut(
 
   .clk(clk), 
	.adc_clk(adc_clk),
   .reset(1'b1),
   .write(1'b0), 
	.read(read), 
   .address(address),
   .burstcount(1'b1),			  
	.readdata(readdata),	  
	.readdatavalid(readdatavalid)
);





 	always @(posedge clk)begin
	
		
		case(st)

 
 			RD0: begin
							
					address <= 0;
											
					read <= 1'b1;
										
					st <= RD1;											
				  end
						
												
	
			RD1: if(readdatavalid) begin
			
					  read <= 1'b0;	
												  
					  $display("data_out = %u", readdata);
					  
					  st <= RD2;
																						
				  end
				  
						
			RD2: if(!readdatavalid) begin
			
					  st <= RD0;	
			
				  end
						
						
			default: ;
						
	
		endcase
 
	end


endmodule: tb_adc
