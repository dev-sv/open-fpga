


module max7219(input bit clk, output bit sclk, ss, mosi, input logic[7:0] max_data, 
                                                               input logic[15:0] addr_data);

`define BLANK	5'b10000

enum logic[3:0] {DEC = 4'h9, INTENS = 4'ha, SCAN = 4'hb,
                 SHUT = 4'hc, TEST = 4'hf} ini;

localparam int Num = 11;

bit   fl = 0, 
      en = 0;

bit[31:0] nwr = 2,
          nrd = 0;
		
int   i = 0, max = Num;		

logic[3:0]  addr[Num];
logic[15:0]  val[Num];
logic[15:0] spi_data;					

int count = 0;

					
initial
begin	
	
// clear.	
//	for(int i = 0; i < 8; ++i) begin
	for(bit[3:0] i = 0; i < 8; ++i) begin
	
	    addr[i] = 1'b1 + i;
	    val[i] = `BLANK;
	end
	

	addr[8] = SHUT;
	val[8] = 1;

	addr[9] = SCAN;
	val[9] = 7;
	
	addr[10] = INTENS;
	val[10] = 1;
		
end


			
	spi	#(.Ni(2), .No(0), .mode(1)) spi_inst(.clk(clk), .miso(0), .en(en), .in_data(spi_data), 
	                                            .sclk(sclk), .ss(ss), .mosi(mosi), .nwr(nwr), .nrd(nrd));

		
	always @(posedge clk) begin
	
	
		if(!ss) begin
		
		   fl <= 0;
			en <= 0;
		end
		
		if(!fl && ss) begin
		
		   if(i < max) begin
			
			   fl <= 1;			
			   en <= 1;
			   spi_data <= seven_seg(addr[i], val[i]);
				++i;
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
