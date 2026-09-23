//   Written by: Lily Anfang
//   Email: lanfang@g.hmc.edu
//   Date: 2026/09/19
//   Description: this module debounces an input using a counter design
//	 it checks every 2ms if the time the bit was on was greater or less
//	 than 50%
//	 Tested: Y

module lab3_debounce #(parameter MAX=12000, 
					   parameter HALFMAX=6000)
					 (input  logic clk, 
					  input  logic reset,
					  input  logic enable,
					  input  logic startdb,
					  input  logic bit_in,
					  output logic enablepress,
				      output logic bit_out);
					  
	logic [31:0] counter, counton;
	always_ff @(posedge clk, negedge reset) begin //for reset as a pushbutton
		if(~reset) begin 
			counter<=0;
			counton<=0;
			enablepress<=0;
			bit_out<=0; 
		end
		else if(startdb) begin 
			counter<=0;
			counton<=0;
			enablepress<=0;
		end
		else if(enable&(~(counter==MAX))) begin
			counter <= counter+1;
			if(bit_in) counton<=counton+1;
			enablepress<=0;
		end
		else if(counter==MAX) begin
			if(counton>=HALFMAX) bit_out<=1'b1;
			else bit_out<=1'b0;
			enablepress<=1;
		end
	end
endmodule