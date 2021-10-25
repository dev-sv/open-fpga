



`include "uvm_macros.svh"

 
 import uvm_pkg::*; 
 import tb_pkg::*; 


 
class UTSequence_0 extends uvm_sequence #(UTSeqItem);	
	

  `uvm_object_utils(UTSequence_0)

  
   function new (string name = "UTSequence_0");
  
		super.new(name);
			 
	endfunction
 

   virtual task body();
	

		req = UTSeqItem::type_id::create("req");
		
  
		repeat(1) begin
		
						   			
			start_item(req); 									
											 				 
			finish_item(req);
						
		end	
		
  endtask
  
endclass: UTSequence_0
