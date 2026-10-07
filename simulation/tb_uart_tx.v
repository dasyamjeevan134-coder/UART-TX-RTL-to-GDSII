`timescale 1ns/1ps

module tb_uart_tx;

reg clk;
reg reset;
reg start;
reg [7:0] data;

wire tx;
wire busy;

uart_tx #(
    .CLKS_PER_BIT(4)
) uut (
    .clk(clk),
    .reset(reset),
    .start(start),
    .data(data),
    .tx(tx),
    .busy(busy)
);

always #5 clk = ~clk;

initial begin

    $dumpfile("simulation/uart_tx.vcd");
    $dumpvars(0, tb_uart_tx);

    clk = 0;
    reset = 1;
    start = 0;
    data = 8'h00;

    #20;
    reset = 0;

    // Transmit ASCII A
    #10;
    data = 8'h41;
    start = 1;

    #10;
    start = 0;

    // Wait for complete transmission
    #500;

    $display("UART transmission completed.");
    $display("Data transmitted = 0x%h", data);

    $finish;

end

endmodule
