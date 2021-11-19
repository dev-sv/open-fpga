
IDE: Quartus Prime Version 18.0.0, ModelSim Starter Edition 10.5 

Hardware:

MAX 10 10M50SAE144C8G
Fosc = 100MHz.

Scripts path.
c:/git/open-fpga/FpgaProjects/hdmi/simulation/modelsim/*.do

UVM testbench path (UTB).
c:/git/open-fpga/FpgaProjects/hdmi/UTB

Doc path.
c:/git/open-fpga/FpgaProjects/hdmi/DOC


Waveform path.
c:/git/open-fpga/FpgaProjects/hdmi/UTB/sync
c:/git/open-fpga/FpgaProjects/hdmi/UTB/tmds_encoder
c:/git/open-fpga/FpgaProjects/hdmi/UTB/tmds_serial



In order to run testbench: 

 1. Create some folder (for example c:/git)
 
 2. cd git
 
 3. git clone https://github.com/dev-sv/open-fpga.git
 
 4. load project in Quartus
 
 5. run ModelSim

 6. run do script

	> do encoder.do
   > do serial.do	
   > do sync.do	
	

If you create your own folder insted of "git", then change variable  PRJ_DIR

set PRJ_DIR "c:/your_own_folder/open-fpga/FpgaProjects/hdmi"
