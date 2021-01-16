


module tmds_encoder(input bit clk, de, input bit[1:0] vh, input logic[7:0]d, output logic[9:0]d_out = 0);


	logic[3:0] balance_acc = 0;
		
	wire[3:0] N1 = d[0] + d[1] + d[2] + d[3] + d[4] + d[5] + d[6] + d[7];
		
	wire      XNOR = (N1 > 4'd4) || (N1 == 4'd4 && d[0] == 1'b0);
		
	wire[8:0] q_m = {~XNOR, q_m[6:0] ^ d[7:1] ^ {7{XNOR}}, d[0]};	
		
	wire[3:0] balance = q_m[0] + q_m[1] + q_m[2] + q_m[3] + q_m[4] + q_m[5] +q_m[6] + q_m[7] - 4'd4;		
		
	wire[3:0] balance_sign_eq = (balance[3] == balance_acc[3]); 

	wire      invert_q_m = (balance == 0 || balance_acc == 0) ? ~q_m[8] : balance_sign_eq;		
		
	wire[3:0] balance_acc_inc = balance - ({q_m[8] ^ ~balance_sign_eq} & ~(balance == 0 || balance_acc == 0));
		
	wire[3:0] balance_acc_new = invert_q_m ? (balance_acc - balance_acc_inc) : (balance_acc + balance_acc_inc);

	wire[9:0] tmds_data = {invert_q_m, q_m[8], q_m[7:0] ^ {8{invert_q_m}}};
							  
	wire[9:0] tmds_code = vh[1] ? (vh[0] ? 10'b1010101011 : 10'b0101010100) : (vh[0] ? 10'b0010101011 : 10'b1101010100);

		
	always @(posedge clk) begin		

		d_out <= de ? tmds_data : tmds_code;
		balance_acc <= de ? balance_acc_new : 4'h0;
		
	end
							  
							  
endmodule: tmds_encoder
