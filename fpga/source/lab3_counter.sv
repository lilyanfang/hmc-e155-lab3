//   Written by: Lily Anfang
//   Email: lanfang@g.hmc.edu
//   Date Modified: 2026/09/11
//   Description: this is a modified version of the lab 1 counter that has been modified to reflect Prof expectations
//   so it now outputs the count rather than the led state. It has parameters WIDTH and MAX
//	 Tested: Y

module lab3_counter #(parameter WIDTH=31, 
					  parameter MAX=2500000)
					 (input  logic 			  clk, 
					  input  logic 			  enable, 
					  input  logic 			  reset,
				      output logic [WIDTH:0] counter);
					  
	always_ff @(posedge clk, negedge reset) begin //for reset as a pushbutton
		if(~reset) counter<=0;
		else if(enable) begin
			counter <= counter+1;
			if(counter==MAX) counter<=0;
		end
	end
endmodule