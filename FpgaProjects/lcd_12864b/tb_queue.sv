

`timescale 1 ps / 1 ps

module tb_queue;

`include "../tb.h"

 
localparam N = 32;
localparam QS = 8;

enum {QRY_1, QRY_0, GET} state = QRY_1;

bit clk, full, query;
bit[7:0] qcount;

logic[$clog2(QS) - 1:0] pWR, 
                        p = 0;
logic[7:0] in_data, 
           out_queue,
			  data[N];
			  
int j = 0, 
    i = 0,
    num = N;

	 
initial
begin

 $display("\n Testbench queue.\n");

 clk = 0;
 
 for(int i = 0; i < N; ++i) 
     data[i] = i;
 

 forever
   #10 clk = ~clk;
 
end



	queue #(QS)queue_mut(.clk(clk), .pWR(pWR), .in_data(in_data), .full(full), .qcount(qcount), 
	                     .out_queue(out_queue), .query(query));


	always @(posedge clk) begin
	
		if((j < num) && !full) begin

   		in_data <= data[j++];
		   pWR <= p++;		
		end

		
		case(state)
		
		
			QRY_1: begin
			
                  if(qcount) begin
					 
                     query <= 1;														
						   state <= QRY_0;
					   end	 
				    end	
		
			QRY_0: begin
			
  			         query <= 0;
			         state <= GET;			
				    end
				  
		   GET:   begin
			
					  `COMP(out_queue, data[i], EQ);
						++i;
                  state <= QRY_1; 
				    end	
				
		endcase
		
	end							
								
endmodule: tb_queue
