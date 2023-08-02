


module hdmi_top(

		input wire 		clk,		
		input          reset,
				
      output[14:0] 	HPS_DDR3_ADDR,
      output[2:0]  	HPS_DDR3_BA,
      output       	HPS_DDR3_CAS_N,
      output       	HPS_DDR3_CKE,
      output       	HPS_DDR3_CK_N,
      output       	HPS_DDR3_CK_P,
      output       	HPS_DDR3_CS_N,
      output[3:0]  	HPS_DDR3_DM,
      inout [31:0] 	HPS_DDR3_DQ,
      inout [3:0]  	HPS_DDR3_DQS_N,
      inout [3:0]  	HPS_DDR3_DQS_P,
      output        	HPS_DDR3_ODT,
      output        	HPS_DDR3_RAS_N,
      output        	HPS_DDR3_RESET_N,
      input          HPS_DDR3_RZQ,
      output       	HPS_DDR3_WE_N,
		
		output wire 	hdmi_clk_pix_p,
		output wire 	hdmi_clk_pix_n,
		output wire 	hdmi_red_p,
		output wire 	hdmi_red_n,
		output wire 	hdmi_green_p,
		output wire 	hdmi_green_n,
		output wire 	hdmi_blue_p,
		output wire 	hdmi_blue_n			
);






	hdmi_qsys hdmi_inst(
	
		.clk_clk            (clk),
		
		.hdmi_clk_pix_p     (hdmi_clk_pix_p),
		.hdmi_clk_pix_n     (hdmi_clk_pix_n),
		.hdmi_red_p         (hdmi_red_p),
		.hdmi_red_n         (hdmi_red_n),
		.hdmi_green_p       (hdmi_green_p),
		.hdmi_green_n       (hdmi_green_n),
		.hdmi_blue_p        (hdmi_blue_p),
		.hdmi_blue_n        (hdmi_blue_n),
				
		.memory_mem_a       (HPS_DDR3_ADDR),
		.memory_mem_ba      (HPS_DDR3_BA),
		.memory_mem_ck      (HPS_DDR3_CK_P),
		.memory_mem_ck_n    (HPS_DDR3_CK_N),
		.memory_mem_cke     (HPS_DDR3_CKE),
		.memory_mem_cs_n    (HPS_DDR3_CS_N),
		.memory_mem_ras_n   (HPS_DDR3_RAS_N),
		.memory_mem_cas_n	  (HPS_DDR3_CAS_N),
		.memory_mem_we_n	  (HPS_DDR3_WE_N),
		.memory_mem_reset_n (HPS_DDR3_RESET_N),
		.memory_mem_dq      (HPS_DDR3_DQ),
		.memory_mem_dqs     (HPS_DDR3_DQS_P),
		.memory_mem_dqs_n   (HPS_DDR3_DQS_N),
		.memory_mem_odt     (HPS_DDR3_ODT),
		.memory_mem_dm      (HPS_DDR3_DM),
		.memory_oct_rzqin   (HPS_DDR3_RZQ)
		
	);

endmodule: hdmi_top
