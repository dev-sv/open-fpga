


module tmds_encoder(input bit clk, hdmi_if.e_de_vh e, input logic[7:0] color, output logic[9:0] out);


 import pkg_disp::code;



	logic[3:0] balance_acc = 0;
		
	wire[3:0] N1 = color[0] + color[1] + color[2] + color[3] + color[4] + color[5] + color[6] + color[7];
		
	wire      XNOR = (N1 > 4'd4) || (N1 == 4'd4 && color[0] == 1'b0);
		
	wire[8:0] q_m = {~XNOR, q_m[6:0] ^ color[7:1] ^ {7{XNOR}}, color[0]};	
		
	wire[3:0] balance = q_m[0] + q_m[1] + q_m[2] + q_m[3] + q_m[4] + q_m[5] +q_m[6] + q_m[7] - 4'd4;		
		
	wire[3:0] balance_sign_eq = (balance[3] == balance_acc[3]); 

	wire      invert_q_m = (balance == 0 || balance_acc == 0) ? ~q_m[8] : balance_sign_eq[0];		
		
	wire[3:0] balance_acc_inc = balance - ({q_m[8] ^ ~balance_sign_eq} & ~(balance == 0 || balance_acc == 0));
		
	wire[3:0] balance_acc_new = invert_q_m ? (balance_acc - balance_acc_inc) : (balance_acc + balance_acc_inc);
	

	wire[9:0] tmds_data = {invert_q_m, q_m[8], q_m[7:0] ^ {8{invert_q_m}}};
							  
	wire[9:0] tmds_code = e.vh[1] ? (e.vh[0] ? pkg_disp::code[3] : pkg_disp::code[2]) : (e.vh[0] ? pkg_disp::code[1] : pkg_disp::code[0]);


	always @(posedge clk) begin		

		out <= e.de ? tmds_data : tmds_code;
		balance_acc <= e.de ? balance_acc_new : 4'h0;
		
	end
							  
							  
endmodule: tmds_encoder
