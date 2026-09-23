//   Written by: Lily Anfang
//   Email: lanfang@g.hmc.edu
//   Date: 2026/09/11
//   Description: this module determines whether each button is pressed
//	 Tested: Y

module lab3_pressed(input  logic 		clk,
					input  logic		reset,
					input  logic [3:0]	enable,
					input  logic [3:0]  row,
					input  logic [3:0]  col,
					output logic [15:0] keypress);
	always_ff @(posedge clk, negedge reset)
		if (~reset) keypress <= 16'b0;
		else begin
			if (enable[0])
				if (row==4'b0001) begin //in row 0
					keypress[1] <= col[0];
					keypress[2] <= col[1];
					keypress[3] <= col[2];
					keypress[10]<= col[3];
				end
			if (enable[1])
				if (row==4'b0010) begin //in row 1
					keypress[4] <= col[0];
					keypress[5] <= col[1];
					keypress[6] <= col[2];
					keypress[11]<= col[3];
				end
			if (enable[2])
				if (row==4'b0100) begin //in row 2
					keypress[7] <= col[0];
					keypress[8] <= col[1];
					keypress[9] <= col[2];
					keypress[12]<= col[3];
				end
			if (enable[3])
				if (row==4'b1000) begin //in row 3
					keypress[14]<= col[0];
					keypress[0] <= col[1];
					keypress[15]<= col[2];
					keypress[13]<= col[3];
				end
		end
endmodule		