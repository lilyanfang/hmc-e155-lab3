//   Written by: Lily Anfang
//   Email: lanfang@g.hmc.edu
//   Date: 2026/09/19
//   Description: this is the testbench to test the lab 3 debounce module

module lab3_db_tb();
	
	logic clk, reset, enable, bit_in, bit_out, enablepress, startdb;

	
	lab3_debounce #(.MAX(10), .HALFMAX(5)) dut(.clk(clk), .reset(reset), .enable(enable), .startdb(startdb), .bit_in(bit_in), .enablepress(enablepress), .bit_out(bit_out));
	always begin
		clk=1; #1;
		clk=0; #1;
	end
	
	initial begin
		
		//test reset
		bit_in = 1'b1;
		enable = 1'b0;
		reset = 1'b1; #4;
		reset= 1'b0; #6;
		reset = 1'b1; #4;
		
		//test enable
		enable = 1'b1;
		#10;
		bit_in = 1'b0;
		#12;
		assert (bit_out == 1'b1)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time); 
		
		startdb=1;
		#2;
		startdb=0;
		
		#10;		
		#2;
		bit_in = 1'b1;		
		#8;
		
		#2;
		assert (bit_out == 1'b0)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time); 
			
		startdb=1;
		#2;
		startdb=0;
		#16;
		bit_in = 1'b0;
		#4;
		
		#2;
		assert (bit_out == 1'b1)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		startdb=1;
		#2;
		startdb=0;
		
		#2;
		bit_in = 1'b1;
		#4;
		bit_in = 1'b0;
		#2;
		bit_in = 1'b1;
		#2;
		bit_in = 1'b0;
		#2;
		bit_in = 1'b1;
		#2;
		bit_in = 1'b0;
		#2;
		bit_in = 1'b1;
		#2;
		bit_in = 1'b0;
		#4;
		assert (bit_out == 1'b1)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		#2;
		$stop;		
	end
endmodule