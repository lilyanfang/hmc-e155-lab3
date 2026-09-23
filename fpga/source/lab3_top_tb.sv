//   Written by: Lily Anfang
//   Email: lanfang@g.hmc.edu
//   Date: 2026/09/19
//   Description: this is the testbench for the lab 3 top module
`timescale 100 ns/1 ns
module lab3_top_tb();
	//inputs
	logic reset, clk;
	logic [3:0] scancol;
	//outputs
	logic [3:0] keypadrows;
	logic [6:0] seg7;
	logic [1:0] anode;
	
	lab3_top dut(.reset(reset), .scancol(scancol), .keypadrows(keypadrows), .seg7(seg7), .anode(anode));
	
	always begin
		clk=1; #5;
		clk=0; #5;
	end
	
	initial begin
		
		
		scancol=4'b0111;//account for bit flip from pins pulling high if no output
		reset=0;
		#20000
		reset=1;
		#1 //offset everything by 100ns to make the inputs not line up with the HSOSC waveform
		//test that it only maps 1 output
		#25000;
		scancol=4'b1111;
		#75000;
		scancol=4'b0111;
		#25000;
		scancol=4'b1111;
		#75000;
		scancol=4'b0111;
		#25000;
		scancol=4'b1111;
		#75000;
		scancol=4'b0111;
		#25000;
		scancol=4'b1111;
		#75000;
		
		//test switch bounce
		scancol=4'b1110;
		#1000;
		scancol=4'b1111;
		#1000;
		scancol=4'b1110;
		#800;
		scancol=4'b1111;
		#1200;
		scancol=4'b1110;
		#21000;
		scancol=4'b1111;
		#75000;
		
		//test multi-input
		
				//test that it only maps 1 output
		scancol=4'b0111;
		#25000;
		scancol=4'b1101;
		#25000;
		scancol=4'b1111;
		#50000;
		scancol=4'b0111;
		#25000;
		scancol=4'b1101;
		#25000;
		scancol=4'b1111;
		#50000;
		scancol=4'b0111;
		#25000;
		scancol=4'b1101;
		#25000;
		scancol=4'b1111;
		#60000;
		$stop;
	end
endmodule