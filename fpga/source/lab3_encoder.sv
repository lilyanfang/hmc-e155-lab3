//   Written by: Lily Anfang
//   Email: lanfang@g.hmc.edu
//   Date: 2026/09/20
//   Description: This module encodes 16 bit signals into 4 bit signals
//	 Tested: Y

module lab3_encoder(input  logic [15:0] inputs,
					output  logic [3:0]  outputs);
	always_comb
		case (inputs)
			16'h0002: outputs = 4'b0001;
			16'h0004: outputs = 4'b0010;
			16'h0008: outputs = 4'b0011;
			16'h0010: outputs = 4'b0100;
			16'h0020: outputs = 4'b0101;
			16'h0040: outputs = 4'b0110;
			16'h0080: outputs = 4'b0111;
			16'h0100: outputs = 4'b1000;
			16'h0200: outputs = 4'b1001;
			16'h0400: outputs = 4'b1010;
			16'h0800: outputs = 4'b1011;
			16'h1000: outputs = 4'b1100;
			16'h2000: outputs = 4'b1101;
			16'h4000: outputs = 4'b1110;
			16'h8000: outputs = 4'b1111; 
			default:  outputs = 4'b0000;
		endcase 
endmodule