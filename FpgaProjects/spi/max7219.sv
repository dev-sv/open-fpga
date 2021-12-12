


module max7219(spi_if.spi spi, input bit clk, input bit[7:0] max_data, input bit[15:0] addr_data);


`define BLANK	5'b10000

`define N      11


enum {S0, S1} st = S0;

enum bit[3:0] {DEC = 4'h9,  INTENS = 4'ha, 
               SCAN = 4'hb, SHUT = 4'hc, TEST = 4'hf} ini;
					
		
const bit[31:0] LOCK_TRANS = 0;
		
int unsigned    i = 0, max = `N, count = 0;		

bit[3:0] addr[`N] = '{1, 2, 3, 4, 5, 6, 7, 8, SHUT, SCAN, INTENS};

bit[15:0] val[`N] = '{`BLANK, `BLANK, `BLANK, `BLANK, 
                     `BLANK, `BLANK, `BLANK, `BLANK,
						    1, 7, 1};
								
bit[15:0] spi_data,
          out_data;
bit[31:0] nb_wr = 0;



		
	spi	#(.NByte(2)) spi_inst(._if(spi), .clk(clk), .in_data(spi_data), .out_data(out_data), .nb_wr(nb_wr), .nb_rd(0), 
	                            .mode(1));
		
		
	
		
	always @(posedge clk) begin
	
	
	
		unique case(st)
		
		
			S0: if(spi.ss) begin
						
					 if(i < max) begin
			
			          nb_wr <= 2;
			          spi_data <= seven_seg(addr[i], val[i]);
				       ++i;
						 st <= S1;

					 end	
			       else begin
			
			
					       if(count < 1000000)					 
					          ++count;					 
						 
					       else begin
			
									  count <= 0;
			
							        i <= 0;
							        max <= 6;
					 
							        addr[0] = 1;
							        val[0] = (max_data & 8'h0F);
	
							        addr[1] = 2;
							        val[1] = (max_data & 8'hF0) >> 4;					 					 
					 
							        addr[2] = 5;
							        val[2] = (addr_data & 16'h000F);					 
					 
							        addr[3] = 6;
							        val[3] = (addr_data & 16'h00F0) >> 4;					 
					 
							        addr[4] = 7;
							        val[4] = (addr_data & 16'h0F00) >> 8;					 
					 
  							        addr[5] = 8;
							        val[5] = (addr_data & 16'hF000) >> 12;			 
					       end
					 
					 end
					
				 end
				
				
			S1: if(!spi.ss) begin
					
					 nb_wr <= LOCK_TRANS;
					 st <= S0;
					
				 end
			    				 		
		endcase
				
	end
	
	

 function automatic [15:0] seven_seg(input[3:0] addr, input[4:0] val);

   reg [15:0] tmp = 0;
	
	if(addr && addr < 9) begin

		case(val)
						
			0: tmp = 7'b1111110;
			1: tmp = 7'b0110000;
			2: tmp = 7'b1101101;
			3: tmp = 7'b1111001;
			4: tmp = 7'b0110011;
			5: tmp = 7'b1011011;
			6: tmp = 7'b1011111;
			7: tmp = 7'b1110000;
			8: tmp = 7'b1111111;
			9: tmp = 7'b1111011;
		  10: tmp = 7'b1110111;
		  11: tmp = 7'b0011111;
		  12: tmp = 7'b1001110;
		  13: tmp = 7'b0111101;
		  14: tmp = 7'b1001111;
		  15: tmp = 7'b1000111;
		
			default: tmp = 7'b0000000;
						  
		endcase 
	
      tmp = tmp | (addr << 8);	
	
	end
	else tmp = (addr << 8) | val;
	
	
	seven_seg = tmp;
	
 endfunction 

	
endmodule: max7219
