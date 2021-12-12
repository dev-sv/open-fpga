

 

 
`include "../../UTB/tb_pkg.svh"

 
 import uvm_pkg::*; 
 import tb_pkg::*; 
 

 
 class UTSequence_0 extends uvm_sequence #(UTSeqItem);	
 
	
	virtual spi_if vif;
	
	bit[1:0]  mode = 0;
	int       nb_wr = 4,
	          nb_rd = 4;
				
	
  `uvm_object_utils(UTSequence_0)

  
   function new (string name = "UTSequence_0");
  
		super.new(name);
			 
	endfunction
 

   virtual task body();
	

	
	req = UTSeqItem::type_id::create("req");
					 
		 
	forever begin
	
		 repeat(8 * (nb_wr + nb_rd)) begin	
			 		
			start_item(req);
													
				req.mode = mode;
				req.nb_wr = nb_wr;
				req.nb_rd = nb_rd;
				req.in_data = $urandom_range(32'h00000000, 32'hffffffff);//val;
				
			finish_item(req);
								  
		 end 		 
		 
	end	 
	
  endtask
  
 endclass: UTSequence_0

 
 
 
 class UTEnv extends uvm_env;

  
   virtual spi_if vif;
  
  
    `uvm_component_utils(UTEnv)

	     
    UTAgent      agent;
	 
	 UTScoreBoard scoreboard;
	 
	 
    function new(string name, uvm_component parent);
	 
      super.new(name, parent);
		
    endfunction
    

	 
    function void build_phase(uvm_phase phase);
	 
      agent = UTAgent::type_id::create("agent", this);
				
      scoreboard = UTScoreBoard::type_id::create("scoreboard", this);
		
		
		if(!uvm_config_db #(virtual spi_if)::get(this, "", "_if", vif)) begin
		   			
			`uvm_error(get_type_name(), "Error: DUT interface not found");
		end
		else begin		
				 
				 `uvm_info(get_type_name(), $sformatf("DUT interface found: %s", $sformatf("%p", vif)), UVM_LOW);
		
      end		

		
// Get virtial interface.
		
		agent.vif = vif;		
	
    endfunction

	 

    function void connect_phase(uvm_phase phase);
	 	 
		agent.monitor.monitor_ap.connect(scoreboard.scoreboard_ap);		
		
	 endfunction

	 
 endclass: UTEnv
 
 
 
 
   
 class UTTest_0 extends uvm_test;
    
	
   `uvm_component_utils(UTTest_0)
	
	string path = "../../UTB/spi_report_mode_";
	
    
   UTEnv env;
	 		
	UTSequence_0 t_seq;

	
   function new(string name = "UTTest_0", uvm_component parent);
	 
     super.new(name, parent);
				
   endfunction

 
	 
   function void build_phase(uvm_phase phase);
	 
		t_seq = UTSequence_0::type_id::create("t_seq", this);
	 	 
      env = UTEnv::type_id::create("env", this);
				
   endfunction
	 
	     
   virtual function string set_mode();
	
		t_seq.mode = 0;
	    		
		return "0.txt";
	 	 		
   endfunction
		  
		  
	  	 
   task run_phase(uvm_phase phase);
	
	
		set_mode();
	
		
      env.scoreboard.fd = $fopen({path, set_mode()}, "w");
				
		
		$fwrite(env.scoreboard.fd, "\n%s %1d\n\n", "UTTest_mode", t_seq.mode);
	
			 
      phase.raise_objection(this);
								
								
			`uvm_info(get_type_name(), $sformatf("\n\n\n********** %s %1d **********\n", "UTTest_mode", t_seq.mode), UVM_LOW);

			t_seq.start(env.agent.seq);
	
			forever 
			#1;
			
      phase.drop_objection(this);
		
   endtask
	
 endclass: UTTest_0
 
 

 class UTTest_1 extends UTTest_0;
 

   `uvm_component_utils(UTTest_1)
 
 
   function new(string name = "UTTest_1", uvm_component parent);
	 
     super.new(name, parent);
				
   endfunction

 
   virtual function string set_mode();
		 
		t_seq.mode = 1;
		
		return "1.txt";
	 	 		
   endfunction
 
 endclass: UTTest_1


 
 class UTTest_2 extends UTTest_0;
 

   `uvm_component_utils(UTTest_2)
 
 
   function new(string name = "UTTest_2", uvm_component parent);
	 
     super.new(name, parent);
				
   endfunction

 
   virtual function string set_mode();
	 
		
		t_seq.mode = 2;
		
		return "2.txt";
	 	 		
   endfunction
 
 endclass: UTTest_2

 
 
 
 class UTTest_3 extends UTTest_0;
 

   `uvm_component_utils(UTTest_3)
 
 
   function new(string name = "UTTest_3", uvm_component parent);
	 
     super.new(name, parent);
				
   endfunction

 
   virtual function string set_mode();
	 
		
		t_seq.mode = 3;
		
		return "3.txt";
	 	 		
   endfunction
	
 
 endclass: UTTest_3
 