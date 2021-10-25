



`include "uvm_macros.svh"

 
 import uvm_pkg::*; 
 import tb_pkg::*; 


 
class UTSequence_0 extends uvm_sequence #(UTSeqItem);	
	
	logic[7:0] val = 0;
	int        count = 0;
	
  `uvm_object_utils(UTSequence_0)

  
   function new (string name = "UTSequence_0");
  
		super.new(name);
			 
	endfunction
 

   virtual task body();
	

		req = UTSeqItem::type_id::create("req");
		
		req.te.vh = 2'b00 ;
	   req.te.de = 1;
		
		
		repeat(2048) begin
		
						   			
			start_item(req); 
			
				req.te.color = val++;
													 				 
			finish_item(req);
         			
			#2;
			
			if(!val)			
 				req.te.vh++;

				
			if(count == 1023) begin	
				
	         req.te.de = 0;
         end	
			
			count++;	
			
		end
			
  endtask
  
endclass: UTSequence_0




class UTSequence_1 extends uvm_sequence #(UTSeqItem);	

	
	logic[7:0] val = 0;
	
	
  `uvm_object_utils(UTSequence_1)

  
   function new (string name = "UTSequence_1");
  
		super.new(name);
			 
	endfunction
 

   virtual task body();
	

		req = UTSeqItem::type_id::create("req");
			
		repeat(2048) begin
		
						   			
			start_item(req); 
			
			
				req.te.de = $urandom_range(1'b0, 1'b1);
			   req.te.vh = $urandom_range(2'b00, 2'b11);
				req.te.color = $urandom_range(8'h00, 8'hff);	
													 				 
			finish_item(req);
         			
			#2;
			
		end
			
  endtask
  
endclass: UTSequence_1

