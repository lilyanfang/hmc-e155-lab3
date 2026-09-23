//   Written by: Lily Anfang
//   Email: lanfang@g.hmc.edu
//   Date: 2026/09/19
//   Description: this is the testbench to test the lab 3 sync module

module lab3_sync_tb();
	
	logic clk, reset;
	logic [3:0] scan, scan_new;

	
	lab3_sync dut(.clk(clk), .reset(reset), .scan(scan), .scan_new(scan_new));
	always begin
		clk=1; #5;
		clk=0; #5;
	end
	
	initial begin
		
		//test reset
		scan=4'b0101;
		reset=1; #22;
		reset=0; #20;
		reset=1;
		
		//test etime for output to change
		scan=4'b0101; #10;
		scan=4'b0111; #7;
		scan=4'b1000; #11;
		scan=4'b1100; #45;
		
		//test reset sets counter back to zero
		reset=0;
		#20;
		$stop;		
	end
endmodule