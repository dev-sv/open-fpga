
IDE Quartus Prime Lite Edition 18.0.0

Hardware: max10 10M50SAE144C8G

 4 channels input.
 Frequency input range: 50 kHz - 50 MHz.
 Frequency sampling   : 200 MHz.
						

Scripts path.
c:/git/open-fpga/FpgaProjects/LogicSlice/simulation/modelsim/*.do

UVM testbench path (UTB).
c:/git/open-fpga/FpgaProjects/LogicSlice/UTB

Doc path.
c:/git/open-fpga/FpgaProjects/LogicSlice/Doc


Waveform path.
c:/git/open-fpga/FpgaProjects/LogicSlice/UTB/wave
c:/git/open-fpga/FpgaProjects/LogicSlice/UTB/encoder
c:/git/open-fpga/FpgaProjects/LogicSlice/UTB/channel
c:/git/open-fpga/FpgaProjects/LogicSlice/UTB/debouncer
				
		
		

In order to run testbench: 

 1. Create some folder (for example c:/git)
 
 2. cd git
 
 3. git clone https://github.com/dev-sv/open-fpga.git
 
 4. load project in Quartus
 
 5. run ModelSim

	 You will get
	 
 ** Error: (vlog-7) Failed to open design unit file "C:/git/open-fpga/FpgaProjects/hdmi/ddio.vo" in read mode.						
 
	 don't pay attention, do next step (6).
 

 6. run do script
 
    Before running scripts, in file ls_if.sv find  task automatic set_string(), 
	 and comment it:
	 
	 /*
	 
		task automatic set_string();
		.
		.
		.
		endtask		
	 
	 */
	
    Otherwise	you will get:
	 
** Error: c:/git/open-fpga/FpgaProjects/LogicSlice/ls_if.sv(57): Questa has encountered an unexpected 
   internal error: ../../src/vlog/vgencode.c(118). Please contact Questa support at http://supportnet.mentor.com/	 

	Then run scripts.
	
	> do encoder.do
   > do channel.do	
   > do debouncer.do	
	> do wave.do
	

If you create your own folder insted of "git", then change variable  PRJ_DIR
set PRJ_DIR "c:/your_own_folder/open-fpga/FpgaProjects/LogicSlice"
