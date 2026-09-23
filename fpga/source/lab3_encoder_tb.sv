//   Written by: Lily Anfang
//   Email: lanfang@g.hmc.edu
//   Date: 2026/09/20
//   Description: testbench for the lab3 encoder

module lab3_encoder_tb();
	
	logic [15:0] inputs;
	logic [3:0] outputs;
	logic clk;
	
	lab3_encoder dut(.inputs(inputs), .outputs(outputs));
	
	always begin
		clk = 1;
		#1;
		clk=0;
		#1;
	end
	
	initial begin
		inputs = 16'h0001;
		#2
		assert (outputs == 4'b0000)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		#2
		
		inputs = 16'h0002;
		#2
		assert (outputs == 4'b0001)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		#2
		
		inputs = 16'h0004;
		#2
		assert (outputs == 4'b0010)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		#2
		
		inputs = 16'h0008;
		#2
		assert (outputs == 4'b0011)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		#2
		
		inputs = 16'h0010; 
		#2
		assert (outputs == 4'b0100)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		#2
		
		inputs = 16'h0020;
		#2
		assert (outputs == 4'b0101)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		#2
		
		inputs = 16'h0040;
		#2
		assert (outputs == 4'b0110)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		#2
		
		inputs = 16'h0080;
		#2
		assert (outputs == 4'b0111)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		#2
		
		inputs = 16'h0100;
		#2
		assert (outputs == 4'b1000)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		#2
		
		inputs = 16'h0200;
		#2
		assert (outputs == 4'b1001)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		#2
		
		inputs = 16'h0400;
		#2
		assert (outputs == 4'b1010)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		#2
		
		inputs = 16'h0800;
		#2
		assert (outputs == 4'b1011)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		#2
		
		inputs = 16'h1000;
		#2
		assert (outputs == 4'b1100)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		#2
		
		inputs = 16'h2000;
		#2
		assert (outputs == 4'b1101)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		#2
		
		inputs = 16'h4000;
		#2
		assert (outputs == 4'b1110)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		#2
		
		inputs = 16'h8000;
		#2
		assert (outputs == 4'b1111)       // check outputs
            $display("PASSED! The output behaves as desired at time: %0t.", $time);
        else 
            $error("FAILED! The output behaves incorrectly at time: %0t.", $time);
		#2
		
		$stop;
	end
endmodule