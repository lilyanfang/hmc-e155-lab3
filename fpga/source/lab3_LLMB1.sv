// Target: Lattice iCE40 UP5K FPGA
// Description: Debounces a 4-bit key code and valid strobe from a keypad scanner,
//              captures the key code on initial press, and emits a single-cycle pulse.
//              Requires a full release before accepting subsequent key presses.

module keypad_oneshot #(
    parameter int CLK_FREQ_HZ = 12_000_000, // Default 12 MHz iCE40 internal oscillator
    parameter int DEBOUNCE_MS = 10           // 10 ms debounce time
) (
    input  logic       clk,
    input  logic       rst_n,        // Active-low asynchronous reset
    
    // Raw inputs from matrix keypad scanner
    input  logic [3:0] raw_key_code,
    input  logic       raw_key_valid, // High when a key press is detected by scanner
    
    // Clean one-shot outputs
    output logic [3:0] key_code,
    output logic       key_strobe    // Single-cycle pulse when a new key is registered
);

    // -------------------------------------------------------------------------
    // 1. Double-Flop Synchronizer for Input Strobe
    // -------------------------------------------------------------------------
    logic valid_sync_0, valid_sync_1;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_sync_0 <= 1'b0;
            valid_sync_1 <= 1'b0;
        end else begin
            valid_sync_0 <= raw_key_valid;
            valid_sync_1 <= valid_sync_0;
        end
    end

    // -------------------------------------------------------------------------
    // 2. Debounce Counter
    // -------------------------------------------------------------------------
    localparam int DEBOUNCE_CYCLES = (CLK_FREQ_HZ / 1000) * DEBOUNCE_MS;
    localparam int COUNTER_WIDTH  = $clog2(DEBOUNCE_CYCLES);

    logic [COUNTER_WIDTH-1:0] debounce_cnt;
    logic                     debounced_valid;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            debounce_cnt    <= '0;
            debounced_valid <= 1'b0;
        end else begin
            if (valid_sync_1 != debounced_valid) begin
                if (debounce_cnt == COUNTER_WIDTH'(DEBOUNCE_CYCLES - 1)) begin
                    debounced_valid <= valid_sync_1;
                    debounce_cnt    <= '0;
                end else begin
                    debounce_cnt    <= debounce_cnt + 1'b1;
                end
            end else begin
                debounce_cnt <= '0;
            end
        end
    end

    // -------------------------------------------------------------------------
    // 3. FSM State Definition and State Register
    // -------------------------------------------------------------------------
    typedef enum logic [1:0] {
        IDLE       = 2'b00,
        REGISTER   = 2'b01,
        WAIT_RELEASE = 2'b10
    } state_e;

    state_e current_state, next_state;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // -------------------------------------------------------------------------
    // 4. Next State Logic (Combinational)
    // -------------------------------------------------------------------------
    always_comb begin
        next_state = current_state;
        
        case (current_state)
            IDLE: begin
                if (debounced_valid) begin
                    next_state = REGISTER;
                end
            end

            REGISTER: begin
                // Automatically transition after 1 cycle
                if (debounced_valid) begin
                    next_state = WAIT_RELEASE;
                end else begin
                    next_state = IDLE;
                end
            end

            WAIT_RELEASE: begin
                if (!debounced_valid) begin
                    next_state = IDLE;
                end
            end

            default: next_state = IDLE;
        endcase
    end

   // -------------------------------------------------------------------------
    // 5. Registered Outputs (Glitch-Free)
    // -------------------------------------------------------------------------
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            key_code   <= 4'h0;
            key_strobe <= 1'b0;
        end else begin
            // Default output state
            key_strobe <= 1'b0;

            if (current_state == IDLE && debounced_valid) begin
                // Capture key code and trigger single-cycle strobe
                key_code   <= raw_key_code;
                key_strobe <= 1'b1;
            end
        end
    end

endmodule