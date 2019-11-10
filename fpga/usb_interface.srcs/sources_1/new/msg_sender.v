`timescale 1ns / 1ps

`include "monitor_defs.v"


module msg_sender(
    input wire clk,
    intput wire rst_n,

    // Input message
    input wire [39:0] msg,
    input wire msg_available,
    output wire sender_ready,

    // Output byte
    output wire [7:0] out_byte,
    output wire out_byte_available,

    // Byte FIFO status
    input wire byte_fifo_full
);

    // FSM states
    localparam  IDLE   = 0,
                ACTIVE = 1,
                ESCAPE = 2;

    reg [1:0] state;
    reg [1:0] next_state;


    // Sender status flag: sender is ready to accept new messages when it is in the IDLE state
    assign sender_ready = (state == IDLE);

    // Output available
    assign out_byte_available = ((msg_available) || (state != IDLE)) && (~byte_fifo_full);

    // Active message
    reg [39:0] active_msg;
    reg [39:0] active_msg_q;

    // Byte index into active message
    reg [2:0] byte_index;
    reg [2:0] byte_index_q;

    // Current byte is selected from active message
    reg [7:0] current_byte;
    always @(*) begin
        case(byte_index)
            3'd0:  current_byte = active_msg[39:32];
            3'd1:  current_byte = active_msg[31:24];
            3'd2:  current_byte = active_msg[23:16];
            3'd3:  current_byte = active_msg[15:8];
            3'd4:  current_byte = active_msg[7:0];
            default: current_byte = 8'b0;
        endcase
    end

    /***************************************
    * Message Sender State Machine         *
    ***************************************/


    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            state <= IDLE;
            byte_index <= 3'b0;
            active_msg <= 40'b0;
        end else begin
            state <= next_state;
            byte_index <= byte_index_q;
            active_msg <= active_msg_q;
        end
    end

    always @(*) begin
        next_state = state;
        byte_index_q = byte_index;
        active_msg_q = active_msg;
        out_byte = current_byte;

        if (~byte_fifo_full) begin
            case(state)
                IDLE: begin
                    if (msg_available) begin
                        // Latch the input message, reset the byte index, output the leading SLIP END byte and continue to ACTIVE
                        active_msg_q = msg;
                        byte_index_q = 3'b0;
                        out_byte = `SLIP_END;
                        next_state = ACTIVE;
                    end
                end

                ACTIVE: begin
                    if (byte_index == `MSG_WRITE_LENGTH) begin
                        // Message is full. Output the trailing SLIP END byte and go to IDLE.
                        out_byte = `SLIP_END;
                        next_state = IDLE;
                    end if ((current_byte == `SLIP_ESC) || (current_byte == `SLIP_END)) begin
                        // This byte must be escaped. Output the SLIP ESC byte, do not increment the byte index, and continue in ESCAPE
                        out_byte = `SLIP_ESC;
                        next_state = ESCAPE;
                    end else begin
                        // Normal message byte, just increment the index to go to the next.
                        byte_index_q = byte_index + 1;
                    end
                end

                ESCAPE: begin
                    // Output the escaped version of the current byte, increment the index and go back to ACTIVE
                    if (current_byte == `SLIP_ESC) begin
                        out_byte = `SLIP_ESC_ESC;
                    end else begin
                        out_byte = `SLIP_ESC_END;
                    end
                    byte_index_q = byte_index + 1;
                    next_state = ACTIVE;
                end
            endcase
        end
    end

endmodule