//   Written by: Lily Anfang
//   Email: lanfang@g.hmc.edu
//   Date: 2026/09/22
//   Description: This is the FSM that determines whether the input is valid and should 
//   enable the output
//	 Tested: Y

module lab3_inputflags(input  logic 	   clk,
					   input  logic 	   reset,
					   input  logic [15:0] keypress,
                       input  logic        held,
					   output logic 	   enable);
	logic nopress, multipress, valid;
	logic [15:0] out1, out2;
	
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
	
	assign valid = ((~multipress)&(~nopress)&(~held));

	//setup states and nextstates
	logic [1:0] state, nextstate;
	always_comb
		case (state)
			2'b00:  if (nopress) nextstate=2'b01;
				else if (multipress|held) nextstate=2'b11;
				else if (valid) nextstate=2'b10;
                else nextstate=2'b00;
			2'b01:  if (nopress) nextstate=2'b01;
				else if (multipress) nextstate=2'b11;
				else if (valid|held) nextstate=2'b10;
                else nextstate=2'b00;
			2'b10:  if (nopress) nextstate=2'b01;
				else if (multipress|held) nextstate=2'b11;
				else if (valid) nextstate=2'b10;
                else nextstate=2'b00;
			2'b11:  if (nopress) nextstate=2'b01;
				else if (multipress|held) nextstate=2'b11;
				else if (valid) nextstate=2'b10;
                else nextstate=2'b00;
		endcase

	//flip flop
	always_ff @(posedge clk, negedge reset) begin
        if (~reset)
            state<=2'b00;
        else
		    state<=nextstate;
	end

	//ouput logic
	always_comb 
		case (state)
			2'b10: enable = 1;
			default: enable = 0;
		endcase

endmodule