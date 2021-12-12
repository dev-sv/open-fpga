



package tb_pkg;


`include "uvm_macros.svh" 

 import uvm_pkg::*;

 
 
class UTSeqItem extends uvm_sequence_item;
  
  
 bit[1:0]  mode;
  
 bit[31:0] nb_wr,
			  nb_rd,
           in_data,
           out_data; 
 
	
 `uvm_object_utils(UTSeqItem)
	
	
  function new (string name = "UTSeqItem");
  
	super.new(name);
	 
  endfunction 
  
  
endclass: UTSeqItem 
 
 
 
 
class UTMonitor extends uvm_monitor;

	
	
 `uvm_component_utils(UTMonitor)
	
	
	bit[31:0]      i = 0, 
	               buff;
						
	virtual spi_if vif;
	 
	
	
	UTSeqItem item;
			
	uvm_analysis_port #(UTSeqItem)	monitor_ap;
	
	
	function new(string name, uvm_component parent = null);

		super.new(name, parent);
				
	endfunction
	
	
	
	virtual function void build_phase(uvm_phase phase);
	
	
		super.build_phase(phase);
		
		monitor_ap = new("mon_ap", this);
				
		item = UTSeqItem::type_id::create("item");
				
	endfunction

	
	
	virtual task run_phase(uvm_phase phase);
				
		
		#1;
		
		forever begin		
		
		
			@(posedge vif.sclk) begin
			
		
			  if(i < (vif.nb_wr << 3)) begin	  
				     
			     buff[(vif.nb_wr << 3) - i - 1] = vif.mosi;
					 
				  i++;
						
           end			  
			  
			end 
								
			
			if(i == (vif.nb_wr << 3)) begin
			
				@(posedge vif.ss) begin
			
				  item.in_data = buff;
				  item.out_data = vif.out_data;
				  monitor_ap.write(item);	
			
				  i = 0;
			
			   end
				
			end
											
		end 	
	
	endtask
	
	
endclass: UTMonitor
 
 
 
 
class UTDriver extends uvm_driver #(UTSeqItem);
	

 
 bit[31:0] i = 0, 
           j = 0, 
			  buff;

	
	`uvm_component_utils(UTDriver)

	virtual spi_if vif;		
	
	
	function new(string name = "UTDriver", uvm_component parent = null);
	
		super.new(name, parent);
		
	endfunction	
		

	
// Send test seq to dut.
	
	task run_phase(uvm_phase phase);

			
		forever begin
						
				
			seq_item_port.get_next_item(req);
			

				
				vif.mode = req.mode;
				vif.nb_wr = req.nb_wr;
				vif.nb_rd = req.nb_rd;
				vif.in_data = req.in_data;
				
				#1;
				
// Master -> Slave.
				
				@(posedge vif.sclk) begin
								  
				  if(i < (req.nb_wr << 3)) begin
				  	
					  buff[(req.nb_wr << 3) - i - 1] = vif.mosi;
					  i++;		
				  end
				  
				end 
				
					
// Slave -> Master.
			
				@(negedge vif.sclk) begin				  
				  
				  
				  if(i == (req.nb_wr << 3)) begin	
				
				     if(j < (req.nb_rd << 3)) begin
					  					     
					     vif.miso = buff[(req.nb_rd << 3) - j - 1];
						  j++;
						  						  
					  end
				     else begin
					  
								i = 0;
				            j = 0;								
	              end
					  
				  end

				end
				
			seq_item_port.item_done();			
									
		end
	
	endtask
	
endclass: UTDriver

 

 
 class UTAgent extends uvm_agent;
		
	
	UTMonitor	monitor;
	
	UTDriver		driver;
		
	virtual spi_if vif;

	
	uvm_sequencer #(UTSeqItem) seq;	
	
	
	`uvm_component_utils(UTAgent);
	
	
	function new(string name, uvm_component parent);

		super.new(name, parent);
		
	endfunction
	
	
	
	function void build_phase(uvm_phase phase);
					
		
		driver = UTDriver::type_id::create("driver", this);		
		
		monitor = UTMonitor::type_id::create("monitor", this);
		
		seq = uvm_sequencer #(UTSeqItem)::type_id::create("seq", this);
				
		monitor.vif = vif;
		driver.vif = vif;
		
	endfunction
	
	
	
// Connect sequencer to driver.	

	function void connect_phase(uvm_phase phase);
	
		driver.seq_item_port.connect(seq.seq_item_export); 
						
	endfunction
	
		
 endclass: UTAgent
 
 
  
 
   
 class UTScoreBoard extends uvm_scoreboard;


 	int	 fd, num; 

   string status = "error";
	
	
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
  
		
		status = (cmp.compare_field_int("int", item.in_data, item.out_data, 10) ? "pass" : "error");
		
		`uvm_info(get_type_name(), $sformatf("[%1d] in_data = %2h  out_data = %2h  %s", num, item.in_data, item.out_data, status), UVM_LOW);
		
		$fwrite(fd, "%s [%3d] in_data = %2h out_data = %2h %s\n", get_type_name(), num++, item.in_data, item.out_data, status);
		 	
   endfunction : write
 
	
 endclass: UTScoreBoard
  
 

endpackage: tb_pkg
