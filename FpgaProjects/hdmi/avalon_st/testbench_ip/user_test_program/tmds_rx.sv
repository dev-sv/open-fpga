

`timescale 1ns / 1ps

/*
	N points/row.
	
*/
module tmds_rx#(parameter N = 1024)(
								
						input wire 		 clk_pix,								
						input wire 		 in_buff,							
						output bit[7:0] out_buff[N],														
						output bit 		 ready
					);
							
							

 hdmi_st prm();

`define Hsync (prm.horz_front_porch + prm.horz_sync + prm.horz_back_porch)

`define MAX (N + ( (1 + ((N/prm.horz_pix) - 1) ) * `Hsync))
 
 bit clk = 1'b0;
 
 bit[9:0] buff[`MAX];
   
 int unsigned i = 0;
 int unsigned j = 0;
 int unsigned n = 0;
 int unsigned m = 0;

 enum { S0, S1, S2, S3, S4 } st = S0;

 
 
// 800 MHz. 
 initial
	forever #0.625 clk = ~clk;
	
	
	
	assign sclk = clk;
		

	always @(posedge clk) begin
		
		
		case(st)
				  
				  
			S0: if(clk_pix)					 
					 st <= S1;
				 
					 
			S1: if(!clk_pix)			
					 st <= S2;
					 
				  
			S2: begin
						

					if(j < `MAX) begin
					
						if(i < 10) begin
												
							buff[j][i] <= in_buff;
				
							i <= i + 1'b1;
						
							if(i == 9) begin
						
								i <= 0;
							
								j <= j + 1'b1;
							end  
							
						end
					 
					end
					else begin
					
							j <= 0;
							
							st <= S3;
					end			
					
				end	
			
		
			S3: begin	
			
// sync code.	
					
					if( (buff[i] == 10'b0010101011) ||
						 (buff[i] == 10'b1101010100) ||
                   (buff[i] == 10'b0010101010) || 
						 (buff[i] == 10'b1101010101) ) begin
						 
						  i <= i + 1'b1;						  
				   end
				   else begin			
												
							if(buff[i][9])
								buff[i][7:0] <= ~buff[i][7:0];
																
							st <= S4;
				   end
															  
				 end 

				
			S4: begin
					
					if(i < `MAX) begin
					
						out_buff[j] <= color(buff[i]);
												
						i <= i + 1'b1;
						
						j <= j + 1'b1;
																
					   st <= S3;
						
					end
					else ready <= 1'b1;	
								
				 end
			
			
			default: ;
			
		endcase
	
	end
		
		
 
		
 function automatic bit[7:0] color(input bit[8:0] buff);
 
 
	bit[7:0] qbuff = 0;
	
 
		if(buff[8]) begin
								
			qbuff[0] = buff[0];
			qbuff[1] = buff[1] ^ buff[0];
			qbuff[2] = buff[2] ^ buff[1];
			qbuff[3] = buff[3] ^ buff[2];
			qbuff[4] = buff[4] ^ buff[3];
			qbuff[5] = buff[5] ^ buff[4];
			qbuff[6] = buff[6] ^ buff[5];
			qbuff[7] = buff[7] ^ buff[6];
														
		end
		else begin
								
				qbuff[0] = buff[0];
				qbuff[1] = buff[1] ~^ buff[0];
				qbuff[2] = buff[2] ~^ buff[1];
				qbuff[3] = buff[3] ~^ buff[2];
				qbuff[4] = buff[4] ~^ buff[3];
				qbuff[5] = buff[5] ~^ buff[4];
				qbuff[6] = buff[6] ~^ buff[5];
				qbuff[7] = buff[7] ~^ buff[6];
								
		end
 
	return qbuff;
	
 endfunction
		
							
endmodule: tmds_rx			