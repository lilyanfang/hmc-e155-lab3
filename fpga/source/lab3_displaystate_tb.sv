//   Written by: Lily Anfang
//   Email: lanfang@g.hmc.edu
//   Date: 2026/09/20
//   Description: testbench for the lab3 display state

module lab3_displaystate_tb();
	
	logic clk, reset;
	logic [15:0] keypress;
	logic [3:0] numb1, numb2;
	
	lab3_displaystate dut(.clk(clk), .reset(reset), .keypress(keypress), .numb1(numb1), .numb2(numb2));
	
	always begin
		clk = 1;
		#1;
		clk=0;
		#1;
	end
	
	initial begin
		keypress = 16'h0001;
		reset = 1;
		#3
		reset = 0;
		#2
		assert (numb1 == 4'b0000)       // check outputs
            $display("PASSED! numb1 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb1 behaves incorrectly at time: %0t.", $time);
		assert (numb2 == 4'b0000)       // check outputs
            $display("PASSED! numb2 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The numb2 behaves incorrectly at time: %0t.", $time);	
		#2
		reset = 1;
		
		
		//test all single input cases
		#2
		assert (numb1 == 4'b0000)       // check outputs
            $display("PASSED! numb1 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb1 behaves incorrectly at time: %0t.", $time);
		assert (numb2 == 4'b0000)       // check outputs
            $display("PASSED! numb2 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The numb2 behaves incorrectly at time: %0t.", $time);	
		#2
		
		keypress = 16'h0002;
		#4
		assert (numb1 == 4'b0001)       // check outputs
            $display("PASSED! numb1 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb1 behaves incorrectly at time: %0t.", $time);
		assert (numb2 == 4'b0000)       // check outputs
            $display("PASSED! numb2 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The numb2 behaves incorrectly at time: %0t.", $time);	
		#2
		
		keypress = 16'h0004;
		#2
		assert (numb1 == 4'b0010)       // check outputs
            $display("PASSED! numb1 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb1 behaves incorrectly at time: %0t.", $time);
		assert (numb2 == 4'b0001)       // check outputs
            $display("PASSED! numb2 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The numb2 behaves incorrectly at time: %0t.", $time);	
		#2
		
		keypress = 16'h0008;
		#2
		assert (numb1 == 4'b0011)       // check outputs
            $display("PASSED! numb1 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb1 behaves incorrectly at time: %0t.", $time);
		assert (numb2 == 4'b0010)       // check outputs
            $display("PASSED! numb2 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb2 behaves incorrectly at time: %0t.", $time);
		#2
		
		keypress = 16'h0010; 
		#2
		assert (numb1 == 4'b0100)       // check outputs
            $display("PASSED! numb1 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb1 behaves incorrectly at time: %0t.", $time);
		assert (numb2 == 4'b0011)       // check outputs
            $display("PASSED! numb2 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb2 behaves incorrectly at time: %0t.", $time);
		#2
		
		keypress = 16'h0020;
		#2
		assert (numb1 == 4'b0101)       // check outputs
            $display("PASSED! numb1 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb1 behaves incorrectly at time: %0t.", $time);
		assert (numb2 == 4'b0100)       // check outputs
            $display("PASSED! numb2 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb2 behaves incorrectly at time: %0t.", $time);
		#2
		
		keypress = 16'h0040;
		#2
		assert (numb1 == 4'b0110)       // check outputs
            $display("PASSED! numb1 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb1 behaves incorrectly at time: %0t.", $time);
		assert (numb2 == 4'b0101)       // check outputs
            $display("PASSED! numb2 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb2 behaves incorrectly at time: %0t.", $time);
		#2
		
		keypress = 16'h0080;
		#2
		assert (numb1 == 4'b0111)       // check outputs
           $display("PASSED! numb1 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb1 behaves incorrectly at time: %0t.", $time);
		assert (numb2 == 4'b0110)       // check outputs
            $display("PASSED! numb2 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb2 behaves incorrectly at time: %0t.", $time);
		#2
		
		keypress = 16'h0100;
		#2
		assert (numb1 == 4'b1000)       // check outputs
            $display("PASSED! numb1 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb1 behaves incorrectly at time: %0t.", $time);
		assert (numb2 == 4'b0111)       // check outputs
           $display("PASSED! numb2 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb2 behaves incorrectly at time: %0t.", $time);
		#2
		
		keypress = 16'h0200;
		#2
		assert (numb1 == 4'b1001)       // check outputs
            $display("PASSED! numb1 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb1 behaves incorrectly at time: %0t.", $time);
		assert (numb2 == 4'b1000)       // check outputs
            $display("PASSED! numb2 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb2 behaves incorrectly at time: %0t.", $time);
		#2
		
		keypress = 16'h0400;
		#2
		assert (numb1 == 4'b1010)       // check outputs
           $display("PASSED! numb1 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb1 behaves incorrectly at time: %0t.", $time);
		assert (numb2 == 4'b1001)       // check outputs
            $display("PASSED! numb2 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb2 behaves incorrectly at time: %0t.", $time);
		#2
		
		keypress = 16'h0800;
		#2
		assert (numb1 == 4'b1011)       // check outputs
            $display("PASSED! numb1 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb1 behaves incorrectly at time: %0t.", $time);
		assert (numb2 == 4'b1010)       // check outputs
           $display("PASSED! numb2 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb2 behaves incorrectly at time: %0t.", $time);
		#2
		
		keypress = 16'h1000;
		#2
		assert (numb1 == 4'b1100)       // check outputs
            $display("PASSED! numb1 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb1 behaves incorrectly at time: %0t.", $time);
		assert (numb2 == 4'b1011)       // check outputs
            $display("PASSED! numb2 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb2 behaves incorrectly at time: %0t.", $time);
		#2
		
		keypress = 16'h2000;
		#2
		assert (numb1 == 4'b1101)       // check outputs
            $display("PASSED! numb1 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb1 behaves incorrectly at time: %0t.", $time);
		assert (numb2 == 4'b1100)       // check outputs
            $display("PASSED! numb2 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb2 behaves incorrectly at time: %0t.", $time);
		#2
		
		keypress = 16'h4000;
		#2
		assert (numb1 == 4'b1110)       // check outputs
           $display("PASSED! numb1 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb1 behaves incorrectly at time: %0t.", $time);
		assert (numb2 == 4'b1101)       // check outputs
            $display("PASSED! numb2 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb2 behaves incorrectly at time: %0t.", $time);
		#2
		
		keypress = 16'h8000;
		#2
		assert (numb1 == 4'b1111)       // check outputs
            $display("PASSED! numb1 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb1 behaves incorrectly at time: %0t.", $time);
		assert (numb2 == 4'b1110)       // check outputs
           $display("PASSED! numb2 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb2 behaves incorrectly at time: %0t.", $time);
		#2
		
		//check multi input flag
		keypress = 16'h8040;
		#2
		assert (numb1 == 4'b1111)       // check outputs
            $display("PASSED! numb1 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb1 behaves incorrectly at time: %0t.", $time);
		assert (numb2 == 4'b1110)       // check outputs
           $display("PASSED! numb2 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb2 behaves incorrectly at time: %0t.", $time);
		#2
		
		//check no input flag
		keypress = 16'h0000;
		#2
		assert (numb1 == 4'b1111)       // check outputs
            $display("PASSED! numb1 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb1 behaves incorrectly at time: %0t.", $time);
		assert (numb2 == 4'b1110)       // check outputs
           $display("PASSED! numb2 behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! numb2 behaves incorrectly at time: %0t.", $time);
		#2
		
		$stop;
	end
endmodule