module tb_FIFO;
    reg clk, reset, wr_en, rd_en;               // Input signals
    reg [7:0] data_in;                           // 8-bit Input
    wire [7:0] data_out;                         // 8-bit Output
    wire full, empty, overflow, underflow, threshold; // Status signals

    // Instantiate the FIFO
    FIFO uut (
        .clk(clk), .reset(reset), .wr_en(wr_en), .rd_en(rd_en),
        .data_in(data_in), .data_out(data_out),
        .full(full), .empty(empty), .overflow(overflow),
        .underflow(underflow), .threshold(threshold)
    );

    // Clock Generation: Toggle every 5 time units
    always #5 clk = ~clk;

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_FIFO);

        // Reset
        clk = 0; reset = 1; wr_en = 0; rd_en = 0; data_in = 0;
        #5 reset = 0;

        // Scenario 1: Write 5, Read 5
        $display("Scenario 1: 5 Writes then 5 Reads");
        repeat (5) begin
            wr_en = 1;
            data_in = $random % 256;
            #10;
        end
        wr_en = 0; rd_en = 1;
        repeat (5) #10;
        rd_en = 0;

        // Scenario 2: Alternate Write-Read
        $display("Scenario 2: Alternate Write-Read");
        repeat (8) begin
            wr_en = 1; data_in = $random % 256; #10;
            wr_en = 0; rd_en = 1; #10;
            rd_en = 0;
        end

        // Scenario 3: Full Write then Full Read
        $display("Scenario 3: Full Write then Full Read");
        repeat (8) begin
            wr_en = 1; data_in = $random % 256; #10;
        end
        wr_en = 0; rd_en = 1;
        repeat (8) #10;
        rd_en = 0;

        $stop;
    end
endmodule
