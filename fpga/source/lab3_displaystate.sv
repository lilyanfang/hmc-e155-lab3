//   Written by: Lily Anfang
//   Email: lanfang@g.hmc.edu
//   Date: 2026/09/22
//   Description: This is the FSM that determines what the display states are
//	 Tested: Y

module lab3_displaystate(input  logic 		 clk,
						 input  logic 		 reset,
						 input  logic [15:0] keypress,
						 output logic [3:0]  numb1,
						 output logic [3:0]  numb2);

	logic enable;
	logic held;
	lab3_inputflags flags(clk, reset, keypress, held, enable);
	lab3_enableoutput enableoutput(reset, clk, enable, keypress, held, numb1, numb2);

endmodule