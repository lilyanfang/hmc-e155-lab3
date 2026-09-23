//   Written by: Lily Anfang
//   Email: lanfang@g.hmc.edu
//   Date: 2026/09/20
//   Description: This is the FSM that determines what the display states are
//	 Tested: Y

module lab3_displaystate(input  logic 		 clk,
						 input  logic 		 reset,
						 input  logic [15:0] keypress,
						 output logic [3:0] numb1,
						 output logic [3:0] numb2);
	logic nopress, multipress, doublepress;
	logic [15:0] state1, state2;
	
	//check if multiple buttons or no buttons are pressed
	always_comb
		case (keypress)
			16'h0001: begin multipress = 0; nopress=0; end
			16'h0002: begin multipress = 0; nopress=0; end
			16'h0004: begin multipress = 0; nopress=0; end
			16'h0008: begin multipress = 0; nopress=0; end
			16'h0010: begin multipress = 0; nopress=0; end
			16'h0020: begin multipress = 0; nopress=0; end
			16'h0040: begin multipress = 0; nopress=0; end
			16'h0080: begin multipress = 0; nopress=0; end
			16'h0100: begin multipress = 0; nopress=0; end
			16'h0200: begin multipress = 0; nopress=0; end
			16'h0400: begin multipress = 0; nopress=0; end
			16'h0800: begin multipress = 0; nopress=0; end
			16'h1000: begin multipress = 0; nopress=0; end
			16'h2000: begin multipress = 0; nopress=0; end
			16'h4000: begin multipress = 0; nopress=0; end
			16'h8000: begin multipress = 0; nopress=0; end
			16'h0000: begin multipress = 0; nopress=1; end
			default:  begin multipress = 1; nopress=0; end
		endcase 
			
	always_ff @(posedge clk, negedge reset) begin
		if (~reset) begin
			state1<=16'b0;
			state2<=16'b0;
			doublepress<=1'b0;
		end
		else if (nopress)
			doublepress<=1;
		else if ((~nopress)&(~multipress))
			if (keypress!=state1) begin
				state1<=keypress;
				state2<=state1;
				doublepress<=0;
			end
			else if (doublepress) begin
				state1<=keypress;
				state2<=state1;
				doublepress<=0;
			end
	end
	//output logic
	lab3_encoder encode1(state1, numb1);
	lab3_encoder encode2(state2, numb2);

endmodule