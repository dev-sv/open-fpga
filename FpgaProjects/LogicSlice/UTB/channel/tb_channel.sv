

`timescale 1 ps / 1 ps



`include "../../UTB/channel/UTTestChannel.svh"


module tb_channel;
 
 
 ls_if channel();

 
initial begin


 channel.clk = 0;

 forever #1  channel.clk = ~channel.clk;

end
 

initial begin


 uvm_config_db #(virtual ls_if)::set(null, "*", "channel", channel);

 run_test("UTTest_0");

end
 
 
	channel channel_dut(.clk(channel.clk), .in(channel.in), .n(channel.n), .np(channel.np), .ch(channel.ch), .sel_ch(channel.sel_ch));


endmodule: tb_channel

