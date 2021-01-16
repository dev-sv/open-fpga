


module spi #(parameter Ni = 1, parameter No = 1, parameter mode = 0)(input bit clk, miso, en, 
                                                                     input logic[(Ni << 3) - 1:0] in_data, 
                                                                     output bit sclk, ss, mosi, 
																							output logic[(No << 3) - 1:0] out_data,
				                                                         input bit [31:0] nwr, 
																							input bit [31:0] nrd);


enum {START, PH0, PH1, STOP} state = STOP;

bit[31:0]  i = 0, j = 0;

logic[(No << 3) - 1:0] tmp = 0;


initial
begin

 ss = 1;
 sclk = (mode == 0 || mode == 1) ? 1'b0 : 1'b1;
 out_data = 0;

end


		always @(posedge clk) begin
		
		
			case(state)
			
			
				START: begin
				
							ss <= 0;							
							tmp <= 0;
							state <= (!mode || mode == 2) ? PH1 : PH0;							
						 end

				  PH0: begin
			
				          sclk <= (!mode || mode == 3) ? 1'b0 : 1'b1;
							 
							 state <= PH1;
						  end
						 
				  PH1: begin
					
				         sclk <= (!mode || mode == 3) ? 1'b1 : 1'b0;

							state <= PH0;
							
							if(i) begin
							
							   --i;
							   mosi <= (in_data >> i);
								
							end
						   else begin
							
					             if(j && nrd) begin
									 
							          --j;									  
  							          tmp <= (tmp | (miso << j));
									 end
									 else begin
									 
									        if(nwr)
											     i <= nwr << 3;
											  
									        sclk <= (!mode || mode == 1) ? 1'b0 : 1'b1;
									        state <= STOP;
									 end		  
							end		
		
                   end 	
						 
				
				 STOP: begin
														
							ss <= 1;
							i <= nwr << 3;
							j <= nrd << 3;
							
							if(en)	
								state <= START;	
			
						   out_data <= tmp;	
				       end						 
					  
				default: ;
						
			endcase
				
		end

endmodule: spi
