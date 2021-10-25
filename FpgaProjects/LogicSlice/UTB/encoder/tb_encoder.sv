

`timescale 1 ps / 1 ps



`include "../../UTB/encoder/UTTestEncoder.svh"


module tb_encoder;
 
 
 ls_if encoder();

 
initial begin

 encoder.clk_pix = 0;

 forever #1 encoder.clk_pix = ~encoder.clk_pix;

end
 

initial begin


 uvm_config_db #(virtual ls_if)::set(null, "*", "encoder", encoder);

 run_test("UTTest_0");

end
 

 encoder encoder_dut(.clk(encoder.clk_pix), .en(1'b1), .e(encoder.e_in), .p(encoder.p), .data(encoder.data));

endmodule: tb_encoder
