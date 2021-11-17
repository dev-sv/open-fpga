

package enum_t;

 typedef enum {STOP, START, WR, ACK, RD, ACK_RD, Z, SCLK_UP} i2c_t;
 
 typedef enum bit[1:0] {EN_STOP, EN_RD, EN_WR} en_t;

endpackage


module i2c(input bit clk, inout sda, output bit sclk, input [7:0] data, input enum_t::en_t en,
           output enum_t::i2c_t st, output logic[7:0] out_i2c);


int   nb = 8;

bit   sw = 1, 
      op = 0, 
      en_sclk = 1;
		
logic[7:0] tmp = 0; 			  
logic      sda_out = 1;



	assign sda = sw ? sda_out : 1'bz;

	
	always @(posedge clk)
	   sclk <= !en_sclk ? ~sclk : 1'b1;
	
	
		
	always @(negedge clk) begin
	
	
		case(st)
		
			
		   enum_t::START:   if(sclk) begin
													  
						           sda_out <= 0;
						           en_sclk <= 0;
									  op <= data;
						           st <= enum_t::WR;									  
					           end	 
					  
					 
			enum_t::WR:      if(!sclk) begin
						
						           if(nb) begin
												 
						              sw <= 1;
								        --nb;
					                 //sda_out <= (data >> nb);										  					  
					                 sda_out <= data[nb];										  					  
						           end
					              else begin
									  
						                  sw <= 0;
						                  st <= enum_t::ACK;
						           end							
						        end						
					  					  
// ack from slave. 					 
		   enum_t::ACK:     if(!sda) begin
			
									  nb <= 8;
// continue to write.									     
									  if(en == enum_t::EN_WR)
									     st <= enum_t::WR;
// stop or read.						          
					              else st <= op ? enum_t::RD : enum_t::SCLK_UP; 
									  										       
								  end
								  
							
			enum_t::RD:      if(sclk) begin
			
			                    if(nb) begin
						
						              --nb;
							           tmp <= tmp | (sda << nb);											  									  
								     end
										  
									  if(!nb) 
// continue to read (sequential) or stop.											  
										  st <= en ? enum_t::ACK_RD : enum_t::SCLK_UP;
								  end	
								  
// ack to slave.
			enum_t::ACK_RD:  begin
			
			                   out_i2c <= tmp;
									 nb <= 8;
		  					       sw <= 1;
  									 sda_out <= 0;
									 st <= enum_t::Z;											  
								  end	 
								    								  
// set sda to z.								  								  
			enum_t::Z:       if(!sclk) begin 
												  
			                    tmp <= 0;
									  sw <= 0;
							        st <= enum_t::RD;
						        end
								  
								  															 						 				
			enum_t::SCLK_UP: begin
			
									 out_i2c <= tmp;
							       en_sclk <= 1;				
							       st <= enum_t::STOP;								
					           end	

					  
		   enum_t::STOP:    if(sclk) begin
			
						           nb <= 8;							
						           sw <= 1;
							        sda_out <= 1;
									  tmp <= 0;
									 
						           if(en)									     
						              st <= enum_t::START;									 
					           end		 	        
			
		   default: ;
		
		endcase
		
	
	end

endmodule: i2c
