//   Written by: Lily Anfang
//   Email: lanfang@g.hmc.edu
//   Date: 2026/09/19
//   Description: this module syncronizes the inputs with the clk
//	 it does this with 3 ff in series
//	 Tested: Y

module lab3_sync(input  logic 		clk,
				 input  logic		reset,
				 input  logic [3:0] scan,
				 output logic [3:0] scan_new);
	logic [3:0] scan1, scan2;
	always_ff @(posedge clk, negedge reset)
		if (~reset) begin
			scan1 <= 4'b0000;
			scan2 <= 4'b0000;
			scan_new <= 4'b0000;
		end
		else begin
			scan1 <= scan;
			scan2 <=scan1;
			scan_new<=scan2;
		end
endmodule