


`timescale 1 ps / 1 ps



`include "../../UTB/wave/UTTestWave.svh"


module tb_wave;
 
 
 ls_if wave();
 
 
initial begin
 
	  
 wave.clk_pix = 0;
 
 forever #1 wave.clk_pix = ~wave.clk_pix;

end
 

initial begin


 uvm_config_db #(virtual ls_if)::set(null, "*", "wave", wave);

 run_test("UTTest_0");

end
 

	wave wave_dut(.clk_pix(wave.clk_pix), .x(wave.x), .y(wave.y), .p(wave.wp), .scan_data(wave.scan_data), 
					  .curs_data(wave.curs_data), .set_curs(wave.set_curs), .np(wave.np), .ch(wave.ch), .red(wave.red), .green(wave.green), 
					  .blue(wave.blue), .s(wave.s), .sel_ch(wave.sel_ch) );
 
endmodule: tb_wave
