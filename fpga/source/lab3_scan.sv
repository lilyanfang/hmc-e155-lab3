//   Written by: Lily Anfang
//   Email: lanfang@g.hmc.edu
//   Date: 2026/09/11
//   Description: this module controls the scanning state//	 modified numbers from lab 2
//	 Tested: Y

module lab3_scan(input logic reset,
					input logic enable,
					input logic clk,
					output logic [3:0] state,
					output logic startdb);
									
	// "clk" for cycling count 100Hz 
	logic [31:0] count;
	lab3_counter	#(.WIDTH(31), .MAX(60000)) count2(clk, enable, reset, count);
	
	// assign statements for keypad
	//nots are to account for hardware giving inverse wave
	assign state[0]=((count<15000)&reset);
	assign state[1]=(((count>=15000)&(count<30000))&reset);
	assign state[2]=(((count>=30000)&(count<45000))&reset);
	assign state[3]=((count>=45000)&reset);
	assign startdb = ((count==0)||(count==15000)||(count==30000)||(count==45000));
	
endmodule