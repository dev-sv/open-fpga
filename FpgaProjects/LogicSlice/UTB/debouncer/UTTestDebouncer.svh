

 
`include "../../UTB/tb_pkg.svh"

 
 import uvm_pkg::*; 
 import tb_pkg::*; 

 
 
 class UTSeqItem extends uvm_sequence_item;

			 
	bit[31:0] delay;
	bit       in, out;
	
	
	
	`uvm_object_utils(UTSeqItem)	
	
	function new (string name = "UTSeqItem");
  
		super.new(name);
	 
	endfunction 
  
 endclass: UTSeqItem
 
 
 
 
 class UTMonitor extends BaseTMonitor #(UTSeqItem);

	
	int     pos = 0, 	// positive time interval.
			  neg = 0;  // negotive time interval.
			  
	virtual ls_if vif;
	
	
  `uvm_component_utils(UTMonitor)
		 

	function new(string name, uvm_component parent = null);

		super.new(name, parent);
				
	endfunction
	
	
	virtual task run_phase(uvm_phase phase);
				
		
	   forever begin
		
			
			@(posedge vif.clk_pix) begin
			
			  sb.in = vif.in;
  			  sb.out = vif.out;				  
		
// measuring interval.
		
           if(vif.out) begin
			  
			     pos++;				  
  			     sb.delay = neg;	
				  neg = 0;
				  
			  end
		     else begin
		
					++neg;					
			      sb.delay = pos;					
					pos = 0;
					
           end 		
		
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
				
					vif.in = req.in;
					vif.delay = req.delay;
					
				end
					          								
			seq_item_port.item_done();
						
		end
	
	endtask
	
 endclass: UTDriver

 
 
 class UTSequence_0 extends uvm_sequence #(UTSeqItem);	
	 
	
  `uvm_object_utils(UTSequence_0)

  
   function new (string name = "UTSequence_0");
  
		super.new(name);
			 
	endfunction
	
	
   virtual task body();
	

		req = UTSeqItem::type_id::create("req");	
				
		req.delay = 16;
		
	
		repeat(450) begin	
		
			start_item(req);

				req.in = $urandom_range(0, 1);
				
			finish_item(req);
			
      end		
				
	endtask
	
  
 endclass: UTSequence_0
 

 
 
 
 
 class UTScoreBoard extends uvm_scoreboard;

 
 	int fd,  i = 0,
	    time_i = 0;
	
	
	bit in_buff[500],
	    out_buff[500];

	
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
  
		check_debouncer(item);		
			 	 
  endfunction: write
 
 
  extern function void check_debouncer(UTSeqItem item);

 endclass: UTScoreBoard
   
	
		
 function void UTScoreBoard::check_debouncer(UTSeqItem item);
 
 
   string status = "error";
 
		
   if(i < 453) begin
	
			
		in_buff[i] = item.in;
		
			
		if(i > 1) begin
		
		
		   out_buff[i - 2] = item.out;
			
									
			if(in_buff[0] == out_buff[i - 2]) begin
							
			   ++time_i;
				
			end	
			else begin
			

			      in_buff[0] = out_buff[i - 2];
							
				
					if(time_i == item.delay) begin
									
					   `uvm_info(get_type_name(), $sformatf("time_i = %2d delay = %2d pass\n", time_i, item.delay), UVM_LOW);
						
						$fwrite(fd, "%s time_i = %2d delay = %2d pass\n\n", get_type_name(), time_i, item.delay);
						
						time_i = 0;
	
					end
					else begin
					
					   `uvm_info(get_type_name(), $sformatf("time_i = %2d delay = %2d error\n", time_i, item.delay), UVM_LOW);
						
						$fwrite(fd, "%s time_i = %2d delay = %2d error\n\n", get_type_name(), time_i, item.delay);
						
					end	
					
					++time_i;					
			end
					  
		  `uvm_info(get_type_name(), $sformatf("in = %b out = %b [%3d]", in_buff[i-2], out_buff[i-2], i-2), UVM_LOW);
		  
		   $fwrite(fd, "%s in = %b out = %b [%3d] \n", get_type_name(), in_buff[i-2], out_buff[i-2], i-2);

		end	
		
	   ++i;			
		
   end
	else $fclose(fd);
	
 
 endfunction
 
 
 
 
 class UTEnv extends BaseTEnv #(UTDriver, UTMonitor, UTSeqItem, UTScoreBoard, "debouncer", virtual ls_if);
  
  
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
	
	
      env.scoreboard.fd = $fopen(file_debouncer_0, "w");
		
		$fwrite(env.scoreboard.fd, "\n%s\n\n", get_type_name());
	
			 
      phase.raise_objection(this);								
		
			`uvm_info(get_type_name(), $sformatf("\n\n\n %s  %s\n", $sformatf("%p", env.vif), get_type_name()), UVM_LOW);
			
			t_seq.start(env.seq);
	
			forever 
			#1;
			
      phase.drop_objection(this);
		
   endtask
	
 endclass: UTTest_0
