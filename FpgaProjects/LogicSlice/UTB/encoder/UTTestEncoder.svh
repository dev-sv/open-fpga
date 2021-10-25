

 
`include "../../UTB/tb_pkg.svh"

 
 import uvm_pkg::*; 
 import tb_pkg::*; 
 import pkg_encoder::*;

 
 
 class UTSeqItem extends uvm_sequence_item;

	
	bit      clk, dt;
   bit[9:0] data;
	
	e_param  p = '{
	
		ini: 0, 
		max: 1023,
		min: 1,
		step:1
	};
	 
	
	`uvm_object_utils(UTSeqItem)	
	
	function new (string name = "UTSeqItem");
  
		super.new(name);
	 
	endfunction 
  
 endclass: UTSeqItem
 
 
 
 
 class UTMonitor extends BaseTMonitor #(UTSeqItem);

	
	virtual ls_if vif;
	
	
  `uvm_component_utils(UTMonitor)
		 

	function new(string name, uvm_component parent = null);

		super.new(name, parent);
				
	endfunction
	
	
	virtual task run_phase(uvm_phase phase);
				
		
	   forever begin
		
			@(negedge vif.clk or negedge vif.dt) begin
		
			  sb.clk = vif.clk;
			  sb.dt = vif.dt;
			  sb.data = vif.data;
				  
			  monitor_ap.write(sb);	
			  
			end
			
		end
		
	endtask	
 
 endclass: UTMonitor 
 

 
 
 class UTDriver extends uvm_driver #(UTSeqItem);
	

	virtual ls_if vif;
	
	`uvm_component_utils(UTDriver)
  		
	
	function new(string name = "UTDriver", uvm_component parent = null);
	
		super.new(name, parent);
				
	endfunction	
		
		
	task run_phase(uvm_phase phase);
		
		forever begin
				
			seq_item_port.get_next_item(req);				
			
				@(posedge vif.clk_pix) begin 
				
					vif.clk = req.clk;
					vif.dt = req.dt;									
					vif.p = req.p;
					
				end
					          								
			seq_item_port.item_done();
						
		end
	
	endtask
	
 endclass: UTDriver

 
 
 class UTSequence_0 extends uvm_sequence #(UTSeqItem);	

	 
   bit v_clk = 1,
	    v_dt = 1;
 	
	int unsigned n_cw = 2048,
	             n_ccw = 2048;
	
	
  `uvm_object_utils(UTSequence_0)

  
   function new (string name = "UTSequence_0");
  
		super.new(name);
			 
	endfunction
	
	
 
   virtual task body();
	

		req = UTSeqItem::type_id::create("req");
		
		
		start_item(req);
			
			init();
		
		finish_item(req);

		
// ClockWise rotation.
  
		repeat(n_cw) begin		
						   			
			start_item(req);
			
				rotate(1'b0);
								
			finish_item(req);
			
			#1;
			
			start_item(req);
														
				rotate(1'b1);
				
			finish_item(req);
			
		end
		
			
		start_item(req);
							
			init();
				
		finish_item(req);


		
// CounterClockWise rotation.
				
		repeat(n_ccw) begin		
						   			
			start_item(req);
			
				rotate(1'b1);
								
			finish_item(req);
			
			#1;
			
			start_item(req);
			
				rotate(1'b0);
								
			finish_item(req);
					
		end				
		
  endtask
  
  
  extern virtual function void init();
  extern virtual function void rotate(bit dir);
  
 endclass: UTSequence_0
 

 
 function void UTSequence_0::init();
 		
	req.clk = 1'b1;
	req.dt = 1'b1;
		  
 endfunction
 

 function void UTSequence_0::rotate(bit dir);
 
   if(!dir) begin
	
		req.clk = v_clk;
		v_clk = ~v_clk;
	end
	else begin
	
			req.dt = v_dt;
			v_dt = ~v_dt;
	end		

 endfunction
 
 
 
 class UTScoreBoard extends uvm_scoreboard;

 
 	int	 fd, num = 0; 
	
	bit[9:0] v = 0;
	
	
	uvm_comparer cmp;
	
 
   `uvm_component_utils(UTScoreBoard)
	
	uvm_analysis_imp#(UTSeqItem, UTScoreBoard) scoreboard_ap;
 
 
   function new(string name, uvm_component parent);
	 
      super.new(name, parent);
		
   endfunction
 
 
	function void build_phase(uvm_phase phase);
		
		scoreboard_ap = new("scoreboard_ap", this);
		
		cmp = new();
		
   endfunction
	
	
 
  virtual function void write(UTSeqItem item);
  
		check_encoder(item);		
			 	 
  endfunction: write
 
 
  extern function void check_encoder(UTSeqItem item);

 endclass: UTScoreBoard
   
	
		
 function void UTScoreBoard::check_encoder(UTSeqItem item);
 
 
   string status = "error";
 
 
	if(!item.clk && item.dt) begin
	
				
		status = (cmp.compare_field_int("bit", !item.clk, item.dt, 1)) ? "pass" : "error";
				
	   `uvm_info(get_type_name(), $sformatf("[%4d] v = %4d data = %4d %s", num++, v, item.data, status), UVM_LOW);
				
		++v;
	end
	
	
	if(item.clk && !item.dt) begin
	
	   --v;
	
		status = (cmp.compare_field_int("int", v, item.data, 10)) ? "pass" : "error";	
		
	   `uvm_info(get_type_name(), $sformatf("[%4d] v = %4d data = %4d %s", num++,  v, item.data, status), UVM_LOW);
	end
	    
		 
	if(num == 2047)
      $fclose(fd);	
 
 endfunction
 
 
 
 
 class UTEnv extends BaseTEnv #(UTDriver, UTMonitor, UTSeqItem, UTScoreBoard, "encoder", virtual ls_if);
  
  
   `uvm_component_utils(UTEnv)
	 
	 
   function new(string name, uvm_component parent);
	 
      super.new(name, parent);
		
   endfunction
	 
	 
   function void connect_phase(uvm_phase phase);
		
		driver.vif = vif;
		monitor.vif = vif;
					 
		driver.seq_item_port.connect(seq.seq_item_export);
	 	 
		monitor.monitor_ap.connect(scoreboard.scoreboard_ap);

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
	
	
      env.scoreboard.fd = $fopen(file_encoder_0, "w");
		
		$fwrite(env.scoreboard.fd, "\n%s\n\n", get_type_name());
	
			 
      phase.raise_objection(this);								
		
			`uvm_info(get_type_name(), $sformatf("\n\n\n %s  %s\n", $sformatf("%p", env.vif), get_type_name()), UVM_LOW);
			
			t_seq.start(env.seq);
	
			forever 
			#1;
			
      phase.drop_objection(this);
		
   endtask
	
 endclass: UTTest_0
