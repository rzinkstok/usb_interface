`timescale 1ns / 1ps

module cmd_receiver(
    input wire clk,
    input wire rst_n,

    // Input bytes
    input wire [7:0] data,
    input wire data_ready,

    // Output commands
    output reg [7:0] cmd_msg,
    output reg cmd_valid,
    output reg state_idle,
    output reg state_active,
    output reg state_escaped
);
    
    /*******************************************************************************.
    * FSM States                                                                    *
    '*******************************************************************************/
    localparam IDLE = 0,
               ACTIVE = 1,
               ESCAPED = 2;
               
    // SLIP special characters
    `define SLIP_END     8'hC0
    `define SLIP_ESC     8'hDB
    `define SLIP_ESC_END 8'hDC
    `define SLIP_ESC_ESC 8'hDD
    
    reg [1:0] state;
    reg [1:0] next_state;
    assign state_idle = (state == IDLE);
    assign state_active = (state == ACTIVE);
    assign state_escaped = (state == ESCAPED);
    
    // Un-SLIPped data ready for writing to the command being processed, and
    // associated validity flag
    reg data_valid;
    reg [7:0] data_q;

    // Current byte index into the command being processed
    reg [2:0] write_index;
    reg [2:0] write_index_q;
    
    // Expected message length based on the first byte (write commands will have
    // the MSB of the first byte set)
    wire [2:0] msg_length;
    assign msg_length = 1'b1;

    /*******************************************************************************.
    * Command Receiver State Machine                                                *
    '*******************************************************************************/
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            state <= IDLE;
            write_index <= 1'b0;
            cmd_msg <= 8'b0;
        end else begin
            state <= next_state;
            write_index <= write_index_q;
            
            if (state == IDLE) begin
                //cmd_msg <= 8'b0;
                ;
            end else if (data_valid) begin
                cmd_msg <= data_q;
                case (write_index)
                    3'd0: cmd_msg[7:0] <= data_q;
                endcase
            end
        end
    end

    always @(*) begin
        next_state = state;
        write_index_q = write_index;
        data_q = 8'b0;
        data_valid = 1'b0;
        cmd_valid = 1'b0;
        
        if (data_ready) begin
            case (state)
                IDLE: begin
                    // Wait in IDLE until we see an END character
                    if (data == `SLIP_END) begin
                        next_state = ACTIVE; 
                        write_index_q = 3'd0;
                    end
                end
        
                ACTIVE: begin
                    if (data == `SLIP_END) begin
                        // We got an END. If we're still at index 0 (i.e., repeated
                        // END), ignore it.
                        if (write_index != 3'd0) begin
                            next_state = IDLE;
                            if (write_index == msg_length) begin
                                cmd_valid = 1'b1;
                            end
                        end
                    end else if (write_index < msg_length) begin
                        // We've gotten some other byte, and still have room left for
                        // it in the current message. Check to see if it's an ESCAPE.
                        if (data == `SLIP_ESC) begin
                            // It is; ignore this byte, but move on to the ESCAPE
                            // state so we properly handle the next.
                            next_state = ESCAPED;
                        end else begin
                            // This is just a regular byte. Write it into the current
                            // command.
                            data_valid = 1'b1;
                            data_q = data;
                            write_index_q = write_index + 1;
                        end
                    end else begin
                        // We've gotten more bytes than expected for the current
                        // command type. Abort this command and wait for the next.
                        next_state = IDLE;
                    end
                end
                
                ESCAPED: begin
                    next_state = ACTIVE;
                    write_index_q = write_index + 1;
        
                    // Unescape whatever byte we've gotten
                    if (data == `SLIP_ESC_END) begin
                        data_valid = 1'b1;
                        data_q = `SLIP_END;
                    end else if (data == `SLIP_ESC_ESC) begin
                        data_valid = 1'b1;
                        data_q = `SLIP_ESC;
                    end else begin
                        // This isn't a valid escaped byte... abort this command and
                        // go wait for the next.
                        next_state = IDLE;
                    end
                end
            endcase
        end
    end
endmodule
