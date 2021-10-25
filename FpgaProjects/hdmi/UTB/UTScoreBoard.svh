


`include "uvm_macros.svh" 
`include "Path.h" 

 
 import uvm_pkg::*; 
 
 import pkg_disp::*;
 
 
 
class UTSeqItem extends uvm_sequence_item;


 typedef struct {
 
   logic[9:0] p, n, d;
	
 } tmds_serial; 
 
 
 typedef struct {
    
	bit        de;   
	bit[1:0]   vh;
   logic[7:0] color;
	logic[9:0] out;
	
 } tmds_encoder;	

 
 typedef struct {
 
	bit[1:0] vh; 
   bit[10:0] x, y;
	
	t_sync sp = '{
	
				horz_front_porch:20,
				
				horz_sync:60,
				
				horz_back_porch:110,
				
				horz_pix:1024,

				vert_front_porch:30,
				
				vert_sync:80,
				
				vert_back_porch:110,
				
				vert_pix:600
	};
	
 } sync_param;
 
 
 tmds_serial  ts;		// serial data.
 
 tmds_encoder te; 	// encoder data.
 
 sync_param   sync;  // sync data.
 
  
	
	`uvm_object_utils(UTSeqItem)
	
	
   function new (string name = "UTSeqItem");
  
		super.new(name);
	 
	endfunction 
  
  
endclass: UTSeqItem
 
 
 
 
 class UTScoreBoard extends uvm_scoreboard;


// HSync.
 
 	enum {hs1, hs0, hstop} st_h = hs1;
	
   int      x0;
	bit[1:0] h;

	
// VSync.
	
 	enum {vs1, vs0, vstop} st_v = vs1;
	
   int      y0;
	bit[1:0] v;

 
 	int	 fd, num = 0; 

   string t_vif;
	
	
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
  
		case(t_vif)
		
			
			serial_if:  check_serial(item);
			
			sync_if:    check_sync(item);
			
			encoder_if: check_encoder(item);
			
		
			default: ;
			
		endcase;	
	 	 
  endfunction : write
 

 
	extern function void check_serial(UTSeqItem item);
	
	extern function void check_sync(UTSeqItem item);
	
	extern function void check_encoder(UTSeqItem item);
	
	extern function logic[7:0] encoder_xnor(UTSeqItem item);
	extern function logic[7:0] encoder_xor(UTSeqItem item);

	
 endclass: UTScoreBoard
 
 
 
/***************************************************************** 

 Serial method.
 
*****************************************************************/  

 
 function void UTScoreBoard::check_serial(UTSeqItem item);
 
 
   string status = "error";
 

	status = (cmp.compare_field_int("int", item.ts.p, ~item.ts.n, 10) &&
	          cmp.compare_field_int("int", item.ts.p, item.ts.d, 10)  &&
	          cmp.compare_field_int("int", item.ts.d, ~item.ts.n, 10)) ? "pass" : "error";
 
	
	$fwrite(fd, "%s [%4d] p = %h n = %h d = %h %s\n", get_type_name(), num, item.ts.p, ~item.ts.n, item.ts.d, status);
						  
	`uvm_info(get_type_name(), $sformatf("[%4d] p = %h n = %h d = %h %s", num++, item.ts.p, ~item.ts.n, item.ts.d, status), UVM_LOW);
	
	 if(num == 1024)
	    $fclose(fd);
	
 endfunction

 
 
/***************************************************************** 

 Sync method.
 
*****************************************************************/   
 
 function void UTScoreBoard::check_sync(UTSeqItem item);


	string status = "error";
 
// HSync.
	
	
	case(st_h)

		
		hs1: if(item.sync.x == (item.sync.sp.horz_pix + item.sync.sp.horz_front_porch)) begin
		
				  h = item.sync.vh;
		        x0 = item.sync.x;
				  
				  st_h = hs0;
		     end
			  
	
		hs0: if(item.sync.x == (item.sync.sp.horz_pix + item.sync.sp.horz_front_porch + item.sync.sp.horz_sync)) begin
		
				  								  
				  status = (cmp.compare_field_int("bit", h, 2'b01, 2) &&
	                     cmp.compare_field_int("bit", item.sync.vh, 2'b00, 2)  &&
	                     cmp.compare_field_int("int", (item.sync.x - x0), item.sync.sp.horz_sync, 10)) ? "pass" : "error";
				  
				  				  
				  $fwrite(fd, "%s [%3d] vh[0] = %b vh[0] = %b x1 = %3d x0 = %3d HSync = %2d %s\n", get_type_name(), num, h, item.sync.vh, item.sync.x, x0, item.sync.x - x0, status);
						  
				  `uvm_info(get_type_name(), $sformatf("[%3d] vh[0] = %b vh[0] = %b x1 = %3d x0 = %3d HSync = %2d %s", num++, h, item.sync.vh, item.sync.x, x0, item.sync.x - x0, status), UVM_LOW);
				  
				  st_h = hs1;
				  
			  end			  
	
		default: ;		

	endcase
	

	
// VSync.
	
	case(st_v)
	

		vs1:
		     if(item.sync.y == (item.sync.sp.vert_pix + item.sync.sp.vert_front_porch - 1)) begin
				
		        v = item.sync.vh;
		        y0 = item.sync.y;
				  
				  st_v = vs0;				 
		     end
			 
 
 		vs0: if(item.sync.y == (item.sync.sp.vert_pix + item.sync.sp.vert_front_porch  + item.sync.sp.vert_sync - 1)) begin
				
				  				  
				  status = (cmp.compare_field_int("bit", v, 2'b10, 2) &&
	                     cmp.compare_field_int("bit", item.sync.vh, 2'b00, 2)  &&
	                     cmp.compare_field_int("int", (item.sync.y - y0), item.sync.sp.vert_sync, 10)) ? "pass" : "error";
				  
				  
				  $fwrite(fd, "%s       vh[1] = %b vh[1] = %b y1 = %3d  y0 = %3d  VSync = %2d %s\n", get_type_name(), v, item.sync.vh, item.sync.y, y0, item.sync.y - y0, status);
						  
				  `uvm_info(get_type_name(), $sformatf("      vh[1] = %b vh[1] = %b y1 = %3d  y0 = %3d  VSync = %2d %s", v, item.sync.vh, item.sync.y, y0, item.sync.y - y0, status), UVM_LOW);
				  
				  st_v = vstop;
		     end
				
				
		default: $fclose(fd);		
				
	endcase

	
 endfunction


 
/***************************************************************** 

 Encoder methods.
 
*****************************************************************/  
 
 function logic[7:0] UTScoreBoard::encoder_xnor(UTSeqItem item);
 
 	logic[9:0] q;
 
	q[0] = item.te.out[0];
	q[1] = item.te.out[1] ~^ item.te.out[0];
	q[2] = item.te.out[2] ~^ item.te.out[1];
	q[3] = item.te.out[3] ~^ item.te.out[2];
	q[4] = item.te.out[4] ~^ item.te.out[3];
	q[5] = item.te.out[5] ~^ item.te.out[4];
	q[6] = item.te.out[6] ~^ item.te.out[5];
	q[7] = item.te.out[7] ~^ item.te.out[6];
 
  return q; 
 
 endfunction

 
 function logic[7:0] UTScoreBoard::encoder_xor(UTSeqItem item);

	logic[9:0] q;

	q[0] = item.te.out[0];
	q[1] = item.te.out[1] ^ item.te.out[0];
	q[2] = item.te.out[2] ^ item.te.out[1];
	q[3] = item.te.out[3] ^ item.te.out[2];
	q[4] = item.te.out[4] ^ item.te.out[3];
	q[5] = item.te.out[5] ^ item.te.out[4];
	q[6] = item.te.out[6] ^ item.te.out[5];
	q[7] = item.te.out[7] ^ item.te.out[6];
 
  return q; 
 
 endfunction

 
 
 function void UTScoreBoard::check_encoder(UTSeqItem item);
 
 
 	string status = "error";
 
   logic[7:0] color_decode;
	
	
	if(item.te.de) begin
	
		  
		if(item.te.out[9])
			item.te.out[7:0] = ~item.te.out[7:0];	
	
		color_decode = (item.te.out[8]) ? encoder_xor(item) : encoder_xnor(item);
	
	
		status = (cmp.compare_field_int("int", item.te.color, color_decode, 8)) ? "pass" : "error";
	

		$fwrite(fd, "%s [%3d] de = %b vh = %2b color = %2h out = %3h color_decode = %2h %s\n", get_type_name(), num, item.te.de, item.te.vh, item.te.color, item.te.out, color_decode, status);	
	
		`uvm_info(get_type_name(), $sformatf("[%3d] de = %b vh = %2b color = %2h out = %3h color_decode = %2h %s", num++, item.te.de, item.te.vh, item.te.color, item.te.out, color_decode, status), UVM_LOW);

	end	
	else begin
	
	
			status = (cmp.compare_field_int("int", item.te.out, pkg_disp::code[item.te.vh], 10)) ? "pass" : "error";
		

			$fwrite(fd, "%s [%3d] de = %b vh = %2b out = %3h code = %3h %s\n", get_type_name(), num, item.te.de, item.te.vh, item.te.out, pkg_disp::code[item.te.vh], status);
			 
		   `uvm_info(get_type_name(), $sformatf("[%3d] de = %b vh = %2b out = %3h  code = %3h  %s", num++, item.te.de, item.te.vh, item.te.out, pkg_disp::code[item.te.vh], status), UVM_LOW);

		
		   if(num == 2048)
			   $fclose(fd);
				
	end
	

 endfunction
 