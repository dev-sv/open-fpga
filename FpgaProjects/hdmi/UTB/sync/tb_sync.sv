

`timescale 1 ps / 1 ps


`include "../../UTB/sync/UTTestSync.svh"


module tb_sync;


 import uvm_pkg::*;
 
 
 hdmi_if dif();
 

initial begin

 dif.clk_pix = 0;

 forever #1 dif.clk_pix = ~dif.clk_pix;

end


initial begin

 uvm_config_db #(virtual hdmi_if)::set(null, "*", "sync", dif);

 run_test("UTTest_0");

end


	sync sync_dut(.clk(dif.clk_pix), .s(dif.s_de_vh), .sp(dif.sp), .x(dif.x), .y(dif.y));

endmodule: tb_sync
