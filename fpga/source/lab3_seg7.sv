//   Written by: Lily Anfang
//   Email: lanfang@g.hmc.edu
//   Date: 2026/09/06
//   Description: this is the module for converting 4 bit binary numbers 
//   (input by the system) into their hex equivilents on a 7-segment
//   display.
//	 Tested: Y

module lab3_seg7(input  logic [3:0] s,
					output logic [6:0] seg);
	//label segments with their associated letter
	logic A, B, C, D, E, F, G;
	always_comb //depending on the switch values, turn the necessary LEDs off
		case (s)
			4'b0000:  	 begin A=1; B=1; C=1; D=1; E=1; F=1; G=0; end
			4'b0001:  	 begin A=0; B=1; C=1; D=0; E=0; F=0; G=0; end
			4'b0010:  	 begin A=1; B=1; C=0; D=1; E=1; F=0; G=1; end
			4'b0011:  	 begin A=1; B=1; C=1; D=1; E=0; F=0; G=1; end
			4'b0100:  	 begin A=0; B=1; C=1; D=0; E=0; F=1; G=1; end
			4'b0101:  	 begin A=1; B=0; C=1; D=1; E=0; F=1; G=1; end
			4'b0110:  	 begin A=1; B=0; C=1; D=1; E=1; F=1; G=1; end
			4'b0111:  	 begin A=1; B=1; C=1; D=0; E=0; F=0; G=0; end
			4'b1001:  	 begin A=1; B=1; C=1; D=0; E=0; F=1; G=1; end
			4'b1010: 	 begin A=1; B=1; C=1; D=0; E=1; F=1; G=1; end
			4'b1011: 	 begin A=0; B=0; C=1; D=1; E=1; F=1; G=1; end
			4'b1100: 	 begin A=1; B=0; C=0; D=1; E=1; F=1; G=0; end
			4'b1101: 	 begin A=0; B=1; C=1; D=1; E=1; F=0; G=1; end
			4'b1110: 	 begin A=1; B=0; C=0; D=1; E=1; F=1; G=1; end
			4'b1111: 	 begin A=1; B=0; C=0; D=0; E=1; F=1; G=1; end
			default: 	 begin A=1; B=1; C=1; D=1; E=1; F=1; G=1; end //also the setting for 8
		endcase
	//assign the letter values to their associated segment
	assign seg[6] = ~A;
	assign seg[5] = ~B;
	assign seg[4] = ~C;
	assign seg[3] = ~D;
	assign seg[2] = ~E;
	assign seg[1] = ~F;
	assign seg[0] = ~G;
endmodule