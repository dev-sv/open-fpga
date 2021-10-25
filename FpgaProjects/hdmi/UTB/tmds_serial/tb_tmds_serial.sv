

`timescale 1 ps / 1 ps


`include "../../UTB/tmds_serial/UTTestSerial.svh"


module tb_tmds_serial;

 
 hdmi_if dif();
 
 
initial begin


 dif.clk_x10 = 0;
  
 forever #10 dif.clk_x10 = ~dif.clk_x10;

end


initial begin

 uvm_config_db #(virtual hdmi_if)::set(null, "*", "serial", dif);

 run_test("UTTest_1");

end



 tmds_serial tmds_serial_dut(.clk_x10(dif.clk_x10), .d(dif.d), .pair(dif.pair)); 


endmodule: tb_tmds_serial
