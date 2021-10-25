

`timescale 1 ps / 1 ps



`include "../../UTB/debouncer/UTTestDebouncer.svh"


module tb_debouncer;
 
 
 ls_if debouncer();

 
initial begin


 debouncer.clk_pix = 0;

 forever #1 debouncer.clk_pix = ~debouncer.clk_pix;

end
 

initial begin


 uvm_config_db #(virtual ls_if)::set(null, "*", "debouncer", debouncer);

 run_test("UTTest_0");

end
 
 
 debouncer debouncer_dut(.clk(debouncer.clk_pix), .in(debouncer.in), .delay(debouncer.delay), .out(debouncer.out));


endmodule: tb_debouncer
