// Generate tick pulses for keypad scanning (~150 Hz) and display refresh (~1 kHz)
module clk_div #(
    parameter int CLK_FREQ_HZ   = 24_000_000,
    parameter int SCAN_FREQ_HZ  = 150,
    parameter int DISP_FREQ_HZ  = 1000
)(
    input  logic clk,
    input  logic rst_n,
    output logic tick_scan,
    output logic tick_disp
);

    localparam int SCAN_COUNT_MAX = CLK_FREQ_HZ / SCAN_FREQ_HZ;
    localparam int DISP_COUNT_MAX = CLK_FREQ_HZ / DISP_FREQ_HZ;

    int scan_cnt;
    int disp_cnt;

    // Scan clock enable (~150 Hz gives implicit ~6.6 ms debounce step per column)
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            scan_cnt  <= 0;
            tick_scan <= 1'b0;
        end else begin
            if (scan_cnt >= SCAN_COUNT_MAX - 1) begin
                scan_cnt  <= 0;
                tick_scan <= 1'b1;
            end else begin
                scan_cnt  <= scan_cnt + 1;
                tick_scan <= 1'b0;
            end
        end
    end

    // Display multiplexing clock enable (~1 kHz prevents flickering)
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            disp_cnt  <= 0;
            tick_disp <= 1'b0;
        end else begin
            if (disp_cnt >= DISP_COUNT_MAX - 1) begin
                disp_cnt  <= 0;
                tick_disp <= 1'b1;
            end else begin
                disp_cnt  <= disp_cnt + 1;
                tick_disp <= 1'b0;
            end
        end
    end

endmodule