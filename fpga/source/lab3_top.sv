//   Written by: Lily Anfang
//   Email: lanfang@g.hmc.edu
//   Date: 2026/09/19
//   Description: this is the top level module for lab 3. This
//	 module controls 2 different 7-segment displays by 
//	 multiplexing between them at a rate of 80Hz where the output
//	 is the 2 most recent keypad keys pressed. 
//	 Tested: N

module lab3_top(input  logic 	   reset,
				input  logic [3:0] scancol,
				output logic [3:0] keypadrows,
				output logic [6:0] seg7,
				output logic [1:0] anode);
				
	// internal clock at 6MHz
	logic clk;
	HSOSC #(.CLKHF_DIV("0b11"))
         hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk)); //drive clk @ 6MHz
		 
	// cannonical FSM controling the state of the scan output
	logic enable, startdb;
	logic [3:0] scanstate;
	assign enable=1'b1;
	lab3_scan scanner(reset, enable, clk, scanstate, startdb);
		 
	// synchronizer for the inputs from scanning the keypad
	logic [3:0] colsync; //synced scanner
	lab3_sync sync(clk, reset, scancol, colsync);
	
	// debounce the inputs from the synchronizer (can add enable input later if needed)
	logic [3:0] scandb, enablepress; //debounced and synced scan
	lab3_debounce db0(clk, reset, startdb, ~colsync[0], enablepress[0], scandb[0]);
	lab3_debounce db1(clk, reset, startdb, ~colsync[1], enablepress[1], scandb[1]);
	lab3_debounce db2(clk, reset, startdb, ~colsync[2], enablepress[2], scandb[2]);
	lab3_debounce db3(clk, reset, startdb, ~colsync[3], enablepress[3], scandb[3]);
	
	// determine which keys are being pressed
	logic [15:0] keypress;
	lab3_pressed pressed(clk, reset, enablepress, scanstate, scandb, keypress);
	
	// determine which keys should be added to the seg7 display
	logic [3:0] numb1, numb2;
	lab3_displaystate displaystate(clk, reset, keypress, numb1, numb2);
	
	// mux output
	logic [3:0] numb;
	lab3_muxcounter mux(clk, reset, numb2, numb1, numb, anode);
	
	// 7-segment display output
	lab3_seg7 seg7display(numb, seg7);
	
	// assign logic for keypad output
	assign keypadrows = scanstate;
endmodule
				