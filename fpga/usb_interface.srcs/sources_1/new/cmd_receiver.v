`timescale 1ns / 1ps

`include "monitor_defs.v"


module cmd_receiver(
    input wire clk,
    input wire rst_n,

    // Input bytes
    input wire [7:0] data,
    input wire data_available,

    // Output command message
    output wire cmd_valid,
    output wire [39:0] cmd_msg
);

    // FSM states
    localparam  IDLE    = 0,
                ACTIVE  = 1,
                ESCAPED = 2;

    reg [1:0] state;
    reg [1:0] next_state;

    // Unslipped data byte and validity flag
    reg [7:0] data_q;
    reg data_valid;

    // Current byte index into cmd_msg
    reg [2:0] write_index;
    reg [2:0] write_index_q;

    // Expected message length, determined from first byte (MSB = 1 for write, MSB = 0 for read)
    wire [2:0] msg_length;
    assign msg_length = (cmd_msg[39]) ? `MSG_WRITE_LENGTH : `MSG_READ_LENGTH;

    /***************************************
    * Command receiver State Machine       *
    ***************************************/

    always @(posedge clk or negedge reset_n) begin
        if (~rst_n) begin
            state <= IDLE;
            write_index <= 3'd0;
            cmd_msg <= 40'b0;
        end else begin
            state <= next_state;
            write_index <= write_index_q;

            if (state == IDLE) begin
                cmd_msg <= 40'b0;
            end else if (data_valid) begin
                // A valid byte can be written to the current location in cmd_msg
                case(write_index)
                    3'd0: cmd_msg[39:32] <= data_q;
                    3'd1: cmd_msg[31:24] <= data_q;
                    3'd2: cmd_msg[23:16] <= data_q;
                    3'd3: cmd_msg[15:8]  <= data_q;
                    3'd4: cmd_msg[7:0]   <= data_q;
                endcase
            end
        end
    end

    always @(*) begin
        next_state = state;
        write_index_q = write_index;
        data_q = 8'h0;
        data_valid = 1'b0;
        cmd_valid = 1'b0;

        if (data_available) begin
            case(state)
                IDLE: begin
                    // Stay idle until an END character was received
                    if (data == `SLIP_END) begin
                        next_state = ACTIVE;
                        write_index_q = 3'd0
                    end
                end

                ACTIVE: begin
                    if (data == `SLIP_END) begin
                        // If we're still on index 0 when receiving an END, ignore it.
                        if (write_index != 3'd0) begin
                            next_state = IDLE;
                            // If the messege length checks out, declare it valid
                            if (write_index == msg_length) begin
                                cmd_valid = 1'b1;
                            end
                        end
                    end else if (write_index < msg_length) begin
                        // There is a new byte, and we still have room for it.
                        if (data == `SLIP_ESCAPE) begin
                            // If it is an escape, make sure to interpret the next byte as escaped.  Do not advance the index
                            next_state = ESCAPED;
                        end else begin
                            // Just a regular byte: add it to the command and advance the index
                            data_valid = 1'b1;
                            data_q = data;
                            write_index_q = write_index + 1;
                        end
                    end else begin
                        // Too many bytes for a valid command: ignore and wait for the next command
                        next_state = IDLE;
                    end
                end

                ESCAPED: begin
                    next_state = ACTIVE;

                    // Unescape the byte
                    if (data == `SLIP_ESC_END) begin
                        data_valid = 1'b1;
                        data_q = `SLIP_END;
                    end else if (data = `SLIP_ESC_ESC) begin
                        data_valid = 1'b1;
                        data_q = `SLIP_ESC;
                    end else begin
                        // Invalid escaped byte. Return to idle and wait for next command.
                        next_state = IDLE;
                    end

                    // Advance the index
                    write_index_q = write_index + 1;
                end
            endcase
        end
    end

endmodule