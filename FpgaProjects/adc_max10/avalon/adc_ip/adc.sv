


module adc(
           input  bit clk, 
			             reset,
			             write, 
							 read, 
							 adc_clk,
							 
           input  bit[9:0] address,
			  
			  input  bit[15:0] writedata,
			  
			  input  bit[0:0] burstcount,
			  
			  output bit[15:0] readdata,
			  
			  output bit waitrequest,
							 readdatavalid
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
    .simfilename_ch0("/home/user/Projects/ip/adc_max10/avalon/testbench/sin_test/sin.txt")) 
	 
 `endif
 
	  adc_inst(
 
	 
    .chsel(5'h00),               	// 5-bits channel selection.
    .soc(soc),                 		// signal Start-of-Conversion to ADC
    .eoc(eoc),                 		// signal end of conversion. Data can be latched on the positive edge of clkout_adccore after this signal becomes high.  EOC becomes low at every positive edge of the clkout_adccore signal.
    .dout(data),                		// 12-bits DOUT valid after EOC rise, still valid at falling edge, but not before the next EOC rising edge
    .usr_pwd(1'b0),             		// User Power Down during run time.  0 = Power Up;  1 = Power Down.
    .tsen(1'b0),                		// 0 = Normal Mode; 1 = Temperature Sensing Mode.
    .clkin_from_pll_c0(adc_clk)   // Clock source from PLL1 c-counter[0] at BL corner or PLL3 c-counter[0] at TL corne	 
 );


 
  	always @(posedge clk)begin
	
		
		case(st)

 
			S0: if(read) begin
			
					 soc <= 1'b1;	
					 st <= S1;		
				 end
				 
 
			S1: if(eoc)begin
			
					readdata <= data;
					readdatavalid <= 1'b1;
					st <= S2;
				 end
 
 
			S2: if(!read)begin
			
			       soc <= 1'b0;
					 readdatavalid <= 1'b0;
					 st <= S3;
				 end 
				
				
			S3: if(!eoc)
					st <= S0;
					
 
			default: ;
 
		endcase
		
	end


endmodule: adc
