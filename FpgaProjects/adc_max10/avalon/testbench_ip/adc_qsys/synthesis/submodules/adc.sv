


module adc(

				input wire clk, 
				
				input wire reset,
				
			   input wire write, 
				
				input wire read, 
				
				input wire aclk,
							 
            input wire[9:0] address,
			  
			   input wire[15:0] writedata,
			  
			   input wire[0:0] burstcount,
				
			   input wire[1:0] byteenable,
			  
			   output bit[15:0] readdata,
			  
			   output bit waitrequest,
				
				output bit readdatavalid
);


 enum { S0, S1, S2, S3 } st = S0;
 
  
 bit        soc = 1'b0;
 wire       eoc;
 wire[11:0] data;  
  
   
 
 `define TEST
  
 
 
 fiftyfivenm_adcblock_top_wrapper
 
 `ifdef TEST
 
 #( .device_partname_fivechar_prefix ("10M50"),
    .clkdiv (1),
    .tsclkdiv (0),
    .tsclksel (1),
    .refsel (0),
    .prescalar (0),
    .is_this_first_or_second_adc (1),
    .analog_input_pin_mask (65536),
    .hard_pwd (0),
    .enable_usr_sim (1),	
    .reference_voltage_sim (65536),
    .simfilename_ch0("/home/user/Projects/max10/adc_max10/avalon/testbench/sin_test/sin.txt")) 
	 
 `endif
 
 
 adc_inst(
	 
    .chsel(5'h00),               	// 5-bits channel selection.
    .soc(soc),                 		// signal Start-of-Conversion to ADC
    .eoc(eoc),                 		// signal end of conversion. Data can be latched on the positive edge of clkout_adccore after this signal becomes high.  EOC becomes low at every positive edge of the clkout_adccore signal.
    .dout(data),                		// 12-bits DOUT valid after EOC rise, still valid at falling edge, but not before the next EOC rising edge
    .usr_pwd(1'b0),             		// User Power Down during run time.  0 = Power Up;  1 = Power Down.
    .tsen(1'b0),                		// 0 = Normal Mode; 1 = Temperature Sensing Mode.
    .clkin_from_pll_c0(aclk)        // Clock source from PLL1 c-counter[0] at BL corner or PLL3 c-counter[0] at TL corne	 
 );

 	
 
  	always @(posedge clk or posedge reset)begin
	
	
		if(reset) begin
	
			readdatavalid <= 1'b0;
					
			waitrequest <= 1'b1;
	
		end
		else begin
		
		
				case(st)
		
		
					S0: begin
			
							readdatavalid <= 1'b0;
					
							waitrequest <= 1'b1;
					
							st <= S1;
						 end	

 
					S1: if(read) begin
			
							 soc <= 1'b1;	
					 
							 waitrequest <= 1'b0;
					 
							 st <= S2;		
						 end
				 
 
					S2: if(eoc)begin
						
							 readdata <= data;
						
							 readdatavalid <= 1'b1;
											
							 st <= S3;
						 end	
				 				
				
					S3: if(!eoc) begin
			
							 soc <= 1'b0;
					 			
							 st <= S0;
						 end		
					
 
					default: ;
 
				endcase
		
		end
		
	end


endmodule: adc
