`timescale 1ns / 1ps
`default_nettype none

module usb_interface(
    input wire rst_n,
    
    // FT2232H signals
    input wire clkout,
    inout wire [7:0] data,
    input wire rxf_n,       // Signifies data is available from FTDI when low
    input wire txe_n,       // Signifies data can be written to FTDI when low
    output wire rd_n,       // Output data from FTDI when low
    output wire wr_n,       // Writes data to FTDI when low
    output wire oe_n,       // Output enable, should be low before driving rd_n low
    output wire siwu,       // Not used
    
    // Output
    output wire dbg_clkout,
    output wire rxf,
    output wire txe,
    output wire [7:0]cmd_in,
    output wire rx_state_idle,
    output wire rx_state_active,
    output wire rx_state_escaped
);
    assign dbg_clkout = clkout;
    assign rxf = ~rxf_n;
    assign txe = ~txe_n;
    
    /*******************************************************************************.
    * FSM States                                                                    *
    '*******************************************************************************/
    localparam IDLE  = 0,
               READ1 = 1,
               READ2 = 2,
               WRITE = 3;
    
    reg [1:0] state;
    reg [1:0] next_state;
    
    /*******************************************************************************.
    * FT2232H Control Signals                                                       *
    '*******************************************************************************/
    // SIWU is unused, so just hold it high
    assign siwu = 1'b1;
    assign wr_n = (state != WRITE);
    assign oe_n = ~((state == READ1) | (state == READ2));
    assign rd_n = (state != READ2);
    
    
    /*******************************************************************************.
    * Command Receiver                                                              *
    '*******************************************************************************/
    // As long as we are in READ2, new RX data is available from the chip
    wire rx_data_ready;
    assign rx_data_ready = (state == READ2);
    wire cmd_valid;
    
    // Command receiver
    cmd_receiver cmd_rx(
        .clk(clkout),
        .rst_n(rst_n),
        .data(data),
        .data_ready(rx_data_ready),
        .cmd_msg(cmd_in),
        .cmd_valid(cmd_valid),
        .state_idle(rx_state_idle),
        .state_active(rx_state_active),
        .state_escaped(rx_state_escaped)
    );

    
    /*******************************************************************************.
    * USB Interface State Machine                                                   *
    '*******************************************************************************/
    always @(posedge clkout or negedge rst_n) begin
        if (~rst_n) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        next_state = state;
    
        case (state)
            IDLE: begin
                if (~rxf_n) begin
                    // If we have room for command bytes and there is some available,
                    // kick off a read. READ1 will assert OE#, and READ2 will assert
                    // RD# and actually clock out the data.
                    next_state = READ1;
                end else if (~txe_n) begin
                    // If we have data to send and the chip has room to accept it,
                    // kick off a write
                    next_state = WRITE;
                end
            end
        
            READ1: begin
                if (rxf_n) begin
                    // Somehow the data was lost before we had a chance to read it. Go
                    // back to IDLE.
                    next_state = IDLE;
                end else begin
                    next_state = READ2;
                end
            end
        
            READ2: begin
                if (rxf_n) begin
                    // Continue reading bytes until we've either got it all, or our
                    // command FIFO is full
                    next_state = IDLE;
                end
            end
        
            WRITE: begin
                if (txe_n | (~rxf_n)) begin
                    // Continue writing until 
                    next_state = IDLE;
                end
            end
        endcase
    end
        
        
    
endmodule
