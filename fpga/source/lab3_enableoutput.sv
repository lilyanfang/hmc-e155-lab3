//   Written by: Lily Anfang
//   Email: lanfang@g.hmc.edu
//   Date: 2026/09/22
//   Description: This is an enabled flop for the the keypad numbers
//	 Tested: Y
module lab3_enableoutput(input logic        reset,
                         input logic        clk,
                         input logic        enable,
                         input logic [15:0] keypad,
                         output logic       held,
                         output logic [3:0] numb1,
                         output logic [3:0] numb2);
    
    logic [15:0] out1, out2, timeing;

    always_ff @(posedge clk, negedge reset)	begin
        if (~reset) begin
            out1<=0;
            out2<=0;
            timeing<=0;
            held<=0;
        end
        else if (enable) begin
            out1<=keypad;
            timeing<=out1;
            held<=(keypad==out1);
        end
        else begin
            out2<=timeing;
            held<=(keypad==out1);
        end
    end
    lab3_encoder encode1(out1, numb1);
	lab3_encoder encode2(out2, numb2);
endmodule