 
 
`include "../../UTB/tb_pkg.svh"

 
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
		
				send_data();
											 
			finish_item(req);
			
			#200;
			
		end	
		
  endtask

  
  extern virtual function void send_data();
  
endclass: UTSequence_0


function void UTSequence_0::send_data();
 
	req.ts.d = val++;
 
endfunction


 
class UTSequence_1 extends UTSequence_0;
	
  
	
  `uvm_object_utils(UTSequence_1)

  
   function new (string name = "UTSequence_1");
  
		super.new(name);
	 
	endfunction

	
  extern virtual function void send_data();

endclass: UTSequence_1


function void UTSequence_1::send_data();
 
	req.ts.d = $urandom_range(10'h000, 10'h3ff);
 
endfunction

 
  
  
   
 class UTEnv extends uvm_env;

  
   virtual hdmi_if vif;
  
  
    `uvm_component_utils(UTEnv)

	     
    UTAgent     agent;
	 
	 UTScoreBoard scoreboard;
	 
	 
    function new(string name, uvm_component parent);
	 
      super.new(name, parent);
		
    endfunction
    

	 
    function void build_phase(uvm_phase phase);
	 
      agent = UTAgent::type_id::create("agent", this);
				
      scoreboard = UTScoreBoard::type_id::create("scoreboard", this);
		
		
		if(!uvm_config_db #(virtual hdmi_if)::get(this, "", "serial", vif)) begin
		   			
			`uvm_error(get_type_name(), "Error: DUT interface not found");
		end
		else begin		
				 
				 `uvm_info(get_type_name(), $sformatf("DUT interface found: %s", $sformatf("%p", vif)), UVM_LOW);
		
      end		

		
// Get virtial interface.
		
		agent.vif = vif;

		
// Get path of virtial interface.

		scoreboard.t_vif = $sformatf("%p", vif);
	
    endfunction

	 

    function void connect_phase(uvm_phase phase);
	 	 
		agent.monitor.monitor_ap.connect(scoreboard.scoreboard_ap);		

	 endfunction

	 
 endclass: UTEnv
	
	
	
 class UTTest_0 extends uvm_test;
    
	
   `uvm_component_utils(UTTest_0)
	
    
   UTEnv        env;
	 		
	UTSequence_0 t_seq;
	

	
   function new(string name = "UTTest_0", uvm_component parent);
	 
     super.new(name, parent);
				
   endfunction

 
	 
   function void build_phase(uvm_phase phase);
	
	 
		t_seq = UTSequence_0::type_id::create("t_seq", this);
	 	 
      env = UTEnv::type_id::create("env", this);
					
   endfunction
	 
	     
	  	 
   task run_phase(uvm_phase phase);
	
	
      env.scoreboard.fd = $fopen(file_serial_0, "w");
		
		$fwrite(env.scoreboard.fd, "\n%s\n\n", get_type_name());
	
				 
      phase.raise_objection(this);
						
		
			`uvm_info(get_type_name(), $sformatf("\n\n\n********** %s **********\n", get_type_name()), UVM_LOW);
			
			t_seq.start(env.agent.seq);
	
			forever 
			#10;
			
      phase.drop_objection(this);
		
   endtask
	
 endclass: UTTest_0

 
 
 
	
 class UTTest_1 extends uvm_test;
    
	
   `uvm_component_utils(UTTest_1)
    
   UTEnv        env;
	
	UTSequence_1 t_seq;

	
   function new(string name = "UTTest_1", uvm_component parent);
	 
     super.new(name, parent);
				
   endfunction

 
	 
   function void build_phase(uvm_phase phase);
	 
		t_seq = UTSequence_1::type_id::create("t_seq", this);
	 	 
      env = UTEnv::type_id::create("env", this);
					
   endfunction
	 
	     
	  	 
   task run_phase(uvm_phase phase);
	
	
      env.scoreboard.fd = $fopen(file_serial_1, "w");
		
		$fwrite(env.scoreboard.fd, "\n%s\n\n", get_type_name());
	
	 	 
      phase.raise_objection(this);
		
		
			`uvm_info(get_type_name(), $sformatf("\n\n\n********** %s **********\n", get_type_name()), UVM_LOW);
						
			t_seq.start(env.agent.seq);
		
			forever
				#10;

      phase.drop_objection(this);
		
   endtask
	
	
 endclass: UTTest_1
	