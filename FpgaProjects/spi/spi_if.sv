

interface spi_if;


 bit sclk, ss, miso, mosi;
	  
 bit[31:0] nb_wr, 
			  nb_rd, 
           in_data,
			  out_data;
			  
 bit[1:0]  mode;
 
 
 modport spi(input miso,  
             output sclk, ss, mosi);                    
 
endinterface
