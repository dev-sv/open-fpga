

package pkg_mst;

typedef struct {
 
	bit       req;
	bit       cmd; 
	bit[31:0] addr;
	bit[31:0] data;
  
} t_mst;

endpackage 


package pkg_slv;

typedef struct {
 
	bit       ack;
	bit[31:0] data;
  
} t_slv;

endpackage 


package pkg_st;

typedef enum {ADDR, CMD, ACK, RD} t_st;

endpackage
