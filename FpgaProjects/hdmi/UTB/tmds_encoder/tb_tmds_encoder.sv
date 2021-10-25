

`timescale 1 ps / 1 ps


`include "../../UTB/tmds_encoder/UTTestEncoder.svh"


module tb_tmds_encoder;

 
 hdmi_if dif();
 
 
initial begin


 dif.clk_pix = 0;
  
 forever #1 dif.clk_pix = ~dif.clk_pix;

end


initial begin

 uvm_config_db #(virtual hdmi_if)::set(null, "*", "encoder", dif);

 run_test("UTTest_0");

end


 tmds_encoder tmds_encoder_dut(.clk(dif.clk_pix), .e(dif.e_de_vh), .color(dif.color), .out(dif.out));


endmodule: tb_tmds_encoder
