


module fb_top(

		input 			clk,
		input          reset,
      output [14:0] 	HPS_DDR3_ADDR,
      output [2:0]  	HPS_DDR3_BA,
      output       	HPS_DDR3_CAS_N,
      output       	HPS_DDR3_CKE,
      output       	HPS_DDR3_CK_N,
      output       	HPS_DDR3_CK_P,
      output       	HPS_DDR3_CS_N,
      output [3:0]  	HPS_DDR3_DM,
      inout   [31:0] 	HPS_DDR3_DQ,
      inout   [3:0]  	HPS_DDR3_DQS_N,
      inout   [3:0]  	HPS_DDR3_DQS_P,
      output        	HPS_DDR3_ODT,
      output        	HPS_DDR3_RAS_N,
      output        	HPS_DDR3_RESET_N,
      input          HPS_DDR3_RZQ,
      output       	HPS_DDR3_WE_N,
		
      hdmi_if.pair 	red, green, blue, sclk		
);


 wire w_clk_x10,
      w_clk_pix,
      w_clk_avl;
			
 bit[10:0] x = 0,
          y = 0;
 
 bit [7:0] r = 8'h00,
          g = 8'h00,
			 b = 8'h00;

 			 
enum {SS0, SS1} state = SS0;
enum {INI, S0, S1, S2, S3, S4, S5, NB} st = INI;
	  
`define x_max 1024
`define y_max 600
	  
const int unsigned max = (`x_max * `y_max);
int unsigned size = max;

bit[31:0] fb_mem[`x_max] = '{default: 0};
         			
bit[7:0]  n = 0;
bit[10:0] np = 0;

// avalon iface.	
bit [29:0]	address, addr;
bit [7:0]    burstcount;
bit[3:0]  	byteenable;
bit      		waitrequest;
bit       	readdatavalid;
wire[31:0] 	readdata;
bit			 	read = 1'b0;

bit[31:0]		writedata;
bit        	write = 1'b0;

wire[7:0]  w_full; 
wire[29:0] w_start_addr; 
 

// Sync params.
import pkg_disp::t_sync;

int unsigned Vs;


t_sync sp = '{ horz_front_porch: 80, horz_sync: 40, horz_back_porch: 80, horz_pix: `x_max,
				  
				  vert_front_porch: 80, vert_sync: 60, vert_back_porch: 80, vert_pix: `y_max };

				
    
 pll	pll_inst(.refclk(clk), .rst(1'b0), .outclk_0(w_clk_x10), .outclk_1(w_clk_pix), .outclk_2(w_clk_avl));

 
 hdmi hdmi_inst(.clk_x10(w_clk_x10), .clk_pix(w_clk_pix), .red(r), .green(g), .blue(b), .sp(sp),
 
								  .red_p(red), .green_p(green), .blue_p(blue), .clk_p(sclk), .x(x), .y(y));
				  		
	
	
						
	always_ff @(posedge w_clk_pix) begin
	
	
		case(state)
			

			SS0: if (st == S4)
			        state <= SS1;
					  
					  
			SS1: begin
			
				
					 x <= (x == (sp.horz_pix + sp.horz_front_porch + sp.horz_sync + sp.horz_back_porch - 1'b1)) ? 1'b0 : (x + 1'b1);

					 if (x == (sp.horz_pix + sp.horz_front_porch + sp.horz_sync + sp.horz_back_porch - 1'b1))
						 y <= (y == (sp.vert_pix + sp.vert_front_porch + sp.vert_sync + sp.vert_back_porch - 1'b1)) ? 1'b0 : (y + 1'b1);

						 
					 if (x < `x_max)
						 {r, g, b} <= fb_mem[x[9:0]];
					 
				  end
			
				  default: ;
	
		endcase
			
	end	

	

		
	always_ff @(posedge w_clk_avl) begin
		
 		
		
		case(st)
			

			INI: begin
			
					burstcount <= 128;
					byteenable <= 4'b1111;
								
				   Vs <= sp.vert_front_porch + sp.vert_sync + sp.vert_back_porch + sp.vert_pix;
				   st <= S0;
				 end
				 
				 
			S0: if (w_full == 8'ha5) begin
					
					 size <= max;
					 addr <= w_start_addr >> 2;
					 st <= S1;
				 end
			
// next burst.	
			NB: begin
			
					addr <= addr + burstcount;
					st <= S1;
				 end
			
			
			S1: begin
			
					 n <= 0;
					 address <= addr;
					 read <= 1'b1;
					 st <= S2;
				 end

			
			S2: if (waitrequest == 1'b0) begin
			
					 read <= 1'b0;
					 st <= S3;
				 end
					
			
			S3: begin
			
					if (readdatavalid) begin
					
						fb_mem[np] <= readdata;
						
						n <= n + 1;
						np <= np + 1;	
					end
					else begin
					
							 if (np == `x_max) begin
							 								 
							    np <= 0;
								 size <= size - `x_max;
							    st <= S4;
							 end
							 else if (n == burstcount)						 
										st <= NB;
					end
					
				 end
								
			
			S4: if (x > `x_max)
					 st <= size ? NB : S5;
// Vsync.
			S5: if (y == (Vs - 1))
					 st <= S0;
				
				
		   default: ;
		
		endcase
		
 end
 

	soc_design u0 (			
	
		.clk_clk                	  (w_clk_avl),
				
		.memory_mem_a        (HPS_DDR3_ADDR),
		.memory_mem_ba       (HPS_DDR3_BA),
		.memory_mem_ck       (HPS_DDR3_CK_P),
		.memory_mem_ck_n     (HPS_DDR3_CK_N),
		.memory_mem_cke      (HPS_DDR3_CKE),
		.memory_mem_cs_n     (HPS_DDR3_CS_N),
		.memory_mem_ras_n    (HPS_DDR3_RAS_N),
		.memory_mem_cas_n	  (HPS_DDR3_CAS_N),
		.memory_mem_we_n	  (HPS_DDR3_WE_N),
		.memory_mem_reset_n	  (HPS_DDR3_RESET_N),
		.memory_mem_dq       (HPS_DDR3_DQ),
		.memory_mem_dqs      (HPS_DDR3_DQS_P),
		.memory_mem_dqs_n    (HPS_DDR3_DQS_N),
		.memory_mem_odt       (HPS_DDR3_ODT),
		.memory_mem_dm       (HPS_DDR3_DM),
		.memory_oct_rzqin        (HPS_DDR3_RZQ),

		
// AVALON						
		.ddr_address(address),

		.ddr_burstcount(burstcount),

		.ddr_byteenable(byteenable),

		.ddr_waitrequest(waitrequest),

// read.		
		.ddr_read(read),
		
		.ddr_readdata(readdata),
		
		.ddr_readdatavalid(readdatavalid),
		
// write.		
		.ddr_writedata(writedata),
		.ddr_write(write),
		
		.full_external_connection_export(w_full),
		
		.start_address_external_connection_export(w_start_addr)
	);
	
endmodule: fb_top
