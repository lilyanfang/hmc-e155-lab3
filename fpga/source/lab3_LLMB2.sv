// Target: Lattice iCE40 UP5K FPGA
// Description: Scans a 4x4 matrix keypad by stepping through columns (active-low)
//              and reading rows (active-low with internal pull-ups on FPGA pins).
//              Outputs a 4-bit key code and a 'key_pressed' flag.

module keypad_scanner #(
    parameter int CLK_FREQ_HZ   = 12_000_000, // 12 MHz internal HFOSC
    parameter int SCAN_FREQ_HZ  = 1_000       // 1 kHz column scan frequency
) (
    input  logic       clk,
    input  logic       rst_n,          // Active-low asynchronous reset
    
    // Physical Keypad Hardware Interface (External Pins)
    output logic [3:0] col,            // Columns driven low one at a time (Active-Low)
    input  logic [3:0] row,            // Rows read with pull-ups enabled (Active-Low)
    
    // Status Outputs
    output logic [3:0] key_code,       // Standard 4x4 Hex key value (0x0 - 0xF)
    output logic       key_pressed     // High as long as a key is detected
);

    // Keypad Layout Mapping:
    //               Col 0   Col 1   Col 2   Col 3
    // Row 0 (00):     1       2       3       A  (0x1, 0x2, 0x3, 0xA)
    // Row 1 (01):     4       5       6       B  (0x4, 0x5, 0x6, 0xB)
    // Row 2 (10):     7       8       9       C  (0x7, 0x8, 0x9, 0xC)
    // Row 3 (11):    * (E)    0      # (F)    D  (0xE, 0x0, 0xF, 0xD)

    // -------------------------------------------------------------------------
    // 1. Scan Clock Divider
    // -------------------------------------------------------------------------
    localparam int CLK_DIV = CLK_FREQ_HZ / SCAN_FREQ_HZ;
    localparam int DIV_WIDTH = $clog2(CLK_DIV);

    logic [DIV_WIDTH-1:0] clk_cnt;
    logic                 scan_tick;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            clk_cnt   <= '0;
            scan_tick <= 1'b0;
        end else begin
            if (clk_cnt == DIV_WIDTH'(CLK_DIV - 1)) begin
                clk_cnt   <= '0;
                scan_tick <= 1'b1;
            end else begin
                clk_cnt   <= clk_cnt + 1'b1;
                scan_tick <= 1'b0;
            end
        end
    end

    // -------------------------------------------------------------------------
    // 2. Double-Flop Synchronizer for Active-Low Row Inputs
    // -------------------------------------------------------------------------
    logic [3:0] row_sync_0, row_sync_1;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            row_sync_0 <= 4'hF;
            row_sync_1 <= 4'hF;
        end else begin
            row_sync_0 <= row;
            row_sync_1 <= row_sync_0;
        end
    end

    // -------------------------------------------------------------------------
    // 3. Column Scanner Logic & Key Detection
    // -------------------------------------------------------------------------
    logic [1:0] col_idx;
    logic [1:0] row_idx;
    logic       row_active;
    logic [3:0] detected_code;

    // Determine if any row in the current active column is driven low
    always_comb begin
        case (row_sync_1)
            4'b1110: begin row_active = 1'b1; row_idx = 2'b00; end // Row 0
            4'b1101: begin row_active = 1'b1; row_idx = 2'b01; end // Row 1             
            4'b1011: begin row_active = 1'b1; row_idx = 2'b10; end // Row 2 AI originally wrote: 4'b1011: begin row_active = 1'b1; row_idx = 2 me_b10; end and had the corrected line below
            4'b0111: begin row_active = 1'b1; row_idx = 2'b11; end // Row 3
            default: begin row_active = 1'b0; row_idx = 2'b00; end // No key or multiple
        endcase
    end

    // Map Row Index (2-bit) and Column Index (2-bit) to 4x4 Standard Key Hex Value
    always_comb begin
        case ({row_idx, col_idx})
            4'b00_00: detected_code = 4'h1;
            4'b00_01: detected_code = 4'h2;
            4'b00_10: detected_code = 4'h3;
            4'b00_11: detected_code = 4'hA;

            4'b01_00: detected_code = 4'h4;
            4'b01_01: detected_code = 4'h5;
            4'b01_10: detected_code = 4'h6;
            //4 me_b01_11: detected_code = 4'hB; AI had both this line and the line below
            4'b01_11: detected_code = 4'hB;

            4'b10_00: detected_code = 4'h7;
            4'b10_01: detected_code = 4'h8;
            4'b10_10: detected_code = 4'h9;
            4'b10_11: detected_code = 4'hC;

            4'b11_00: detected_code = 4'hE; // '*' key
            4'b11_01: detected_code = 4'h0;
            4'b11_10: detected_code = 4'hF; // '#' key
            4'b11_11: detected_code = 4'hD;
            default:  detected_code = 4'h0;
        endcase
    end

    // Sequence column drive signals and latch outputs synchronously
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            col_idx     <= 2'b00;
            key_code    <= 4'h0;
            key_pressed <= 1'b0;
        end else if (scan_tick) begin
            if (row_active) begin
                // Lock current key position and maintain state output
                key_code    <= detected_code;
                key_pressed <= 1'b1;
            end else begin
                // Advance to next active-low column scan
                col_idx <= col_idx + 1'b1;
                
                // If a full rotation completes with no active rows, clear key_pressed
                if (col_idx == 2'b11) begin
                    key_pressed <= 1'b0;
                end
            end
        end
    end

    // One-hot active-low column drive output decoder
    always_comb begin
        case (col_idx)
            2'b00:   col = 4'b1110;
            2'b01:   col = 4'b1101;
            2'b10:   col = 4'b1011;
            2'b11:   col = 4'b0111;
            default: col = 4'b1111;
        endcase
    end

endmodule