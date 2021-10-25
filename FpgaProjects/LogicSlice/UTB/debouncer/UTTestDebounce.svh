

 
`include "../../UTB/tb_pkg.svh"

 
 import uvm_pkg::*; 
 import tb_pkg::*; 

 
 
 class UTSequence_0 extends uvm_sequence #(UTSeqItem);	

	 	
	
  `uvm_object_utils(UTSequence_0)

  
   function new (string name = "UTSequence_0");
  
		super.new(name);
			 
	endfunction
	

	
 
   virtual task body();
	

		req = UTSeqItem::type_id::create("req");
		
		
		start_item(req);
			
		
		finish_item(req);
		
  endtask
  
    
 endclass: UTSequence_0

 
 
 
 
 class UTEnv extends uvm_env;

  
   virtual ls_if vif;
  
  
    `uvm_component_utils(UTEnv)

	     
    UTAgent      agent;
	 
	 UTScoreBoard scoreboard;
	 
	 
    function new(string name, uvm_component parent);
	 
      super.new(name, parent);
		
    endfunction
    

	 
    function void build_phase(uvm_phase phase);
	 
	 
      agent = UTAgent::type_id::create("agent", this);
				
      scoreboard = UTScoreBoard::type_id::create("scoreboard", this);
		
		
		if(!uvm_config_db #(virtual ls_if)::get(this, "", "debouncer", vif)) begin
		   			
			`uvm_error(get_type_name(), "Error: DUT interface not found");
		end
		else begin		
				 
				 `uvm_info(get_type_name(), $sformatf("DUT interface found: %s", $sformatf("%p", vif)), UVM_LOW);
		
				 agent.vif = vif;
				 
				 scoreboard.t_vif = $sformatf("%p", vif);				 
      end		
	
    endfunction
	 

	 
    function void connect_phase(uvm_phase phase);
	 	 
		agent.monitor.monitor_ap.connect(scoreboard.scoreboard_ap);		

	 endfunction

	 
 endclass: UTEnv
 
 
 
 
   
 class UTTest_0 extends uvm_test;
    
	
   `uvm_component_utils(UTTest_0)
    
   UTEnv env;
	 		
	UTSequence_0 t_seq;

	
   function new(string name = "UTTest_0", uvm_component parent);
	 
     super.new(name, parent);
				
   endfunction

 
	 
   function void build_phase(uvm_phase phase);
	 
		t_seq = UTSequence_0::type_id::create("t_seq", this);
	 	 
      env = UTEnv::type_id::create("env", this);
		
   endfunction
	 
	     
	  	 
   task run_phase(uvm_phase phase);
	
	
      //env.scoreboard.fd = $fopen(file_encoder_0, "w");
		
		//$fwrite(env.scoreboard.fd, "\n%s\n\n", get_type_name());
	
			 
      phase.raise_objection(this);
								
		
			`uvm_info(get_type_name(), $sformatf("\n\n\n********** %s **********\n", get_type_name()), UVM_LOW);

			
			t_seq.start(env.agent.seq);
	
			forever 
			#1;
			
      phase.drop_objection(this);
		
   endtask
	
 endclass: UTTest_0
