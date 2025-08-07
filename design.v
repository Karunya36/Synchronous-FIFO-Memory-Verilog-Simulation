module FIFO #(parameter DATA_WIDTH = 8, DEPTH = 16, THRESHOLD = 4)(
    input clk, reset, wr_en, rd_en,              // Clock, Reset, Write Enable, Read Enable
    input [DATA_WIDTH-1:0] data_in,              // Data input
    output reg [DATA_WIDTH-1:0] data_out,        // Data output
    output reg full, empty, overflow, underflow, threshold, // Status signals
    output reg [4:0] write_ptr, read_ptr, count  // Pointers and count for debugging
);

    reg [DATA_WIDTH-1:0] memory [0:DEPTH-1]; // FIFO memory storage

    // Reset Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            write_ptr <= 0;
            read_ptr <= 0;
            count <= 0;
            full <= 0;
            empty <= 1;
            overflow <= 0;
            underflow <= 0;
            threshold <= 1;
            data_out <= 0;
        end else begin
            threshold <= (count <= THRESHOLD);
        end
    end

    // Write Operation
    always @(posedge clk) begin
        if (!reset) begin
            if (wr_en && !full) begin
                memory[write_ptr] <= data_in;
                write_ptr <= write_ptr + 1;
                count <= count + 1;
                overflow <= 0;
            end else if (wr_en && full) begin
                overflow <= 1;
            end else begin
                overflow <= 0;
            end
        end
    end

    // Read Operation
    always @(posedge clk) begin
        if (!reset) begin
            if (rd_en && !empty) begin
                data_out <= memory[read_ptr];
                read_ptr <= read_ptr + 1;
                count <= count - 1;
                underflow <= 0;
            end else if (rd_en && empty) begin
                underflow <= 1;
            end else begin
                underflow <= 0;
            end
        end
    end

    // Status Flag Updates
    always @(*) begin
        full = (count == DEPTH);
        empty = (count == 0);
        threshold = (count <= THRESHOLD);
    end

endmodule
