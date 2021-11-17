
Hardware:
Evoluation board RZ-EasyFPGA A2.2
www.rzrd.net.
Cyclone IV	Fosc = 50MHz.

Lcd 12864b.

Pin assignment:

osc		23
rs			141
rw			138
e			143
data[0]	142
data[1]	1
data[2]	144
data[3]	3
data[4]	2
data[5]	10
data[6]	7
data[7]	11


In order to run testbench: 

 1. Create some folder (for example c:/git)
 
 2. cd git
 
 3. git clone https://github.com/dev-sv/open-fpga.git
 
 4. load project in Quartus
 
 5. run ModelSim

 6. run do script

	> do lcd.do
   > do queue.do	

	
Path tp scripts:
	
C:/git/open-fpga/FpgaProjects/lcd_12864b/simulation/modelsim/*.do


If you create your own folder insted of "git", then change variable  PRJ_DIR

set PRJ_DIR "c:/your_own_folder/open-fpga/FpgaProjects/lcd_12864b"
 
