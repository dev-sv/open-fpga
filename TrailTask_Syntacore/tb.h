

enum {EQ, NEQ} t_cmp; 

string str, ops;


`define COMP(a, b, op) \
 case(op) \
	EQ:  begin \
          ops = "EQ"; \
	       assert(a == b) \
                 str = "OK"; \
			 else str = "Error"; \
	     end \
	NEQ: begin \
			 ops = "NEQ"; \
	       assert(a != b) \
                 str = "OK"; \
			 else str = "Error"; \
        end \
 endcase \
 $display("op: %s  a = %x b = %x %s.", ops, a, b, str);
