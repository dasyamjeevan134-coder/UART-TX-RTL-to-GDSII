module uart_tx #(
    parameter CLKS_PER_BIT = 16
)(
    input        clk,
    input        reset,
    input        start,
    input  [7:0] data,
    output reg   tx,
    output reg   busy
);

    localparam IDLE  = 2'b00;
    localparam START = 2'b01;
    localparam DATA  = 2'b10;
    localparam STOP  = 2'b11;

    reg [1:0]  state;
    reg [7:0]  data_reg;
    reg [3:0]  bit_index;
    reg [15:0] baud_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state      <= IDLE;
            data_reg   <= 8'b0;
            bit_index  <= 4'b0;
            baud_count <= 16'b0;
            tx         <= 1'b1;
            busy       <= 1'b0;
        end
        else begin
            case (state)

                IDLE: begin
                    tx         <= 1'b1;
                    busy       <= 1'b0;
                    baud_count <= 16'b0;
                    bit_index  <= 4'b0;

                    if (start) begin
                        data_reg <= data;
                        busy     <= 1'b1;
                        state    <= START;
                    end
                end

                START: begin
                    tx   <= 1'b0;
                    busy <= 1'b1;

                    if (baud_count == CLKS_PER_BIT-1) begin
                        baud_count <= 16'b0;
                        state      <= DATA;
                    end
                    else begin
                        baud_count <= baud_count + 1'b1;
                    end
                end

                DATA: begin
                    tx   <= data_reg[bit_index];
                    busy <= 1'b1;

                    if (baud_count == CLKS_PER_BIT-1) begin
                        baud_count <= 16'b0;

                        if (bit_index == 4'd7) begin
                            bit_index <= 4'b0;
                            state     <= STOP;
                        end
                        else begin
                            bit_index <= bit_index + 1'b1;
                        end
                    end
                    else begin
                        baud_count <= baud_count + 1'b1;
                    end
                end

                STOP: begin
                    tx   <= 1'b1;
                    busy <= 1'b1;

                    if (baud_count == CLKS_PER_BIT-1) begin
                        baud_count <= 16'b0;
                        state      <= IDLE;
                        busy       <= 1'b0;
                    end
                    else begin
                        baud_count <= baud_count + 1'b1;
                    end
                end

                default: begin
                    state <= IDLE;
                    tx    <= 1'b1;
                    busy  <= 1'b0;
                end

            endcase
        end
    end

endmodule
