
Hardware:

Evoluation board RZ-EasyFPGA A2.2

www.rzrd.net.
Cyclone IV	Fosc = 50MHz.

max 3232e

Pin assignment:

osc				23
tx					114
rx					115



In order to run testbench: 

 1. Create some folder (for example c:/git)
 
 2. cd git
 
 3. git clone https://github.com/dev-sv/open-fpga.git
 
 4. load project in Quartus
 
 5. run ModelSim

 6. run do script

	> do uart.do

	
Path to scripts:
	
C:/git/open-fpga/FpgaProjects/uart/simulation/modelsim/*.do


If you create your own folder insted of "git", then change variable  PRJ_DIR

set PRJ_DIR "c:/your_own_folder/open-fpga/FpgaProjects/uart"
 
