//   Written by: Lily Anfang
//   Email: lanfang@g.hmc.edu
//   Date: 2026/09/20
//   Description: this is the testbench to test the lab 3 pressed module

module lab3_pressed_tb();
	
	logic clk, reset;
	logic [3:0] enable, row, col;
	logic [15:0] keypress;
	
	lab3_pressed dut(.clk(clk), .reset(reset), .enable(enable), .row(row), .col(col), .keypress(keypress));
	
	always begin
		clk=1; #1;
		clk=0; #1;
	end
	
	initial begin
		row = 4'b0001;
		col = 4'b1000;
		reset = 1;
		enable = 4'b0000;
		#6
		//test reset overrides enable
		reset=0;
		#3
		enable=4'b1111;
		#2
		reset=1;
		
		//test functionality for row 0 & col 3
		#3
		assert (keypress == 16'h0400)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		#2
		
		//test functionality of enable
		enable = 4'b0000;
		row = 4'b1000;
		col = 4'b0010;
		#2
		assert (keypress == 16'h0400)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		
		//test functionality of row 3 & col 1, test multi row read		
		#2
		enable = 4'b1111;
		#2
		assert (keypress == 16'h0401)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		#2
			
		//test functionality of row 1 & col 2
		row = 4'b0010;
		col = 4'b0100;
		#2
		assert (keypress == 16'h0441)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		
		//test functionality of row 2 & col 0, test inputs reset with row cue
		row = 4'b1000;
		col = 4'b0000;
		#2
		row = 4'b0001;
		col = 4'b0000;
		#2
		row = 4'b0010;
		col = 4'b0000;
		#2
		row = 4'b0100;
		col = 4'b0001;
		#2
		assert (keypress == 16'h0080)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
			
		//test multi column read
		row = 4'b1000;
		col = 4'b0000;
		#2
		row = 4'b0001;
		col = 4'b0000;
		#2
		row = 4'b0010;
		col = 4'b0000;
		#2
		row = 4'b0100;
		col = 4'b0111;
		#2
		assert (keypress == 16'h0380)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
	$stop;	
	end	
	
endmodule