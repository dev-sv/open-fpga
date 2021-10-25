



 
`include "../../UTB/tb_pkg.svh"

 
 import uvm_pkg::*; 
 import tb_pkg::*; 

 
 
 class UTSeqItem extends uvm_sequence_item;

			 
   bit[9:0] n, np;
	bit      in, sel_ch, 
	         ch[960], 
	         reff[960];
	
	
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
								
		#8;
		
	   forever begin
					
			@(posedge vif.clk) begin
			
			  sb.reff = channel_reff_data;			
  			  sb.ch = vif.ch;				  
				
			  monitor_ap.write(sb);	
			  
			end  
		
		end
		
	endtask	
 
 endclass: UTMonitor 
 

 
 
 class UTDriver extends uvm_driver #(UTSeqItem);
	

	int i = 0;
	
	
	virtual ls_if vif;
	
	`uvm_component_utils(UTDriver)
	
  		
	
	function new(string name = "UTDriver", uvm_component parent = null);
	
		super.new(name, parent);
				
	endfunction	
				
		
		
	task run_phase(uvm_phase phase);
		
		forever begin
				
			seq_item_port.get_next_item(req);				
			
				@(posedge vif.clk) begin 
				
					vif.in = req.in;
					vif.sel_ch = req.sel_ch;
					vif.n = req.n;
								
				end
					          								
			seq_item_port.item_done();
						
		end
	
	endtask
	
 endclass: UTDriver

 
 
 class UTSequence_0 extends uvm_sequence #(UTSeqItem);	
	 
	 
	 int i = 0, 
	     pos = 0, 
		  neg = 0;
		  	 
	
  `uvm_object_utils(UTSequence_0)

  
   function new (string name = "UTSequence_0");
  
		super.new(name);
			 
	endfunction
	
	
   virtual task body();
	

		req = UTSeqItem::type_id::create("req");	
		
		req.in = 0;
		req.sel_ch = 0;
		req.n = 0;		
		
	
// Sync impulse.
	
		repeat(2) begin	
		
			start_item(req);
			
				req.in = ~req.in;
		
			finish_item(req);
			
		end
		
		
// input data.
		
	repeat(96) begin	

		pos = $urandom_range(1, 10);
		neg = $urandom_range(1, 10);

		
		repeat(pos) begin	
		
			start_item(req);
			
				req.in = 1'b1;
				
				channel_reff_data[i++] = req.in;
						
			finish_item(req);
			
		end
		
		
		repeat(neg) begin
		
			start_item(req);
			
				req.in = 1'b0;
				
				channel_reff_data[i++] = req.in;
		
			finish_item(req);
				
		end
		
	end	
									
   endtask
	
 endclass: UTSequence_0
 

 
  
 class UTScoreBoard extends uvm_scoreboard;

 
 	int fd, i = 0; 	
	
	
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
  
		check_channel(item);		
			 	 
  endfunction: write
 
 
  extern function void check_channel(UTSeqItem item);

 endclass: UTScoreBoard
   
	
	
		
 function void UTScoreBoard::check_channel(UTSeqItem item);
 
 
   string status = "error";
	
	
 	status = cmp.compare_field_int("int", item.ch[i], item.reff[i], 10) ? "pass" : "error";
 
	`uvm_info(get_type_name, $sformatf("ch[%3d] = %b reff[%3d] = %b %s", i, item.ch[i], i, item.reff[i], status), UVM_LOW);
	
	 $fwrite(fd, "%s ch[%3d] = %b reff[%3d] = %b %s\n", get_type_name(), i, item.ch[i], i, item.reff[i], status);

	
    i++;
	 
	 if(i == 960)
	    $fclose(fd);
 
 endfunction
 
 
 
 
 class UTEnv extends BaseTEnv #(UTDriver, UTMonitor, UTSeqItem, UTScoreBoard, "channel", virtual ls_if);
  
  
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
	
	
      env.scoreboard.fd = $fopen(file_channel_0, "w");
		
		$fwrite(env.scoreboard.fd, "\n%s\n\n", get_type_name());
	
			 
      phase.raise_objection(this);								
		
			`uvm_info(get_type_name(), $sformatf("\n\n\n %s  %s\n", $sformatf("%p", env.vif), get_type_name()), UVM_LOW);
			
			t_seq.start(env.seq);
	
			forever 
			#1;
			
      phase.drop_objection(this);
		
   endtask
	
 endclass: UTTest_0
