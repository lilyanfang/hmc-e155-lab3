// Target: Lattice iCE40 UP5K FPGA
// Top-Level Module: Integrates keypad scanner, one-shot debouncer, 
//                   shift register, and multiplexed dual 7-segment display.

module keypad_top (
    // Keypad Physical Pins
    output logic [3:0] kp_col,      // Keypad Columns (Active-Low)
    input  logic [3:0] kp_row,      // Keypad Rows (Active-Low, requires internal pull-ups)

    // Dual 7-Segment Display Physical Pins
    output logic [6:0] seg,         // Segments [a..g]
    output logic [1:0] digit_select // Digit Enable lines (Active-Low)
);

    // -------------------------------------------------------------------------
    // 1. iCE40 UP5K Hard IP Oscillator Primitive
    // -------------------------------------------------------------------------
    logic clk;

    // SB_HFOSC generates 12 MHz clock using internal oscillator (CLKHF_DIV = "0b10")
    SB_HFOSC #(
        .CLKHF_DIV("0b10") // 48 MHz / 4 = 12 MHz
    ) u_hfosc (
        .CLKHFPU(1'b1),
        .CLKHFEN(1'b1),
        .CLKHF  (clk)
    );

    // Internal Power-On Reset Generation
    logic [3:0] reset_cnt = '0;
    logic       rst_n;

    always_ff @(posedge clk) begin
        if (reset_cnt != 4'hF) begin
            reset_cnt <= reset_cnt + 1'b1;
            rst_n     <= 1'b0;
        end else begin
            rst_n     <= 1'b1;
        end
    end

    // -------------------------------------------------------------------------
    // 2. Interconnect Signals
    // -------------------------------------------------------------------------
    logic [3:0] raw_key_code;
    logic       raw_key_valid;
    
    logic [3:0] new_key_code;
    logic       key_strobe;

    logic [3:0] digit_most_recent; // Digit 0 (Right)
    logic [3:0] digit_older;       // Digit 1 (Left)

    // -------------------------------------------------------------------------
    // 3. Module Instantiations
    // -------------------------------------------------------------------------

    // Keypad Matrix Scanner
    keypad_scanner #(
        .CLK_FREQ_HZ (12_000_000),
        .SCAN_FREQ_HZ(1_000)
    ) u_scanner (
        .clk        (clk),
        .rst_n      (rst_n),
        .col        (kp_col),
        .row        (kp_row),
        .key_code   (raw_key_code),
        .key_pressed(raw_key_valid)
    );

    // Keypad One-Shot & Debouncer
    keypad_oneshot #(
        .CLK_FREQ_HZ(12_000_000),
        .DEBOUNCE_MS(10)
    ) u_oneshot (
        .clk          (clk),
        .rst_n        (rst_n),
        .raw_key_code (raw_key_code),
        .raw_key_valid(raw_key_valid),
        .key_code     (new_key_code),
        .key_strobe   (key_strobe)
    );

    // -------------------------------------------------------------------------
    // 4. Shift Register: Capture and Shift Key History
    // -------------------------------------------------------------------------
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            digit_most_recent <= 4'h0;
            digit_older       <= 4'h0;
        end else if (key_strobe) begin
            // Shift history: older receives prior most recent, most recent receives new key
            digit_older       <= digit_most_recent;
            digit_most_recent <= new_key_code;
        end
    end

    // -------------------------------------------------------------------------
    // 5. Multiplexed Dual 7-Segment Display Controller
    // -------------------------------------------------------------------------
    
    // Refresh Rate Divider (~1 kHz multiplexing frequency for flicker-free display)
    // 12 MHz / 12,000 = 1 kHz refresh rate (500 Hz per digit)
    localparam int MUX_DIV = 12_000;
    logic [$clog2(MUX_DIV)-1:0] mux_cnt;
    logic                       active_digit;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mux_cnt      <= '0;
            active_digit <= 1'b0;
        end else begin
            if (mux_cnt == MUX_DIV - 1) begin
                mux_cnt      <= '0;
                active_digit <= ~active_digit; // Toggle active digit selection
            end else begin
                mux_cnt <= mux_cnt + 1'b1;
            end
        end
    end

    // Digit Nibble Mux
    logic [3:0] current_nibble;

    always_comb begin
        if (active_digit == 1'b0) begin
            current_nibble = digit_most_recent;
            digit_select   = 2'b10; // Enable Digit 0 (Active-Low)
        end else begin
            current_nibble = digit_older;
            digit_select   = 2'b01; // Enable Digit 1 (Active-Low)
        end
    end

    // 7-Segment Decoder Instance
    sevenSegment u_seg_decoder (
        .hex_digit(current_nibble),
        .segments (seg)
    );

endmodule