

/*

 hardware test
 
 w25q32 flash memory
 
 mode: 00, 11.
 
*/
module spi_top(
						input wire clk,
						
						output wire ss, 
						
						output wire sclk, 
						
						output wire mosi, 
						
						input  wire miso, 
						
						output wire[3:0] led
);


// num bytes for test.
 `define MAX 128	

// status bits.
 const bit[7:0] WEL = 8'h02,
                BUSY = 8'h01;				
// commands.				
 const bit[7:0]  CMD_WR_EN 		= 8'h06;
 const bit[7:0]  CMD_STATUS 		= 8'h05;
 const bit[7:0]  CMD_READ 			= 8'h03;
 const bit[7:0]  CMD_ERASE_SECTOR= 8'h20;
 const bit[7:0]  CMD_WRITE 		= 8'h02;	

 bit[7:0] cmd[`MAX + 4] = '{default:0};
 
 enum { SC0, SC1, SC2, SC3 } s = SC0;
 
 enum { S0, S1, S2, SPI, SPI0, SPI1, SPI2, SPI3, CMP, ERR } st = S0, next;
 

 wire w_clk;
 
 wire[3:0] w_sb;
 
 wire[3:0] w_rb;
 
 bit[3:0] err = 0;
 
 bit [1:0] op = `STOP; 
 
 bit[7:0] data = 0;
 
 bit[7:0] in_data;
  
 wire[7:0] w_out_data;
 
 bit[7:0] recv_buff[`MAX] = '{default:0};
 
 int unsigned i = 0;
 int unsigned send_num;
 int unsigned recv_num;
 int unsigned count = 0;
 int unsigned delay = 3000000;
  

	 
 
	pll pll_inst(.inclk0(clk), .c0(w_clk));

 
	spi spi_inst(
						.clk(w_clk), 
						
						.ss(ss), 
						.sclk(sclk), 
						.mosi(mosi), 
						.miso(miso), 
						
						.op(op),		
						
						.in_data(in_data),
						
						.out_data(w_out_data),
						
						.sb(w_sb),
						
						.rb(w_rb),
						
// mode: 2'b00, 2'b11
						.mode(2'b00)						
	);


	
	assign led = ~err;
	
	always @(posedge w_clk) begin
	
		
		case(st)
			
			
			S0:  begin
				
					cmd[0] <= CMD_WR_EN;
					
					i <= 0;
					
					send_num <= 1;
					
					recv_num <= 1;
					
					next <= S1;
					
					st <= SPI;
				 end	
				 
				 
			S1: begin

					cmd[0] <= CMD_STATUS;
					
					i <= 0;
					
					send_num <= 1;

					recv_num <= 1;
					
					next <= S2;
					
					st <= SPI;			

				 end
				 
				 
			S2: begin
					
					 i <= 0;				
				
					 case(s)	
			 
			
						SC0: if(!(recv_buff[0] & BUSY))begin
						
									 if(recv_buff[0] & WEL)begin
						
										 cmd[0] <= CMD_ERASE_SECTOR;
										 cmd[1] <= 8'h00;
										 cmd[2] <= 8'h00;
										 cmd[3] <= 8'h00;
										
										 send_num <= 4;
														
										 recv_buff[0] <= 8'h00;
// go to delay after erasing.
										 delay <= 3000000;
										 
										 s <= SC3;
					
										 st <= SPI;			
									 end
								 end
								 
								 
						SC1: if(!(recv_buff[0] & BUSY))begin
						
									 if(recv_buff[0] & WEL)begin
						
										 cmd[0] <= CMD_WRITE;
// address for writing.										 
										 cmd[1] <= 8'h00;
										 cmd[2] <= 8'h00;
										 cmd[3] <= 8'h00;
// load data for writing.
// cmd[4] - [`MAX + 4].
										 if(i < `MAX) begin
										 
										    cmd[i + 4] <= data;
											 
											 data <= data + 1'b1;
											 
											 i <= i + 1'b1;
										 end	 
										 else begin
										 										 
												send_num <= 260;
									
// go to delay after writing.
												delay <= 50000;	
									
												s <= SC3;
					
												st <= SPI;
										 end 		
									 end
								 end	 
								 
								 
						SC2: begin
								 								
									cmd[0] <= CMD_READ;
									cmd[1] <= 8'h00;
									cmd[2] <= 8'h00;
									cmd[3] <= 8'h00;
														
									send_num <= 4;
					
									recv_num <= `MAX;

									next <= CMP;
														
									st <= SPI;							
								 end	

// delays.								 
						SC3: begin
								
									if(count < delay)
									   count <= count + 1'b1;
		
									else begin
											
											count <= 0;
																						
											if(cmd[0] == CMD_ERASE_SECTOR) begin
											
												s <= SC1;
																							
												st <= S0;
											end
										   else if(cmd[0] == CMD_WRITE)
													  s <= SC2;											
									end
								 end
						
						
						default: ;
									
					 endcase				
				 
				 end
				 
				 
				 
// spi_if.	 
			
			SPI: if(!w_sb) begin
				
					   in_data <= cmd[i];
							
					   op <= `SEND;
						
					   i <= i + 1'b1;
							
					   st <= SPI0;
					end	
								
					 
			SPI0: if(w_sb) begin
				
						if(i < send_num)
						   st <= SPI;
							 
						else begin
						 
								i <= 0; 
						 									 
								st <= SPI1; 
						end  
					end	

					
// wait send last byte.					 
			SPI1: if(!w_sb) begin
												
						if( (cmd[0] == CMD_WR_EN) || 
							 (cmd[0] == CMD_WRITE) ||
						    (cmd[0] == CMD_ERASE_SECTOR) ) begin 
					
						   op <= `STOP;
							 
							st <= next;
						end	 
						else begin
						 				
								op <= `RECV;
						 
								st <= SPI2;
						end			
									
					end
					 					 
					 
			SPI2: if(w_rb)		
					   st <= SPI3;
					 
					 
			SPI3: if(!w_rb) begin
										  	
						recv_buff[i] <= w_out_data;
												
						if(i == (recv_num - 1)) begin
						
							i <= 0;
							
						   op <= `STOP;
							
							st <= next;
						end	
						else begin
						 
		 						 i <= i + 1'b1;

								 st <= SPI2;
						end		 
						 
					end
			
			
			
			CMP: begin

					if(i < `MAX) begin
					
						if(cmd[i + 4] != recv_buff[i])
							st <= ERR;
							
						else begin
						
								i <= i + 1'b1;
								
								err <= 4'b0000;
						end		
					end
					else begin	
					
							s <= SC0;
							
							st <= S0;
					end
			
				  end
			
				 
			default: err <= 4'b1001;
			
		endcase	
			
	end
		
		
endmodule: spi_top