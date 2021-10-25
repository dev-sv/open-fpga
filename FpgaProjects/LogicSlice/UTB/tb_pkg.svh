




package tb_pkg;

 
`include "uvm_macros.svh" 
`include "Path.h" 

 import uvm_pkg::*;
 
 
 bit channel_reff_data[960];
 
 bit[10:0]  reff_x, reff_y;
 bit        reff_ch[960];
 
class BaseTMonitor #(type SEQ = uvm_sequence_item) extends uvm_component;

	
  `uvm_component_utils(BaseTMonitor)
		 	 	
	uvm_analysis_port #(SEQ) monitor_ap;
	
	SEQ	sb;
	 

	function new(string name, uvm_component parent = null);

		super.new(name, parent);
				
	endfunction
	
	
	virtual function void build_phase(uvm_phase phase);
	
		super.build_phase(phase);
		
		monitor_ap = new("monitor_ap", this);						

		sb = SEQ::type_id::create("sb", this);		
				
	endfunction
	
	
endclass: BaseTMonitor


 

class BaseTEnv #(type DRV = uvm_driver, type MON = uvm_monitor, 
              type SEQ = uvm_sequence_item, type SB = uvm_scoreboard, string if_name = "", type VI = virtual a_if) extends uvm_component;

   
   `uvm_component_utils(BaseTEnv) 	 

	VI  vif;
	
	DRV driver;
	
	MON monitor;
		 
	SB  scoreboard;
	
	uvm_sequencer #(SEQ) seq;
	
	 
	  	
   function new(string name, uvm_component parent);
	 
		super.new(name, parent);
		
   endfunction
    
	 
	 
	function void build_phase(uvm_phase phase);

		driver = new("driver", this);		
		
		monitor = new("monitor", this);

		seq = uvm_sequencer#(SEQ)::type_id::create("seq", this);
		
      scoreboard = new("scoreboard", this);
		
		

		if(!uvm_config_db #(VI)::get(this, "", if_name, vif)) begin
		   			
			`uvm_error(get_type_name(), "Error: DUT interface not found");
		end
		else `uvm_info(get_type_name(), $sformatf("DUT interface found: %s", $sformatf("%p", vif)), UVM_LOW);
										 				 
														 
	endfunction
	 	 
	 
endclass: BaseTEnv
 
 
endpackage: tb_pkg
