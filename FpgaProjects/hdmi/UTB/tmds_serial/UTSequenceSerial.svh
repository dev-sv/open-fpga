



`include "uvm_macros.svh"

 
 import uvm_pkg::*; 
 import tb_pkg::*; 


 
class UTSequence_0 extends uvm_sequence #(UTSeqItem);


   bit[9:0] val = 0;

  `uvm_object_utils(UTSequence_0)

  
   function new (string name = "UTSequence_0");
  
		super.new(name);
			 
	endfunction
 

   virtual task body();
	

		req = UTSeqItem::type_id::create("req");
  
		repeat(1024) begin
		
						   			
			start_item(req); 
																				
				req.ts.d = val++;
		
			   $display("sequence = %h", req.ts.d);
							 
			finish_item(req);
			
			#200;
			
		end	
		
  endtask
  
endclass: UTSequence_0




class UTSequence_1 extends uvm_sequence #(UTSeqItem);
	
  
	
  `uvm_object_utils(UTSequence_1)

  
   function new (string name = "UTSequence_1");
  
		super.new(name);
	 
	endfunction
 

	
	virtual task body();
	

		req = UTSeqItem::type_id::create("req");
		
  
		repeat(1024) begin
		
				   			
			start_item(req); 
																
			  req.ts.d = $urandom_range(10'h000, 10'h3ff);
			  
			  $display("sequence = %h", req.ts.d);
			  
			finish_item(req);
			
			#200;
			
		end
		
	endtask
  
endclass: UTSequence_1
