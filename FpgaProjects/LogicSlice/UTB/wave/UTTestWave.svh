



 
`include "../../UTB/tb_pkg.svh"

 
 import uvm_pkg::*; 
 import tb_pkg::*; 
 import pkg_wave::*; 

 
 
 class UTSeqItem extends uvm_sequence_item;
 

   bit        sel_ch, s;
	bit[9:0]   np; 
   bit[10:0]  x, y, 
	           reff_x, 
				  reff_y;				  
 	bit[7:0]   red, green, blue; 
	
	bit        ch[960] = '{default: 0};

 
	w_param wp = '{
	
	curs_color:'{8'h00, 8'h9f, 8'hff},  
	wave_color:'{8'hff, 8'hd7, 8'h00},
	zero_coord_color:'{8'haa, 8'haa, 8'haa},  

	y_min:80 , y_max:150, y0:64, y1:190
	
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
			
	
			@(posedge vif.clk_pix) begin
			
			  sb.reff_x = tb_pkg::reff_x;	
			  sb.reff_y = tb_pkg::reff_y;
			  sb.ch = tb_pkg::reff_ch;
			  
			  sb.s = vif.s;
			  sb.red = vif.red;
			  sb.green = vif.green;
			  sb.blue = vif.blue;
			  
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
			
				@(posedge vif.clk_pix) begin 
				
					vif.x = req.x;
					vif.y = req.y;
				   vif.wp = req.wp;
				   vif.np = req.np;
				   vif.sel_ch = req.sel_ch;	
					vif.ch = req.ch;
					
				end
					          								
			seq_item_port.item_done();
						
		end
	
	endtask
	
 endclass: UTDriver

 
 
 class UTSequence_0 extends uvm_sequence #(UTSeqItem);	
	 
	 
	bit[9:0]    i = 0; 
   bit[9:0] v_x, v_y;	 
		  	 
	
  `uvm_object_utils(UTSequence_0)

  
   function new (string name = "UTSequence_0");
  
		super.new(name);
			 
	endfunction


	
   virtual task body();
	

		req = UTSeqItem::type_id::create("req");
		
		v_x = 0;
		v_y = 0;
		
		req.np = 960;
		req.sel_ch = 1'b1;
			
				
// 1024x600.
	
//		repeat(614400) begin
		repeat(307200) begin
		
			start_item(req);

			
         if(i < 960) begin
			
			   req.ch[i] = $urandom_range(0, 1);
				reff_ch[i] = req.ch[i];
				i++;
			end	
							
			req.x = v_x;
			req.y = v_y;						
			
			tb_pkg::reff_x = v_x;
			tb_pkg::reff_y = v_y;
			
			
			if(!v_x)
			   v_y++;
			
			v_x++;
			
			
			finish_item(req);
		
		end
											
   endtask
	
 endclass: UTSequence_0
 

 
  
 class UTScoreBoard extends uvm_scoreboard;

 
 	int fd, i = 0, y = 80;
   bit v = 1'b1;     	
	
	
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
  
		check_wave(item);		
			 	 
  endfunction: write
 
 
  extern function void check_wave(UTSeqItem item);
  

 endclass: UTScoreBoard
   
	
	
		
 function void UTScoreBoard::check_wave(UTSeqItem item);
 
 
   string status = "error";	
	
	
	
   if(item.reff_x > 66 && item.reff_x < 1024) begin

	
		v = (item.reff_y == item.wp.y_min) ? 1'b1 : (item.reff_y == item.wp.y_max) ? 1'b0 : v;
		
		y = (item.reff_y == item.wp.y_min) ? item.wp.y_min : (item.reff_y == item.wp.y_max) ? item.wp.y_max : y;
		

		
		if(item.reff_y == y) begin
	
		
			if(item.ch[i] == v || (item.ch[i] != item.ch[i + 1])) begin	
												  
		      status = (item.red == item.wp.wave_color[2] && item.green == item.wp.wave_color[1] && 
				          item.blue == item.wp.wave_color[0] && item.s) ? "pass" : "error";
							 
			end			
			else status = (item.red == 0 && item.green == 0 && item.blue == 0 && item.s) ? "pass" : "error";
			
			
			`uvm_info(get_type_name(), $sformatf("s = %1b red = %2h green = %2h blue = %2h row = %2d col = %3d ch = %1b %s", item.s, item.red, item.green, item.blue, item.reff_y, item.reff_x, item.ch[i], status), UVM_LOW);

			$fwrite(fd, "%s s = %1b red = %2h green = %2h blue = %2h row = %3d col = %3d ch = %1b %s\n", get_type_name(), item.s, item.red, item.green, item.blue, item.reff_y, item.reff_x, item.ch[i], status);
						
			i++;			
			
			if(item.reff_x == 1023)
			   i = 0;
				
			if(item.reff_y == item.wp.y_max && item.reff_x == 1023)
			   $fclose(fd);
			
		end
			
	end
				 
 endfunction
 
 
 
 
 class UTEnv extends BaseTEnv #(UTDriver, UTMonitor, UTSeqItem, UTScoreBoard, "wave", virtual ls_if);
  
  
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
	
	
      env.scoreboard.fd = $fopen(file_wave_0, "w");
		
		$fwrite(env.scoreboard.fd, "\n%s\n\n", get_type_name());
	
			 
      phase.raise_objection(this);								
		
			`uvm_info(get_type_name(), $sformatf("\n\n\n %s  %s\n", $sformatf("%p", env.vif), get_type_name()), UVM_LOW);
			
			t_seq.start(env.seq);
	
			forever 
			#1;
			
      phase.drop_objection(this);
		
   endtask
	
 endclass: UTTest_0

