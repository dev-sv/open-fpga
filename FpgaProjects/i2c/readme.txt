
Hardware:

Evoluation board RZ-EasyFPGA A2.2

www.rzrd.net.
Cyclone IV	Fosc = 50MHz.

Lcd 1602 (PCF8574 i/o expander for i2c, Power supply 5V).

Real time clock ds1307. (Power supply 5V).

Flash memory at24c04.   (Power supply 5V).


Pin assignment:

osc				23

sda_at24c04		66
sclk_at24c04	64

sda_ds1307		55
sclk_ds1307		53

sda_lcd			51
sclk_lcd			49


In order to run testbench: 

 1. Create some folder (for example c:/git)
 
 2. cd git
 
 3. git clone https://github.com/dev-sv/open-fpga.git
 
 4. load project in Quartus
 
 5. run ModelSim

 6. run do script

	> do i2c_wr.do
   > do i2c_rd.do	

	
Path tp scripts:
	
C:/git/open-fpga/FpgaProjects/i2c/simulation/modelsim/*.do


If you create your own folder insted of "git", then change variable  PRJ_DIR

set PRJ_DIR "c:/your_own_folder/open-fpga/FpgaProjects/i2c"
