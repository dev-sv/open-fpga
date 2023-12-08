


module tmds_encoder(input wire clk, input wire de, input wire[1:0] vh, input wire[7:0] color, output bit[9:0] out);



 const bit[9:0] code[4] = '{10'b0010101011, 10'b1101010100,
                            10'b0010101010, 10'b1101010101};
									 

	logic[3:0] balance_acc = 0;
		
	wire[3:0] N1 = color[0] + color[1] + color[2] + color[3] + color[4] + color[5] + color[6] + color[7];
		
	wire      XNOR = (N1 > 4'd4) || (N1 == 4'd4 && color[0] == 1'b0);
		
	
	wire[8:0] q_m = {~XNOR, q_m[6:0] ^ color[7:1] ^ {7{XNOR}}, color[0]};	
		
	wire[3:0] balance = q_m[0] + q_m[1] + q_m[2] + q_m[3] + q_m[4] + q_m[5] +q_m[6] + q_m[7] - 4'd4;		
		
	wire[3:0] balance_sign_eq = (balance[3] == balance_acc[3]); 

	wire      invert_q_m = (balance == 0 || balance_acc == 0) ? ~q_m[8] : 0;
		
	wire[3:0] balance_acc_inc = balance - ({q_m[8] ^ ~balance_sign_eq} & ~(balance == 0 || balance_acc == 0));
		
	wire[3:0] balance_acc_new = invert_q_m ? (balance_acc - balance_acc_inc) : (balance_acc + balance_acc_inc);
	
	wire[9:0] tmds_data = {invert_q_m, q_m[8], q_m[7:0] ^ {8{invert_q_m}}};
								  
	wire[9:0] tmds_code = vh[1] ? (vh[0] ? code[3] : code[2]) : (vh[0] ? code[1] : code[0]);


	always @(posedge clk) begin		
		
	
		out <= de ? tmds_data : tmds_code;
		
		balance_acc <= de ? balance_acc_new : 4'h0;
		
	end
							  
							  
endmodule: tmds_encoder
