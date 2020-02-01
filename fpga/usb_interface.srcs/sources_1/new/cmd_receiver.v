`timescale 1ns / 1ps

module cmd_receiver(
    input wire clk,
    input wire rst_n,

    // Input bytes
    input wire [7:0] data,
    input wire data_ready,

    // Output commands
    output reg [7:0] cmd_msg,
    output reg cmd_valid
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
    
    reg data_valid;
    reg [7:0] data_q;

    
    /*******************************************************************************.
    * Command Receiver State Machine                                                *
    '*******************************************************************************/
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            state <= IDLE;
            cmd_msg <= 8'b0;
        end else begin
            state <= next_state;
            
            if (state == IDLE) begin
                //cmd_msg <= 8'b0;
            end else if (data_valid) begin
                cmd_msg <= data_q;
            end
        end
    end

    always @(*) begin
        next_state = state;
        data_q = 8'h0;
        data_valid = 1'b0;
        cmd_valid = 1'b0;
        
        if (data_ready) begin
            case (state)
                IDLE: begin
                    // Wait in IDLE until we see an END character
                    if (data == `SLIP_END) begin
                        next_state = ACTIVE;  
                    end
                end
        
                ACTIVE: begin
                    if (data == `SLIP_END) begin
                        next_state = IDLE;
                        cmd_valid = 1'b1;
                    end else begin
                        if (data == `SLIP_ESC) begin
                            // It is; ignore this byte, but move on to the ESCAPE
                            // state so we properly handle the next.
                            next_state = ESCAPED;
                        end else begin
                            data_valid = 1'b1;
                            data_q = data;
                        end
                    end
                end
                
                ESCAPED: begin
                    next_state = ACTIVE;
                    
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
                        //next_state = IDLE;
                    end
                end
            endcase
        end
    end
endmodule
