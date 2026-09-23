//   Written by: Lily Anfang
//   Email: lanfang@g.hmc.edu
//   Date: 2026/09/11
//   Description: this is the multiplexing counter module. It modulates 
//	 which 7 segment display is turned on and being fed info.
//	 modified 9/19 to eliminate logic accounting for pushbutton input
//	 Tested: Y

module lab3_muxcounter(input  logic 	   clk,
					   input  logic 	   reset,
					   input  logic [3:0]  switch0,
					   input  logic [3:0]  switch1,
					   output logic [3:0]  switch,
					   output logic [1:0]  anode);
	
	//clock at 60 Hz
	logic [31:0] count;
	lab3_counter	#(.WIDTH(31), .MAX(100000)) count1(clk, 1'b1, reset, count);
	logic clk60;
	assign clk60=(count>50000);
	
	//mux
	assign anode = {clk60 & reset, ~clk60 & reset};
	assign switch= clk60 ? switch1 : switch0;

endmodule